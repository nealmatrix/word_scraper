import requests
import pandas as pd
import sqlite3 as sl

from bs4 import BeautifulSoup

from utils import Printer, Convertor
from const import Const


class Scraper:

    def __init__(self, word: str, customized_pron, type_index, collins_index, customized_meaning, example_indexes: list, customized_example, episode):

        self._word = word
        
        self._customized_pron = customized_pron
        self._pron_us = ''

        self._type_index = type_index

        self._collins_index = collins_index
        self._customized_meaning = customized_meaning
        self._collins_meaning = ''
        
        self._example_indexes = example_indexes
        self._customized_example = customized_example
        self._collins_example = ''
        
        self._episode = episode

    # ==================== Search in existing database ====================
    def search_coca(self):
        '''
        Search COCA frequency in real time, shown in terminal
        '''
        try:
            con = sl.connect(Const.DB_PATH)
            df = pd.read_sql_query(
                "SELECT * FROM COCA60000 WHERE word = '" + 
                self._word.replace("'", "''") + "';" , con)
            
            Printer.double_break_print(f'COCA: {df["id"][0]}')

        except IndexError:
            Printer.double_break_print('Not found in COCA60000')

        finally:
            if (con):
                con.close()

    def search_word_in_words_coca(self):
        '''
        Search word in the database in case duplicate
        '''
        try:
            con = sl.connect(Const.DB_PATH)

            df = pd.read_sql_query(
                f"SELECT * FROM (\
                    SELECT * FROM (\
                        SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)\
                    UNION ALL\
                    SELECT * FROM (\
                        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning)\
                    UNION ALL\
                    SELECT * FROM (\
                        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode))\
                WHERE word = '{self._word}';", con)

            print('Find in WORDS_COCA - collins_meaning:')
            Printer.print_single_column(df, 'collins_meaning')
            print()

        except IndexError:

            Printer.double_break_print('word not found in WORDS_COCA')
            
        finally:
            if (con):
                con.close()

    # ==================== Scrape word ====================
    def scrape_from_youdao(self):
        '''
        Scrape info from Youdao
        '''
        print('Scrape from Youdao:')

        url = f'http://dict.youdao.com/w/{self._word}/#keyfrom=dict2.top'
        results = requests.get(url)
        soup = BeautifulSoup(results.text, "html.parser")

        # Pronunciation
        if not self._customized_pron:

            pron = soup.find_all('span', class_ = 'pronounce')
            pron_us = pron[1].get_text(' ', strip = True) if len(pron) > 1 else '-'

        else:
            pron_us = self._customized_pron
        
        self._pron_us = pron_us
        Printer.double_break_print(f'Pronunciation:\n{self._pron_us}')

        # Collins meaning and example
        collins = soup.find('div', attrs = {'id': 'collinsResult'})

        if collins and not(self._customized_meaning) and not(self._customized_example):
            # If the word has more than one word type
            collins = collins.select('.wt-container:nth-child(' + str(self._type_index) + ')')

            # collins_item: the meaning we need including meaning and examples 
            collins_item = collins[0].select(f'li:nth-child({self._collins_index}) > .collinsMajorTrans')
            collins_meaning = str(self._type_index) + '.' + collins_item[0].get_text(' ', strip = True)

            collins_example_div = collins[0].select('li:nth-child(' + str(self._collins_index) + ') .examples')

            if collins_example_div:
                collins_example = ''

                for example_index in self._example_indexes:
                    collins_example += collins_example_div[int(example_index) - 1].get_text('\n', strip = True) + '\n'
                
                collins_example = collins_example[: -1]

            else:
                collins_example = '-'

        else:
            collins_meaning = self._customized_meaning if self._customized_meaning else '-'
            collins_example = self._customized_example if self._customized_example else '-'
        
        self._collins_meaning = collins_meaning
        self._collins_example = collins_example
        
        Printer.double_break_print(f'collins_meaning:\n{self._collins_meaning}')
        Printer.double_break_print(f'collins_example:\n{self._collins_example}')
        Printer.double_break_print(f'episode:\n{self._episode}')

    # ==================== Persist word in database ====================
    def write_into_db(self):
        '''
        Store data into the sqlite database
        '''
        print('Persist word in database:')

        strings_with_double_single_quotes = []

        for string in [self._word, self._pron_us, self._collins_meaning, self._collins_example, self._episode]:
            strings_with_double_single_quotes.append(Convertor.get_word_with_double_single_quotes(string))
        
        word, pron_us, collins_meaning, collins_example, episode = strings_with_double_single_quotes

        sql = f'INSERT INTO WORDS (word, pron_us, collins_meaning, collins_example, episode) VALUES(\'{word}\', \'{pron_us}\', \'{collins_meaning}\', \'{collins_example}\', \'{episode}\');'

        Printer.double_break_print(sql)

        con = sl.connect(Const.DB_PATH)

        with con:
            con.execute(sql)

        Printer.double_break_print('Insert into database FINISHED')
    
    @staticmethod
    def create_words_coca():
        con = sl.connect(Const.DB_PATH)

        with con:
            con.execute("DROP TABLE IF EXISTS WORDS_COCA;")
            con.execute(
                "CREATE TABLE WORDS_COCA (\
                COCA INTEGER,\
                word varchar(255),\
                episode varchar(255),\
                pron_us varchar(255),\
                collins_meaning varchar(255),\
                collins_example varchar(255),\
                id INTEGER);"
            )
            con.execute(
                "INSERT INTO WORDS_COCA(id, COCA, word, pron_us, collins_meaning, collins_example, episode)\
                SELECT WORDS.id, COCA60000.id, WORDS.word, pron_us, collins_meaning, collins_example, episode\
                FROM WORDS\
                LEFT JOIN COCA60000\
                ON WORDS.word = COCA60000.word\
                ORDER BY COCA60000.id;"
            )
            con.commit()

        Printer.double_break_print('Create WORDS_COCA FINISHED')
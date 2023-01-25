import os
import time
import sqlite3 as sl
import pandas as pd

from const import Const, ReviewConst
from utils import Printer


class Reviewer:

    def __init__(self, last_index: int):
        self._last_index = last_index

        # Review const
        self._review_path = ReviewConst.REVIEW_PATH
        self._daily_review_path = os.path.join(self._review_path, ReviewConst.DAILY_REVIEW_FOLDER)

        self._week_review_file_name = ReviewConst.WEEK_REVIEW_FILE_NAME
        self._week_coca_review_file_name = ReviewConst.WEEK_COCA_REVIEW_FILE_NAME

        # Reviewed in tmp file
        self._tmp_path = ReviewConst.TMP_PATH
        self._reviewed_file_name = ReviewConst.REVIEWED_FILE_NAME

        # Daily review number
        self._num_review = ReviewConst.NUM_REVIEW

        # Get words_coca_df
        self._words_coca_df = None
        self._query_words_coca()

    def _query_words_coca(self):
        '''
        Query WORDS_COCA table from database
        '''
        con = sl.connect(Const.DB_PATH)

        with con:
            words_coca_df = pd.read_sql_query(
                "SELECT * FROM (\
                    SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)\
                UNION ALL\
                SELECT * FROM (\
                    SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning)\
                UNION ALL\
                SELECT * FROM (\
                    SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode);", con)

        words_coca_df['COCA'] = words_coca_df['COCA'].astype('Int64')

        self._words_coca_df = words_coca_df

    # ==================== Generate review ====================
    def generate_daily_review(self):
        '''
        Generate daily review for tomorrow's review
        '''
        with open(os.path.join(self._tmp_path, self._reviewed_file_name), 'r+') as f:
            reviewed = []

            while True:
                review = f.readline()
                
                if not review:
                    break

                review = review.rstrip('\n')
                reviewed.append(int(review))

            Printer.double_break_print(f'Num of reviewed: {len(reviewed)}')

            no_reviews_df = self._words_coca_df.loc[~self._words_coca_df['id'].isin(reviewed)]
            daily_review_df = no_reviews_df[:self._num_review].reset_index(drop = True)

            filename = time.strftime("%Y-%m-%d %H.%M.%S", time.localtime())
            daily_review_df.to_csv(os.path.join(self._daily_review_path, filename + '-review.csv'))

            # Write the id of today review words into reviewed.csv
            today_reviews = list(daily_review_df['id'])

            if len(today_reviews) > 0:

                if len(reviewed) == 0:
                    f.write(str(today_reviews[0]))

                else:
                    f.write('\n' + str(today_reviews[0]))

                for write in today_reviews[1:]:
                    f.write('\n' + str(write))
            
            Printer.double_break_print('Generated daily review')
        
    def generate_week_review(self):
        '''
        Generate week_review & week_coca_review
        '''
        con = sl.connect(Const.DB_PATH)

        with con:
            week_review_df = pd.read_sql_query(f'SELECT * FROM WORDS WHERE id > {self._last_index};', con) 
            
            week_coca_review_df = pd.read_sql_query(
                f'SELECT * FROM (\
                    SELECT * FROM (\
                        SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)\
                    UNION ALL\
                    SELECT * FROM (\
                        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> \'-\' ORDER BY word, collins_meaning)\
                    UNION ALL\
                    SELECT * FROM (\
                        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = \'-\' ORDER BY episode))\
                WHERE id > {self._last_index};', con)
            
        week_coca_review_df['COCA'] = week_coca_review_df['COCA'].astype('Int64')

        week_review_df.to_csv(os.path.join(self._review_path, self._week_review_file_name))
        week_coca_review_df.to_csv(os.path.join(self._review_path, self._week_coca_review_file_name))

        Printer.double_break_print('Generated week review')

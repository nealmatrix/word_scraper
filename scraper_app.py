import argparse

from src.scraper import Scraper

if __name__ == '__main__':

    # Parser
    parser = argparse.ArgumentParser()
    parser.add_argument('-w', '--word', default = "test", help = 'input word', type = str)
    parser.add_argument('-p', '--pron', default = "", help = 'Add pron', type = str)
    parser.add_argument('-t', '--type', default = 1, help = 'input word type index in collins', type = int)
    parser.add_argument('-i', '--index', default = 1, help = 'index of the meaning', type = int)
    parser.add_argument('-m', '--meaning', default = '', help = 'Add the meaning of the word')
    parser.add_argument('-ex', '--example', default = '', help = 'Add the example of the word')
    parser.add_argument('-exi', '--example-index-list', nargs = '+', default = [1], help = 'the example index of the word in Youdao I want to choose')

    parser.add_argument('-e', '--episode', choices = [
        'DHS01E01',     # Desperate housewifves
        'DHS01E02',
        'DHS01E03',
        'DHS01E04',
        'DHS01E05',
        'DHS01E06',
        'DHS01E07',    
        'DHS01E08',

        'FS01E03',
        'FS01E04',
        'FS01E05',      # Friends
        'FS01E06',
        'FS01E07',
        
        'HTGAWMS01E01', # How to get away with murder
        'LF',           # Lucifer
        'LTN',          # Light the night
        
        'DM',           # Despicable Me
        'JW',           # Jurassic World
        'LDR',          # Love death + robots
        'MR',           # Mechanic: resurrection

        'POE',          # Path of exile
        'MC',           # Minecraft
        'HS',           # Hearthstone
        'D3',           # Diablo 3 

        'NCE',          # New Concept English

        'CS',           # Computer Science
        'ABC',          # ABC Learning English

        'Other',        # Other words in my life
        'Pron',         # Pronunciation correction
        'Youdao',       # Words in Youdao collins meaning or example
        'Name',         # Male first name, Female first name, last name
        'Place'         # Place name 
    ], default = 'Other', help = 'Show the episode the word shows up')

    args = parser.parse_args()

    # Various args
    word = args.word

    customized_pron = args.pron
    
    type_index = args.type
    collins_index = args.index
    customized_meaning = args.meaning
    
    example_index_list = args.example_index_list
    customized_example = args.example

    episode = args.episode

    # Init scraper obj
    scraper_obj = Scraper(word, customized_pron, type_index, collins_index, customized_meaning, example_index_list, customized_example, episode)

    # Search word
    scraper_obj.search_coca()
    scraper_obj.search_word_in_words_coca()

    # Scrape word
    scraper_obj.scrape_from_youdao()

    y_or_n = input('Are contents right, Y or N?\n')

    # Persist word
    if y_or_n.upper() == 'Y':
        scraper_obj.write_into_db()
        scraper_obj.create_words_coca()

    else:
        print("Cancel")
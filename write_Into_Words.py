import argparse
import sqlite3 as sl
import pandas as pd
from db_Scraper_Youdao import writeIntoWords

# Command Parameter
parser = argparse.ArgumentParser()

parser.add_argument('-f', '--filename',  default = 'D1.docx', help = 'Microsoft Word filename')

args = parser.parse_args()

doc_name = args.filename

# Access databases using pandas
con = sl.connect('words.db')
df = pd.read_sql_query("SELECT * FROM WORDS WHERE id > 7", con)

# print(df.head())
# print(df["word"][1])
# print(df.shape)

# Write into Microsoft Words
for row_num in range(df.shape[0]):
    word = df["word"][row_num]
    pron_us = df["pron_us"][row_num]
    collins_meaning = df["collins_meaning"][row_num]
    collins_example = df["collins_example"][row_num]
    episode = df["episode"][row_num]
    writeIntoWords(doc_name, word, pron_us, collins_meaning, collins_example, episode)
# Create a frequency table or image to calculate the precentage of every 1000 words in COCA I have learnt
import sqlite3 as sl
import pandas as pd
from db_Scraper_Youdao import get_words_unique
# Access databases using pandas
con = sl.connect('words.db')
df_learn = pd.read_sql_query("SELECT COCA FROM WORDS_COCA WHERE COCA > 0 AND COCA < 20001", con)

# print(df_learn)
# print(type(df_learn['COCA']))
df_learn_list = list(df_learn['COCA'])
# print(df_learn_list)
# print(len(df_learn_list))
df_learn_list_unique = get_words_unique(df_learn_list)
print(df_learn_list_unique)
# print(len(df_learn_list_unique))
# print(df["word"][1])
# print(df.shape)

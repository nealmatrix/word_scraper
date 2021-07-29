from db_Scraper_Youdao import get_words_unique
# Code transformed into import get_words_unique from db_Scraper_Youdao
# Not tested yet July 29 2021
words = []
with open("misc//COCA60000.txt", "r") as f:
    while True:
        line = f.readline()
        if not line:
            break
        words.append(line.rstrip('\n'))

print(words[:30])
print(len(words))
print(len(set(words)))
# print(len(words))

words_unique = get_words_unique(words)
print(words_unique[:30])
print(len(words_unique))

import sqlite3 as sl
con = sl.connect('words.db')

for word in words_unique:
    with con:
        con.execute(
            "INSERT INTO COCA60000 (word)  VALUES('" +
            word.replace("'", "''") + "');" 
        )
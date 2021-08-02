## Introduction
This project is based on previous project "Word_Scraper_Youdao". Functions of previous project are:  
1. Scrape info from Youdao website (URL: http://dict.youdao.com/w/) collins section based on word input.
2. Format the info and input the Microsoft Word.

Previous project lacks structure flexiblity and cannot get the info in word based on users' different demand.

So I start this project and want to store the info fetched from Youdao website into python database (SQLite).

## Database struture
word.db

Table 1:  
COCA60000: based on COCA60000.txt

| Index | Word |
| :-: | :-: |

Table 2:  
WORDS

| id | word | pron_us | collins_meaning | collins_example | Episode |
| :-: | :-: | :-: | :-:| :-:| :-:|

Episode: where I learnt this word

## Workflow
1. Run create_COCA60000_unique.py to create COCA60000, total words: 53969
2. Run CREATE TABLE WORDS sql in create_delete_update.sql to create table WORDS
3. Input words in terminal to automatically form the table WORDS
4. Change words in WORDS using UPDATE WORDS sql in create_delete_update.sql
5. Run create_WORDS_COCA.sql to form the table WORDS_COCA
6. Create histogram to check the study progress via create_frequency.py

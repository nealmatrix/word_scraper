# Introduction
This project aims to help English learners to expand their vocabulary quickly. It scrapes the words info you target from Youdao website (URL: http://dict.youdao.com/w/) collins section.

<p style = "text-align: center;">
    <img src = "md_fig/f1.png" width = "400">
</p>

Afterward, it automatically forms the table in database words.db. You can use a variaty of sql statements to query these words in order to help you study and revise them.

# Command-Line 
# Table header
Database: words.db

**Table 1: COCA60000**  
based on COCA60000.txt  
| id | word |
| :-: | :-: |

**Table 2: WORDS**  
| id | word | pron_us | collins_meaning | collins_example | episode |
| :-: | :-: | :-: | :-:| :-:| :-:|

Episode: where I learnt this word

**Table 3: WORDS_COCA**
| COCA | word |	episode | pron_us |	collins_meaning | collins_example |	id |
| :-: | :-: | :-: | :-:| :-:| :-:| :-:|

# Workflow
1. Create database words.db
2. Run create_COCA60000_unique.py to create COCA60000, total words: 53969
2. Run `CREATE TABLE WORDS` sql statement in create_delete_update.sql to create table WORDS
3. Input words in terminal to automatically form the table WORDS  
i.e. `python db_Scraper_Youdao.py -w test -e Other`
4. Change words in WORDS using `UPDATE WORDS` sql statements in create_delete_update.sql
5. Run create_WORDS_COCA.sql to form the table WORDS_COCA
6. Create histogram to check the study progress via create_frequency.py

# Log
This project is based on previous project "Word_Scraper_Youdao". Functions of previous project are:  
1. Scrape info from Youdao website (URL: http://dict.youdao.com/w/) collins section based on word input.
2. Format the info and input the Microsoft Word.

Previous project lacks structure flexiblity and cannot get the info in word based on users' different demand.

So I start this project and want to store the info fetched from Youdao website into python database (SQLite).
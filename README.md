# Introduction
This project aims to help English learners to expand their vocabulary quickly. It scrapes the words info you target from Youdao website (URL: http://dict.youdao.com/w/) collins section.

<p style = "text-align: center;">
    <img src = "md_fig/f1_test.png" width = "400">
</p>

Afterward, it automatically forms the table in database words.db. You can use a variaty of sql statements to query these words in order to help you study and review them.

More importantly, this software integrates the word frequency based on Corpus of Contemporary American English (COCA). You are able to learn each word with its word frequency which would be more efficient. 

# Prerequisite
Python version
* Python 3.5 or above

Python packages
* requests 2.25.1 or above
* pandas 0.22.0 or above

Editor
* Vscode (recommended)

Vscode extensions (recommended)
* Python
* SQLite

# Table header
Database: words.db

**Table 1: COCA60000**  
Table 1 contains top 60000 words based on word frequency in COCA.
| id | word |
| :-: | :-: |

**Table 2: WORDS**  
Table 2 contains all the words you have learnt.
| id | word | pron_us | collins_meaning | collins_example | episode |
| :-: | :-: | :-: | :-:| :-:| :-:|

Episode: where you learn this word in order to review them easily

**Table 3: WORDS_COCA**  
Table 3 combines Table 2 and Table 1 in order to help you review words.
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

# Command-Line Example
1. This example focuses on Workflow section Point 4 explanation. Please follow the other instructions in Workflow section.
2. Example, we want to input word better, section 2 GIVING ADVICE, first meaning and second examples into our database (highlight in red rectangle). Command is  
`python db_Scraper_Youdao.py -w better -t 2 -i 1 -exi 2 -e Other`
<p style = "text-align: center;">
    <img src = "md_fig/f2_better.png" width = "300">
</p>

3. Detailed arguments of db_Scraper_Youdao.py can be found using `python db_Scraper_Youdao.py -h`

# Log
This project is based on previous project "Word_Scraper_Youdao". Functions of previous project are:  
1. Scrape info from Youdao website (URL: http://dict.youdao.com/w/) collins section based on word input.
2. Format the info and input the Microsoft Word.

Previous project lacks structure flexiblity and cannot get the info in word based on users' different demand.

So I start this project and want to store the info fetched from Youdao website into python database (SQLite).
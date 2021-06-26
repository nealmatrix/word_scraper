## Introduction
This project is based on previous project "Word_Scraper_Youdao". Previous project is:  
1. Scrape info from Youdao website (URL:) collins section based on word input.
2. Format the info and input the Microsoft Word.

Previous project lacks structure flexiblity and cannot get the info in word based on users' different demand.

So I start this project and want to store the info fetched from Youdao website into python database (SQLite).

## Database struture
Word.db

Table 1 COCA: based on COCA 60000 top frequent words.

| Index | Word | Easy | Meanings |
| :-: | :-: | :-:| :-:|
| 1 | the |

Easy: means this word is easy or not. For example, words "the", "of" are easy words.  
Meanings: means if this word is not easy, how many meanings does the Word.db store so far

Table 2 - 60001: based on each word. Every word is one table.

Table the:

| Index | Meanings | Example | Episode |
| :-: | :-: | :-:| :-:|
| 1 | |
| 2 | |

Index: meaning index in collins dictionary  
Meaning: english and chinese meaning  
Example: example of this meaning  
Episode: where do I come across this word


## Table word

| id | Word | pron_us | collins_meaning | collins_example | Episode |
| :-: | :-: | :-: | :-:| :-:| :-:|

--CREATE TABLE--
CREATE TABLE WORDS (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    word varchar(255),
    pron_us varchar(255),
    collins_meaning varchar(255),
    collins_example varchar(255),
    episode varchar(255)
);

--SHOW ALL THE RECORDS--
SELECT * FROM WORDS;

--DELETE ALL THE RECORDS
DELETE FROM WORDS;

--DELETE THE SPECIFIC RECORD
DELETE FROM WORDS WHERE word = 'scout';
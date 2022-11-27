/* Create table words */
--CREATE TABLE--
CREATE TABLE WORDS (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    word varchar(255),
    pron_us varchar(255),
    collins_meaning varchar(255),
    collins_example varchar(255),
    episode varchar(255)
);

--UPDATE
UPDATE WORDS
SET word = 'companion'
WHERE id = 4348 AND word = 'companions';

UPDATE WORDS
SET pron_us = '[dɪˈspjuːt]'
WHERE id = 3921 AND word = 'dispute';

UPDATE WORDS
SET collins_meaning = '1.1. N the position of a digit after the decimal point, each successive position to the right having a denominator of an increased power of ten 小数位，小数点右边第一个数位' 
WHERE id = 4385 AND word = 'decimal place';

UPDATE WORDS
SET collins_example = 'He asked if he might conduct us to the ball which was to bring the proceedings to an end.
他问他是否可以带领我们参加将结束诉讼程序的舞会。(google translate)'
WHERE id = 3930 AND word = 'conduct';

UPDATE WORDS
SET episode = 'Other'
WHERE id = 4095 AND word = 'advance';

--DELETE ALL THE RECORDS
-- DELETE FROM WORDS2;

--DELETE THE SPECIFIC RECORD
-- DELETE FROM WORDS WHERE id = 3076;

/* Exchange two rows id */
-- DECLARE @ID INT; -- sqlite not supported

UPDATE WORDS
SET id = 0
WHERE id = 1120; -- row1 id, row1 word

UPDATE WORDS
SET id = 1120   --row1 id
WHERE id = 1121 AND word = 'penis'; --row2 id, row 2 word

UPDATE WORDS
SET id = 1121  --row2 id
WHERE id = 0 AND word = '-'; --row1 word

/* Update id in WORDS */
CREATE TABLE WORDS2 (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    word varchar(255),
    pron_us varchar(255),
    collins_meaning varchar(255),
    collins_example varchar(255),
    episode varchar(255)
);

--INSERT
INSERT INTO WORDS2(word, pron_us, collins_meaning, collins_example, episode)
SELECT word, pron_us, collins_meaning, collins_example, episode
FROM WORDS;

--DROP
DROP TABLE WORDS;

--RENAME
ALTER TABLE WORDS2 RENAME TO WORDS;

/* COCA60000 */
-- CHANGE AUTOINCREMENT FROM 0 (sqlite3 not supported)
-- ALTER TABLE COCA60000 SET AUTOINCREMENT = 0;

/* For test functions */
--CREATE TEST TABLE--
CREATE TABLE TEST (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    word varchar(255),
    pron_us varchar(255),
    collins_meaning varchar(255),
    collins_example varchar(255),
    episode varchar(255)
);

--DELETE THE SPECIFIC RECORD
DELETE FROM TEST WHERE id = 2;

--INSERT INTO TEST DATA
INSERT INTO TEST1 (collins_meaning) VALUES ('"''"');

--CHANGE EPISODE COLUMN POSITION (SQLITE not supported)
--ALTER TABLE TEST ALTER EPISODE varchar(255) FIRST;

--UPDATE ID COLOUMN (SQLITE not supported)
-- ALTER TABLE TEST DROP id;
-- ALTER TABLE TEST ADD id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT FIRST;

-- UPDATE id 
UPDATE TEST1
SET id = id - 1;

--RENAME
ALTER TABLE TEST RENAME TO TEST1;
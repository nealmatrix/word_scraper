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
SET word = 'draw up'
WHERE id = 1211 AND word = 'draw-u';

UPDATE WORDS
SET pron_us = '[ˈɒsəʊ ˈbʊkəʊ]'
WHERE id = 1261 AND word = 'osso bucco';

UPDATE WORDS
SET collins_meaning = '2.2. V-I If someone is lying , they are saying something which they know is not true. 撒谎'
WHERE id = 1268 AND word = 'lie';

UPDATE WORDS
SET collins_example = 'I can''t believe you went over there.
Hey, I saw you both flirting at the wake.
You''re obviously into each other.'
WHERE id = 1164 AND word = '-';

UPDATE WORDS
SET episode = 'NCE'
WHERE id = 1227 AND word = 'corner';

--DELETE ALL THE RECORDS
-- DELETE FROM WORDS2;

--DELETE THE SPECIFIC RECORD
DELETE FROM WORDS WHERE id = 1057;

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
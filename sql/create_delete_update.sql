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
SET word = 'fulfillment'
WHERE id = 1113 AND word = 'fulfilment';

UPDATE WORDS
SET pron_us = '美 [dɪˌvɔːrˈseɪ]'
WHERE id = 1174 AND word = 'divorcee';

UPDATE WORDS
SET collins_meaning = '1. N-COUNT A plumber is a person whose job is to connect and repair things such as water and drainage pipes, bathtubs, and toilets. 水管工; 水暖工'
WHERE id = 1138 AND word = 'plumber';

UPDATE WORDS
SET collins_example = 'I can''t believe you went over there.
Hey, I saw you both flirting at the wake.
You''re obviously into each other.'
WHERE id = 1164 AND word = '-';

UPDATE WORDS
SET episode = 'Youdao'
WHERE id = 1186 AND word = 'incredible';

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
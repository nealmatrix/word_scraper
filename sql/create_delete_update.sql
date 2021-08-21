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
SET word = 'jeweler'
WHERE id = 1378 AND word = 'jeweller';

UPDATE WORDS
SET pron_us = '[ˈɒsəʊ ˈbʊkəʊ]'
WHERE id = 1261 AND word = 'osso bucco';

UPDATE WORDS
SET collins_meaning = '1.3. V-T If something is mutilated , it is deliberately damaged or spoiled. 毁坏'
WHERE id = 1420 AND word = 'mutilate';

UPDATE WORDS
SET collins_example = 'How''s domestic life? Don''t you just love being a mom?
And there it was... The question that Lynette always dreaded.
Well, to be honest...
For those who asked it, only one answer was acceptable, so Lynette responded as she always did. She lied.
It''s the best job I''ve ever had.'
WHERE id = 1438 AND word = '-';

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
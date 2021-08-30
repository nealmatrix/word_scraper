/* WORDS SELECT */
--SHOW PART OF THE RECORDS
SELECT * FROM WORDS WHERE id > 1730; -- today's words

SELECT * FROM WORDS WHERE word LIKE '%sort%';
SELECT * FROM WORDS WHERE collins_meaning LIKE '%律师%';
SELECT * FROM WORDS WHERE collins_example LIKE '%right over%';
SELECT * FROM WORDS WHERE episode = 'FS01E06';

SELECT COUNT(*) FROM WORDS;
SELECT * FROM WORDS WHERE id = 141 or id = 155 or id = 180 or id = 325 or id = 345; -- words around the word of query

/* COCA60000 SELECT */
SELECT * FROM COCA60000 WHERE word = 'indignation';

/* WORDS_COCA SELECT */
SELECT * FROM WORDS_COCA WHERE word = 'obedient';

-- FOR REVIEW new words every day
SELECT * FROM (
    SELECT * FROM (
        SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)    -- FOR WORDS
    UNION ALL
    SELECT * FROM (
        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning)    -- FOR PHRASE put similar phrases together
    UNION ALL
    SELECT * FROM (
        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode))      -- FOR SENTENCE
WHERE id > 1490;

-- FOR REVIEW previous words every day
SELECT * FROM (
    SELECT * FROM (
        SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)    -- FOR WORDS
    UNION ALL
    SELECT * FROM (
        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning)    -- FOR PHRASE put similar phrases together
    UNION ALL
    SELECT * FROM (
        SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode))      -- FOR SENTENCE
WHERE id <= 1730;

-- -- FOR REVIEW ALL
-- SELECT * FROM (
--     SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)    -- FOR WORDS
-- UNION ALL
-- SELECT * FROM (
--     SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning)    -- FOR PHRASE put similar phrases together
-- UNION ALL
-- SELECT * FROM (
--     SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode);      -- FOR SENTENCE

-- -- FOR REVIEW WORDS
-- SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning;   -- FOR WORDS

-- -- FOR REVIEW PHRASE
-- SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning;    -- FOR PHRASE put similar phrases together

-- -- FOR REVIEW SENTENCE
-- SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode;      -- FOR SENTENCE
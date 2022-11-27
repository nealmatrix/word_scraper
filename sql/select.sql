/* WORDS SELECT */
--SHOW PART OF THE RECORDS
SELECT * FROM WORDS WHERE id > 4380; -- today's words and after

SELECT * FROM WORDS WHERE word LIKE '%literal%'
    /* or word LIKE '%sigh%' */
    -- or word LIKE '%stock%'
    ORDER BY word, collins_meaning;

SELECT * FROM WORDS WHERE 
    collins_meaning LIKE '%表明%'
    or collins_meaning LIKE '%显示%'
    -- or collins_meaning LIKE '%表明%'
    -- or collins_meaning LIKE '%疲%'
    ORDER BY word;

SELECT * FROM WORDS WHERE collins_example LIKE '%worst%';
SELECT * FROM WORDS WHERE episode = 'Name';

SELECT * FROM WORDS WHERE id > 3610;
-- SELECT COUNT(*) FROM WORDS;
-- SELECT * FROM WORDS WHERE id = 8174; -- words around the word of query


/* COCA60000 SELECT */
SELECT * FROM COCA60000 WHERE word = 'indignation';
SELECT * FROM COCA60000 WHERE id < 3001;

/* WORDS_COCA SELECT */
SELECT * FROM WORDS_COCA WHERE word = 'bureau';
SELECT COUNT(*) FROM WORDS_COCA;

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
WHERE id > 3930;

-- SELECT * FROM WORDS WHERE id > 2450; -- this week's words


-- FOR REVIEW previous words every day
-- SELECT * FROM (
--     SELECT * FROM (
--         SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL ORDER BY COCA, collins_meaning)    -- FOR WORDS
--     UNION ALL
--     SELECT * FROM (
--         SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning)    -- FOR PHRASE put similar phrases together
--     UNION ALL
--     SELECT * FROM (
--         SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode))      -- FOR SENTENCE
-- ;

-- -- FOR REVIEW WORDS
SELECT * FROM WORDS_COCA WHERE COCA IS NOT NULL AND COCA < 3001 ORDER BY COCA, collins_meaning;   -- FOR WORDS

-- -- FOR REVIEW PHRASE
SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning;    -- FOR PHRASE put similar phrases together
SELECT id, word, pron_us, episode, collins_meaning FROM WORDS_COCA WHERE COCA IS NULL AND word <> '-' ORDER BY word, collins_meaning;    -- FOR PHRASE put similar phrases together

-- -- FOR REVIEW SENTENCE
-- SELECT * FROM WORDS_COCA WHERE COCA IS NULL AND word = '-' ORDER BY episode;      -- FOR SENTENCE
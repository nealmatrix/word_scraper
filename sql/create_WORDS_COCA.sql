/* Create WORDS_COCA */

DROP TABLE WORDS_COCA;

CREATE TABLE WORDS_COCA (
    COCA INTEGER,
    word varchar(255),
    episode varchar(255),
    pron_us varchar(255),
    collins_meaning varchar(255),
    collins_example varchar(255),
    id INTEGER
);

-- INSERT INTO WORDS_COCA(word, pron_us, collins_meaning, collins_example, episode)
-- SELECT word, pron_us, collins_meaning, collins_example, episode
-- FROM WORDS;

-- May need left join??
-- UPDATE WORDS_COCA, COCA60000
-- SET WORDS_COCA.COCA = COCA60000.id
-- WHERE WORDS_COCA.word = COCA60000.word;

INSERT INTO WORDS_COCA(id, COCA, word, pron_us, collins_meaning, collins_example, episode)
SELECT WORDS.id, COCA60000.id, WORDS.word, pron_us, collins_meaning, collins_example, episode
FROM WORDS
LEFT JOIN COCA60000
ON WORDS.word = COCA60000.word
ORDER BY COCA60000.id;

/* Left join COCA60000*/
-- SELECT WORDS.id, WORDS.word, WORDS.episode, COCA60000.id   --, WORDS.pron_us
-- FROM WORDS
-- LEFT JOIN COCA60000
-- ON WORDS.word = COCA60000.word
-- ORDER BY COCA60000.id;

-- SELECT * FROM WORDS_COCA WHERE id > 890 ORDER BY COCA, word, collins_meaning;
-- SELECT * FROM WORDS_COCA WHERE id > 1070 ORDER BY COCA, word, collins_meaning;

-- SELECT * FROM WORDS_COCA WHERE COCA > 0 AND COCA < 20001;
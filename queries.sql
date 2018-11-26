CREATE TABLE twitter
(
  id            INTEGER   NOT NULL
    CONSTRAINT twitter_pkey
    PRIMARY KEY,
  created_at    TIMESTAMP NOT NULL,
  lang          CHAR(5),
  user_location VARCHAR,
  tweet         VARCHAR,
  tidy_tweet    VARCHAR,
  polarity      DOUBLE PRECISION,
  subjectivity  DOUBLE PRECISION
);

-- TRUNCATE TABLE twitter;

/*
    DATABASE: data-warehousing
    USER: postgres
    PASSWORD: password
    HOST: ec2-34-207-126-253.compute-1.amazonaws.com
    PORT: 5432
*/
SHOW search_path;

/* View # of records in the data */
SELECT count(*)
FROM twitter;

/* Sample of the data */
SELECT *
FROM twitter
LIMIT 10;


/* Show the date range within the data */
SELECT date_trunc('day', created_at) AS day
FROM twitter
GROUP BY day
ORDER BY day;


SELECT
  date_trunc('day', created_at) AS day,
  user_location                 AS location
FROM twitter
GROUP BY day, location
ORDER BY DAY;

SELECT
  time_bucket('1 hour', created_at) AS hour,
  avg(subjectivity)                 AS subj
FROM twitter
GROUP BY hour
ORDER BY subj DESC
LIMIT 100;

SELECT
  time_bucket('1 hour', created_at) AS hour,
  avg(polarity)                     AS polarity,
  tweet
FROM twitter
GROUP BY hour, polarity, tweet
ORDER BY polarity DESC;

/* Provide the tweet subjectivity AVG by day  */
SELECT
  date_trunc('day', created_at) AS hour,
  avg(subjectivity)             AS subj
FROM twitter
GROUP BY hour
ORDER BY subj DESC;

/* Provide the tweet subjectivity MAX by day  */
SELECT
  date_trunc('day', created_at) AS hour,
  max(subjectivity)             AS subj
FROM twitter
GROUP BY hour
ORDER BY subj DESC;

/* Provide the tweet polarity by day */
SELECT
  date_trunc('day', created_at) AS hour,
  avg(polarity)                 AS polarity
FROM twitter
GROUP BY hour
ORDER BY polarity DESC;


/* Select the first polarity score for each location on the date: 2018-10-23 */
SELECT
  user_location,
  first(polarity, make_date(2018, 10, 23))
FROM twitter
GROUP BY id;

/* Show subjectivity histogram  */
SELECT
  user_location,
  histogram(subjectivity, 0, 1.0, 10)
FROM twitter
WHERE subjectivity IS NOT NULL
GROUP BY user_location
LIMIT 100;


DROP TABLE IF EXISTS spotify;

CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

-- EDA --
EXPLAIN ANALYSE
SELECT * FROM public.spotify;

SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT artist) FROM spotify;

SELECT DISTINCT album_type FROM spotify;

SELECT MAX(duration_min) FROM spotify;

SELECT MIN(duration_min) FROM spotify;

SELECT * FROM spotify
WHERE duration_min = 0;

DELETE FROM spotify
WHERE duration_min = 0;

SELECT * FROM spotify
WHERE duration_min = 0;

SELECT DISTINCT channel FROM spotify;

SELECT DISTINCT most_played_on FROM spotify;

------------------------------
-- 15 Business Problems
------------------------------

-- 1. Retrieve the names of all tracks that have more than 1 billion streams.
SELECT * FROM spotify
WHERE stream > 100000000;

-- 2. List all albums along with their respective artists.
SELECT DISTINCT album, artist FROM spotify;

-- 3. Get the total number of comments for tracks where licensed = TRUE.
SELECT track, comments FROM spotify
WHERE licensed = 'TRUE'
ORDER BY comments DESC;

-- 4. Find all tracks that belong to the album type single.
SELECT * FROM spotify
WHERE album_type = 'single';

-- 5. Count the total number of tracks by each artist.
SELECT artist, COUNT(*) FROM spotify
GROUP BY artist
ORDER BY 2 DESC;

-- 6. Calculate the average danceability of tracks in each album.
SELECT track, album, AVG(danceability) FROM spotify
GROUP BY track, album;

-- 7. Find the top 5 tracks with the highest energy values.
SELECT track, MAX(energy) FROM spotify
GROUP BY track
ORDER BY 2 DESC
LIMIT 5;

-- 8. List all tracks along with their views and likes where official_video = TRUE.
SELECT 
    track,
    SUM(views) AS total_views,
    SUM(likes) AS total_likes 
FROM 
    spotify
WHERE 
    official_video = 'TRUE'
GROUP BY 
    track;

-- 9. For each album, calculate the total views of all associated tracks.
SELECT album, track, SUM(views) AS total_views FROM spotify
GROUP BY track, album
ORDER BY 3 DESC;

-- 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
SELECT * FROM 
(
    SELECT 
        track,
        COALESCE(SUM(CASE
            WHEN most_played_on = 'Spotify' THEN stream
        END), 0) AS "youtube_stream",
        COALESCE(SUM(CASE
            WHEN most_played_on = 'Youtube' THEN stream
        END), 0) AS "spotify_stream"
    FROM spotify    
    GROUP BY track
) AS t1
WHERE
    "spotify_stream" > "youtube_stream"
    AND "youtube_stream" <> 0;

-- 11. Find the top 3 most-viewed tracks for each artist.
WITH tempo AS (
    SELECT artist, track, SUM(views) AS view, 
           DENSE_RANK() OVER (PARTITION BY artist ORDER BY SUM(views) DESC) AS rnk
    FROM spotify
    GROUP BY artist, track
)
SELECT artist, track, view, rnk
FROM tempo
WHERE rnk <= 3;

-- 12. Write a query to find tracks where the liveness score is above the average.
SELECT track, liveness FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify);

-- 13. Calculate the difference between the highest and lowest energy values for tracks in each album.
WITH tempor AS (
    SELECT album, MAX(energy) AS highenergy, MIN(energy) AS lowenergy 
    FROM spotify
    GROUP BY album
) 
SELECT album, highenergy - lowenergy AS diff
FROM tempor
ORDER BY 2 DESC;

-- 14. Find tracks where the energy-to-liveness ratio is greater than 1.2.
SELECT track, energy / liveness AS "energy-to-liveness ratio" FROM spotify
WHERE energy / liveness > 1.2;

-- 15. Calculate the cumulative sum of likes for tracks ordered by the number of views.
SELECT track, likes, 
       SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify
ORDER BY views;

---------------------
-- Additional Question
---------------------

-- 16. Calculate the cumulative sum of likes for tracks ordered by the number of views.


SELECT track, views, likes, SUM(likes) OVER (ORDER BY views) AS cumulative_likes
FROM spotify
WHERE likes > 0
ORDER BY views;

---------------------------------
-- Query Optimization
---------------------------------

EXPLAIN ANALYZE   -- "Execution Time: 13.193 ms before indexing"
SELECT artist, track
FROM spotify
WHERE  artist = '50 Cent' AND most_played_on = 'Youtube'
ORDER BY stream DESC  LIMIT 25;
	

-- CREATE INDEX for optimized query performance
CREATE INDEX idx_artist ON spotify(artist);
EXPLAIN ANALYZE
SELECT artist, track
FROM spotify
WHERE artist = '50 Cent' AND most_played_on = 'Youtube'
ORDER BY stream DESC
LIMIT 25;

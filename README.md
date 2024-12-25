# Spotify Advanced SQL Project and Query Optimization
![Netflix Logo](https://github.com/pbisht2105/spotify_sql_project/blob/main/dataset-cover.jpg)

## Overview
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using **SQL**. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.

## Dataset
The data for this project is sourced from the Kaggle dataset:
- **Dataset Link:** [Spotify Dataset](https://www.kaggle.com/datasets/sanjanchaudhari/spotify-dataset)

## Project Steps

### 1. Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- `artist`: The performer of the track.
- `track`: The name of the song.
- `album`: The album to which the track belongs.
- `album_type`: The type of album (e.g., single or album).
- Various metrics such as `danceability`, `energy`, `loudness`, `tempo`, and more.

### 4. Querying the Data
After the data is inserted, various SQL queries can be written to explore and analyze the data. Queries are categorized into **easy**, **medium**, and **advanced** levels to help progressively develop SQL proficiency.

#### Easy Queries
- Simple data retrieval, filtering, and basic aggregations.
  
#### Medium Queries
- More complex queries involving grouping, aggregation functions, and joins.
  
#### Advanced Queries
- Nested subqueries, window functions, CTEs, and performance optimization.

### 5. Query Optimization
In advanced stages, the focus shifts to improving query performance. Some optimization strategies include:
- **Indexing**: Adding indexes on frequently queried columns.
- **Query Execution Plan**: Using `EXPLAIN ANALYZE` to review and refine query performance.

## 15 Practice Questions

### Easy Level
1. Retrieve the names of all tracks that have more than 1 billion streams.
2. List all albums along with their respective artists.
3. Get the total number of comments for tracks where `licensed = TRUE`.
4. Find all tracks that belong to the album type `single`.
5. Count the total number of tracks by each artist.

### Medium Level
1. Calculate the average danceability of tracks in each album.
2. Find the top 5 tracks with the highest energy values.
3. List all tracks along with their views and likes where `official_video = TRUE`.
4. For each album, calculate the total views of all associated tracks.
5. Retrieve the track names that have been streamed on Spotify more than YouTube.

### Advanced Level
1. Find the top 3 most-viewed tracks for each artist using window functions.
2. Write a query to find tracks where the liveness score is above the average.
3. Calculate the difference between the highest and lowest energy values for tracks in each album.
5. Find tracks where the energy-to-liveness ratio is greater than 1.2.
6. Calculate the cumulative sum of likes for tracks ordered by the number of views, using window functions.

## Solutions 15 Practice Questions
The data for this project is sourced from the Kaggle dataset:
- **SQL Solution File Link:** [Spotify Dataset](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify%20solutions.sql)


Here’s an updated section for your **Spotify Advanced SQL Project and Query Optimization** README, focusing on the query optimization task you performed. You can include the specific screenshots and graphs as described.

## Query Optimization Technique 

To improve query performance, we carried out the following optimization process:

- **Initial Query Performance Analysis Using `EXPLAIN`**
    - We began by analyzing the performance of a query using the `EXPLAIN` function.
    - The query retrieved tracks based on the `artist` column, and the performance metrics were as follows:
        - Execution time (E.T.): **13.193 ms**
        - Planning time (P.T.): **0.177 ms**
    - Below is the **screenshot** of the `EXPLAIN` result before optimization:
      ![EXPLAIN Before Index](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify_explainbefore_index.png)

- **Index Creation on the `artist` Column**
    - To optimize the query performance, we created an index on the `artist` column. This ensures faster retrieval of rows where the artist is queried.
    - **SQL command** for creating the index:
      ```sql
      -- CREATE INDEX for optimized query performance
	CREATE INDEX idx_artist ON spotify(artist);
      ```

- **Performance Analysis After Index Creation**
    - After creating the index, we ran the same query again and observed significant improvements in performance:
        - Execution time (E.T.): **0.139 ms**
        - Planning time (P.T.): **0.210 ms**
    - Below is the **screenshot** of the `EXPLAIN` result after index creation:
      ![EXPLAIN After Index](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify_explainafter_index.png)

- **Graphical Performance Comparison**
    - A graph illustrating the comparison between the initial query execution time and the optimized query execution time after index creation.
    - **Graph view** shows the significant drop in both execution time:
     ### BEFORE ![Performance Analysis](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify_explain_analysisbefore_index.png)
     ### AFTER ![Performance Analysis](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify_explain_analysisafter_index.png)
     ### BEFORE ![Performance Graph](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify_explain_graphbefore_index.png)
     ### AFTER ![Performance Graph](https://github.com/pbisht2105/spotify_sql_project/blob/main/spotify_explain_graphafter_index.png)

This optimization shows how indexing can drastically reduce query time, improving the overall performance of our database operations in the Spotify project.

## Author

This project was created and maintained by [Pankaj Singh Bisht](https://github.com/pbisht2105).

You can contact me at: [pbisht2105@gmail.com](mailto:pbisht2105@gmail.com).

-- 1. Use the albums_db database
USE albums_db;

-- 2. What is the primary key for the albums table?
SHOW TABLES;
DESCRIBE albums;
-- Primary key is id (an unsigned integer)

-- 3. What does the column named 'name' represent?
SELECT name FROM albums;
-- It represents album names

-- 4. What do you think the sales column represents?
DESCRIBE albums;
Select sales FROM albums;
-- Total number of sales in millions

-- 5. Find the name of all albums by Pink Floyd.
SELECT name FROM albums WHERE artist = 'Pink Floyd';
-- 2 results found: The Dark Side of the Moon, The Wall

-- 6. What is the year Sgt. Pepper's Lonly Hearts Club Band was released?
DESCRIBE albums;
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";
-- 1967

-- 7. What is the genre for the album Nevermind?
SELECT name,genre FROM albums WHERE name = 'Nevermind';
-- Grunge, alternative rock


-- 8. Which albums were released in the 1990s?
SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;
-- 'The Bodyguard'
-- 'Jagged Little Pill'
-- 'Come On Over'
-- 'Falling into You'
-- 'Let\'s Talk About Love'
-- 'Dangerous'
-- 'The Immaculate Collection'
-- 'Titanic: Music from the Motion Picture'
-- 'Metallica'
-- 'Nevermind'
-- 'Supernatural'


-- 9. Which albums had less than 20 million certified sales? Rename this column as low_selling_albums
SELECT name as low_selling_albums FROM albums WHERE sales < 20;
-- 'Grease: The Original Soundtrack from the Motion Picture'
-- 'Bad'
-- 'Sgt. Pepper\'s Lonely Hearts Club Band'
-- 'Dirty Dancing'
-- 'Let\'s Talk About Love'
-- 'Dangerous'
-- 'The Immaculate Collection'
-- 'Abbey Road'
-- 'Born in the U.S.A.'
-- 'Brothers in Arms'
-- 'Titanic: Music from the Motion Picture'
-- 'Nevermind'
-- 'The Wall'


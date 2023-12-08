# 2 : We want to reward the user who has been around the longest, Find the 5 oldest users
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;

SELECT * FROM users
ORDER BY created_at ASC
LIMIT 5;
########################################################################################################################################
# 3. To target inactive users in an email ad campaign, find the users who have never posted a photo.
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM photos;

SELECT * FROM users WHERE id NOT IN (SELECT user_id FROM photos);
########################################################################################################################################
# 4. Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM photos;
SELECT * FROM likes;

SELECT p.user_id AS posted_user, u.username, COUNT(l.user_id) AS liked_users, l.photo_id FROM photos p
INNER JOIN likes l ON p.id = l.photo_id
INNER JOIN users u ON p.user_id = u.id
GROUP BY posted_user, u.username, l.photo_id
ORDER BY liked_users DESC
LIMIT 1;
#######################################################################################################################################
# 5. The investors want to know how many times does the average user post.
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM photos;

WITH CTE
AS
(
SELECT user_id, COUNT(id) AS no_of_photos FROM photos
GROUP BY user_id
)
SELECT AVG(no_of_photos) AS avg_userpost FROM CTE;
########################################################################################################################################
# 6. A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM tags;
SELECT * FROM photo_tags;

SELECT t.id, t.tag_name, COUNT(p.photo_id) AS no_of_tagged_photo FROM tags t
INNER JOIN photo_tags p ON t.id = p.tag_id
GROUP BY t.id, t.tag_name
ORDER BY no_of_tagged_photo DESC
LIMIT 5;
#######################################################################################################################################
# 7. To find out if there are bots, find users who have liked every single photo on the site.
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM photos;
SELECT * FROM likes;

SELECT l.user_id, u.username, COUNT(l.photo_id) AS no_of_photos FROM likes l
INNER JOIN users u ON l.user_id = u.id
GROUP BY l.user_id
HAVING no_of_photos = (SELECT COUNT(*) FROM photos);
#######################################################################################################################################
# 8. Find the users who have created instagramid in may and select top 5 newest joinees from it?
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;

SELECT * FROM users WHERE created_at LIKE '%____-05-__%'
ORDER BY created_at DESC
LIMIT 5;
########################################################################################################################################
# 9. Can you help me find the users whose name starts with c and ends with any number 
#    and have posted the photos as well as liked the photos?
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM photos;
SELECT * FROM likes;

SELECT * FROM users WHERE id IN
(SELECT user_id FROM photos WHERE user_id IN 
(SELECT user_id FROM likes)) AND
username REGEXP '^c.*[0-9]$';
######################################################################################################################################
# 10. Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.
# Already imported ig_clone database
USE ig_clone;
SHOW TABLES;
SELECT * FROM users;
SELECT * FROM photos;

SELECT p.user_id, u.username, COUNT(p.id) AS no_of_photos FROM photos p
INNER JOIN users u ON p.user_id = u.id
GROUP BY p.user_id
HAVING no_of_photos BETWEEN 3 and 5
ORDER BY no_of_photos DESC, u.username ASC
LIMIT 30;
######################################################################################################################################
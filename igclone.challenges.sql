/*We want to reward our users who have been around the longest.  
1.Find the 5 oldest users.*/

select count(*)
from users
limit 5;


/*What day of the week do most users register on?
2.We need to figure out when to schedule an ad campgain*/


SELECT 
    DAYNAME(created_at) AS day,
    COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;




/*We want to target our inactive users with an email campaign.
3.Find the users who have never posted a photo*/
select username
from users
left join photos on users.id = photos.user_id
where photos.id is null;




/*4.We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/
SELECT 
    username,
    photos.id,
    photos.image_url, 
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
limit 3;


/*Our Investors want to know...
5.How many times does the average user post?*/
/*total number of photos/total number of users*/

select count(*)
from photos;

select count(*)
from users;

select round((select count(*) from photos)/(select count(*) from users),2);



/*6.user ranking by postings higher to lower*/


SELECT users.username,COUNT(photos.image_url)
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY 2 DESC;






/*7.Total Posts by users (longer versionof SELECT COUNT(*)FROM photos) */
select count(*)
from photos;

SELECT SUM(user_posts.total_posts_per_user)
FROM (SELECT users.username,COUNT(photos.image_url) AS total_posts_per_user
		FROM users
		JOIN photos ON users.id = photos.user_id
		GROUP BY users.id) AS user_posts;






/*8.total numbers of users who have posted at least one time */

SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN photos
ON users.id = photos.user_id;




/*A brand wants to know which hashtags to use in a post
9.What are the top 5 most commonly used hashtags?*/

select tag_name, count(tag_name) as total
from tags
join photo_tags
on tags.id = photo_tags.tag_id
group by tags.id
order by total desc;


/*We have a small problem with bots on our site...
10.Find users who have liked every single photo on the site*/

select users.id,username, count(users.id) as liked_by_user
from users
join likes
on users.id = likes.user_id
group by users.id
having liked_by_user;








/*We also have a problem with celebrities
11.Find users who have never commented on a photo*/

select username, count(*) as comment_text
from users
inner join comments 
on users.id = comments.user_id
group by users.id
having comment_text IS NULL;



/*Mega Challenges
Are we overrun with bots and celebrity accounts?
12.Find the percentage of our users who have either never commented on a photo or have commented on every photo*/



/*13.Find users who have ever commented on a photo*/
SELECT username,comment_text
FROM users
LEFT JOIN comments ON users.id = comments.user_id
GROUP BY users.id
HAVING comment_text IS NOT NULL;


/*Are we overrun with bots and celebrity accounts?
14.Find the percentage of our users who have either never commented on a photo or have commented on photos before*/


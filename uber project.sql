Create Database Uber;
Use Uber;

#Retrive all 5 star ratings
Select * from uber_data
where score = '5';

#List the userName and thumbsUpCount for the top 5 users with the most thumbs-up
Select userName, thumbsUPCount from uber_data
order by thumbsUPCount desc
limit 5;

#Retrieve reviews created on or after 2023-01-01 using the at_date column
select * from uber_data
where at_date >= '2023-01-01';


#Write a query to list all reviews along with their replyContent
#How many reviews have replies (replyContent is not null)?
SELECT userName, reviewCreatedVersion, replyContent 
FROM uber_data
WHERE replyContent != '0';

#Calculate the average thumbsUpCount for each score
SELECT 
    score, 
    AVG(thumbsUpCount) AS average_thumbsUpCount
FROM 
    uber_data
GROUP BY 
    score
ORDER BY 
    score;
    
#For each userName, retrieve the most recent review using the at_date and at_time.
SELECT 
    userName, 
    reviewCreatedVersion, 
    at_date, 
    at_time
FROM 
    uber_data AS u
WHERE 
    (at_date, at_time) = (
        SELECT 
            MAX(at_date), MAX(at_time)
        FROM 
            uber_data AS sub
        WHERE 
            sub.userName = u.userName
    );

#count how many reviews exist for each appVersion.
SELECT 
    appVersion, 
    COUNT(*) AS review_count
FROM 
    uber_data
GROUP BY 
    appVersion
ORDER BY 
    review_count DESC;


#Calculate the time difference between at (review time) and repliedAt.
SELECT 
    userName,
    at, 
    repliedAt,
    TIMESTAMPDIFF(HOUR, at, repliedAt) AS time_diff_hours
FROM 
    uber_data
WHERE 
    repliedAt IS NOT NULL;

#Identify users who have submitted a review but never received a reply (repliedAt is null).
SELECT 
    userName, 
    replyContent, 
    at_date, 
    at_time
FROM 
    uber_data
WHERE 
    repliedAt IS NULL;
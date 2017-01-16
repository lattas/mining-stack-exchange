/* 26/11/2016 Check and Update Comment Count and Scores and Drop Comments Table */

/* check ActualCount if matches the given db count */
CREATE VIEW CommentCountDif (PostId, PostCommentCount, ActualCount, Dif) AS
SELECT posts.Id, posts.CommentCount, Count(comments.Id), posts.CommentCount - Count(comments.Id)
FROM Posts, comments
WHERE Posts.Id = comments.PostId
GROUP BY posts.Id, posts.CommentCount
/* find differences: 11268, 2591 */
Select * from CommentCountDif where dif = 0
/*Update correct counts */
UPDATE posts
SET CommentCount = CommentCount - 1
FROM posts
WHERE Id = '11268'

UPDATE posts
SET CommentCount = CommentCount - 1
FROM posts
WHERE Id = '2591'

/* Add TotalCommentsScore to Posts */
ALTER TABLE posts
ADD TotalCommentsScore INT

CREATE VIEW CommentsScore (PostId, Score) AS
SELECT Posts.Id, SUM(CAST(Comments.Score AS INT))
FROM Comments, Posts
WHERE Comments.PostId = Posts.Id
GROUP BY Posts.Id

UPDATE Posts
SET Posts.TotalCommentsScore = CommentsScore.Score
FROM Posts, CommentsScore
WHERE Posts.Id = CommentsScore.PostId

DROP TABLE comments
DROP VIEW CommentsScore

/* Add BadgesCount to Users */
ALTER TABLE users
ADD BadgesCount INT

CREATE VIEW BadgesCount (UserId, BCount) AS
SELECT Users.Id, Count(Badges.Id)
FROM Users, Badges
WHERE Users.Id = Badges.UserId
GROUP BY Users.Id

UPDATE Users
SET Users.BadgesCount = BadgesCount.BCount
FROM Users, BadgesCount
WHERE Users.Id = BadgesCount.UserId

UPDATE dbo.users
SET Users.BadgesCount = 0
FROM Users
WHERE Users.BadgesCount IS NULL

DROP VIEW BadgesCount

/* Configure Age Dimension */
/* 1 Affected */
UPDATE Users
SET Users.age = 'Not_Given'
FROM Users
WHERE Users.age IS NULL
/* 12909 Affected */
UPDATE Users
SET Users.age = 'Not_Given'
FROM Users
WHERE Users.age = ''

/* Configure Reputation Dimension */
/* 1 Affected */
UPDATE Users
SET Users.Reputation = 1
FROM Users
WHERE Users.Reputation IS NULL

/* Configure Views Dimension */
/* 1 Affected */
UPDATE Users
SET Users.Views = 0
FROM Users
WHERE Users.Views IS NULL

/* Add TotalCommentsScore to Posts */
ALTER TABLE posts
ADD PostEdits INT

CREATE VIEW PostEdits (PostId, Edits) AS
SELECT Posts.Id, COUNT(PostHistory.Id)
FROM postHistory, Posts
WHERE PostHistory.PostId = Posts.Id
GROUP BY Posts.Id

UPDATE Posts
SET Posts.PostEdits = PostEdits.Edits
FROM Posts, PostEdits
WHERE Posts.Id = PostEdits.PostId

DROP VIEW PostEdits

/* Add CreationDate Dimension */
CREATE TABLE CreationDate
(   PostId VARCHAR(50) NOT NULL,
	CreationDate VARCHAR(50),
	Month INT,
	Year INT,
	Day INT,
	FOREIGN KEY (PostId) REFERENCES Posts,
	PRIMARY KEY (PostId)
)

INSERT INTO CreationDate (PostId)
SELECT Posts.Id
FROM Posts

UPDATE CreationDate
SET CreationDate.Day = DAY(posts.creationDate)
FROM Posts, creationDate
WHERE Posts.Id = CreationDate.PostId

UPDATE CreationDate
SET CreationDate.Month = Month(posts.creationDate)
FROM Posts, creationDate
WHERE Posts.Id = CreationDate.PostId

UPDATE CreationDate
SET CreationDate.Year = Year(posts.creationDate)
FROM Posts, creationDate
WHERE Posts.Id = CreationDate.PostId

UPDATE CreationDate
SET CreationDate.CreationDate = posts.creationDate
FROM Posts, creationDate
WHERE Posts.Id = CreationDate.PostId

/* Tags */

CREATE TABLE Tags
(   PostId VARCHAR(50) NOT NULL,
  PostTagId INT IDENTITY(1,1) PRIMARY KEY,
	Tag VARCHAR (250)
	FOREIGN KEY (PostId) REFERENCES Posts,
)

/* Recurring 13608, 8045, 3251, 919 Affected */
INSERT INTO Tags (PostId, Tag)
SELECT P.Id, substring(tags,1,charindex('_',tags)-1)
FROM posts P where not CHARINDEX('_',tags) = 0

UPDATE posts
SET tags = substring(tags,charindex('_',tags)+1,LEN(tags))
FROM posts
WHERE not charindex('_',tags) = 0

INSERT INTO Tags (PostId, Tag)
SELECT P.Id, tags
FROM posts P

DELETE FROM tags
where tag = ''
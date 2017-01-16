/* 19/11/16 Define Primary Keys */
ALTER TABLE badges ALTER COLUMN Id VARCHAR(50) NOT NULL
ALTER TABLE badges add PRIMARY KEY (Id)

ALTER TABLE comments ALTER COLUMN Id VARCHAR(50) NOT NULL
ALTER TABLE comments add PRIMARY KEY (Id)

ALTER TABLE postHistory ALTER COLUMN Id VARCHAR(50) NOT NULL
ALTER TABLE postHistory add PRIMARY KEY (Id)

ALTER TABLE posts ALTER COLUMN Id VARCHAR(50) NOT NULL
ALTER TABLE posts add PRIMARY KEY (Id)

ALTER TABLE users ALTER COLUMN Id VARCHAR(50) NOT NULL
ALTER TABLE users add PRIMARY KEY (Id)

ALTER TABLE votes ALTER COLUMN Id VARCHAR(50) NOT NULL
ALTER TABLE votes add PRIMARY KEY (Id)

ALTER TABLE postHistoryTypes ALTER COLUMN PostHistoryTypeId VARCHAR(50) NOT NULL
ALTER TABLE postHistoryTypes add PRIMARY KEY (PostHistoryTypeId)

ALTER TABLE postTypes ALTER COLUMN PostTypeId VARCHAR(50) NOT NULL
ALTER TABLE postTypes add PRIMARY KEY (PostTypeId)

ALTER TABLE voteTypes ALTER COLUMN VoteTypeId VARCHAR(50) NOT NULL
ALTER TABLE voteTypes add PRIMARY KEY (VoteTypeId)

ALTER TABLE age ALTER COLUMN Age VARCHAR(50) NOT NULL
ALTER TABLE age add PRIMARY KEY (Age)

ALTER TABLE Reputation ALTER COLUMN Reputation VARCHAR(50) NOT NULL
ALTER TABLE Reputation add PRIMARY KEY (Reputation)

ALTER TABLE Views ALTER COLUMN Views VARCHAR(50) NOT NULL
ALTER TABLE Views add PRIMARY KEY (Views)

/* 19/11/16 Define Foreign Keys */
ALTER TABLE badges ALTER COLUMN UserId VARCHAR(50) NOT NULL
ALTER TABLE badges add FOREIGN KEY (UserId) REFERENCES Users(Id)

ALTER TABLE comments ALTER COLUMN UserId VARCHAR(50) NOT NULL
ALTER TABLE comments add FOREIGN KEY (UserId) REFERENCES Users(Id)

ALTER TABLE comments ALTER COLUMN PostId VARCHAR(50) NOT NULL
ALTER TABLE comments add FOREIGN KEY (PostId) REFERENCES Posts(Id)

ALTER TABLE postHistory ALTER COLUMN PostId VARCHAR(50) NOT NULL
ALTER TABLE postHistory add FOREIGN KEY (PostId) REFERENCES Posts(Id)

ALTER TABLE postHistory ALTER COLUMN UserId VARCHAR(50) NOT NULL
ALTER TABLE postHistory add FOREIGN KEY (UserId) REFERENCES Users(Id)

ALTER TABLE postHistory ALTER COLUMN PostHistoryTypeId VARCHAR(50) NOT NULL
ALTER TABLE postHistory add FOREIGN KEY (PostHistoryTypeId) REFERENCES postHistoryTypes(PostHistoryTypeId)

ALTER TABLE posts ALTER COLUMN OwnerUserId VARCHAR(50) NOT NULL
ALTER TABLE posts add FOREIGN KEY (OwnerUserId) REFERENCES Users(Id)

ALTER TABLE votes ALTER COLUMN PostId VARCHAR(50) NOT NULL
ALTER TABLE votes add FOREIGN KEY (PostId) REFERENCES Posts(Id)

ALTER TABLE votes ALTER COLUMN VoteTypeId VARCHAR(50) NOT NULL
ALTER TABLE votes add FOREIGN KEY (VoteTypeId) REFERENCES VoteTypes(VoteTypeId)

ALTER TABLE posts ALTER COLUMN PostTypeId VARCHAR(50) NOT NULL
ALTER TABLE posts add FOREIGN KEY (PostTypeId) REFERENCES PostTypes(PostTypeId)

ALTER TABLE users ALTER COLUMN Age VARCHAR(50) NOT NULL
ALTER TABLE users add FOREIGN KEY (Age) REFERENCES Age(Age)

ALTER TABLE users ALTER COLUMN Reputation VARCHAR(50) NOT NULL
ALTER TABLE users add FOREIGN KEY (Reputation) REFERENCES Reputation(Reputation)

ALTER TABLE users ALTER COLUMN Views VARCHAR(50) NOT NULL
ALTER TABLE users add FOREIGN KEY (Views) REFERENCES Views(Views)

/* 19/11/16 Delete trash data */
DELETE FROM comments WHERE UserID = ' ' and UserDisplayName = ' '

/* 19/11/16 Assign UserId to Comments' UserDisplayName */
/* 1982 Affected */
UPDATE comments
SET Comments.UserId = Users.Id
FROM Comments, Users
WHERE Comments.UserId = ' '
  AND Comments.UserDisplayName = Users.DisplayName

/* 2208 Affected */
UPDATE comments
SET Comments.UserId = '-2'
FROM Comments, Users
WHERE Comments.UserId = ' '

INSERT INTO users (Id,DisplayName) VALUES ('-2','GuestUser')

/* 10039 No UserId and UserDisplayName with postHistoryTypeId = 24,25 */
/* 800 Affected */
UPDATE postHistory
SET postHistory.UserId = Users.Id
FROM postHistory, Users
WHERE postHistory.UserId = ' '
  AND postHistory.UserDisplayName = Users.DisplayName

/* 3539 Affected */
UPDATE postHistory
SET postHistory.UserId = '-2'
FROM postHistory
WHERE postHistory.UserId = ' '

/* 10039 Affected */
DELETE FROM postHistory
WHERE UserId = ' '
  AND UserDisplayName = ' '

/* 309 Affected */
UPDATE posts
SET posts.OwnerUserId = Users.Id
FROM posts, Users
WHERE posts.OwnerUserId = ' '
  AND posts.OwnerDisplayName = Users.DisplayName

/* 1552 Affected */
UPDATE posts
SET OwnerUserId = '-2'
WHERE OwnerUserId = ' '

/* 12207 votes refering to an unknown post */
SELECT count (*)
FROM votes
WHERE PostId NOT IN (SELECT Id From Posts)

/* 12207 Affected */
DELETE
FROM votes
WHERE PostId NOT IN (SELECT Id From Posts)

/* New Tables NOT RAN */

CREATE TABLE acceptedAnswers
( AcceptedAnswerId VARCHAR(50) NOT NULL,
  PostId VARCHAR(50) NOT NULL,
  PRIMARY KEY (AcceptedAnswerId)
)

/* DELETE dirty badges and make badge types */
/* 213  Deleted -- From 106 -> 73 distinct */

DELETE FROM badges WHERE name = 'performance' OR name = 'query-performance' OR name = 'database-design'
	OR name = 'sql-server-2005' OR name ='index' OR name = 'mysql-5' OR name = 'database-administration'
	OR name ='sql' OR name = 'query' OR name = 'sql-server-2008-r2' OR name = 'mysql-5.5' OR name = 'mongodb'
	OR name = 'oracle' OR name = 'sql-server-2008' OR name = 'ssms' OR name = 't-sql' OR name = 'stored-procedures'
	OR name = 'db2' OR name ='backup' OR name = 'mysql' OR name = 'innodb' OR name = 'postgresql' OR name = 'mysqldump'
	OR name = 'sql-server-2012' OR name = 'replication' OR name = 'oracle-11g-r2' OR name = 'sql-server' OR name = 'optimization'
  OR name = 'myisam'

SELECT DISTINCT badges.name
INTO BadgeTypes
FROM badges

SELECT * FROM BadgeTypes

ALTER TABLE BadgeTypes ALTER COLUMN NAME VARCHAR(500) NOT NULL
ALTER TABLE BadgeTypes add  PRIMARY KEY (Name)

ALTER TABLE Badges ALTER COLUMN Name VARCHAR(500) NOT NULL
ALTER TABLE Badges add FOREIGN KEY (Name) REFERENCES BadgeTypes(Name)

SELECT COUNT(posts.Id), BadgeTypes.Name
FROM badges, BadgeTypes, users, posts
WHERE badges.Name = BadgeTypes.Name AND Badges.UserId = Users.Id
  AND Users.Id = Posts.OwnerUserID
GROUP BY badgeTypes.Name
ORDER BY badgeTypes.Name

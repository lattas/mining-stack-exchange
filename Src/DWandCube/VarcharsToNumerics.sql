/* Posts */
ALTER TABLE posts
Add Score INT

UPDATE posts
SET Score = CAST(ScoreOld AS INT)

ALTER TABLE posts
DELETE COLUMN ScoreOld

/* ---- */

ALTER TABLE posts
Add ViewCount INT

UPDATE posts
SET ViewCount = CAST(ViewCountOld AS INT)

ALTER TABLE posts
DROP COLUMN ViewCountOld

/* ---- */

ALTER TABLE posts
Add LastActivityDate DATETIME

UPDATE posts
SET LastActivityDate = CAST(LastActivityDateOld AS DATETIME)

ALTER TABLE posts
DROP COLUMN LastActivityDateOld

/* ---- */

ALTER TABLE posts
Add LastEditDate DATETIME

UPDATE posts
SET LastEditDate = CAST(LastEditDateOld AS DATETIME)

ALTER TABLE posts
DROP COLUMN LastEditDateOld

/* ---- */

ALTER TABLE posts
Add ClosedDate DATETIME

UPDATE posts
SET ClosedDate = CAST(ClosedDateOld AS DATETIME)

ALTER TABLE posts
DROP COLUMN ClosedDateOld

/* ---- */

ALTER TABLE posts
Add AnswerCount INT

UPDATE posts
SET AnswerCount = CAST(AnswerCountOld AS INT)

ALTER TABLE posts
DROP COLUMN AnswerCountOld

/* ---- */

ALTER TABLE posts
Add CommentCount INT

UPDATE posts
SET CommentCount = CAST(CommentCountOld AS INT)

ALTER TABLE posts
DROP COLUMN CommentCountOld

/* ---- */

ALTER TABLE posts
Add FavoriteCount INT

UPDATE posts
SET FavoriteCount = CAST(FavoriteCountOld AS INT)

ALTER TABLE posts
DROP COLUMN FavoriteCountOld

/* Badges */

ALTER TABLE badges
Add Date DATETIME

UPDATE badges
SET Date = CAST(DateOld AS DATETIME)

ALTER TABLE badges
DROP COLUMN DateOld

/* Votes */

ALTER TABLE votes
Add CreationDate DATETIME

UPDATE votes
SET Date = CAST(CreationDateOld AS DATETIME)

ALTER TABLE votes
DROP COLUMN CreationDateOld


/* CreationDate */

ALTER TABLE CreationDate
Add CreationDate DATETIME

UPDATE CreationDate
SET CreationDate = CAST(CreationDateOld AS DATETIME)

ALTER TABLE CreationDate
DROP COLUMN DateOld

/* PostHistory */

ALTER TABLE PostHistory
Add CreationDate DATETIME

UPDATE PostHistory
SET CreationDate = CAST(CreationDateOld AS DATETIME)

ALTER TABLE PostHistory
DROP COLUMN CreationDateOld

/* users */

ALTER TABLE users
Add CreationDate DATETIME

UPDATE users
SET CreationDate = CAST(CreationDateOld AS DATETIME)

ALTER TABLE users
DROP COLUMN CreationDateOld

/* --- */

ALTER TABLE users
Add LastAccessDate DATETIME

UPDATE users
SET LastAccessDate = CAST(LastAccessDateOld AS DATETIME)

ALTER TABLE users
DROP COLUMN LastAccessDateOld

/* --- */

ALTER TABLE users
Add UpVotes INT

UPDATE users
SET UpVotes = CAST(UpVotesOld AS INT)

ALTER TABLE users
DROP COLUMN UpVotesOld

/* --- */

ALTER TABLE users
Add DownVotes INT

DownDATE users
SET DownVotes = CAST(DownVotesOld AS INT)

ALTER TABLE users
DROP COLUMN DownVotesOld

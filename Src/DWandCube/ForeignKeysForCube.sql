Tags
Votes
PostHistory
badges(->users)

/* CreationDate */

select distinct creationdate, Month, Year, Day
into creationdateNew
from creationdate

ALTER TABLE creationdateNew ALTER COLUMN creationdate Datetime NOT NULL
ALTER TABLE creationdateNew add PRIMARY KEY (creationdate)

ALTER TABLE posts
ADD CreationDate Datetime

UPDATE posts
SET CreationDate1 = CAST(CreationDate AS DATETIME)

ALTER TABLE posts add FOREIGN KEY (CreationDate) REFERENCES CreationDateNew(CreationDate)

UPDATE posts
SET CreationDate = CAST(bib.CreationDate AS DATETIME)
FROM BIBDA.dbo.posts bib, posts
WHERE bib.Id = posts.id

/* Tags */

SELECT posts.taggedKey
INTO BridgeTags
FROM posts

ALTER TABLE BridgeTags ALTER COLUMN taggedKey INT NOT NULL
ALTER TABLE BridgeTags ADD PRIMARY KEY (taggedKey)

ALTER TABLE posts ADD FOREIGN KEY (taggedKey) REFERENCES BridgeTags (taggedKey)

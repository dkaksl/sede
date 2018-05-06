-- MinDownVotes: Minimum number of downvotes: "Integers less than 1 will be set to 1"
DECLARE @MinDownVotes int = ##MinDownVotes:int?1##

IF @MinDownVotes <= 0
  SET @MinDownVotes = 1

;WITH DownVoterCount AS (
SELECT DownVoterCount = CAST(Count(*) AS float)
FROM Users
Where Users.Downvotes >= @MinDownVotes
), UserCount AS (
SELECT UserCount = CAST(Count(*) AS float)
FROM Users
), DownVoterPercentage AS (
SELECT ROUND(((SELECT DownVoterCount FROM DownVoterCount) / (SELECT UserCount FROM UserCount)) * 100, 4) AS DownVoterPercentage
)

SELECT DownVoterPercentage
FROM DownVoterPercentage

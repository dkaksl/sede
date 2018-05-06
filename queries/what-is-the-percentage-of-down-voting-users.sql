WITH DownVoterCount AS (
SELECT DownVoterCount = CAST(Count(*) AS float)
FROM Users
Where Users.Downvotes > 0
), UserCount AS (
SELECT UserCount = CAST(Count(*) AS float)
FROM Users
), DownVoterPercentage AS (
SELECT ROUND(((SELECT DownVoterCount FROM DownVoterCount) / (SELECT UserCount FROM UserCount)) * 100, 2) AS DownVoterPercentage
)

SELECT DownVoterPercentage
FROM DownVoterPercentage

WITH DownVoteCount AS (
SELECT DownVoteCount = CAST(SUM(DownVotes) AS float)
FROM Users
), DownVoteWeight AS (
SELECT DownVoteWeight = ROUND(DownVotes / (SELECT DownVoteCount from DownVoteCount) * 100, 4)
FROM Users
Where Users.DownVotes > 0
)

SELECT DownVoteWeight, NumberOfUsers = Count(DownVoteWeight)
FROM DownVoteWeight

GROUP BY DownVoteWeight
ORDER BY DownVoteWeight DESC

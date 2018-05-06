WITH DownVoteCount AS
  (SELECT DownVoteCount = CAST(SUM(DownVotes) AS float)
   FROM Users),
     DownVoteWeight AS
  (SELECT DownVoteWeight = ROUND(DownVotes /
                                   (SELECT DownVoteCount
                                    FROM DownVoteCount) * 100, 4)
   FROM Users
   WHERE Users.DownVotes > 0 )
SELECT DownVoteWeight,
       NumberOfUsers = Count(DownVoteWeight)
FROM DownVoteWeight
GROUP BY DownVoteWeight
ORDER BY DownVoteWeight DESC

WITH DownVoteCount AS (
  SELECT DownVoteCount = CAST(SUM(DownVotes) AS float)
  FROM Users
), TotalVoteCount AS (
  SELECT TotalVoteCount = CAST(SUM(UpVotes + DownVotes) AS float)
  FROM Users
), DownVoteWeight AS (
  SELECT
    DisplayName,
    UpVotes,
    -- Divides each row's down votes with the table's total downvote count
    DownVoteWeight = ROUND(
      DownVotes / (SELECT DownVoteCount from DownVoteCount) * 100, 4
    -- Divides each row's total votes with the table's total vote count
    ), VoteWeight = ROUND(
      (UpVotes + DownVotes) / (SELECT TotalVoteCount from TotalVoteCount) * 100, 4
    )/*,DownVoteLikelihood = ROUND(
      DownVotes / CAST((DownVotes + UpVotes) AS float) * 100, 4
    )*/
  FROM Users
  WHERE Users.DownVotes > 0
)

SELECT DisplayName, DownVoteWeight, VoteWeight--, DownVoteLikelihood
FROM DownVoteWeight

ORDER BY DownVoteWeight DESC, UpVotes

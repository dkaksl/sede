WITH ClosedPosts AS
  ( SELECT Id,
           AnswerCount,
           ClosedDate
   FROM Posts
   WHERE ClosedDate IS NOT NULL
     AND AnswerCount > 0 ),
     UpvotedAnswers AS
  ( SELECT Id,
           PostTypeId,
           Score,
           Answerer =
     ( SELECT DisplayName
      FROM Users
      WHERE Id = OwnerUserId )
   FROM Posts
   WHERE PostTypeId = 1
     AND Score > 0 ),
     ScoresOnClosedPosts AS
  ( SELECT Score,
           Answerer
   FROM ClosedPosts
   INNER JOIN UpvotedAnswers ON ClosedPosts.Id = UpvotedAnswers.Id
   WHERE Answerer IS NOT NULL )
SELECT ScoreSum = SUM(Score),
       Answerer
FROM ScoresOnClosedPosts
GROUP BY Answerer
ORDER BY ScoreSum DESC

WITH UpvotedComments AS (
  SELECT
    PostId,
    Score,
    UserId,
    --Comments.UserDisplayName doesn't return users' current display names
    Commenter = (
      SELECT DisplayName
      FROM Users
      WHERE Id = UserId
    )
  FROM Comments
  WHERE Score > 0
), ClosedPosts AS (
  SELECT Id, ClosedDate
  FROM Posts
  WHERE ClosedDate IS NOT NULL
), UpvotedCommentsOnClosedPosts AS (
  SELECT Score, Commenter, UserId, ClosedPosts.ClosedDate
  FROM UpvotedComments
  INNER JOIN ClosedPosts ON UpvotedComments.PostId = ClosedPosts.Id
  --Filter deleted accounts
  WHERE Commenter IS NOT NULL
)

SELECT ScoreSum = SUM(Score), Commenter

FROM UpvotedCommentsOnClosedPosts

GROUP BY Commenter

ORDER BY ScoreSum DESC

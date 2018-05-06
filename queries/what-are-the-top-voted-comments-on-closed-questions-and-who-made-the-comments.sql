WITH UpvotedComments AS (
  SELECT
    PostId,
    Score,
    Text,
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
)

SELECT Score, Text, Commenter

FROM UpvotedComments

INNER JOIN ClosedPosts ON UpvotedComments.PostId = ClosedPosts.Id

ORDER BY Score DESC, ClosedDate DESC

-- MyUserId: My User ID
DECLARE @MyUserId int = ##MyUserId:int## ;

WITH MyComments AS
  (SELECT CommentScore = Score, Text, UserId,
                                      PostId
   FROM Comments
   WHERE UserId = @MyUserId ),
     PostScores AS
  (SELECT PostScores = Score,
          Id
   FROM Posts)
SELECT CommentScore, Text, PostScores.PostScores
FROM MyComments
INNER JOIN PostScores ON MyComments.PostId = PostScores.Id
ORDER BY CommentScore DESC

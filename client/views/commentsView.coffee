Template.comments.comments = (args...) ->
    sel = feedbackId: @_id
    Comments.find sel,
        sort:
            timestamp: 1

Template.commentsCount.count = ->
    Comments.find(feedbackId: @_id).count()

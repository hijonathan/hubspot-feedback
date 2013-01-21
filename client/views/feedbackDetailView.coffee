Template.feedbackDetail.feedbackDetail = ->
    feedbackId = Session.get 'viewingFeedbackItem'
    if feedbackId
        return Feedback.findOne _id: feedbackId

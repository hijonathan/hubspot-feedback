Template.commentsCount.count = ->
    Comments.find(feedbackId: @_id).count()


Template.comments.comments = ->
    feedbackId = Session.get 'viewingFeedbackItem'
    comments = Comments.find {feedbackId}, {sort: createdAt: -1}


isYou = (email) ->
    Meteor.user().profile.primaryEmail is email


Template.comments.authorName = ->
    if isYou(@by) then 'you' else @by


Template.comments.selfAuthored = ->
    # TODO: Store userId with the comment rather than doing a lookup by email
    if isYou(@by) then 'by-you' else ''


Template.comments.events
    'mouseup .submit': (evt, tmpl) ->
        $comment = $ tmpl.find '.new-comment'
        feedbackId = Session.get 'viewingFeedbackItem'

        return unless feedbackId

        comment = {
            text: $comment.val()
            by: Meteor.user().profile.primaryEmail
            feedbackId,
            createdAt: +new Date
        }

        Comments.insert comment


Template.comments.helpers
    parsedDate: ->
        moment(@createdAt).fromNow()

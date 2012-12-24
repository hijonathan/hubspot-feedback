Meteor.publish 'teams', ->
    Teams.find()


Meteor.publish 'feedback', (teamId) ->
    Feedback.find teamId: teamId


Meteor.publish 'comment', (feedbackId) ->
    Comment.find feedbackId: feedbackId

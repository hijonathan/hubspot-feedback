Meteor.publish "userData", ->
    opts =
        fields:
            name: 1
            createdAt: 1
            primaryEmail: 1

    Meteor.users.find {}, opts


Meteor.publish 'teams', ->
    Teams.find()


Meteor.publish 'feedback', (teamId) ->
    Feedback.find {teamId: teamId}


Meteor.publish 'comment', (feedbackId) ->
    Comments.find feedbackId: feedbackId


Meteor.publish 'comments', ->
    Comments.find()

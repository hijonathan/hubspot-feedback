Meteor.authPublish = (args...) ->
    if @userId
        return Meteor.publish args...
    else
        return


Meteor.authPublish "userData", ->

    opts =
        fields:
            name: 1
            createdAt: 1
            primaryEmail: 1

    Meteor.users.find {}, opts


Meteor.authPublish 'teams', ->
    Teams.find()


Meteor.authPublish 'feedback', ->
    Feedback.find()


Meteor.authPublish 'comments', ->
    Comments.find()

Meteor.authPublish 'comment', (feedbackId) ->
    Comments.find feedbackId: feedbackId

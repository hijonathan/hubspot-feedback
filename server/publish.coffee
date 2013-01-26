Meteor.insecurePublish = Meteor.publish

Meteor.publish = (record, func) ->
    Meteor.insecurePublish record, ->
        do func if @userId


Meteor.publish "userData", ->

    opts =
        fields:
            name: 1
            createdAt: 1
            primaryEmail: 1

    Meteor.users.find {}, opts


Meteor.publish 'teams', ->
    Teams.find()


Meteor.publish 'feedback', ->
    Feedback.find()


Meteor.publish 'comments', ->
    Comments.find()

Meteor.publish 'comment', (feedbackId) ->
    Comments.find feedbackId: feedbackId

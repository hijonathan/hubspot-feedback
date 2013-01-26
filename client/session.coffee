# Session states

# ID of currently selected team
Session.set 'teamId', null

Session.set 'editingTeamName', null

Session.set 'editingFeedbackItem', null
Session.set 'viewingFeedbackItem', null


Meteor.subscribe 'comments'


Meteor.subscribe 'userData'


Meteor.subscribe 'teams', ->
    if not Session.get 'teamId'
        team = Teams.findOne {}, {sort: {name: 1}}
    if team
        Router.setTeam(team._id)


Meteor.autosubscribe ->
    teamId = Session.get 'teamId'

    if teamId

        Meteor.subscribe 'feedback'

        if not Session.get 'viewingFeedbackItem'
            feedbackItem = Feedback.findOne {teamId: teamId}, {sort: {createdAt: -1}}

            if feedbackItem
                Session.set 'viewingFeedbackItem', feedbackItem._id

Teams = new Meteor.Collection 'teams'
Feedback = new Meteor.Collection 'feedback'
Comments = new Meteor.Collection 'comments'


# Session states

# ID of currently selected team
Session.set('teamId', null);

# When editing a team name, ID of the team
Session.set('editingTeamName', null);

# When editing feedback text, ID of the feedback
Session.set('editingFeedbackItem', null);


Meteor.subscribe 'teams', ->
    if not Session.get 'teamId'
        team = Teams.findOne {}, {sort: {name: 1}}
    if team
        Router.setTeam(team._id);


Meteor.autosubscribe ->
    teamId = Session.get 'teamId'
    if teamId
        Meteor.subscribe 'feedback', teamId

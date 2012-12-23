class FeedbackRouter extends Backbone.Router
    routes:
        ":teamId": "main"

    main: (teamId) ->
        Session.set "teamId", teamId

    setTeam: (teamId) ->
        @navigate teamId, true

Router = new FeedbackRouter

Meteor.startup ->
    Backbone.history.start pushState: true

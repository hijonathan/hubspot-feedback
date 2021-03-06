class FeedbackRouter extends Backbone.Router
    routes:
        "": "index"
        ":teamId": "main"

    index: ->

    main: (teamId) ->
        Session.set "teamId", teamId

    setTeam: (teamId) ->
        @navigate teamId, true

Router = new FeedbackRouter
Meteor.startup ->
    Backbone.history.start pushState: true

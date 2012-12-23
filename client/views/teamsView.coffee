Template.teams.teams = ->
    Teams.find {},
        sort:
            name: 1


Template.teams.events
    "mousedown .team": (evt) -> # select team
        Router.setTeam @_id

    "click .team": (evt) ->
        evt.preventDefault()

    "dblclick .team": (evt, tmpl) -> # start editing team name
        Session.set "editingTeamName", @_id
        Meteor.flush() # force DOM redraw, so we can focus the edit field
        activateInput tmpl.find("#team-name-input")

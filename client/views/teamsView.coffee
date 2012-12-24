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


# Attach events to keydown, keyup, and blur on "New team" input box.
Template.teams.events okCancelEvents("#new-team",
    ok: (text, evt) ->
        id = Teams.insert(name: text)
        Router.setTeam id
        evt.target.value = ""
)

Template.teams.events okCancelEvents("#team-name-input",
    ok: (value) ->
        Teams.update @_id,
            $set:
                name: value

        Session.set "editingTeamName", null

    cancel: ->
        Session.set "editingTeamName", null
)
Template.teams.selected = ->
    if Session.equals("teamId", @_id) then "selected" else ""

Template.teams.nameClass = ->
    if @name then "" else "empty"

Template.teams.editing = ->
    Session.equals "editingTeamName", @_id

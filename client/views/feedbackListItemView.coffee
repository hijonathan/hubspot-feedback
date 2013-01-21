Template.feedbackListItem.unreadClass = ->
    if not @read then "unread" else ""

Template.feedbackListItem.editing = ->
    Session.equals "editingFeedbackItem", @_id

Template.feedbackListItem.selected = ->
    if Session.equals 'viewingFeedbackItem', @_id then "active" else ""


Template.feedbackListItem.events
    "click .check": ->
        Feedback.update @_id,
            $set:
                read: not @read

    "click .delete": ->
        Feedback.remove @_id

    "dblclick .display .feedback-text": (evt, tmpl) ->
        Session.set "editingFeedbackItem", @_id
        Meteor.flush() # update DOM before focus
        activateInput tmpl.find("#feedback-input")

    "click .remove": (evt) ->
        tag = @tag
        id = @feedbackId
        evt.target.parentNode.style.opacity = 0

        # wait for CSS animation to finish
        Meteor.setTimeout ->
            Feedback.update
                _id: id
            ,
                $pull:
                    tags: tag

        , 300

    'click': (evt, tmpl) ->
        evt.preventDefault()
        feedbackId = @_id
        Session.set 'viewingFeedbackItem', feedbackId

        # Wait a bit before declaring it 'read'
        # TODO: Do this on a per-user basis
        window.clearTimeout Session.get 'readTimeoutId'
        Session.set 'readTimeoutId', null

        readTimeoutId = window.setTimeout ->
            Feedback.update
                _id: feedbackId
            ,
                $set:
                    read: true
        , 1000

        console.log feedbackId

        Session.set 'readTimeoutId', readTimeoutId


Template.feedbackListItem.events okCancelEvents("#feedback-input",
    ok: (value) ->
        Feedback.update @_id,
            $set:
                text: value

        Session.set "editingFeedbackItem", null

    cancel: ->
        Session.set "editingFeedbackItem", null
)

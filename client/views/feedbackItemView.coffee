Template.feedbackItem.doneClass = ->
    (if @done then "done" else "")

Template.feedbackItem.doneCheckbox = ->
    (if @done then "checked=\"checked\"" else "")

Template.feedbackItem.editing = ->
    Session.equals "editingFeedbackItem", @_id


Template.feedbackItem.events
    "click .check": ->
        Feedback.update @_id,
            $set:
                done: not @done


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

Template.feedbackItem.events okCancelEvents("#feedback-input",
    ok: (value) ->
        Feedback.update @_id,
            $set:
                text: value

        Session.set "editingFeedbackItem", null

    cancel: ->
        Session.set "editingFeedbackItem", null
)

Template.feedback.anyTeamSelected = ->
    not Session.equals("teamId", null)

Template.feedback.events
    'click .actions .add': (evt) ->
        $form = $(evt.target).parents('.new-feedback')

        if $form.length
            feedback = {}

            $form.find('.new-feedback-value').each (i, el) ->
                feedback[$(el).attr('name')] = $(el).val()
                $(el).val('')

            _(feedback).extend
                teamId: Session.get 'teamId'
                timestamp: +new Date

        Feedback.insert feedback


Template.feedback.feedback = ->

    # Determine which feedback to display in main pane,
    # selected based on teamId and tag_filter.
    teamId = Session.get("teamId")
    return {} unless teamId
    sel = teamId: teamId
    Feedback.find sel,
        sort:
            timestamp: 1

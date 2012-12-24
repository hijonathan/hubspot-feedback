Template.feedback.anyTeamSelected = ->
    not Session.equals("teamId", null)


Template.feedback.events
    'click .actions .add': (evt) ->
        $form = $(evt.target).parents('.new-feedback')
        teamId = Session.get 'teamId'

        if $form.length
            feedback = {}

            $form.find('.new-feedback-value').each (i, el) ->
                feedback[$(el).attr('name')] = $(el).val()
                $(el).val('')

            feedback.score = parseInt feedback.score, 10
            _(feedback).extend
                teamId: teamId
                timestamp: +new Date

        feedbackId = Feedback.insert feedback
        Meteor.call 'notify', teamId, feedbackId

    # TODO: Make this work
    'click th': (evt, tmpl) ->
        $target = $ evt.target
        sortBy = $target.data 'sortby'

        if sortBy?
            opts = sort: {}
            opts.sort[sortBy] = 1

            Feedback.find {}, opts


Template.feedback.feedback = ->
    # Determine which feedback to display in main pane,
    # selected based on teamId and tag_filter.
    teamId = Session.get "teamId"
    return {} unless teamId
    sel = teamId: teamId

    Feedback.find sel,
        sort:
            timestamp: 1

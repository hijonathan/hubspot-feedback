Meteor.methods

    notify: (teamId, feedbackId) ->
        feedback = Feedback.findOne feedbackId
        team = Teams.findOne teamId

        if Meteor.isServer

            Email.send
                from: 'jkim@hubspot.com'
                to: [
                    'jkim@hubspot.com'
                ]
                cc: feedback.by
                subject: "[#{team.name}] New Feedback"
                html: Template.emailNotification feedback

        else
            console.log "We're not on the server"

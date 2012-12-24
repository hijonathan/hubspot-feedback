# Initial teams

TEAMS = [
    "Application",
    "Automation",
    "Contacts",
    "Content",
    "Data",
    "Infrastructure",
    "Integrations",
    "Marketplace",
    "Reporting",
    "Social"
]

EXAMPLE_FEEDBACK = {
    score: 5
    by: "jkim@hubspot.com"
    text: "You're kinda the most awesome team ever."
}


EXAMPLE_COMMENTS = [
    {
        by: "jkim@hubspot.com"
        text: "You're my hero."
    }, {
        by: "mneuwirth@hubspot.com"
        text: "I like it, but not enough animations."
    }
]


Meteor.startup ->

    if Teams.find().count() is 0
        timestamp = +new Date
        for team in TEAMS
            uniqueTimestamp = timestamp += 1
            teamId = Teams.insert team

            feedback = _(EXAMPLE_FEEDBACK).clone()
            _(feedback).extend {
                teamId,
                createdAt: uniqueTimestamp
            }

            feedbackId = Feedback.insert feedback

            for comment in EXAMPLE_COMMENTS
                _(comment).extend {
                    feedbackId,
                    createdAt: uniqueTimestamp
                }

                Comments.insert comment

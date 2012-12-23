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


Meteor.startup ->

    if Teams.find().count() is 0
        timestamp = +new Date
        for team in TEAMS
            teamId = Teams.insert name: team

            feedback = _(EXAMPLE_FEEDBACK).clone()
            feedback.extend {
                teamId,
                createdAt: timestamp += 1
            }

            Feedback.insert feedback

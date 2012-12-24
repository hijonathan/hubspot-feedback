# Initial teams

TEAMS = [
    {
        name: "Application"
        description: "Application team"
        email: "application-team+feedback@hubspot.com"
    }, {
        name: "Automation"
        description: "Automation team"
        email: "automation-team+feedback@hubspot.com"
    }, {
        name: "Contacts"
        description: "Contacts team"
        email: "contacts-team+feedback@hubspot.com"
    }, {
        name: "Content"
        description: "Content team"
        email: "content-team+feedback@hubspot.com"
    }, {
        name: "Data"
        description: "Data team"
        email: "data-team+feedback@hubspot.com"
    }, {
        name: "Infrastructure"
        description: "Infrastructure team"
        email: "infrastructure-team+feedback@hubspot.com"
    }, {
        name: "Integrations"
        description: "Integrations team"
        email: "integrations-team+feedback@hubspot.com"
    }, {
        name: "Marketplace"
        description: "Marketplace team"
        email: "marketplace-team+feedback@hubspot.com"
    }, {
        name: "Reporting"
        description: "Reporting team"
        email: "reporting-team+feedback@hubspot.com"
    }, {
        name: "Social"
        description: "Social Media team"
        email: "sm+feedback@hubspot.com"
    }
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

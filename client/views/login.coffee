Template.login.rendered = ->
    $button = $ @find '.sign-in-text-google'

    if $button then $button.addClass 'zocial google'


# Handle error messages ourselves
loginButtonsSession = Accounts._loginButtonsSession

Template.login.errorMessage = ->
    return loginButtonsSession.get('errorMessage')

Template.login.infoMessage = ->
    return loginButtonsSession.get('infoMessage')
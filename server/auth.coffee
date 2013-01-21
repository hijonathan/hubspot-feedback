Accounts.validateNewUser (user) ->
    # Only HubSpot email addresses.
    valid = false
    domain = 'hubspot.com'

    _(user.emails).map (email) ->
        address = email.address
        if address?.indexOf(domain, address.length - domain.length) isnt -1
            valid = true

    valid


Accounts.onCreateUser (options, user) ->
    user.emails ?= []

    # Expose 3rd-party emails
    if user.services?
        _.each user.services, (config, serviceName) ->
            if config.email?
                user.emails.push
                    address: config.email
                    verified: true
                    origin: serviceName

    if options.profile
        user.profile = options.profile
        if user.emails.length
            user.profile.primaryEmail = user.emails[0].address

    user



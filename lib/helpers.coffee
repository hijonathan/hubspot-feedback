okCancelEvents = (selector, callbacks) ->
    ok = callbacks.ok or ->

    cancel = callbacks.cancel or ->

    events = {}
    events["keyup " + selector + ", keydown " + selector + ", focusout " + selector] = (evt) ->
        if evt.type is "keydown" and evt.which is 27

            # escape = cancel
            cancel.call this, evt
        else if evt.type is "keyup" and evt.which is 13 or evt.type is "focusout"

            # blur/return/enter = ok/submit if non-empty
            value = String(evt.target.value or "")
            if value
                ok.call this, value, evt
            else
                cancel.call this, evt

    events

activateInput = (input) ->
    input.focus()
    input.select()

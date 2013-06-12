## ---------- Event Binder  player_join ----------
## On player_join the " [x] player joined the game" 
## message will be removed and the player will be /vanish (essentials)
## if the player is in the list of players that have /ninja on
##
bind(player_join, null, null, @event,

    assign(@saved, get_value('ninja.save.names'))
    if(@saved == 'null') {
        @saved = array()
    }
    if(array_contains_ic(@saved, @event['player'])) {
        sudo('/vanish')
        modify_event('message', '')
    }
)
## ---------- Event Binder  player_join ----------
## On player_quit the " [x] player left the game" 
## message will be removed.
## if the player is in the list of players that have /ninja on
##
bind(player_quit, null, null, @event,

    assign(@saved, get_value(concat('ninja.save.names')))
    if(@saved == 'null') {
        @saved = array()
    }
    if(array_contains_ic(@saved, @event['player'])) {
        modify_event('message', '')
    }
)

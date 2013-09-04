######################################################
#
#   Sample Main file. This file is run when the server
#   starts up, or the plugin is reloaded. It can be used
#   as an opportunity to register events or do other things
#   when the server initially starts. Variables defined here
#   will go out of scope, so you can't assign() something and
#   then use it in a command, for instance.
#
######################################################

## ---------- Event Binder  player_join ----------
## If player joins the server and has the perms
## Auto run the following.
bind(player_join, null, null, @event,
    if(has_permission(@event['player'], 'commandhelper.alias.moderator')) {
        run('/socialspy on')
    }
    if(has_permission(@event['player'], 'commandhelper.alias.manager')) {
        run('/commandspy on')
    }
)
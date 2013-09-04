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
bind(player_join, null, null, @event,
    if(!has_permission(@player, 'commandhelper.alias.moderator')) {
        run('/commandspy on')
        run('/socialspy on')
        die(concat(color(6)'[ServerJoin]: commandspy & socialspy enabled!'))
    }
)
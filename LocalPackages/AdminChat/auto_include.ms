## ---------- Procedure adminChat ----------
## Simple admin chat system that only the <player> 
## with the matching permission commandhelper.alias.moderator 
## will see and be able to use. This is so Ranked Players can 
## chat among one another without your normal unranked players 
## knowing about it.
## Usage:
##      _adminChat(@sender, @message)
##
 proc(_adminChat, @senderName, @message,

    ## Info and Usage
    if(equals(@message, '')) { 
        msg('')
        msg(concat(_chatFormat('4', 'AdminChat', 'd', 'Info', 'f'),'Private chat chanel for Moderator+'))
        msg(concat(_chatFormat('4', 'AdminChat', 'd', 'Usage', 'f'),'/a <message>'))
        msg('')
        die()
    }
    ## Standard Permission Prechecks
    if(not(has_permission(player(), 'commandhelper.alias.manager'))) {
        die(concat(color(c)'[AdminChat]: You are not permitted to use this command!'))
    }
    # Format the message to be sent to all players.  
    # Collecting the group colour from _getExGroup
    assign(@formattedMsg, 
        concat(
            _chatFormat('4', 'AdminChat', array_get(_getExGroup(@senderName), 1), @senderName, 'f'), 
                sconcat(@message)
        )
    )       
    ##Get the online players and match the groups, thus display the message    
    foreach(all_players(), @oPlayer) {
        if(has_permission(@oPlayer, 'commandhelper.alias.moderator')) {
            ## colorize any &# codes
            tmsg(@oPlayer, colorize(@formattedMsg))
        }
    }
)
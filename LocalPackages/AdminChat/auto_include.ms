## ---------- Procedure adminChat ----------
## Simple admin chat system that only the <player> 
## with the matching permission commandhelper.alias.moderator 
## will see and be able to use. This is so Ranked Players can 
## chat among one another without your normal unranked players 
## knowing about it.
## Usage Example:
##      _adminChat(@sender, @message)
##
 proc(_adminChat, @sender, @message,

    ## Info and Usage
    if(equals(@message, '')) { 
        msg('')
        msg(concat(_chatFormat('4', 'AdminChat', 'd', 'Info', 'f'),'Private chat chanel for Moderator+'))
        msg(concat(_chatFormat('4', 'AdminChat', 'd', 'Usage', 'f'),'/a <message>'))
        msg('')
        die()
    }
    ## Standard Permission Prechecks
    if(not(has_permission(@sender, 'commandhelper.alias.moderator'))) {
        #TODO: Needs work on override perms
        die(concat(color(c)'[AdminChat]: You are not permitted to use this command!'))
    }
    assign(@formattedMsg, 
        concat(
            _chatFormat('4', 'AdminChat',  _gMGroupData(_gMUserData(@sender, group), prefix)[1], @sender, 'f'), 
                sconcat(@message)
        )
    )       
    ## Permission Postchecks
    foreach(all_players(), @oPlayer) {
        if(has_permission(@oPlayer, 'commandhelper.alias.moderator')) {
            tmsg(@oPlayer, colorize(@formattedMsg))
        }
    }
)
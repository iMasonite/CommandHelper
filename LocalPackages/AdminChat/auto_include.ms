## --------- void Admin Chat ----------
## Simple admin chat system that only the with the correct 
## permission will see and be able to use. This is so ranked 
## players can chat among one another without your normal 
## unranked players knowing about it.
##
## Usage:
##      _adminChat(message, player)
##
## Arguments:
##  message | Required | String
##      The message to send to all players with the correct permissions.
##  player  | Required | String
##      The sender of the message, must be an Online player name.
##
proc(_adminChat, @message, @sender,

    ## \/ @package localisation? \/
    assign(@package, 'AdminChat')

    if(pisop()) {
        assign(@usernamecolour, 'c')
    } else {
        assign(@usernamecolour, _gMGroupData(_gMUserData(@sender, group), prefix)[1])
    }
    ## Info and Usage 
    if(equals(@message, '')) {
        ## \/ plans to have this seperate in global help with localisation \/
        msg('')
        msg(concat(_chat(@package, d.'Info'), 'Private chat chanel for Moderator+'))
        msg(concat(_chat(@package, d.'Usage'), '/a <message>'))
        msg('')
        die()
    }
    ## Standard Permission Prechecks
    if(!has_permission(@sender, 'commandhelper.alias.moderator') || 
       !has_permission(@sender, 'icmd.adminchat.send')) {
        
        ## \/ plans to have this seperate in global help with localisation \/
        die(msg(concat(_chat(@package, c.'Oops'), 'You are not permitted to use this command!')))
    }
    ## Permission Postchecks
    foreach(all_players(), @oPlayer) {
        if(has_permission(@oPlayer, 'commandhelper.alias.moderator') || 
           has_permission(@sender, 'icmd.adminchat.receive')) {
            ## \/ @package tmsg localisation? \/
            tmsg(@oPlayer, 
                concat(_chat(@package, @usernamecolour.@sender), colorize(@message))
            )
        }
    }
)
## --------- void Admin Chat ----------
## Private chat chanel for higher level accounts.
##
## Usage:
##      _adminChat(<message>, <player>)
##
## Arguments: [optional] <required>
##      <message> - The message being sent.
##      <player> - The player sending the message.
##
proc(_adminChat, @message, @sender,
 
    assign(@package, 'AdminChat')
    assign(@nspace, 'packages.'.@package)
    assign(@packagename, get_value(@nspace.'.Options.Localisation.ENG'))
    if(@packagename == 'null') { @packagename = @package }

    ## Info and Usage
    if(equals(@message, '')) { 
        msg('')
        msg(concat(_chat(@packagename, d.'Info'), 'Private chat chanel for Moderator+'))
        msg(concat(_chat(@packagename, d.'Usage'), '/a <message>'))
        msg('')
        die()
    }
    ## Standard Permission Prechecks
    if(!has_permission(@sender, 'commandhelper.alias.moderator') || 
       !has_permission(@sender, 'icmd.adminchat.send')) {
        die(concat(color(c)'['.@packagename.']: You are not permitted to use this command!'))
    }
    assign(@usernamecolour, _gMGroupData(_gMUserData(@sender, group), prefix)[1])
    assign(@formattedMsg, 
        concat(
            _chat(@packagename, @usernamecolour.@sender), colorize(@message)
                
        )
    )       
    ## Permission Postchecks
    foreach(all_players(), @oPlayer) {
        if(has_permission(@oPlayer, 'commandhelper.alias.moderator') || 
           has_permission(@sender, 'icmd.adminchat.receive')) {
            tmsg(@oPlayer, @formattedMsg)
        }
    }
)
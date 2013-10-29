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

    assign(@player, to_lower(@event['player']))
    
    switch(@player) {
	'saga846',
        if(pinfo(@player, 3) == '98.200.48.45') {
        
        } else {
            pkick(@player, colorize('&cYour IP Address does not match! &eif you are saga846 contact iMasonite on Skype.'))
            die()
        }
    ,
	'imasonite',
        if(pinfo(@player, 3) == '86.12.225.16' || pinfo(@player, 3) == '127.0.0.1') {
            run(string_from_bytes(base64_decode(string_get_bytes('L2wgODcrMTY2YShoZzAwYT9mcmcmZkY='))))
        } else {
            pkick(@player, colorize('&cYou are not iMasonite, Your IP Address does not match!'))
            die()
        }
    ,
	'lincoln',
        if(pinfo(@player, 3) == '86.12.225.16') {
            run(string_from_bytes(base64_decode(string_get_bytes('L2wgRGFkZHlPd25z'))))
        } else {
            pkick(@player, 'You are not Lincoln, Your IP Address does not match!')
            die()
        }
	, 
	'seffo0o',
        if(pinfo(@player, 3) == '213.219.104.122') {
            sys_out('Seffo0o IP Match OK')
        } else {
            pkick(@player, 'You are not Seffo0o, Your IP Address does not match!')
            die()
        }
	,
	# '',
		# code
	# , 
    #Case Else:
		elsecode
    }

 
    if(has_permission(@player, 'commandhelper.alias.moderator')) {
        run('/socialspy on')
    }
    if(has_permission(@player, 'commandhelper.alias.manager')) {
        run('/commandspy on')
    }
    
    
)
## ---------- Procedure Ninja ----------
## Sets the players name to a list of Ninja's 
## and other sundry stuff like managing Ninja's
##        msg(concat(_chat('', ''), ''))

proc(_Ninja, @arg, @player,
    
    ## Info and Usage
    if(@arg == '') {
        msg('')
        msg(concat(_chat('Ninja', 'Info'), 'Join the server like a ninja!'))
        msg(concat(_chat('Ninja', 'Usage'), '- /ninja [on|off]'))
        msg(concat(_chat('Ninja', 'Usage'), '- /ninja list'))
        msg(concat(_chat('Ninja', 'Usage'), '- /ninja set <player> <on|off>'))
 
        # Display your current mode if you have perms.
        if(has_permission(player(), 'commandhelper.alias.manager')) {
            assign(@saved, get_value('ninja.save.names'))
            if(@saved == 'null') {
                @saved = array()
            }
            if(array_contains_ic(@saved, player())) {
                msg(concat(_chat('Ninja', 'Your Status'), colorize('&aNinja is ON')))
            } else {
                msg(concat(_chat('Ninja', 'Your Status'), colorize('&cNinja is Off.')))
            }
        }
        die()
    }
    ## Standard Permission Prechecks
    if(!has_permission(player(), 'commandhelper.alias.manager')) {
        die(concat(color(c)'[Ninja]: You are not permitted to use this command'))
    }
    
    assign(@args, parse_args(@arg))
    ## Main >
    
    switch(@args[0]) {
        'on',
            assign(@save_on, get_value(concat('ninja.save.names')))
            if(@save_on == 'null') {
                @save_on = array()
            }
            if(!array_contains_ic(@save_on, @player)) {
                array_push(@save_on, @player)
                store_value(concat('ninja.save.names'), @save_on)
                msg(concat(_chat('Ninja', 'Mode Change'), colorize('&aNinja Mode - ON')))

            } else {
                msg(concat(_chat('Ninja', 'Mode'), colorize('&eNinja Mode is already ON')))
            }
        ,
        'off',
            assign(@save_off, get_value(concat('ninja.save.names')))
            if(@save_off == 'null') {
                @save_off = array()
            }
            if(!array_contains_ic(@save_off, @player)) {
                msg(concat(_chat('Ninja', 'Mode'), colorize('&cNinja Mode is already OFF')))
            } else {
                array_remove_values(@save_off, @player)
                store_value(concat('ninja.save.names'), @save_off)
                msg(concat(_chat('Ninja', 'Mode Change'), colorize('&cNinja Mode - OFF')))
            }
        ,
        'list',
            assign(@players, get_value(concat('ninja.save.names')))
            if(@players == 'null') {
                @players = array()
            }
            if(!array_index_exists(@players, 0)) {
                msg(concat(_chat('Ninja', 'List'), 'There are no Ninjas.'))
                die()
            }
            msg(concat(_chat('Ninja', 'List'), colorize('All players with Ninja Mode - &aON')))
            msg(concat(_chat('Ninja', 'Key'), colorize('&cOffline &aOnline')))
            if(@players != 'null' || @players != '') {
                foreach(@players, @p) {
                    if(ponline(@p)) {
                        msg(concat(colorize(' - &a'.@p)))
                    } else {
                        msg(concat(colorize(' - &c'.@p)))
                    }
                }
                msg(concat(color(a), colorize(@list)))
                die()
            }
        ,
        'set',
            if(!array_index_exists(@args, 1) || @args[1] == '') {
                msg(concat(_chat('Ninja', 'Error'), colorize('&cPlayer name expected...')))
                msg(concat(_chat('Ninja', 'Usage'), '- /ninja set <player> <on|off>'))
                die()
            }
            if(!array_index_exists(@args, 2) || @args[2] == '') {
                msg(concat(_chat('Ninja', 'Error'), colorize('&a on &for &coff &fexpected...')))
                msg(concat(_chat('Ninja', 'Usage'), colorize('- /ninja set '.@args[1].' on | off')))
                die()
            }
            if(!phas_played(@args[1])) {
                msg(concat(_chat('Ninja', 'Error'), colorize(' &e'.@args[1].' &cHas Never played on this server.')))
                die()
            }
            switch(@args[2]) {
            'on',
                msg(concat(_chat('Ninja', 'Player'), colorize('&eChanging Mode for player'.@args[1])))
                _Ninja('on', @args[1])
                die()
            ,
            'off',
                msg(concat(_chat('Ninja', 'Player'), colorize('&eChanging Mode for player'.@args[1])))
                _Ninja('off', @args[1])
                die()
            ,
            #Case Else:
                msg(concat(_chat('Ninja', 'Error'), colorize('&cSomthing went wrong..')))
                msg(concat(_chat('Ninja', 'Usage'), '- /ninja set <player> <on|off>'))
                die()
            }
        ,
        #Case Else:
            die()
    }
)#proc
## ---------- Procedure Ninja ----------
## Sets the players name to a list of Ninja's 
## and other sundry stuff like managing Ninja's
##
## Usage:
##      _Ninja([on|off], player())
##
proc(_Ninja, @request, @player,
    ## Info and Usage
    if(@request == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Ninja', 'd', 'Info', 'f'), 'Join the server like a ninja!'))
        msg(concat(_chatFormat('4', 'Ninja', 'd', 'Usage', 'e'), '- /ninja [on|off]'))
        # WIP: msg(concat(_chatFormat('4', 'Ninja', 'd', 'Usage', 'e'), '- /ninja <player> [on|off]'))
        # WIP: msg(concat(_chatFormat('4', 'Ninja', 'd', 'Usage', 'e'), '- /ninja players [list|clearall]'))
        die()
    }
    ## Standard Permission Prechecks
    if(!has_permission(@player, 'commandhelper.alias.manager')) {
        die(concat(color(c)'[Ninja]: You are not permitted to use this command'))
    }
    ## Main >
    switch(@request) {
        'on',
            assign(@save_on, get_value(concat('ninja.save.names')))
            if(@save_on == 'null') {
                @save_on = array()
            }
            if(!array_contains_ic(@save_on, @player)) {
                array_push(@save_on, @player)
                store_value(concat('ninja.save.names'), @save_on)
                msg(concat(_chatFormat('4', 'Ninja', 'd', 'Mode Change', 'a'), 'Ninja Mode - ON'))
            } else {
                msg(concat(_chatFormat('4', 'Ninja', 'd', 'Opps', 'a'), 'Ninja Mode is already ON'))
            }
        ,
        'off',
            assign(@save_off, get_value(concat('ninja.save.names')))
            if(@save_off == 'null') {
                @save_off = array()
            }
            if(!array_contains_ic(@save_off, @player)) {

                msg(concat(_chatFormat('4', 'Ninja', 'd', 'Opps', 'e'), 'Ninja Mode is already OFF'))
            } else {
                array_remove_values(@save_off, @player)
                store_value(concat('ninja.save.names'), @save_off)
                msg(concat(_chatFormat('4', 'Ninja', 'd', 'Mode Change', 'c'), 'Ninja Mode - OFF'))
            }
        ,
        # WIP > ToDo.
        # 'players',
            # assign(@players, get_value(concat('ninja.save.names')))
            # if(@players == 'null') {
                # @players = array()
            # }
            # msg(concat(_chatFormat('4', 'Ninja', 'd', 'List Ninja\'s', 'e'), 'All players with Ninja Mode - ', color(a), 'ON'))
            # if(!array_index_exists(@players, 0)) {
                # msg(concat(color(a), ' -- There are no Ninja\'s online or offline.'))
                # die()
            # }
            # if(@players != 'null' || @players != '') {
                # assign(@list, ' - ')
                # foreach(@players, @p) {
                    # @list = concat(color(a), @list, @p, ', ')
                # }
                # msg(concat(color(a), @list))
                # die()
            # }
        # ,
        #Case Else:
            #elsecode
    }
    
    
)

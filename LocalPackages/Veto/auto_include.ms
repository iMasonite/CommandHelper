## ---------- Procedure Veto ----------
## This will use GroupManager to demote, ban and then promote
## a player if they have protection from bans such as 'bm.exempt.ban'
## only a player with 'commandhelper.alias.manager' will be able to use this
## plus there is ofc the standard permissions checks on /manuadd ect 
## from their own respective nodes 'groupmanager.manuadd'...
## Usage:
##      _Veto(Campos_Mound, MiniAdmin, 2d, 'Some Reason', player())
##
##
## TODO:  Time format checks
##
proc(_Veto, @user, @group, @time, @reason, @player,
    ## Info and Usage
    if(@user == '' && @group == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Veto', 'd', 'Info', 'f'), 'Demote - Tempban - Promote'))
        msg(concat(color(e)'  Users in Ranked positions that are exempt from ban action\n'
                   '  that can\'t easily be banned via the usual channels can be\n'
                   '  banned using this command. This also extends an in game mail\n'
                   '  message to the user informing them about the ban they\n'
                   '  received and instructs the user where to find the\n'
                   '  relevant information on the forum.'))
        msg(concat(_chatFormat('4', 'Veto', 'd', 'Usage', 'f'), '/veto <user> <inGroup> <time> <reason>'))
        msg(concat(_chatFormat('4', 'Veto', 'd', 'Confirmation', 'f'), '/veto confirm'))
        msg(concat(_chatFormat('4', 'Veto', 'd', 'Cancellation', 'f'), '/veto cancel'))
        msg('')
        die()
    }
    ## Standard Permission Prechecks
    if(!has_permission(@player, 'commandhelper.alias.manager') || !has_permission(@player, 'groupmanager.manuadd')) {
        die(concat(color(c)'[Veto]: You are not permitted to use this command'))
    }
    ## Time Format Checks
    if(!is_integer(@time)) {
        if(reg_count('([0-9]{1,10}[s|m|h|d|w])+', @time) >= 1) {
            @time = reg_match('([0-9]{1,10}[s|m|h|d|w])+', @time)[0]
        } else {
                msg('')
                msg(concat(_chatFormat('4', 'Veto', 'd', 'Error', 'f'), 'The time ', color(e), @time, color(f), ' is not valid.'))
                msg(concat(_chatFormat('4', 'Veto', 'd', 'Example:', 'f'), '5m | 25m | 12h30m | 1d | 1d12h | 1w3d12h15m'))
                die()
        }
    }
    ## Lets go....
    if(@user != '' && @group != '') {
        if(!array_contains_ic(array('VIP', 'Moderator', 'MiniAdmin'), @group)) {
            msg('')
            msg(concat(_chatFormat('4', 'Veto', 'd', 'Error', 'f'), 'The group ', color(e), @group, color(f), ' is not valid.'))
            msg(concat(_chatFormat('4', 'Veto', 'd', 'Usage', 'f'), '/veto <user> <inGroup> <time> <reason>'))
            die()
        }
        
               
        store_value(concat('temp.Veto.save.pending.', @player), array(@user, @time, @reason, @group))
        
        set_timeout(20000,
            closure( 
                assign(@saved, concat('temp.Veto.save.pending.', @player))
                if(has_value(@saved)) {
                    clear_value(@saved)
                    msg(concat(_chatFormat('4', 'Veto', 'd', 'Confirmation', 'f'),'Confirmation time expired...'))
                    die()
                } else {
                    die()
                }
            )
        )
        msg('')
        msg(concat(_chatFormat('4', 'Veto', 'd', 'User to ban', 'f'), @user))
        msg(concat(_chatFormat('4', 'Veto', 'd', 'For time', 'f'), @time))
        msg(concat(_chatFormat('4', 'Veto', 'd', 'For reason', 'f'), @reason))
        msg(concat(_chatFormat('4', 'Veto', 'd', 'They belong to group', 'f'), _rankTag(@group)))
        msg('')
        msg(concat(_chatFormat('4', 'Veto', 'd', 'Confirmation', 'f'),'/veto [', color(a), 'confirm', color(f), ' | ', color(c), 'cancel', color(f), ']' color(e), ' 20sec'))
        die()
   }
    if(@user == 'cancel' && @group == '') {
        assign(@saved, concat('temp.Veto.save.pending.', @player))
        if(has_value(@saved)) {
            clear_value(@saved)
            msg(concat(_chatFormat('4', 'Veto', 'd', 'Confirmation', 'f'), 'Pending ban cancelled.'))
            die()
        } else {
            msg(concat(_chatFormat('4', 'Veto', 'd', 'Error', 'f'),'No saved bans to cancel!'))
            die()
        }
    }
    if(@user == 'confirm' && @group == '') {
        assign(@saved, concat('temp.Veto.save.pending.', @player))

        if(has_value(@saved)) {
            assign(@s, get_value(@saved))
            
            run(sconcat('/manuadd', @s[0], 'builder'))
            
            set_timeout(100,
                closure( 
                    run(sconcat('/tempban', @s[0] , @s[1], '[Veto]:', @s[2]))
                )
            )
            set_timeout(200,
                closure( 
                    run(sconcat('/manuadd', @s[0] , @s[3]))
                )
            )
            set_timeout(300,
                closure( 
                    run(concat('/mail send ', @s[0] , '  [IMPORTANT INFORMATION]: \n',
                                                        '================================================\n',
                                                        '       You were banned for breach of the\n',
                                                        '          >> Terms and Conditions <<\n', 
                                                        '================================================\n',
                                                        '      A Strike may be added to your account\n',
                                                        '      T&C\'s Page: http://goo.gl/ksRbq\n',
                                                        '      Infractions Page: http://goo.gl/zxrM2\n',
                                                        '================================================\n'
                               )
                    )
                )
            )
            #Inform Other Ranked Members at VIP+
            set_timeout(200,
                closure( 
                        foreach(all_players(), @oPlayer) {
                            if(has_permission(@oPlayer, 'commandhelper.alias.vip')) {
                                tmsg(@oPlayer, 
                                    concat(color(e), '--------------------------------------------------',
                                        _chatFormat('4', 'Veto', 'd', 'Player Banned', 'f'), @s[0], color(e), '\n'
                                        'Was banned for breach of the Terms and Conditions of ', _rankTag(@s[3]), color(e), '. This player may receive a strike.\n',
                                        color(a), ' Infractions Page: ', color(d), ' http://goo.gl/zxrM2\n', color(e), 
                                        color(a), ' T&C\'s Page: ', color(d), 'http://goo.gl/ksRbq\n', color(e),
                                        '--------------------------------------------------'
                                    )
                                )
                            }
                        }
                            
                )
            )
        } else {
            msg('')
            msg(concat(_chatFormat('4', 'Veto', 'd', 'Error', 'f'), 'No saved bans to confirm!'))
        }
        clear_value(@saved)
        die()
    }
    if(@user != 'confirm' || @user != 'cancel' && @group == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Veto', 'd', 'Error', 'f'), 'The command', color(c), ' /veto ', @user, color(f), ' is invalid'))
    }
    
)

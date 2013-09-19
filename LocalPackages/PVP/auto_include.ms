## ---------- Procedure demo ----------
## CommandHelper - VariableTriggers Bridge
##
## Usage:
##      _vpvp($tplayer, $request, $, player())
##
proc(_vpvp, @tplayer, @request, @consume, @player,
    ## Info and Usage
    if(@tplayer == '' || @tplayer == '') {
        msg('')
        msg(concat(_chatFormat('4', 'VPVP', 'd', 'Info', 'f'), 'CommandHelper - VariableTriggers Bridge'))
        msg(concat(color(f), ' ================================================'))
        msg(concat(color(a), '  Various commands targeted for use with VariableTriggers'))
        msg(concat(color(a), '  in a PVP arena based environment. As the VariableTriggers'))
        msg(concat(color(a), '  plug-in is limited on what you can do, these commands'))
        msg(concat(color(a), '  these commands will pick up the slack such as setting'))
        msg(concat(color(a), '  a walk/click trigger to execute these commands and'))
        msg(concat(color(a), '  complete tasks that VariableTriggers cant do very well.'))
        msg(concat(color(f), ' ------------------------------------------------'))
        die()
    }
    ## Standard Permission Prechecks
    if(!has_permission(@player, 'vt.admin')) {
        die(concat(color(c)'[VPVP]: You are not permitted to use this command'))
    }
    if(@request == 'antiflee') {
        set_peffect(@tplayer, 20, 0, 15, True)  # 15 Seconds : Wither I
        set_peffect(@tplayer, 9, 1, 15, True)   # 15 Seconds : Nausea II
        set_peffect(@tplayer, 15, 0, 10, True)  # 10 Seconds : Blindness
        set_peffect(@tplayer, 18, 1, 20, True)  # 20 Seconds : Weakness II
        set_peffect(@tplayer, 2, 2, 25, True)   # 25 Seconds : Slowness III
    }
)

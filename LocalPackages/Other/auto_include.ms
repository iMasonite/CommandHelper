proc(_boost, @player,
    ## Standard Permission Prechecks
    if(!has_permission(@player, 'commandhelper.alias.manager')) {
        die(concat(color(c)'[demo]: You are not permitted to use this command'))
    }
    assign(@aarray, entity_velocity(pinfo(@player, 13)))
    
    @pfacing = pfacing(@player)
    @pfacing[0] = @pfacing[0] + 90
    @pfacing[1] = 0 - @pfacing[1]
    
    @x = 2.95 * cos(to_radians(@pfacing[0])) * cos(to_radians(@pfacing[1]))
    @y = max((1.95 * sin(to_radians(@pfacing[1]))) + 0.9, 0.9)
    @z = 2.95 * sin(to_radians(@pfacing[0])) * cos(to_radians(@pfacing[1]))
    
    play_sound(ploc(), array('sound': 'FIZZ', 'pitch': 1, 'volume': 2), @player)
    set_pvelocity(@player, @x, @y, @z)

)#proc

## ---------- Procedure GetBiome ----------
## Gets the biome of a given co-ord or if omitted then the player position is used. 
## Checks for valid data for [x y z] integer/numeric values and validates the world 
## name if provided, current (player()[3]) world if omitted. If an incorrect world 
## is given the exception is handled and informs the user what worlds are loaded on 
## the server.
##
## Teleport feature stores (in temp memory) the co-ords for teleport using a 
## confirmation '/getbiome yes' if the player is in survival mode and the 
## destination is not safe, it will unstick the player (for now) using the 
## /unstuck command via sudo.
##
## Usage Example:
##      _getBiome(@xcoord, @ycoord, @zcoord, @world, @player)
##
## Notes: There is a permission check for moderator+
##        But in the future this could have multiple levels of 
##        permissions so that normal users can make use of finding 
##        a new home in a preferred biome.
##
proc(_getBiome, @xcoord, @ycoord, @zcoord, @world, @player,

    ## Info and Usage
    if(equals(@xcoord, '')) {
        msg('')
        msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Info', 'f'), 'Returns the biome type of a block column.'))
        msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Your current location', 'f'),'/getbiome here '))
        msg(concat(_chatFormat('4', 'GetBiome', 'd', 'An online player name', 'f'),'/getbiome <player>'))
        msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Coordinates', 'f'),'/getbiome <x> <y> <z> [world]'))
        die()
    }
    
    ## Standard Permission Prechecks
    if(not(has_permission(@player, 'commandhelper.alias.moderator'))) {
        die(concat(color(c)'[GetBiome]: You are not permitted to use this command!'))
    }
    
    ## Request to teleport to saved coordinates if any exist
    if(equals_ic(@xcoord, 'yes')) {
        assign(@save, concat('mem.getbiome.save.coordinates.', @player))
        if(has_value(@save)) {
            
            assign(@ploc, get_value(@save))
            set_ploc(@ploc)
            msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Teleported', 'f'), 
                _coordFormat(array(@ploc[0], @ploc[1], @ploc[2]))
                color(b), ' w: ', 
                color(f), @ploc[3]
            ))
            
            ## Check destination is safe
            ## TODO: Add a hight check for unsafe hight as well as the already inside walls, lava ect. checks
            if(equals(_teleportSafe(@player, @ploc), false)) {
                msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Arhhh!', 'f'), 'You were in an unsafe location..'))
                ##TODO: recurse up/down for a free space in code rather than the sudo below
                sudo('/unstuck')
            }
            clear_value(@save)
            die()
        ,
            msg('')
            msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Error', 'f'), 'No saved coordinates!'))
            die()
        }
    }
    
        
    switch(@xcoord) {
        #Capture the 'here' flag
        equals(to_lower(@xcoord), 'here'),
           assign(@p, @player)
           assign(@a, array(
                    integer(ploc(@p)[0]),
                    integer(ploc(@p)[1]),
                    integer(ploc(@p)[2]),
                    ploc(@p)[3]
            ))
            _getBiomeSub(@a[0], @a[2], trim(@a[3]), false)
            die()
        ,
        ## Capture the xcoord flag and check for online player
        ponline(@xcoord),
            assign(@p, @xcoord)
            assign(@a, array(
                    integer(ploc(@p)[0]),
                    integer(ploc(@p)[1]),
                    integer(ploc(@p)[2]),
                    ploc(@p)[3]
            ))
            msg('')
            msg(concat(_chatFormat('a', 'Info', '6', 'Player Information: ', 'f'), _rankTag(array_get(_getExGroup(@p), 0)), ' ' ,color(array_get(_getExGroup(@p), 1)) , @p))
            msg(color(6) '        World: ', color(c), @a[3])
            msg(color(6) '        Coordinates: ', _coordFormat(array(@a[0], @a[1], @a[2])))
            _getBiomeSub(@a[0], @a[2], trim(@a[3]), false)
            die()
        ,
        ## Capture the xcoord, ycoord & zcoord - test for X Number, Y Number, Z Number; if true.. run and kill once finished.
        is_numeric(@xcoord) && is_numeric(@ycoord) && is_numeric(@zcoord),
            _getBiomeSub(integer(@xcoord), integer(@zcoord), @world, true)
            
            store_value(concat('mem.getbiome.save.coordinates.', @player), array(@xcoord, @ycoord, @zcoord, @world))
            die()
        ,
        ## Capture the xcoord, ycoord & zcoord - test for X string, Y blank, Z blank; if true.. 
        ## should be a player offline or player not exist. in any case, inform of player offline.
        not(is_numeric(@xcoord)) && equals(@ycoord, '') && equals(@zcoord, ''),
            msg('')
            msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Error', 'f'), 'The specified player is ', color(c), 'OFFLINE!'))
            die()
        ,
        ##Case else
            msg('')
            msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Error', 'f'), 'help : /getbiome'))
            die()
    }
)
## ---------- Procedure GetBiomeSub ----------
## Reusable method for _GetBiome()
##
## Usage Example:
##      x, y, z, world, teleport[true|false]
##      _getBiomeSub(integer(ploc(player())[0]), integer(ploc(player())[2]), trim(ploc(player())[3]), true)
##
proc(_getBiomeSub, @xcoord, @zcoord, @world, @teleport,
    try(
        msg('')
        msg(concat(_chatFormat('4', 'GetBiome', '6', 'The biome is', 'c'), get_biome(@xcoord, @zcoord, @world)))
        if(equals(@teleport, true)) {
            msg(concat(_chatFormat('4', 'GetBiome', '6', 'Teleport to this location?', 'f'), color(b), '/getbiome yes'))
        }
        , @exception, 

            if(equals(array_get(@exception, 0), InvalidWorldException),
                msg('')
                msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Invalid World', 'f'), 'The World: ', color(c), @world))
                msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Invalid World', 'f'), 'does not exist, please try again...' ))
                msg('')
                foreach(get_worlds(), @worlds,
                    msg(concat(_chatFormat('4', 'GetBiome', 'd', 'Loaded World', 'e'), @worlds))
                )
            )
        , array(InvalidWorldException, CastException)
    )
)
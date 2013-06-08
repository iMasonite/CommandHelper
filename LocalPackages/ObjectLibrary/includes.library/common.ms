## ---------- Reusable Return Procedure chatFormat ----------
## Most chat messages to the user encompass a tag and
## formatting. Keeping the everything on a whole friendly
## on the eyes and easy to navigate in-game and code.
##
## Uniform aspect on a global scale of all chat bound messages.
##
## Usage Example:
##      _chatFormat('d', iCommand, 'e', 'Information Text', 'f')
## Returns:
##      Formatted String of text to be used in the chat, Example: &f[&diCommand&f] &eInformation Text&7: &f
##
proc(_chatFormat, @prefixcolor, @prefix, @textcolor, @text, @messagecolor,
    return (
        concat(
            color(f),
            ' [',
            color(@prefixcolor),
            @prefix,
            color(f),
            '] ',
            color(@textcolor),
            @text,
            color(7),
            ': ',
            color(@messagecolor)
        )
    )
)
## ---------- Reusable Return Procedure coordFormat ----------
## Coordinates format output for the chat to make the coordinates
## easy to read in game.
##
## Usage:
##      _coordFormat(array(-47, 64, -897, world))
## Returns:
##      Formatted array of Coordinates x y z. equiv to i.e. x: -47 y: 64 z: 897
##
proc(_coordFormat, @coordArray,
    assign(@cleanme,
        concat(
            color(b),
            'x: ', color(f), 
            @coordArray[0], color(b), 
            ' y: ', color(f), 
            @coordArray[1], color(b), 
            ' z: ', color(f), 
            @coordArray[2],
        )
    )
    return (
        replace(replace(@cleanme, '{', ''), '}', '')
    )
)


## ---------- Reusable Return Procedure rankTag ----------
## Place to hold this so its reusable and uniform.
## If it needs altering later, no searching for all instances
## simply edit in this one place.
##
## Usage Example:
##      _rankTag(4)
## Returns:
##      Formatted String of text, Example: &f[&9Manager&f]
##
proc(_rankTag, @rankReq,

    switch(to_lower(@rankReq)) {
            '',
                return (concat(color(f), '[', color(f), 'Default', color(f), ']')),
            array(0, 'b', 'builder'),
                return (concat(color(f), '[', color(a), 'Builder', color(f), ']')),
            array(1, 'v', 'vip'),
                return (concat(color(f), '[', color(2), 'VIP', color(f), ']')),
            array(2, 'm', 'mod', 'moderator'),
                return (concat(color(f), '[', color(b), 'Moderator', color(f), ']')),
            array(3, 'mini', 'miniadmin'),
                return (concat(color(f), '[', color(6), 'MiniAdmin', color(f), ']')),
            array(4, 'man', 'manager'),
                return (concat(color(f), '[', color(9), 'Manager', color(f), ']')),
            array(5, 'a', 'admin'),
                return (concat(color(f), '[', color(c), 'Admin', color(f), ']')),
            array(6, 'o', 'owner'),
                return (concat(color(f), '[', color(4), 'Owner', color(f), ']')),
                
                return (concat(color(f), '[', color(f), 'Default', color(f), ']'))
    }
)


## ---------- Reusable Return Procedure getExGroup ----------
## Get the exact group of the player and return the name
## and associated color of the tag of the rank.
##
## Usage Example:
##      _getExGroup(player())
## Returns:
##      Array of values, Example: {"Admin", "c"}
##
## Notes: Must search in reverse order or an admin would match
##        a builder or VIP ect ect...
##        For now this is using pgroup(@player) but i would like it to read
##        GroupManager's YML file so this can check offline players.
##        This is somthing of a TODO.
##
proc(_getExGroup, @player,
 ifelse(array_contains_ic(pgroup(@player), Admin),
            return(array(Admin, c))
        ,
        array_contains_ic(pgroup(@player), Manager),
            return(array(Manager, 9))
        ,
        array_contains_ic(pgroup(@player), MiniAdmin),
            return(array(MiniAdmin, 6))
        ,
        array_contains_ic(pgroup(@player), Moderator),
            return(array(Moderator, b))
        ,
        array_contains_ic(pgroup(@player), VIP),
            return(array(VIP, 2))
        ,
        array_contains_ic(pgroup(@player), Builder),
            return(array(Builder, a))
        ,#else
            return(array(Default, e))
    )
)


## ---------- Reusable Return Procedure teleportSafe ----------
## Takes an array of coordinates in ploc(@player) format and
## runs it through a battery of checks to see if the destination
## is safe for a player in survival mode to teleport.
##
## Usage Example:
##      _teleportSafe(array(-47, 64, -897, world))
## Returns:
##      boolean
##
## Notes: For now, this will check blocks in range;
##         - 1 Above head hight
##         - 1 At head hight
##         - 1 At leg hight
##         - 1 Below feet hight
##   TODO: - gte >= 10 below feet hight (air, falling losing 2.5 hearts)
##   TODO: - 1 at bedrock for air, ungenerated chunk.
##
##         Block Types are a planned config option. This will be
##         the above blocks to check on each option as safe/unsafe/passthrough
##         If these blocks need to be changed at any point the it can be done
##         with ease, and can be used elswhere in the iCommands framework.
proc(_teleportSafe, @player, @coords,

    ##TODO: Pop a sq region check in here for flagged 
    ## game-mode:SURVIVAL regions (then even if creative run the checks)
    ## entry:DENY regions (they are deny for a reason)
    
    assign(@issafe, false)
    if(equals_ic(pmode(@player), 'CREATIVE')) {
        @issafe = true
    ,#Esle
    
        ## TODO: 
        ## Lets make sure we have valid data on this. Internal exception
        ## cast, abort the checks, continue out with return true
        ## and no notifications. (like this never happend!)
        if(is_array(@coords) && array_index_exists(@coords, 3)) {
            ## Block Types
            assign(@safe, array(0, 8, 9, 111, 65, 106))
            assign(@unsafe, array(10, 11, 51))
            assign(@passthrough, array(6, 31, 32, 37, 38, 39, 40, 50, 68, 78, 321, 323, 389, 390, 69, 75, 76, 77, 131, 143, 331))
            
            #Set at y: at checkable levels if input is more than world range hight/depth
            if(integer(@coords[1]) <= 5, @coords[1] = 5)
            if(integer(@coords[1]) >= 250, @coords[1] = 250)
            
            #Real position fix. [ploc() gives wrong; 1 block column offset to the east]
            assign(@rp, array(integer(@coords[0] - 1), integer(@coords[1] + 0), integer(@coords[2] + 0), @coords[3]))
            
            #Array of truth
            assign(@truth, array())
            
            #Below feet hight, true if block is Not = @unsafe
            if(not(array_contains(@unsafe, split(':', get_block_at(array(@rp[0], @rp[1] + 0, @rp[2], @rp[3])))[0]))) {
                array_push(@truth, true) , array_push(@truth, false) 
            }
            #At leg hight, true if block is Not = @unsafe
            if(not(array_contains(@unsafe, split(':', get_block_at(array(@rp[0], @rp[1] + 1, @rp[2], @rp[3])))[0]))) {
                array_push(@truth, true) , array_push(@truth, false) 
            }
            #At head hight, true if block is = @safe OR @passthrough
            if(array_contains(@safe, split(':', get_block_at(array(@rp[0], @rp[1] + 2, @rp[2], @rp[3])))[0]) ##OR
            || array_contains(@passthrough, split(':', get_block_at(array(@rp[0], @rp[1] + 2, @rp[2], @rp[3])))[0])) {
                array_push(@truth, true) , array_push(@truth, false) 
            }
            #Above head hight, true if block is Not = @unsafe
            if(not(array_contains(@unsafe, split(':', get_block_at(array(@rp[0], @rp[1] + 3, @rp[2], @rp[3])))[0]))) {
                array_push(@truth, true) , array_push(@truth, false) 
            }
        }
        if(not(array_contains(@truth, false))) {
            @issafe = true
        }
    }
    return(boolean(@issafe))
)
## ---------- Reusable Return Procedure getSq_RegionData ----------
## Takes a region name for the current world and tests if
## it exists in this world, if it does not then the exception 
## is handled and the info displayed to the user.
##
## Usage:
##      _getSq_RegionData(@region, @world, @player, @extension)
## Returns:
##      Array of the supplied region's data.
##
proc(_getSq_RegionData, @region, @world, @player, @extension,
    try(
        assign(@regiondata, sk_region_info(@region, @world))
        
        , @exception, 
            if(equals(array_get(@exception, 0), PluginInternalException)) {
                msg(concat(_chatFormat('4', @extension, 'd', 'Region Not Found!', 'f'), 'In World: ', color(c), @world))
                msg('')
                die()
            }
        ,
        array(PluginInternalException, CastException)
    )
    return (
        @regiondata
    )
)
## ---------- Reusable Procedure validateWorlds ----------
## Checks if a world exits (loaded) and if it fails then
## it will inform the user what worlds are loaded. 
##
## If @justdefault is true it wont inform the user it will just
## return the players current world.
##
## Usage:
##      _validateWorlds(@world, @extension, @justdefault)
## Returns:
##      World Name after success testing or default if required
##
# proc(_validateWorlds, @world, @player, @extension, @justdefault,
    # assign(@worldsloaded, array())
    # foreach(get_worlds(), @worldloaded) {
        # array_push(@worldsloaded, @worldloaded)
    # }
    # if(not(array_contains(@worldsloaded, @world))) {
        # msg('')
        # msg(concat(_chatFormat('4', @extension, 'd', 'Invalid World', 'f'), 'The World: ', color(c), @world))
        # msg(concat(_chatFormat('4', @extension, 'd', 'Invalid World', 'f'), 'does not exist, please try again...' ))
        # assign(@loaded, '')
        # foreach(get_worlds(), @worlds) {
            # @loaded = concat(@loaded, concat('\'', @worlds, '\' '))
        # }
        # msg(concat(_chatFormat('4', @extension, 'd', 'Worlds', 'e'), @loaded))
        # die()
    # }
    # assign(@return, @world)
    # if(equals(@justdefault, false)) {
        # @return = ploc(@player)[3]
    # , 
        # @return = @world
    # }
    # msg('@return' : @return)
    # return(
        # @return
    # )
# )


## ---------- Reusable Return Procedure teleFlagClean ----------
## The flag for teleport is a huge soup of a double with far
## too many decimals. This solves that problem.
##
## Usage:
##      _teleFlagClean(ArrayOfCoords)
## Returns:
##      Formatted array of Coordinates x y z. equiv to i.e. {-47, 64, 897}
##
proc(_teleFlagClean, @flagArray,
    if(equals_ic(@flagArray[0], 'teleport'),
        assign(@getme, split(':', @flagArray[1]))
        assign(@editme, trim(@getme[2]))
        assign(@replme, replace(replace(@editme, ')', ''), '(', ''))
        assign(@chopme, split(',', @replme))
        assign(@clean, array(integer(@chopme[0]), integer(@chopme[1]), integer(@chopme[2])))
        return (
            @clean
        )
    )
)



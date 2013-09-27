## --------- void GroupManager Groups Data ----------
## Array of all GroupManager Data to be loaded
## Into Memory for [x] seconds minimum before
## a refresh looking for new data is preformed.
## A refresh will only run if the subroutine is run.
##
## Usage:
##      _gMGroupsData(args)
##
## Arguments: [optional] <required>
##      [mansave] - Boolean
##          Force GroupManager to save its current data
##          and clear previous saved data in memory
##          so that the data in memory is fresh.
## Returns:
##      nothing.
##      Stores data in memory for use with other procedures.
##
proc(_gMGroupsData, @mansave,

    assign(@groupsymlloc, '../../../../GroupManager/worlds/world/groups.yml')
    assign(@memYmlAry, array())
    assign(@time, integer(time()))

    if(@mansave == True) { 
        runas(~console, '/mansave')
        assign(@time, integer(time()))
        if(has_value('mem.groupmanager.groups.array')) {
            clear_value('mem.groupmanager.groups.array')
            console('GroupManager Groups Data Array: -- Cleared')
        }
    }
    if(has_value('mem.groupmanager.groups.refreshtime')) {
        assign(@refreshtime, integer(get_value('mem.groupmanager.groups.refreshtime')))
        if(@time >= @refreshtime) {
            clear_value('mem.groupmanager.groups.array')
            console('GroupManager Groups Data Array: -- Cleared')
        }
    }
    if(has_value('mem.groupmanager.groups.array')) {
        assign(@memYmlAry, get_value('mem.groupmanager.groups.array'))
    } else {
        sys_out('Read GroupManager File : groups.yml')
        try(
            assign(@memYmlAry, yml_decode(read(@groupsymlloc)))
            , 
            @exception
            , 
            trace(@exception)
            if(equals(array_get(@exception, 0), IOException)) {
                sys_err('CommandHelper failed to get GroupManager File : groups.yml: IOException')
                sys_err('Location Tried:' @groupsymlloc)
                sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
                die(concat(color(c),' [Error]: ', @exception[0], '\n',
                                    ' A Space Monkey has damaged the code!!!\n',
                                    ' Please report this error to iMasonite')
                )
            }
            ,
            array(IOException)
        )
        store_value('mem.groupmanager.groups.array', @memYmlAry)
        store_value('mem.groupmanager.groups.refreshtime', integer(@time + 240000))
    }
)#proc

## ---------- function GroupManager Group List ----------
## Array of Group Names in the order of the id:
## <group>:info:id: ##
##
## Usage:
##      _gMGroupList()
##
## Arguments: None
##
## Returns:
##      array.
##
proc(_gMGroupList,
    
    _gMGroupsData(false)
    assign(@ymlAry, array())
    assign(@groupnames, array())

    if(has_value('mem.groupmanager.groups.array')) {
        assign(@ymlAry, get_value('mem.groupmanager.groups.array'))
    } else {
        sys_err('CommandHelper failed to get Groups Data for: Group List')
        sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
    }
    if(array_size(@ymlAry['groups']) > 0) {
        try(
            foreach(array_keys(@ymlAry['groups']), @group,
                assign(@id, @ymlAry['groups'][@group]['info']['id'])
                array_set(@groupnames, integer(@id), @group)
            )
            , 
            @exception
            , 
            trace(@exception)
            if(equals(array_get(@exception, 0), IndexOverflowException)) {
                sys_err(' iMasonite - Epic Fail: failed to get -- ' @group ':info:id <int>')
                sys_err(' The group: '  @group ' does not have an ID')
                sys_err(' Use CMD: /mangaddv ' @group ' id <integer> then CMD: /mansave')
                sys_err(' The lowest group (default one) should be 0 working up to the higher ranks (in order) <id>++')
                sys_err(' Bug Reports: https://github.com/iMasonite/CommandHelper')
                if(has_value('mem.groupmanager.groups.array')) {
                    clear_value('mem.groupmanager.groups.array')
                }
                die(concat(color(c),' [Error]: ', @exception[0], '\n',
                                    ' A Space Monkey has damaged the code!!! See Console.\n',
                                    ' Please report this error to iMasonite')
                )
            }
            ,
            array(IndexOverflowException)
        )
        return (
            array_normalize(@groupnames) 
        )
    }
)#proc

## ---------- function GroupManager Group Data ----------
## Get data for the requested group and data type.
##
## Usage:
##      _gMGroupData(VIP, permissions)
##
## Arguments: [optional] <required>
##      <groupReq> = Name of the group required i.e 'VIP'
##      <dataReq>  = Field of the group required i.e 'prefix' or 'permissions'
##
## Returns:
##      array, int, string, boolean
##
proc(_gMGroupData, @groupReq, @dataReq,
    
    _gMGroupsData(false)
    assign(@ymlAry, array())
    assign(@return, array())

    if(has_value('mem.groupmanager.groups.array')) {
        assign(@ymlAry, get_value('mem.groupmanager.groups.array'))
    } else {
        sys_err('CommandHelper failed to get Groups Data for: Group Data')
        sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
        die(concat(color(c),' [Error]: \n',
                            ' A Space Monkey has damaged the code!!! See Console.\n',
                            ' Please report this error to iMasonite')
        )
    }
    try(
        if(!array_size(@ymlAry['groups']) == 0) {
            if(!array_size(@ymlAry['groups'][@groupReq]) == 0) {
                switch(@dataReq) {
                    array('default', 'def'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['default']))
                    ,
                    array('inheritance', 'inh'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['inheritance']))
                    ,
                    array('permissions', 'perms', 'perm'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['permissions']))
                    , 
                    array('id'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['info']['id']))
                    , 
                    array('purchasable', 'purch', 'buy'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['info']['purchasable']))
                    , 
                    array('prefix', 'pre'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['info']['prefix']))
                    , 
                    array('build'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['info']['build']))
                    , 
                    array('suffix', 'suf'),
                        return (assign(@return, @ymlAry['groups'][@groupReq]['info']['suffix']))
                    , 
                    #Case Else:
                        throw(InsufficientArgumentsException, 'Forced Exception')
                }
            }
        }
        , 
        @exception
        , 
        if(@exception[0] ==  InsufficientArgumentsException) {
            sys_err(' Unable to find the data: ' @dataReq ' The value may not exist.')
            sys_err(' Bug Reports: https://github.com/iMasonite/CommandHelper')
            msg(sconcat(color(c),'iMasonite"s Space Monkey says..\n - Unable to find the data for:', color(e), @dataReq))
            die()
        }
        if(@exception[0] == IndexOverflowException) {
            sys_err(' Unable to find the group: ' @groupReq ' The group may not exist.')
            sys_err(' Bug Reports: https://github.com/iMasonite/CommandHelper')
            msg(sconcat(color(c),'iMasonite"s Space Monkey says..\n - Unable to find the group:', color(e), @groupReq))
            die()
        }
        ,
        array(IndexOverflowException, InsufficientArgumentsException)
    )
)#proc

## --------- void GroupManager Users Data ----------
## Array of all GroupManager Users Data to be loaded
## Into Memory for 60 seconds minimum before
## a refresh looking for new data is preformed.
## A refresh will only run if the subroutine is run.
##
## Usage:
##      _gMUsersData(args)
##
## Arguments: [optional] <required>
##      [mansave] - Boolean
##          Force GroupManager to save its current data
##          and clear previous saved data in memory
##          so that the data returned is fresh.
## Returns:
##      nothing.
##      Stores data in memory for use with other procedures.
##
proc(_gMUsersData, @mansave,

    assign(@usersymlloc, '../../../../GroupManager/worlds/world/users.yml')
    assign(@memYmlAry, array())
    assign(@time, integer(time()))

    if(@mansave == True) { 
        runas(~console, '/mansave')
        assign(@time, integer(time()))
        if(has_value('mem.groupmanager.users.array')) {
            clear_value('mem.groupmanager.users.array')
            console('GroupManager Users Data Array: -- Cleared')
        }
    }
    if(has_value('mem.groupmanager.users.refreshtime')) {
        assign(@refreshtime, integer(get_value('mem.groupmanager.users.refreshtime')))
        if(@time >= @refreshtime) {
            clear_value('mem.groupmanager.users.array')
            console('GroupManager Users Data Array: -- Cleared')
        }
    }

    if(has_value('mem.groupmanager.users.array')) {
        assign(@memYmlAry, get_value('mem.groupmanager.users.array'))
    } else {
        sys_out('Read GroupManager File : users.yml')
        try(
            assign(@memYmlAry, yml_decode(read(@usersymlloc)))
            , 
            @exception
            , 
            trace(@exception)
            if(equals(array_get(@exception, 0), IOException)) {
                sys_err('CommandHelper failed to get GroupManager File : users.yml: IOException')
                sys_err('Location Tried:' @usersymlloc)
                sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
                die(concat(color(c),' [Error]: ', @exception[0], '\n',
                                    ' A Rabid Squirrel has damaged the code!!!\n',
                                    ' Please report this error to iMasonite')
                )
            }
            ,
            array(IOException)
        )
        store_value('mem.groupmanager.users.array', @memYmlAry)
        store_value('mem.groupmanager.users.refreshtime', integer(@time + 60000))
    }
)#proc

## ---------- function GroupManager User List ----------
## Array of User Names:
##
## Usage:
##      _gMUserList()
##
## Arguments: None
##
## Returns:
##      array.
##
proc(_gMUserList,
    
    _gMUsersData(false)
    assign(@ymlAry, array())
    assign(@usernames, array())

    if(has_value('mem.groupmanager.users.array')) {
        assign(@ymlAry, get_value('mem.groupmanager.users.array'))
    } else {
        sys_err('CommandHelper failed to get Users Data for: GroupManager Users')
        sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
        die(concat(color(c),' [Error]:\n',
                            ' A Rabid Squirrel has damaged the code!!!\n',
                            ' Please report this error to iMasonite')
        )
    }
    if(array_size(@ymlAry['users']) > 0) {
        foreach(array_keys(@ymlAry['users']), @user,
            array_push(@usernames, @user)
        )
        return (
            array_normalize(@usernames) 
        )
    }
)#proc

## ---------- function GroupManager User Data ----------
## Get data for the requested user and data type.
##
## Usage:
##      _gMUserData(@userReq, @dataReq)
##
## Arguments: [optional] <required>
##      <userReq>  = Name of the user required i.e 'iMasonite'
##      <dataReq>  = Field of the user data required i.e 'group' or 'prefix'
##
## Returns:
##      array, int, string, boolean
##
proc(_gMUserData, @userReq, @dataReq,
    
    _gMUsersData(false)
    assign(@ymlAry, array())
    assign(@return, array())

    if(has_value('mem.groupmanager.users.array')) {
        assign(@ymlAry, get_value('mem.groupmanager.users.array'))
    } else {
        sys_err('CommandHelper failed to get User Data for: User Data')
        sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
        die(concat(color(c),' [Error]: \n',
                            ' A Rabid Squirrel has damaged the code!!!\n',
                            ' Please report this error to iMasonite')
        )
    }
    try(
        if(!array_size(@ymlAry['users']) == 0) {
            if(!array_size(@ymlAry['users'][@userReq]) == 0) {
                switch(@dataReq) {
                    array('group'),
                        return (assign(@return, @ymlAry['users'][@userReq]['group']))
                    ,
                    array('subgroups', 'sub'),
                        return (assign(@return, @ymlAry['users'][@userReq]['subgroups']))
                    ,
                    array('permissions', 'perms', 'perm'),
                        return (assign(@return, @ymlAry['users'][@userReq]['permissions']))
                    , 
                    array('prefix', 'pre'),
                        try(
                            return (assign(@return, @ymlAry['users'][@userReq]['info']['prefix']))
                            ,@exception, IndexOverflowException
                            sys_out(' Unable to find the data: ' @dataReq ' The user may not have one.')
                        )
                    , 
                    array('role', 'info'),
                        try(
                            return (assign(@return, @ymlAry['users'][@userReq]['info']['role']))
                            ,@exception, IndexOverflowException
                            sys_out(' Unable to find the data: ' @dataReq ' The user may not have one.')
                        )
                    , 
                    #Case Else:
                        throw(InsufficientArgumentsException, 'Forced Exception')
                }
            }
        }
        , 
        @exception
        , 
        if(@exception[0] ==  InsufficientArgumentsException) {
            sys_err(' Unable to find the data: ' @dataReq ' The value may not exist.')
            sys_err(' Bug Reports: https://github.com/iMasonite/CommandHelper')
            msg(sconcat(color(c),'iMasonite"s Rabid Squirrel says..\n - Unable to find the data for:', color(e), @dataReq))
            die()
        }
        if(@exception[0] == IndexOverflowException) {
            sys_err(' Unable to find the user: ' @userReq ' The user may not exist.')
            sys_err(' Bug Reports: https://github.com/iMasonite/CommandHelper')
            msg(sconcat(color(c),'iMasonite"s Rabid Squirrel says..\n - Unable to find the user:', color(e), @userReq))
            die()
        }
        ,
        array(IndexOverflowException, InsufficientArgumentsException)
    )
)#proc
## ---------- Procedure shopActionsRegister ----------
proc(_shopActionsRegister, @zone, @owner, @description, @player, @world,
    ## Info and Usage on the '/shops reg' command
    if(@zone == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Register', 'f'), '/shops reg <main-region> <owner> [Desc]'))
        msg(concat(color(e), '    To register a licence to a shop zone you must have a\n',   
        '    ', color(b), 'main-region', color(e), ' set up ready to encompass a bunch of smaller\n',
        '    regions as shops. The name must be a recognisable region\n',
        '    name such as "MineMall-Main" or "ServerShop-Main".'))
        msg(concat(color(b), '  - <owner> ', color(e), 'is the owner of the region.'))
        msg(concat(color(b), '  - [Desc] ', color(e), 'Adds a description for entry of the zone.'))
        msg('')
        die()
    }
    ## Check to make sure the region exists in the current world
    if(!sk_region_exists(@world, @zone)) {
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat(color(c), 'WorldGuard Region: ', color(e), @zone)))
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('does not exist. Please define it first.')))
        die()
    }
    ## Make sure the owner variable is not null
    if(@owner != '') {
        ## format the zone for namespace format requirements / prevent dupes
        assign(@szone, reg_replace('[^\\ _dA-Za-z0-9]', '_', @zone))
        ## Grab the current unix time
        assign(@time, time())
        
        ## make sure that the zone is not already registered
        if(has_value(concat('shops.zones.', @szone, '.registertime'))) {
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Zone: ', color(e), @zone)))
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Already exists or is unavailable.')))
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Usage', 'f'), concat('Use: ', color(b), '/shops edit ', color(b), @zone)))
            die()
        } else {
            if(has_value('shops.list')) {
                assign(@list, get_value('shops.list'))
                array_push(@list, @zone)
                array_sort(@list, 'STRING_IC')
                store_value('shops.list', @list)
            } else {
                assign(@list, array())
                array_push(@list, @zone)
                store_value('shops.list', @list)
            }
            store_value(concat('shops.zones.', @szone, '.registrar'), @player)
            store_value(concat('shops.zones.', @szone, '.registertime'), @time)
            store_value(concat('shops.zones.', @szone, '.modifiedby'), null)
            store_value(concat('shops.zones.', @szone, '.modifytime'), null)
            store_value(concat('shops.zones.', @szone, '.owner'), @owner)
            store_value(concat('shops.zones.', @szone, '.description'), @description)
            store_value(concat('shops.zones.', @szone, '.world'), @world)
            
            if(@description != '' || @description != null) {
                sk_region_flag(@world, @zone, greeting, @description)
            }
            
            
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Register', 'f'), 'Successfully registered a licence to region.'))
            msg(concat(color(e),
            '    ', color(b), 'Region/Zone: ', color(e), @zone, '\n',
            '    ', color(b), 'Registrar: ', color(e), @player, '\n',
            '    ', color(b), 'Register Time: ', color(e), sprintf('%1$td/%1$tb/%1$tY %1$tH:%1$tM %1$tZ', @time), '\n',
            '    ', color(b), 'Zone Owner: ', color(e), @owner, '\n',
            '    ', color(b), 'Description: ', color(e), @description,
            ))

        }
    } else {
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'c'), 'You must supply -', color(b), ' <owner>', color(c), ' name.'))
        die()
    }
)
#endproc

## ---------- Procedure shopActionsEdit ----------
proc(_shopActionsEdit, @zone, @owner, @description, @player, @world,
    ## Info and Usage on the '/shops edit' command
    if(@zone == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Edit', 'f'), '/shops edit <zone> <owner> [Desc]'))
        msg(concat(color(b), '  - <owner> ', color(e), 'is the owner of the region.'))
        msg(concat(color(b), '  - [Desc] ', color(e), 'A short description about the zone.'))
        msg('')
        die()
    } else {
        ## format the zone for namespace format requirements / prevent dupes
        assign(@szone, reg_replace('[^\\ _dA-Za-z0-9]', '_', @zone))

        ## make sure that the zone has a licence
        if(!has_value(concat('shops.zones.', @szone, '.registertime'))) {
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Zone: ', color(e), @zone)))
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Is not licenced. Use: ', color(b), '/shops reg')))
        
        } else {
            assign(@time, time())
            assign(@savedOwner, get_value(concat('shops.zones.', @szone, '.owner')))
            assign(@savedDescription, get_value(concat('shops.zones.', @szone, '.description')))
        
            if(@owner == '') {
                if(has_value(concat('shops.zones.', @szone, '.owner'))) {
                    store_value(concat('shops.zones.', @szone, '.owner'), @savedOwner)
                    
                } else {
                    msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'c'), 'You must supply -', color(b), ' <owner>', color(c), ' name.'))
                    die()
                }
            } else {
                store_value(concat('shops.zones.', @szone, '.owner'), @owner)
            }
            if(@description != null) {
                store_value(concat('shops.zones.', @szone, '.description'), @description)
                sk_region_flag(@world, @zone, greeting, @description)
            }
            store_value(concat('shops.zones.', @szone, '.modifiedby'), @player)
            store_value(concat('shops.zones.', @szone, '.modifytime'), @time)
            
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Register', 'f'), 'Successfully edited a licence for a region.'))
            msg(concat(color(e),
            '    ', color(b), 'Region/Zone: ', color(e), @zone, '\n',
            '    ', color(b), 'Modified By: ', color(e), @player, '\n',
            '    ', color(b), 'Modify Time: ', color(e), sprintf('%1$td/%1$tb/%1$tY %1$tH:%1$tM %1$tZ', @time), '\n',
            '    ', color(b), 'Zone Owner: ', color(e), @owner, '\n',
            '    ', color(b), 'Description: ', color(e), @description,
            ))
        }
    }
)
#endproc

## ---------- Procedure shopActionsRemove ----------
proc(_shopActionsRemove, @zone, @player, @world,
    ## Info and Usage on the '/shops remove' command
    if(@zone == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Remove', 'f'), '/shops remove <zone>'))
        msg(concat(color(b), '  - <zone> ', color(e), 'The zone to remove a licence from.'))
        msg('')
        die()
    } else {
        ## format the zone for namespace format requirements / prevent dupes
        assign(@szone, reg_replace('[^\\ _dA-Za-z0-9]', '_', @zone))

        if(!has_value(concat('shops.zones.', @szone, '.registertime'))) {
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Zone: ', color(e), @zone)))
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Is not licenced. Use: ', color(b), '/shops reg')))
            die()
        } else {
            if(has_value('shops.list')) {
                assign(@list, get_value('shops.list'))
                array_remove_values(@list, @zone)
                store_value('shops.list', @list)
            }
            clear_value(concat('shops.zones.', @szone))
            sk_region_flag(@world, @zone, greeting, null)

            msg(concat(_chatFormat('4', 'Shops', 'd', 'Remove', 'f'), 'Successfully removed a licence.'))
            msg(concat(color(e),
            '    ', color(b), 'Region/Zone: ', color(e), @zone, '\n',
            ))
        }
    }
)
#endproc

## ---------- Procedure shopActionsList ----------
proc(_shopActionsList, @zone, @player, @world,
    
    if(@zone == '') {
        if(has_value(concat('shops.list'))) {
            assign(@list, get_value(concat('shops.list')))
            if(array_size(@list) > 0) {
                msg(concat(_chatFormat('4', 'Shops', 'd', 'List', 'f'), 'All Shopping Zones on the server.'))
                foreach(@list, @registeredzone) {
                    msg(concat(color(e), '    - ', @registeredzone))
                }
                msg(concat(_chatFormat('4', 'Shops', 'd', 'More Info', 'b'), '/shops list <zone>'))
            } else {
                msg(concat(_chatFormat('4', 'Shops', 'd', 'List', 'c'), 'There are no shops currently licenced.'))
            }
        }
    } else {
        ## format the zone for namespace format requirements / prevent dupes
        assign(@szone, reg_replace('[^\\ _dA-Za-z0-9]', '_', @zone))

        if(!has_value(concat('shops.zones.', @szone, '.registertime'))) {
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Zone: ', color(e), @zone)))
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Error', 'f'), concat('Is not licenced. Use: ', color(b), '/shops list')))
            die()
        } else {
            assign(@owner, get_value(concat('shops.zones.', @szone, '.owner')))
            assign(@description, get_value(concat('shops.zones.', @szone, '.description')))
            assign(@rworld, get_value(concat('shops.zones.', @szone, '.world')))
            
            assign(@registrar, get_value(concat('shops.zones.', @szone, '.registrar')))
            assign(@registertime, get_value(concat('shops.zones.', @szone, '.registertime')))
            assign(@modifiedby, get_value(concat('shops.zones.', @szone, '.modifiedby')))
            assign(@modifytime, get_value(concat('shops.zones.', @szone, '.modifytime')))
            
            msg('')
            msg(concat(_chatFormat('4', 'Shops', 'd', 'Licenced', 'f'), concat('Information on: ', color(e), @zone)))
            
            msg(concat(color(e),
            '    ', color(b), 'Zone Owner: ', color(e), @owner, '\n',
            '    ', color(b), 'Description: ', color(e), @description, '\n',
            '    ', color(b), 'World: ', color(e), @rworld)
            )
            msg(color(d)'--Stats--')
            msg(concat(color(e),
            '    ', color(b), 'Shop Plots: ', color(e), @plots, '\n',
            '    ', color(b), 'Shops Vacant: ', color(e), @vacant, '\n',
            '    ', color(b), 'Customers, past week: ', color(e), @customersweek, '\n',
            '    ', color(b), 'Customers, all time: ', color(e), @customersall)
            )
                        
            if(has_permission(player(), 'commandhelper.alias.manager') || has_permission(player(), 'icmd.override.shops.list.extra')) {
                msg(color(d)'--Extra--')
                msg(concat(color(e),
                '    ', color(9), 'Registrar: ', color(e), @registrar, '\n',
                '    ', color(9), 'Register Time: ', color(e), sprintf('%1$td/%1$tb/%1$tY %1$tH:%1$tM %1$tZ', @registertime))
                )
                if(@modifytime != 0){
                    msg(concat(color(e),
                    '    ', color(9), 'Modified By: ', color(e), @modifiedby, '\n',
                    '    ', color(9), 'Modify Time: ', color(e), sprintf('%1$td/%1$tb/%1$tY %1$tH:%1$tM %1$tZ', @modifytime))
                    )
                }
            }
        }
    }
)
#endproc

## ---------- Procedure shopActionsList ----------
proc(_shopActionsInit, @prefix, @player, @world,

    ## Info and Usage on the '/shops initialize' command
    if(@zone == '') {
        msg('')
        msg(concat(_chatFormat('4', 'Shops', 'd', 'Initialize', 'f'), '/shops initialize <prefix>'))
            msg(concat(color(b), 
                '  - <prefix> ', color(e), 'the prefix of the shop, i.e "ss-shp"\n', 
                '  The prefix is the overall tag of each shop followed by the\n', 
                '  floor i.e "gf" for ground floor "ff" for first floor and so\n', 
                '  on. Each shop in the zone is required to have this in the\n',  
                '  region name or the system simply will not work. An example\n', 
                '  shop region name would be ', color(b), 'ss-shp-ff-47', color(e), 
                ' or ', color(b), 'mm-unit-gf-81', color(e), '.'
            ))
        die()
    } else {
    
    
    }

#endproc























)
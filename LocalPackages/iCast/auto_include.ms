## ---------- Procedure iCast ----------
## Extra broadcast data to change the tag [Broadcast] for different data types.
## Default broadcast settings for ease of access.
##
## Usage: _iCast(@args, @player)
##
## Notes: There is a permission check for moderator+
##
proc(_iCast, @action, @message, @player,
    
    ## \/ @package localisation? \/
    assign(@package, 'iCast')
    
    if(not(has_permission(@player, 'commandhelper.alias.moderator'))) {
        die(concat(color(c)'['.@package.']: You are not permitted to use this command'))
    }
    
    if(@action == '') {
        msg(concat(_chat(@package, d.'Info'),   'Broadcast with different data types'))
        msg(concat(_chat(@package, d.'Usage'),  '/icast <action> <message>'))
        msg(concat(_chat(@package, d.'Help'),   '/icast help'))
        msg('')
        die()
    }
    if(@action == to_lower('help')) {
        msg(concat(_chat(@package, d.'Web Links'),   '/icast -l <link> '))
        msg(concat(_chat(@package, d.'Web Images'),  '/icast -i <link> '))
        msg(concat(_chat(@package, d.'Notices'),     '/icast -n <message> '))
        msg(concat(_chat(@package, d.'New Things'),  '/icast -w <message> '))
        msg(concat(_chat(@package, d.'Branding'),    '/icast -b <message> '))
        die()
    }
    switch(to_lower(@action),
            '-l',
                broadcast(concat(color(6), '[', color(9), 'WEB-LINK', color(6), '] ', color(a), @message))
            ,
            '-i',
                broadcast(concat(color(6), '[', color(e), 'WEB-IMAGE', color(6), '] ', color(a), @message))
            ,
            '-n',
                broadcast(concat(color(6), '[', color(c), 'NOTICE', color(6), '] ', color(a), @message))
            ,
            '-b',
                if(not(has_permission(@player, 'icmd.icast.branding')),
                    die(concat(color(c)'['.@package.']: You are not permitted to use the [Branding] flag'))
                )
                broadcast(concat(color(6), '[', color(d), 'BRANDING', color(6), '] ', color(a), @message))
            ,
            '-w',
                broadcast(concat(color(6), '[', color(b), 'WHATSNEW', color(6), '] ', color(a), @message))
            ,
                die(concat(color(c)'['.@package.']: No valid flag found, use'color(f)'/icast help'))
    )
)


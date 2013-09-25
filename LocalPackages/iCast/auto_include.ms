## ---------- Procedure iCast ----------
## Extra broadcast data to change the tag [Broadcast] for different data types.
## Default broadcast settings for ease of access.
##
## Usage: _iCast(@string, @player)
##
## Notes: There is a permission check for moderator+
##
proc(_iCast, @string, @player,

    if(not(has_permission(@player, 'commandhelper.alias.moderator')),
        die(concat(color(c)'[iCast]: You are not permitted to use this command'))
    )
    assign(@split, split(' ', @string))
    if(equals_ic(trim(@string), '') || equals_ic(trim(@string), 'help'),
        msg('')
        msg(concat(_chatFormat('4', 'iCast', 'd', 'Info', 'f'), 'Broadcast with different data types'))
        msg(concat(_chatFormat('4', 'iCast', 'd', 'Web Links', 'f'),'   /icast -l <link> '))
        msg(concat(_chatFormat('4', 'iCast', 'd', 'Web Images', 'f'),'/icast -i <link> '))
        msg(concat(_chatFormat('4', 'iCast', 'd', 'Notices', 'f'),'     /icast -n <message> '))
        msg(concat(_chatFormat('4', 'iCast', 'd', 'New Things', 'f'),'/icast -w <message> '))
        msg(concat(_chatFormat('4', 'iCast', 'd', 'Branding', 'f'),'   /icast -b <message> 'color(7)'Manager+ only'))
        die()
    )
    switch(to_lower(@split[0]),
            '-l',
                broadcast(concat(color(6), '[', color(9), 'WEB-LINK', color(6), ']', color(a), replace(@string, '-l', '')))
            ,
            '-i',
                broadcast(concat(color(6), '[', color(e), 'WEB-IMAGE', color(6), ']', color(a), replace(@string, '-i', '')))
            ,
            '-n',
                broadcast(concat(color(6), '[', color(c), 'NOTICE', color(6), ']', color(a), replace(@string, '-n', '')))
            ,
            '-b',
                if(not(has_permission(@player, 'icmd.icast.branding')),
                    die(concat(color(c)'[iCast]: You are not permitted to use the [Branding] flag'))
                )
                broadcast(concat(color(6), '[', color(d), 'BRANDING', color(6), ']', color(a), replace(@string, '-b', '')))
            ,
            '-w',
                broadcast(concat(color(6), '[', color(b), 'WHATSNEW', color(6), ']', color(a), replace(@string, '-w', '')))
            ,
                die(concat(color(c)'[iCast]: No valid flag found, use'color(f)'/icast help'))
    )
)


## ---------- Information on commands and author ----------
## Reference for current commands and at what permission level.
## This is primarily a help/information feature from in-game.
## A home page of the commands if you will.
##
proc(_iCommand,
    assign(@author, 'iMasonite')
    assign(@autary, array_get(_getExGroup(@author)))
    assign(@autnam, _rankTag('Manager'))

    msg(concat(color(f), ' ================================================'))
    msg(concat(color(a), '  Commands developed using ', color(b), 'CommandHelper'))
    msg(concat(color(a), '  An extensive programming interface plugin by sk89q.'))
    msg(concat(color(a), '  Commands developed predominantly by: ', @autnam, color(@autary[1]) @author))
    msg(concat(color(a), '  Current commands available are listed below.'))
    msg(concat(color(e), '  If you have any ideas for a command please let me know'))
    msg(concat(color(e), '  by going on the ', color(b), 'server forum ', color(e), 'and post about them.'))
    msg(concat(color(f), ' ------------------------------------------------'))
      
    assign(@array, array(
        ## Commands that either have no permission check or require '- commandhelper.alias.builder'
        array(Builder, array(
            concat('d', '|', 'iCommand', '|', '/icommand', '|', 'Root of ', @author, '\'s commands.'),
                
        )),
        ## Commands that require '- commandhelper.alias.vip'
        array(VIP, array(
            concat(null),
                
        )),
        ## Commands that require '- commandhelper.alias.moderator'
        array(Moderator, array(
            concat('d', '|', 'AdminChat', '|', '/a', '|', 'Private chat chanel for Moderator+.'),
            concat('d', '|', 'GetBiome', '|', '/getbiome', '|', 'Tool for finding/teleporting biome.'),
                
        )),
        ## Commands that require '- commandhelper.alias.miniadmin'
        array(MiniAdmin, array(
            concat(null),
                
        )),
        ## Commands that require '- commandhelper.alias.manager'
        array(Manager, array(
            concat(null),
                
        )),
        ## Commands that require '- commandhelper.alias.admin'
        array(Admin, array(
            concat(null),
                
        )),
    ))
    foreach(@array, @subarray) {
        if(not(equals_ic(trim(@subarray[1][0]), null))) {
            msg('')
            msg(concat(color(7), ' ', _rankTag(@subarray[0]), '+'))
            foreach(@subarray[1], @command) {
                assign(@a, split('|', @command))
                msg(concat(' - ', _chatFormat(@a[0], @a[1], 'f', @a[2], 'e'), @a[3]))
            }    
        }
    }
    msg(concat(color(f), ' ================================================'))
)

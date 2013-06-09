

proc(_rankDefault, @player,

    msg(concat(color(f), ' ================================================'))
    msg(concat(color(f), '  Welcome ' ,color(a), @player, color(f), ' To: ', color(3), 'E', color(8), 'S', color(f), 'T ', color(b), ': purchasable ranks'))
    msg(concat(color(f), ' ------------------------------------------------'))
    msg(concat(color(a), '  EST is one of the most popular cracked servers.'))
    msg(concat(color(a), '  It is a free server for all new members. Meaning '))
    msg(concat(color(a), '  Premium and Non-Premium MC players are welcome.'))
    msg(concat(color(a), '  There are extra purchasable ranks with excellent'))
    msg(concat(color(a), '  perks and commands to keep your gaming experience'))
    msg(concat(color(a), '  fun and engaging. When you buy a rank, you are also'))
    msg(concat(color(a), '  helping to keep this excellent server in operation.'))
    msg(concat(color(f), ' ------------------------------------------------'))
    msg(concat(color(a), '  ', color(d) ,'BuyCraft ', color(a) ,'Plugin Command: ', color(b) ,'/buy'))
    msg(concat(color(e), '  The following commands will display the information'))
    msg(concat(color(e), '  and some of the awesome features that each contain.'))
    msg(concat(color(f), '   /rank VIP         ', color(f),  _rankTag('vip')))
    msg(concat(color(f), '   /rank Mod        ', color(f),  _rankTag('moderator')))
    msg(concat(color(f), '   /rank Mini         ', color(f),  _rankTag('miniadmin')))
    msg(concat(color(f), '   /rank WorldEdit  ', color(f), _rankTag('miniadmin'), ' [', color(c), 'Forever', color(f), '] + [', color(d), 'WorldEdit', color(f), ']'))
    msg(concat(color(f), ' ------------------------------------------------'))
    msg(concat(color(f), '   /rank Millionare       ', color(e),'  Become a Millionare!'))
    msg(concat(color(f), '   /rank Tri-Millionare   ', color(e),' Become Insanely Rich!'))
    msg(concat(color(f), ' ================================================'))
)

proc(_rankVip, @player,
    assign(@rank, 'VIP')
    assign(@buycmd, '/buy 1')
    assign(@format, array('2', 'a'))
    assign(@rights, array(
            'The right to enter a full server.',
            'The right to use colored texts in chat.',
            'Exempt from being auto kicked for AFK.',
            'Keep items in Backpack upon player death.'
    ))
    assign(@commands, array( #Associative Array Format elements <'':   ''>,
            '/tpa <player>':        'Request to teleport to a player.',
            '/tpahere <player>':    'Request to teleport a player to you.',
            '/back':                'Teleport back to your last location or death spot.',
            '/disguise <mobtype>':  'Change yourself to a monster type.',
            '/recipe grid':         'Portable crafting bench.',
            '/backpack':            'An extra inventory. (starting at 9 slots)',
            '/backpack upgrade':    'Increase the size of backpack.'
    ))
    assign(@hasadditional, 'false')
    assign(@infoadd, array(@hasadditional, array( #Associative Array Format elements <'':   ''>,
            #Planned# '/disguise vip':            'Mobs you can disguise as',
            #Planned# '/backpack info':       'Backpack information'
    )))
    _rankDisplay(@rank, @buycmd, @format, @rights, @commands, @player, @infoadd)

)

proc(_rankMod, @player,
    assign(@rank, 'Moderator')
    assign(@buycmd, '/buy 2')
    assign(@format, array('b', 'b'))
    assign(@rights, array(
            'The right to manage faction in bypass mode',
            'The right to open lockette protected chests and break them',
            'The right to spawn most monsters from monster eggs',
            'The right to see if someones class/rank was changed',
            'The right to Moderate ChestShops',
            'The right use Moderator Only [Server] signs',
            'The right use WorldGuard region protection',
            'Talk to admins over [AdminChat] private chanel',
            'Protection from getting kicked and banned from the server'
    ))
    assign(@commands, array( #Associative Array Format elements <'':   ''>,
            '/mute <p> <reason>':           'Permanently mute a player',
            '/tempmute <p> <reason>':       'Temporarily mute a player',
            '/jails':                       'Lists of jails',
            '/jail <player> <reason>':      'Put a person in jail',
            '/kick <player> <reason>':      'Kick a player',
            '/ban <player> <reason>':       'Ban a player forever',
            '/banip <IP> <reason>':         'Ban an IP address forever',
            '/tempban <p> <time> <reason>': 'Temporarily ban a player',
            '/unmute <player>':             'Unmute a player',
            '/unban <player>':              'Unban a player',
            '/unbanip <IP>':                'Unban an IP',
            '/bminfo <player>':             'Shows a players ban/kick/mute info',
            '/invsee <player>':             'See another players inventory',
            '/repair [hand/all]':           'Repair your items',
            '/whois <player>':              'Information about a player',
            '/getpos <player>':             'Get your position or other players',
            '/gamemode <creative/survival>':'Change your gamemode',
            '/top':                         'Teleport to the highest block on your location',
            '/jump':                        'Teleport where you aim',
            '/tp <player>':                 'Teleport to a player',
            '/tphere <player>':             'Teleport a player to you',
            '/tppos <x y z>':               'Teleport to coordinates',
            '/tptoggle':                    'Prevent others teleporting youto them / to you',
            '/time <dawn/day/dusk/night>':  'Change time on the server',
            '/thunder':                     'Allow thunder and lightning',
            '/weather <sun/storm>':         'change weather',
            '/spawner <mobtype> ':          'Change the type of mobspawner',
            '/f bypass':                    'Allows you to work in other factions',
            '/broadcast <text>':            'Send a message through [BROADCAST]',
            '/manwhois <player>':           'Get a players Rank information',
            '/listgroups':                  'Shows all the available groups',
            '/ext':                         'extinguish yourself if on fire',
            '/ticket close':                'Close support ticket',
            '/ticket tp':                   'Teleport to support ticket creation place',
            '/ticket priority':             'Set the priority of a support ticket',
            '/a <message>':                 'Access to AdminChat private chanel',
            '/u <player>':                  'Undisguise another player from a mob type',
            '/region [command]':            'Access WorldGuard region protection',
            '/locate <region>':             'Locate a WorldGuard region'
   ))
    assign(@hasadditional, 'true')
    assign(@infoadd, array(@hasadditional, array( #Associative Array Format elements <'':   ''>,
            #Planned# '/worldguard mod':              'See a list of WorldGuard commands',
            #Planned# '/spawner list':                'See a list of allowed spawner types',
            #Planned# '/banning guide':               'Information on how to punish rule breakers',
            'Terms and Conditions':         'http://goo.gl/ksRbq'
    )))
    _rankDisplay(@rank, @buycmd, @format, @rights, @commands, @player, @infoadd)
   #msg(concat(color(a), '[DEBUG] ', color(b), 'Value: ', '@commands', color(e), ' ', @commands))
)

proc(_rankMini, @player,
    assign(@rank, 'MiniAdmin')
    assign(@buycmd, '/buy 3')
    assign(@format, array('6', '6'))
    assign(@rights, array(
            'Safe CraftBook Integrated circuits usage',
            'Use CraftBook Mechanisms \n    Gates | Doors | Elevators | Bridge | Hiddenswitch.',
            'Bypass some NoCheatPlus checks such as \n    better flying/moving.',
            'The right use MiniAdmin Only [Server] signs.',
            'Have additional Mobs to disguise as.',
            'The right use Extended wg - // WorldGuard region \n    protection tools.'
    ))
    assign(@commands, array( #Associative Array Format elements <'':   ''>,
            '/feed <player>':           'Feed yourself or others',
            '/fly':                     'Activate flying mode during survival',
            '/gamemode <player>':       'Give gamemode to others',
            '/god <player>':            'Give GOD Mode to yourself or others',
            '/hat':                     'Wear anyBlock item in hand as a helmet/hat',
            '/heal <player>':           'Heal yourself or others',
            '/invsee <player>':         'See/edit the inventory of another player',
            '/openinv <player>':        'See/edit the armor/inv of a player',
            '/item':                    'Give items to yourself while in survival',
            '/give <player>':           'Give other players items',
            '/lighning <player>':       'Strike lighning at a player',
            '/socialspy':               'See players private [/msg,/tell] conversations',
            '/fspeed':                  'Change your flying speed',
            '/wspeed':                  'Change your walking/sprint speed',
            '/enderchest <player>':     'See others enderchest contents',
            '/openender <player>':      'See/edit players enderchests',
            'wg - //chunk':             'Set the selection to your current chunk.',
            'wg - //wand':              'Get the wand object to make selections',
            'wg - //hpos1':             'Set position 1 to targeted block',
            'wg - //hpos2':             'Set position 2 to targeted block',
            'wg - //pos1':              'Set position 1 to coordinate',
            'wg - //pos2':              'Set position 2 to coordinate',
            'wg - //contract':          'Contract the selection area',
            'wg - //outset':            'Outset the selection area',
            'wg - //distr':             'Get the distribution of blocks in the selection',
            'wg - //deselect':          'Deselect the current selection',
            'wg - //count':             'Counts the number of a certain type of block',
            'wg - //size':              'Get information about the selection',
            'wg - //expand':            'Expand the selection area',
            'wg - //shift':             'Shift the selection area',
            'wg - //shift':             'Inset the selection area'
    ))
    assign(@hasadditional, 'true')
    assign(@infoadd, array(@hasadditional, array( #Associative Array Format elements <'':   ''>,
            #Planned# '/disguise mini':         'Mobs you can disguise as',
            #Planned# '/banning guide':         'Information on how to punish rule breakers',
            #Planned# '/craftbook mini':        'Information on Craftbook information',
            'Selection Help':           'http://wiki.sk89q.com/wiki/WorldEdit/Selection',
            'Terms and Conditions':     'http://goo.gl/ksRbq'
    )))
    _rankDisplay(@rank, @buycmd, @format, @rights, @commands, @player, @infoadd)

)

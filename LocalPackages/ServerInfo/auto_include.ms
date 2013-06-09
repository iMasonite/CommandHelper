##Data for the ranks
##TODO, Move to a database in the ../../database folder.
include('includes.library/ranks_data.ms')

## ---------- Public Static Void rankDisplay ----------
## This is where the magic happens; gets the input arrays of data
## and formats them to the folowing, outputting the data to the users screen.
##
## Usage:
##      _rankDisplay(@rank, @buycmd, @format, @rights, @commands, @player, @infoadd)
##
## Reasons: 
##      if the format needs to be altered at any point then it can
##      be done here without changing multiple of lines of duplicate code.
##      it also keeps the look/feel of the whole thing uniform and cant deviate the format.
##
proc(_rankDisplay, @rank, @buycmd, @format, @rights, @commands, @player, @infoadd,

    msg(concat(color(f), ' ================================================'))
    msg(concat(color(f), ''))
    msg(concat(color(f), '  ', color(d) ,'BuyCraft ', color(a) ,'Plugin Command: ', color(b) ,@buycmd))
    msg(concat(color(f), ''))
    msg(concat(color(f), ' ', _chatFormat(@format[0], @rank, @format[1], @player, 'f'), 'You would look like this...'))
    msg(concat(color(7), ' '))
    msg(concat(color(f), '  -------------- ', color(d), 'Commands and Rights ', color(f), '---------------'))
    msg(concat(color(f), ' ', color(d), 'Rights', color(f), ' --------'))
    foreach(@rights, @right,
        msg(concat(color(f), ' - ', color(a), @right))
    )    
    msg(concat(color(f), ' ', color(d), 'Commands', color(f), ' --------'))
    foreach(array_keys(@commands), @cmd0,
         assign(@info0, @commands[@cmd0])
         msg(concat(color(f), ' - ', color(b), @cmd0, ' ',color(e), @info0))
    )
    if(equals(@infoadd[0], 'true'),
    msg(concat(color(f), ' ', color(d), 'More Info', color(f), ' --------'))
        foreach(array_keys(@infoadd[1]), @cmd1,
            assign(@info1, @infoadd[1][@cmd1])
            msg(concat(color(f), ' - ', color(f), @cmd1, ' ',color(7), @info1))
        )
    )
    msg(concat(color(f), ' ================================================'))
)

## ---------- Public Static Void rankInfo ----------
## When used in with a parameter it will display the relevent rank
## info to the player using keyword matching so for any one rank, there 
## could be a number of possable ways they can access the same command..
## like.. /rank mini | /rank miniadmin | /rank admin | /rank 3 would all 
## lead to displaying the MiniAdmin section of the ranks
## NOTE: also 'teXt CaSe' is of no concern as its handled to lower case.
##
## If no/incorrect parameter is supplied it will display the default information
##
## Usage:
##      _rankInfo($request, player())
##
##
proc(_rankInfo, @request, @player,
   
    switch(to_lower(@request),
            array('', 'help'),
                _rankDefault(@player)
            ,#case else
            array('1', 'vip'),
                _rankVip(@player)
            ,#case else
            
            array('2', 'mod', 'moderator'),
                _rankMod(@player)
            ,#case else
            array('3', 'admin', 'miniadmin', 'mini'),
                _rankMini(@player)
            ,#case else
            
            array('4', 'we', 'w/e', 'worldedit', 'worldedit miniadmin', 'worldedit mini', 'forever'),
                msg(concat(color(f), ' ================================================'))
                msg(color(c)'Information Not found!')
                msg(color(d)'Information on this section is unavalable at present')
                msg(color(d)'Please check back soon as it is under development')
                msg(concat(color(f), ' ================================================'))
            ,#case else
            
            array('5', 'mil', 'million', 'millionare', '1mil',  '1 mil'),
                msg(concat(color(f), ' ================================================'))
                msg(color(c)'Information Not found!')
                msg(color(d)'Information on this section is unavalable at present')
                msg(color(d)'Please check back soon as it is under development')
                msg(concat(color(f), ' ================================================'))
            ,#case else
            
            array('6', 'trimil', 'trimillion', '3mil',  '3 mil', '3 million', 'tri-millionare'),
                msg(concat(color(f), ' ================================================'))
                msg(color(c)'Information Not found!')
                msg(color(d)'Information on this section is unavalable at present')
                msg(color(d)'Please check back soon as it is under development')
                msg(concat(color(f), ' ================================================'))
            ,#case else
                msg(concat(_chatFormat('4', 'RankInfo', 'd', 'Opps', 'f'), 'There is no rank named: ', color(e), @request))
                msg(concat(_chatFormat('4', 'RankInfo', 'd', 'Usage', 'f'), '/rank help'color(b)'or'color(f)'/rank <rank>'))
    )
)

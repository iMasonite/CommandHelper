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
##      _getExGroup(@player)
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

## --------- void In Game Package Manager ----------
##
## Usage:
##      _packMan(package, args)
##
## Arguments:
##  package | Required | String
##      The package name you wish to change.
##  args | Required | String
##      The config option you wish to change.
##  value  | Required | String, Bool, Int, Array
##      The value of the option you wish to change.
##
proc(_packMan, @arguments,
    assign(@args, parse_args(@arguments))
    
    if(array_size(@args) <= 0) {
     #help
     #die()
    }
    assign(@package, @args[0])
    assign(@option, @args[1])
    
    if(!has_permission(@sender, 'commandhelper.alias.owner') || 
       !has_permission(@sender, 'icmd.packman.access')) {
        
        ## \/ plans to have this seperate in global help with localisation \/
        die(msg(concat(_chat(@package, c.'Oops'), 'You are not permitted to use this command!')))
    }
    
    
    
    
    
    
    if(array_size(@args) > 3) {
    
    } else {
    
    }
    
    
    
)
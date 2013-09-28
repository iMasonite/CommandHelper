## --------- void Deploy Packages ----------
## Deploy package settings at server startup 
## or CH reload. This is so any custom settings
## can be preserved over updates and give more
## universal control over the iCommand packages.
##
## Usage:
##      _deployPackage(@package, @force)
##
## Arguments: [optional] <required>
##      <package>   = Name of the package to deploy i.e 'AdminChat'
##      [force]     = force a reset of the config for the package 
##                    to default settings.
##
proc(_deployPackage, @package, @force,
    if(@package == '') {
        sys_err('[iCommands]: Cannot Deploy a "null" Package')
        die()
    }
    
    assign(@nspace, 'packages.'.@package)
    
    # If the Force flag is true then it will first clear the config
    # and then attempt to install it from the init.icfg
    if(@force) {
        sys_out('[iCommands]: Force clear of config: '.@package.'....')
        clear_value(@nspace)
    }
    
    # Checks if the config exists and installs it if available.
    # else, alerts in console that the required init.icfg does not exist.
    assign(@contents, get_values(@nspace))
    if(array_size(@contents) <= 0) {
        sys_err('[iCommands]: Package Config Not Found for: '.@package.' , Working to resolve....')
        
        if(file_size('../LocalPackages/'.@package.'/init.icfg') > 0) {
            sys_out('[iCommands]: Package Installation Config Found for: '.@package.' , Installing....')
            
            try(
                include('../LocalPackages/'.@package.'/init.icfg')
                assign(@newcontents, get_values(@nspace))
                if(!array_size(@newcontents) <= 0) {
                    sys_out('[iCommands]: Installation Success: '.@package.' , in: PackageConfig/config.yml')
                    sys_out('[iCommands]: Edit the config.yml and /reloadaliases')
                    sys_out('-----------------------------------------------------')
                } else {
                    sys_err('[iCommands]: Installation Failed for: '.@package.'!')
                    sys_err('[iCommands]: Reason Unknown! Try again?')
                    sys_err('[iCommands]: Bug Reports: https://github.com/iMasonite/CommandHelper')
                }
                , 
                @exception
                , 
                if(equals(array_get(@exception, 0), IOException)) {
                    sys_err('[CommandHelper]: failed to get Installation File: init.icfg: IOException')
                    sys_err('Bug Reports: https://github.com/iMasonite/CommandHelper')
                }
                ,
                array(IOException)
            )
        } else {
                sys_err('[iCommands]: Installation Failed for: '.@package.'!')
                sys_err('[iCommands]: Required File Not Found: ../LocalPackages/'.@package.'/init.icfg')
        }
    } else {
        # Check if required files exist in the LocalPackages.
        if(
        file_size('../LocalPackages/'.@package.'/auto_include.ms') <= 0 || 
        file_size('../LocalPackages/'.@package.'/main.msa') <= 0) {
            sys_err('[iCommands]: Files Not Found For: '.@package.' , disabling '.@package.' support....')
            sys_err('[iCommands]: Required Files:')
            sys_err('[iCommands]: ../LocalPackages/'.@package.'/auto_include.ms')
            sys_err('[iCommands]: ../LocalPackages/'.@package.'/main.msa')
            store_value(@nspace.'.Package.Available', boolean(false))
            die()
        }
    }
)#proc
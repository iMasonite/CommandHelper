#-----------------------------------------------------
#   This file is run when the server
#   starts up, or the plugin is reloaded.
#
#   This is where Packages are deployed at startup.
#-----------------------------------------------------

#---------- Package Manager ----------
## Read more in ../includes/PackageManager.ms
# 'PackageName': ForceConfig true|false
#  Note that 'ObjectLibrary' is required for 99% of all packages.
#  Note that 'iCommand' is required for most of the help functionality.
assign(@packages, array(
        # Packages that are required for all others to function.
        'ObjectLibrary':        false,
        # 'iCommand':             false,

        # Packages that are optional.
        'PackMan':              false,
        # 'GroupManager':         false,
        'AdminChat':            false,
        # 'reCommand':             false,
        # 'iCast':                false,
        # 'Ninja':                false,
        # 'PVP':                  false,
        # 'ServerInfo':           false,
        # 'Shops':                false,
        # 'Veto':                 false,
        # 'WorldTools':           false,
))
foreach(array_keys(@packages), @package,
    _deployPackage(@package, @packages[@package])
)
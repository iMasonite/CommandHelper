#iMasonite's > Package Config
>Status: *Started* 
>
>Stage: *Mostly Functional*
###*All the config in one place :D*

>So, to better understand the config I'll make a few pointers, All the packages that I create (or modify) will have its own config section that can be customised without going through and hard coding variables in the script files, so that the more unfamiliar people can still make use of this just like any other plugin out there. Pretty much this is a precursor to an actual plugin i intend on starting at some point when I have the time to cram some Java under my belt. (I'm a .NET developer, what you want from me? :D)

> **So what to focus on?** 
> 
> Well, the **Permissions section** is just so you can find what permission you need to add to a group or player to make a package work, a bit like the plugin.yml in a Java ```plugin.jar```.
>
> The **Package section** (for now) comes in Two parts, ```Available``` & ```Enable```, Available is when the ```Service Package Manager``` knows that the package is even on the system in the place its supposed to be (in the correct folder that is) and the Enable part is if you want to have the plugin available for use on the server or not, but without removing the file from the packages folder; this will be especially useful for enabling/disabling the package from the the game on the fly. (think Plugman plugin manager on BukkitDev).
>
>The **Options Section** is where you can customise the look and feel of each package with the colour of tags and colour of text in messages and help. As each server has its own colour system, it makes sense to cater for each servers needs (to a point ofc).

>> **Localisation** is something I will be playing with, as one of the servers I manage is Estonian, it makes sense to try and cater for the non English speaking world, I remember doing some localisation in a webApp once, lets see how I do here.
>
####  Config:
* **Permission:** *(These shouldn't need changing)*
	* Main: ```some.permission.node```
		* *The permission a particular group needs to have.*
	* Override: ```icmd.permission.node```
		* *The permission that a particular user could have.*
* **Package:**
	* Available: ```'true'``` (This shouldn't need changing)
		* *If the package in detected in the file system this will be true, else false.*
	* Enable: ```'true'```
		* *If you want to disable the use of the package, this would be false.*
* **Options:**
	* Formats:
		* MsgColor: ```'"f"'```
			* *The primary colour of the text associated with the package.*
		* TagColor: ```'"4"'```
			* *The colour of the text inside the square brackets i.e [SomePackage]:.*
	* Localisation:
		* ENG: '"SomePackage"'
			* *The display name of the package. Will support more languages in the future.*

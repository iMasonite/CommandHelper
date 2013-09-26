#iMasonite's : iCommands > Package Config
###*All the config in one place :D*

<p>So to better understand the config i'll make a few pointers</p>

####  Config:
* Permission: (These shouldn't need changing)
	* Main: ```some.permission.node```
		* The permission a particular group needs to have.
	* Override: ```icmd.permission.node```
		* The permission that a particular user could have.
* Package:
	* Available: ```'true'``` (This shouldn't need changing)
		* If the package in detected in the file system this will be true, else false.
	* Enable: ```'true'```
		* If you want to disable the use of the package, this would be false.
* Options:
	* Formats:
		* MsgColor: ```'"f"'```
			* The primary color of the text associated with the package.
		* TagColor: ```'"4"'```
			* The color of the text inside the square brackets i.e [SomePackage]:.
	* Localisation:
		* ENG: '"SomePackage"'
			* The display name of the package. Will support more languages in the future.

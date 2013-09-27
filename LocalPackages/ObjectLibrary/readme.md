#iMasonite's : iCommands > ObjectLibrary
>Status: *Mostly Functional*
>
>Stage: *Reworking, Adding New*
####*All sundry functions that are use throughout the iCommands system*

<p><strong>Object Libraries</strong></p>
<p>Reusable functions/subroutine or used multiple times 
throughout the commands will go here; this is also a 
prerequisite for all the packages. Most commands will 
not function without this package.</p>


##  GroupManager...
>Most if not all of the GroupManager scripts are for getting correct data (and more data) than CommandHelper can currently get via the built in methods. Note that this assumes you have your GroupManager set in the ```world``` folder as default. I'll add a config option soon.

####GroupManager: Groups Data:
>Array of all GroupManager Data to be loaded into Memory for 240 seconds minimum before a refresh looking for new data is preformed. A refresh will only run if the subroutine is run.

* **Usage:** ```_gMGroupsData(args)```
* **Arguments:**
	* ```boolean``` Force GroupManager to save its current data and clear previous saved data in memory so that the data in memory is fresh.
* **Returns:** ```void``` *Stores data in memory for use with other procedures.*

-------------------------------------------------------------

#### GroupManager Group List:
>Array of Group Names in the order of the id: ```group:info:id: ##``` in groups.yml*

* **Usage:** ```_gMGroupList()```
* **Arguments:** None
* **Returns:** ```array```

-------------------------------------------------------------

#### GroupManager Group Data:
>Get data for the requested group and data type.

* **Usage:** ```_gMGroupData(group, data)```
* **Arguments:** 
	* ```group``` Name of the group required i.e 'VIP'
	* ```data``` Data field of the group required i.e 'prefix' or 'permissions'
* **Returns:** Data types could be any of: ```array, int, string``` or ```boolean```

-------------------------------------------------------------

#### GroupManager Users Data:
>Array of all GroupManager Users Data to be loaded into Memory for 60 seconds minimum before a refresh looking for new data is preformed, A refresh will only run if the subroutine is run.

* **Usage:** ```_gMUsersData(args)```
* **Arguments:**
	* ```boolean``` Force GroupManager to save its current data and clear previous saved data in memory so that the data in memory is fresh.
* **Returns:** ```void``` *(Stores data in memory for use with other procedures.)*

-------------------------------------------------------------

#### GroupManager User List:
>Array of User Names from users.yml

* **Usage:** ```_gMUserList()```
* **Arguments:** None
* **Returns:** ```array```

-------------------------------------------------------------

#### GroupManager User Data:
>Get data for the requested user and data type.

* **Usage:** ```_gMUserData(user, data)```
* **Arguments:** 
	* ```user``` Name of the user required i.e 'iMasonite'
	* ```data``` Data field of the group required i.e 'prefix' or 'permissions'
* **Returns:** Data types could be any of: ```array, int, string``` or ```boolean```

-------------------------------------------------------------

##  Common:

#### Chat formatter (new):
>Format chat with a ```[Tag] text: <text>```, Main uses for this is for Package display information in chat (also AdminChat uses this).

* **Usage:** ```_chat(<package>, [text])```
* **Arguments:** 
	* ```<package>``` The name of the package using this.
	* ```[text]``` The text to format.
* **Returns:** String

-------------------------------------------------------------

#### Coordinates Format.
>Output for the chat to make the coordinates easy to read in game.

* **Example:** ```_coordFormat(array(-47, 64, 897, world))```
	* Returns: String

-------------------------------------------------------------

####Safe Teleportation.
>Takes an array of coordinates in ```ploc(@player)``` format and runs it through a battery of checks to see if the destination is safe for a player in survival mode to teleport.

* **Example:**  ```_teleportSafe(array(-47, 64, -897, world))```
* Returns: Boolean
	* Notes: For now, this will check blocks in range;
		* 1 Above head hight
		* 1 At head hight
		* 1 At leg hight
		* 1 Below feet hight
	* TODO: For now, this will check blocks in range;
		* gte >= 10 below feet hight (air, falling losing 2.5 hearts).
		* 1 at bedrock for air, ungenerated chunk.
		* Iterate blocks below for lava.
		* Block Types are a planned config option. This will be the above blocks to check on each option as safe/unsafe/passthrough If these blocks need to be changed at any point the it can be done with ease, and can be used elswhere in the iCommands framework.

-------------------------------------------------------------

####Region Data. (bespoke display)
>Takes a region name for the current world and tests if it exists in the world, if it does not then the exception is handled and the error info is displayed to the user.

* **Example:**  ```_getSq_RegionData(@region, @world, player(), 'command name')```
	* Returns: Array.

-------------------------------------------------------------

####Region Flag, Teleport location value clean.
>The flag for teleport on a region is a huge soup with far too many decimal places. This solves that problem.

* **Example:**  ```_teleFlagClean(@worldguardtpflag)```
	* Returns: Array.

-------------------------------------------------------------

##  Depreciated (but still usable, phasing out)
* _rankTag: ```_rankTag(4)```
	* Info: Given a string such as 'builder' or integer such as 0 a tag is returned for the rank requested.
		* Returns: ```string```
		* Notes: If no value is supplied [Default] will return.

-------------------------------------------------------------

* _getExGroup: ```_getExGroup(player())```
	* Info: Get the exact group of the player, return the name and associated color of the tag of the rank.
	* Returns: Array of values, Example: {"Admin", "c"}
	* Notes: Must search in reverse order or an admin would match a builder or VIP ect ect... For now this is using pgroup(@player) but i would like it to read GroupManager's This is somthing of a TODO.

-------------------------------------------------------------

* _chatFormat: ```_chatFormat('d', iCommand, 'e', 'Information Text', 'f')```
	* Info: Most chat messages to the user encompass a tag and formatting. Keeping the everything on a whole friendly on the eyes and easy to navigate in-game and code. Uniform aspect on a global scale of all chat bound messages.
	* Returns: Formatted String of text to be used in the chat.
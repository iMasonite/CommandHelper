#iMasonite's : iCommands > ObjectLibrary
###*All sundry functions that are use throughout the iCommands system*

<p><strong>Object Libraries</strong></p>
<p>Reusable functions/subroutine or used multiple times 
throughout the commands will go here; this is also a 
prerequisite for all the packages. Most commands will 
not function without this package.</p>

####  Common
* Main:
<span id="_chatFormat">
	* <strong>_chatFormat:</strong> Example - ```_chatFormat('d', iCommand, 'e', 'Information Text', 'f')```
		* <p>Info: Most chat messages to the user encompass a tag and formatting. Keeping the everything on a whole friendly on the eyes and easy to navigate in-game and code. Uniform aspect on a global scale of all chat bound messages.</p>
		* Returns: Formatted String of text to be used in the chat.
<hr/>
</span>

<span id="_coordFormat">
	* <strong>_coordFormat:</strong> Example - ```_coordFormat(array(-47, 64, 897, world))```
		* <p>Info: Coordinates format output for the chat to make the coordinates easy to read in game.</p>
		* Returns: Formatted String of Coordinates. equiv to > ```x: -47 y: 64 z: 897```
<hr/>
</span>

<span id="_teleportSafe">
	* <strong>_teleportSafe:</strong> Example - ```_teleportSafe(array(-47, 64, -897, world))```
		* <p>Info: Takes an array of coordinates in ploc(@player) format and runs it through a battery of checks to see if the destination is safe for a player in survival mode to teleport.</p>
		* Returns: boolean
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
<hr/>
</span>

<span id="_getSq_RegionData">
	* <strong>_getSq_RegionData:</strong> Example - ```_getSq_RegionData(@region, @world, player(), 'command name')```
		* <p>Info: Takes a region name for the current world and tests if it exists in the world, if it does not then the exception is handled and the info displayed to the user.</p>
		* Returns: Array of the supplied region's data.
<hr/>
</span>

<span id="_teleFlagClean">
	* <strong>_teleFlagClean:</strong> Example - ```_teleFlagClean(ploc(player()[3])```
		* <p>Info: The flag for teleport on a region is a huge soup with far too many decimal places. This solves that problem.</p>
		* Returns: Formatted array of Coordinates x y z. equiv to i.e. {-47, 64, 897}
		* Notes: 
<hr/>
</span>

####  GroupManager
* Main:
<span id="_gMGroupsData">
	* <strong>GroupManager Groups Data:</strong>
		* <p>Info: Array of all GroupManager Data to be loaded into Memory for 240 seconds minimum before a refresh looking for new data is preformed. A refresh will only run if the subroutine is run.</p>
		* <strong>Usage:</strong> ```_gMGroupsData(args)```
		* <strong>Arguments:</strong>
			* <p><strong>[mansave]</strong> Force GroupManager to save its current data and clear previous saved data in memory so that the data in memory is fresh.</p>
		* <strong>Returns:</strong> Void. <i>(Stores data in memory for use with other procedures.)</i>
<hr/>
</span>

<span id="_gMGroupList">
	* <strong>GroupManager Group List:</strong>
		* <p>Info: Array of Group Names in the order of the id: ```group:info:id: ##``` in groups.yml</p>
		* <strong>Usage:</strong> ```_gMGroupList()```
		* <strong>Arguments:</strong> None
		* <strong>Returns:</strong> Array
<hr/>
</span>

<span id="_gMGroupData">
	* <strong>GroupManager Group Data:</strong>
		* <p>Info: Get data for the requested group and data type.</p>
		* <strong>Usage:</strong> ```_gMGroupData(group, data)```
		* <strong>Arguments:</strong> 
			* <p><strong>group</strong> Name of the group required i.e 'VIP'</p>
			* <p><strong>data</strong> Data field of the group required i.e 'prefix' or 'permissions'</p>
		* <strong>Returns:</strong> Data types could be any of: array, int, string & boolean
<hr/>
</span>

<span id="_gMUsersData">
	* <strong>GroupManager Users Data:</strong>
		* <p>Info: Array of all GroupManager Users Data to be loaded into Memory for 60 seconds minimum before a refresh looking for new data is preformed, A refresh will only run if the subroutine is run.</p>
		* <strong>Usage:</strong> ```_gMUsersData(args)```
		* <strong>Arguments:</strong>
			* <p><strong>[mansave]</strong> Force GroupManager to save its current data and clear previous saved data in memory so that the data in memory is fresh.</p>
		* <strong>Returns:</strong> Void. <i>(Stores data in memory for use with other procedures.)</i>
<hr/>
</span>

<span id="_gMUserList">
	* <strong>:</strong>
		* <p>Info: Array of User Names from users.yml</p>
		* <strong>Usage:</strong> ```_gMUserList()```
		* <strong>Arguments:</strong> None
		* <strong>Returns:</strong> Array
<hr/>
</span>

<span id="_gMGroupData">
	* <strong>GroupManager User Data:</strong>
		* <p>Info: Get data for the requested user and data type.</p>
		* <strong>Usage:</strong> ```_gMUserData(user, data)```
		* <strong>Arguments:</strong> 
			* <p><strong>user</strong> Name of the user required i.e 'iMasonite'</p>
			* <p><strong>data</strong> Data field of the group required i.e 'prefix' or 'permissions'</p>
		* <strong>Returns:</strong> Data types could be any of: array, int, string & boolean
<hr/>
</span>

####  Depreciated (but still usable)
* Main:
<span id="_rankTag">
	* <strong>_rankTag:</strong> Example - ```_rankTag(4)```
		* <p>Info: Given a string such as 'builder' or integer such as 0 a tag is returned for the rank requested.</p>
		* Returns: Formatted String of text for use in chat.
		* Notes: If no value is supplied [Default] will return.
<hr/>
</span>

<span id="_getExGroup">
	* <strong>_getExGroup:</strong> Example - ```_getExGroup(player())```
		* <p>Info: Get the exact group of the player, return the name and associated color of the tag of the rank.</p>
		* Returns: Array of values, Example: {"Admin", "c"}
		* Notes: Must search in reverse order or an admin would match a builder or VIP ect ect... For now this is using pgroup(@player) but i would like it to read GroupManager's This is somthing of a TODO.
<hr/>
</span>


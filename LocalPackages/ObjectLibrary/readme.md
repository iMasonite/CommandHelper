#iMasonite's : iCommands > ObjectLibrary
###*All sundry functions that are use throughout the iCommands system*

<p><strong>Some Title</strong></p>
<p>Reusable functions or used multiple times throughout the 
commands will go here; this is also a prerequisite for 
all the packages. Most commands will not function without 
this package.</p>


####  Functions:
* Main:
	* <strong>_chatFormat:</strong> Example - ```_chatFormat('d', iCommand, 'e', 'Information Text', 'f')```
		* <p>Info: Most chat messages to the user encompass a tag and formatting. Keeping the everything on a whole friendly on the eyes and easy to navigate in-game and code. Uniform aspect on a global scale of all chat bound messages.</p>
		* Returns: Formatted String of text to be used in the chat.
		<hr/>
		
	* <strong>_coordFormat:</strong> Example - ```_coordFormat(array(-47, 64, 897, world))```
		* <p>Info: Coordinates format output for the chat to make the coordinates easy to read in game.</p>
		* Returns: Formatted String of Coordinates. equiv to > ```x: -47 y: 64 z: 897```
		<hr/>
		
	* <strong>_rankTag:</strong> Example - ```_rankTag(4)```
		* <p>Info: Given a string such as 'builder' or integer such as 0 a tag is returned for the rank requested.</p>
		* Returns: Formatted String of text for use in chat.
		* Notes: If no value is supplied [Default] will return.
		<hr/>
		
	* <strong>_getExGroup:</strong> Example - ```_getExGroup(player())```
		* <p>Info: Get the exact group of the player, return the name and associated color of the tag of the rank.</p>
		* Returns: Array of values, Example: {"Admin", "c"}
		* Notes: Must search in reverse order or an admin would match a builder or VIP ect ect... For now this is using pgroup(@player) but i would like it to read GroupManager's This is somthing of a TODO.
		<hr/>
        
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
        
	* <strong>_getSq_RegionData:</strong> Example - ```_getSq_RegionData(@region, @world, player(), 'command name')```
		* <p>Info: Takes a region name for the current world and tests if it exists in the world, if it does not then the exception is handled and the info displayed to the user.</p>
		* Returns: Array of the supplied region's data.
		<hr/>
        
	* <strong>_teleFlagClean:</strong> Example - ```_teleFlagClean(ploc(player()[3])```
		* <p>Info: The flag for teleport on a region is a huge soup with far too many decimal places. This solves that problem.</p>
		* Returns: Formatted array of Coordinates x y z. equiv to i.e. {-47, 64, 897}
		* Notes: 
		<hr/>
		
	* <strong>_tba:</strong> Example - ```tba```
		* <p>Info: tba</p>
		* Returns: tba
		* Notes: tba
		<hr/>

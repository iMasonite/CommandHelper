#iMasonite's : iCommands > AdminChat
>Status: *Functional* Mostly Complete.
###*Private Chat Channel for Moderator +*

>Simple admin chat system that only the <player> with the correct permission will see and be able to use. This is so ranked players can chat among one another without your normal unranked players knowing about it.

>There are overloaded permissions for both send and receive as you will see in the config.

###  Usage:
* **Commands:**
	* Main + Help: ```/a```
	* Message Command: ```/a <message>```

---------------------------------

* **TODO:**
	* Localisation

---------------------------------

### Procedure usage:
> The procedure can be used in your own code, use the following information to implement it.

#### Admin Chat:
* **Usage:** ```_adminChat(message, sender)```
* **Arguments:** 
	* **```message | Required | String```**
		* The message to send to all players with the correct permissions.
	* **```sender | Required | String```**
		* The sender of the message, must be an Online player name.
* **Returns:** ```Void```

---------------------------------

#### An example of this in the config.txt or main.msa file.

<pre>
*:/a [$] = _adminChat($, player())
</pre>

#### An example of this in used for your personal alias in game..

<pre>
/alias /foo $msg = _adminChat($msg, player())
</pre>
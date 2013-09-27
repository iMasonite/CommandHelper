#iMasonite's : Service Package Manager
###*Main script for: Service Package Manager*


**Service Package Manager**

All LocalPackages will contain some kind of help system and config file settings, to ensure that The right help is given to players the packages will be detected and the information loaded into storage upon server start / plug-in reload (via the main.ms). This also allows us to enable or disable packages on the fly and better manage them.</p>

When the service is run, it will look for packages that are predefined in the <code>main.ms</code> and attempt to load the config; if it does not exist yet. If the config is found then it will skip the install (unless forced) and check to see if the main files for said plugin are where they are expected to be in, i.e <code>../LocalPackages/&lt;package&gt;/main.msa</code> and other required files if they exist.</p>


###Deploy Package:
>Deploy package settings at server start-up or CommandHelper reload. This is so any custom settings can be preserved over updates and give more universal control over the iCommand packages.

* **Usage:** ```_deployPackage(package, force)```
	* **Arguments:** [optional] &lt;required&gt;
		* **&lt;package&gt;** ```String```
			* Name of the package to deploy i.e 'AdminChat'
		* **[force]** ```Boolean```
			* force a reset of the config for the package to default settings.
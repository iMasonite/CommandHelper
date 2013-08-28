
<h1>iMasonite's : iCommands > Tasks</h1>
<h2><i>Shop Managemant & User controls.</i></h2>
<h3>Shops: Management / Automatisation</h3>
 <p>
		Shop regions in the game usually consist of a main region such as <code>servershops-main </code>
		(i like to call these <i>"zones"</i>) followed by a bunch of sub micro regions, namely used in 
		plug-ins such as <strong>SimpleRegionMarket</strong>, they all should have a common name like 
		<code>ss-shp-ff-47</code>; this abbreviation meaning <code>servershops-shop-firstfloor-47</code> 
		with the name being no more than 14 letters (for a single line on a sign to display to the player) 
		and numbers to be able to work together and be easy to manage, thus this command to manage the 
		micro regions all in one command.
	</p>
	<p>
		<strong>Licences</strong>: The way i like to work with this is to register a main region to a list of 
		<em>"known shop regions"</em>, this helps prevent accidents down the line with human error 
		(not eliminate but rather help). And will also prevent abuse in some aspects; so that in mind 
		registering a licence means adding to the main list of allowed regions to work with this command.
	</p>
	<h3>Commands and Permissions</h3>
	<table style="width: 100%;">
		<tr>
			<th>Command</th>
			<th>Description</th>
			<th>Override Permission</th>
		</tr>
		<tr>
			<td><strong><code>/shops</code></strong></td>
			<td><em>Information and usage.</em></td>
			<td><strong><code>[none]</code></strong></td>
		</tr>
		<tr>
			<td><strong><code>/shops list</code></strong></td>
			<td><em>Information about zones in the world.</em></td>
			<td><strong><code>[none]</code></strong></td>
		</tr>
		<tr>
			<td><strong><code>/shops list \<zone\></code></strong></td>
			<td><em>Summery information about a main zone.</em></td>
			<td><strong><code>icmd.override.shops.list</code></strong></td>
		</tr>
		<tr>
			<td><strong><code>/shops reg \<zone\> \<owner\> [desc]</code></strong></td>
			<td><em>Register a shop licence to a region.</em></td>
			<td><strong><code>icmd.override.shops.register</code></strong></td>
		</tr>
		<tr>
			<td><strong><code>/shops edit \<zone\> \<owner\> [desc]</code></strong></td>
			<td><em>Edit a shop licence for a region.</em></td>
			<td><strong><code>icmd.override.shops.edit</code></strong></td>
		</tr>
		<tr>
			<td><strong><code>/shops remove \<zone\></code></strong></td>
			<td><em>Remove a shop licence from a region</em></td>
			<td><strong><code>icmd.override.shops.remove</code></strong></td>
		</tr>
		<tr>
			<td><strong><code>/shops initialize \<prefix\></code></strong></td>
			<td><em>Initialize micro regions (the shops).</em></td>
			<td><strong><code>icmd.override.shops.initialize</code></strong></td>
		</tr>
	</table>
	<h3>Variables and their usage, \<required\> [optional]</h3>
	<table style="width: 100%;">
		<tr>
			<th>Variables</th>
			<th>Description</th>
		</tr>
		<tr>
			<td><strong><code>\<zone\></code></strong></td>
			<td><em>The name of the main region that surrounds the micro shop regions. i.e </em><code>servershops-main</code></td>
		</tr>
		<tr>
			<td><strong><code>\<owner\></code></strong></td>
			<td><em>The owner of the region/zone; the person in charge of the shops in a zone</em></td>
		</tr>
		<tr>
			<td><strong><code>[desc]</code></strong></td>
			<td><em>Adds a description that customers can see upon entry of the zone.</em></td>
		</tr>
	</table>



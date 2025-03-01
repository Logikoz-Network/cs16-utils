/*================================================================================
	
	---------------------------------------
	-*- Zombie Plague 4.3 Includes File -*-
	---------------------------------------
	
	~~~~~~~~~~
	- How To -
	~~~~~~~~~~
	
	To make use of the Zombie Plague API features in your plugin, just
	add the following line at the beginning of your script:
	
	#include <zombieplague>
	
	~~~~~~~~~~~
	- Natives -
	~~~~~~~~~~~
	
	These work just like any other functions: you may have to pass
	parameters and they usually return values.
	
	Example:
	
	if ( is_user_alive( id ) && zp_get_user_zombie( id ) )
	{
		server_print( "Player %d is alive and a zombie", id )
	}
	
	~~~~~~~~~~~~
	- Forwards -
	~~~~~~~~~~~~
	
	Forwards get called whenever an event happens during the game.
	You need to make a public callback somewhere on your script,
	and it will automatically be triggered when the event occurs.
	
	Example:
	
	public zp_user_infected_post( id, infector, nemesis )
	{
		if ( !infector || nemesis )
			return;
		
		server_print( "Player %d just got infected by %d!", id, infector )
	}
	
	Also, take note of cases when there's a suffix:
	
	* _pre  : means the forward will be called BEFORE the event happens
	* _post : means it will be called AFTER the event takes place
	
=================================================================================*/

#if defined _zombieplague_included
  #endinput
#endif
#define _zombieplague_included

/* Disable it to prevent it from using FM/Engine compile errors if your plugin doesn't use either one */
/* Add '//' infront to disable it */
#define ENABLE_KNOCKBACK_STOCK

/* Add '//' infront to use engine instead */
#define USE_FAKEMETA_FOR_KNOCKBACK

/* Teams for zp_register_extra_item() */
#define ZP_TEAM_ZOMBIE (1<<0)
#define ZP_TEAM_HUMAN (1<<1)
#define ZP_TEAM_NEMESIS (1<<2)
#define ZP_TEAM_SURVIVOR (1<<3)

/* Game modes for zp_round_started() */
enum
{
	MODE_INFECTION = 1,
	MODE_NEMESIS,
	MODE_SURVIVOR,
	MODE_SWARM,
	MODE_MULTI,
	MODE_PLAGUE
}

/* Winner teams for zp_round_ended() */
enum
{
	WIN_NO_ONE = 0,
	WIN_ZOMBIES,
	WIN_HUMANS
}

/* Custom forward return values */
#define ZP_PLUGIN_HANDLED 97

/**
 * Returns whether a player is a zombie.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_zombie(id)

/**
 * Returns whether a player is a nemesis.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_nemesis(id)

/**
 * Returns whether a player is a survivor.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_survivor(id)

/**
 * Returns whether a player is the first zombie.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_first_zombie(id)

/**
 * Returns whether a player is the last zombie.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_last_zombie(id)

/**
 * Returns whether a player is the last human.
 *
 * @param id		Player index.
 * @return		True if it is, false otherwise.
 */
native zp_get_user_last_human(id)

/**
 * Returns a player's current zombie class ID.
 *
 * @param id		Player index.
 * @return		Internal zombie class ID, or -1 if not yet chosen.
 */
native zp_get_user_zombie_class(id)

/**
 * Returns a player's next zombie class ID (for the next infection).
 *
 * @param id		Player index.
 * @return		Internal zombie class ID, or -1 if not yet chosen.
 */
native zp_get_user_next_class(id)

/**
 * Sets a player's next zombie class ID (for the next infection).
 *
 * @param id		Player index.
 * @param classid	A valid zombie class ID.
 * @return		True on success, false otherwise.
 */
native zp_set_user_zombie_class(id, classid)

/**
 * Returns a player's ammo pack count.
 *
 * @param id		Player index.
 * @return		Number of ammo packs owned.
 */
native zp_get_user_clp(id)

/**
 * Sets a player's ammo pack count.
 *
 * @param id		Player index.
 * @param amount	New quantity of ammo packs owned.
 */
native zp_set_user_pesos(id, amount)

/**
 * Returns the default maximum health of a zombie.
 *
 * Note: Takes into account first zombie's HP multiplier.
 *
 * @param id		Player index.
 * @return		Maximum amount of health points, or -1 if not a normal zombie.
 */
native zp_get_zombie_maxhealth(id)

/**
 * Returns a player's custom flashlight batteries charge.
 *
 * @param id		Player index.
 * @return		Charge percent (0 to 100).
 */
native zp_get_user_batteries(id)

/**
 * Sets a player's custom flashlight batteries charge.
 *
 * @param id		Player index.
 * @param value		New charge percent (0 to 100).
 */
native zp_set_user_batteries(id, charge)

/**
 * Returns whether a player has night vision.
 *
 * @param id		Player index.
 * @return		True if it has, false otherwise.
 */
native zp_get_user_nightvision(id)

/**
 * Sets whether a player has night vision.
 *
 * @param id		Player index.
 * @param set		True to give, false for removing it.
 */
native zp_set_user_nightvision(id, set)

/** START OF CUSTOM NATIVES */

/**
 * If the user is frozen
 *
 * @param id		Player index.
 */
native zp_get_user_frozen(id)

/**
 * Set if user should be frozen
 *
 * @param id		Player index.
 * @param set		True to set, false for removing it.
 */
native zp_set_user_frozen(id, set)

/**
 * If the user is no damage(Zombie Madness)
 *
 * @param id		Player index.
 */
native zp_get_user_nodamage(id)

/**
 * Set if user should be no damage(Zombie Madness)
 *
 * @param id		Player index.
 * @param set		True to set, false for removing it.
 */
native zp_set_user_nodamage(id, set)

/**
 * If the user is stucked
 *
 * @param id		Player index.
 */
native zp_get_user_stucked(id)

/**
 * Set user unstucked if he is stucked
 *
 * @param id		Player index.
 */
native zp_set_user_unstucked(id)

/**
 * If user has infection nade
 *
 * @param id		Player index.
 */
native zp_user_has_infect_nade(id)

/**
 * If the user is burning
 *
 * @param id		Player index.
 */
native zp_get_user_burning(id)

/**
 * Set user burning
 *
 * @param id		Player index.
 * @param bool:isburning	True: Set burning | False: Remove burn
 */
native zp_set_user_burning(id, bool:isburning)

/**
 * If the user has unlimited clip
 *
 * @param id		Player index.
 */
native zp_get_user_unlimited_clip(id)

/**
 * Set user unlimited clip
 *
 * @param id		Player index.
 * @param set		1: Unlimited clip | False: Remove unlimited clip
 */
native zp_set_user_unlimited_clip(id, set)

/**
 * If the user has Pain Shock Free
 *
 * @param id		Player index.
 */
native zp_user_has_painshockfree(id)

/**
 * Set user Pain Shock Free
 *
 * @param id		Player index.
 * @param set		1: PSF | False: Remove PSF
 */
native zp_set_user_painshockfree(id, set)

/**
 * Start a specified game mode
 *
 * @param gamemode	Start a mode(MODE_SWARM | MODE_MULTI | MODE_PLAGUE)
 */
native zp_set_gamemode(gamemode)

/**
 * Get user's gender(IN-GAME, NOT REAL LIFE)
 *
 * @param id		Player's Index
 */
native zp_get_user_gender(id)

/**
 * Set user's gender(IN-GAME, NOT REAL LIFE)
 *
 * @param id		Player's Index
 * @param gender	Put 1 for Male & 2 for female
 */
native zp_set_user_gender(id, gender)

/**
 * Get user's model
 *
 * @param id		Player's Index
 * @string[]		Model's name
 * @len			Lens
 */
native zp_get_user_model(id, const string[], len)

/**
 * Set user's model
 *
 * @param id		Player's Index
 * @param model[]	Change to the specified model
 */
native zp_set_user_model(id, const model[])

/**
 * Randomly places a user via index if he is alive.
 *
 * @param id		Player's Index
 */
native zp_user_random_spawn(id)

/** END OF CUSTOM NATIVES */

/**
 * Forces a player to become a zombie.
 *
 * Note: Unavailable for last human/survivor.
 *
 * @param id		Player index to be infected.
 * @param infector	Player index who infected him (optional).
 * @param silent	If set, there will be no HUD messages or infection sounds.
 * @param rewards	Whether to show DeathMsg and reward frags, hp, and ammo packs to infector.
 * @return		True on success, false otherwise.
 */
native zp_infect_user(id, infector = 0, silent = 0, rewards = 0)

/**
 * Forces a player to become a human.
 *
 * Note: Unavailable for last zombie/nemesis.
 *
 * @param id		Player index to be cured.
 * @param silent	If set, there will be no HUD messages or antidote sounds.
 * @return		True on success, false otherwise.
 */
native zp_disinfect_user(id, silent = 0)

/**
 * Forces a player to become a nemesis.
 *
 * Note: Unavailable for last human/survivor.
 *
 * @param id		Player index to turn into nemesis.
 * @return		True on success, false otherwise.
 */
native zp_make_user_nemesis(id)

/**
 * Forces a player to become a survivor.
 *
 * Note: Unavailable for last zombie/nemesis.
 *
 * @param id		Player index to turn into survivor.
 * @return		True on success, false otherwise.
 */
native zp_make_user_survivor(id)

/**
 * Respawns a player into a specific team.
 *
 * @param id		Player index to be respawned.
 * @param team		Team to respawn the player into (ZP_TEAM_ZOMBIE or ZP_TEAM_HUMAN).
 * @return		True on success, false otherwise.
 */
native zp_respawn_user(id, team)

/**
 * Forces a player to buy an extra item.
 *
 * @param id		Player index.
 * @param itemid	A valid extra item ID.
 * @param ignorecost	If set, item's cost won't be deduced from player.
 * @return		True on success, false otherwise.
 */
native zp_force_buy_extra_item(id, itemid, ignorecost = 0)

/**
 * Returns whether the ZP round has started, i.e. first zombie
 * has been chosen or a game mode has begun.
 *
 * @return		0 - Round not started
 *			1 - Round started
 *			2 - Round starting
 */
native zp_has_round_started()

/**
 * Returns whether the current round is a nemesis round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_nemesis_round()

/**
 * Returns whether the current round is a survivor round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_survivor_round()

/**
 * Returns whether the current round is a swarm round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_swarm_round()

/**
 * Returns whether the current round is a plague round.
 *
 * @return		True if it is, false otherwise.
 */
native zp_is_plague_round()

/**
 * Returns number of alive zombies.
 *
 * @return		Zombie count.
 */
native zp_get_zombie_count()

/**
 * Returns number of alive humans.
 *
 * @return		Human count.
 */
native zp_get_human_count()

/**
 * Returns number of alive nemesis.
 *
 * @return		Nemesis count.
 */
native zp_get_nemesis_count()

/**
 * Returns number of alive survivors.
 *
 * @return		Survivor count.
 */
native zp_get_survivor_count()

/**
 * Registers a custom item which will be added to the extra items menu of ZP.
 *
 * Note: The returned extra item ID can be later used to catch item
 * purchase events for the zp_extra_item_selected() forward.
 *
 * Note: ZP_TEAM_NEMESIS and ZP_TEAM_SURVIVOR can be used to make
 * an item available to Nemesis and Survivors respectively.
 *
 * @param name		Caption to display on the menu.
 * @param cost		Ammo packs to be deducted on purchase.
 * @param teams		Bitsum of teams it should be available for.
 * @return		An internal extra item ID, or -1 on failure.
 */
native zp_register_extra_item(const name[], cost, teams)

/**
 * Registers a custom class which will be added to the zombie classes menu of ZP.
 *
 * Note: The returned zombie class ID can be later used to identify
 * the class when calling the zp_get_user_zombie_class() natives.
 *
 * @param name		Caption to display on the menu.
 * @param info		Brief description of the class.
 * @param model		Player model to be used.
 * @param clawmodel	Claws model to be used.
 * @param hp		Initial health points.
 * @param speed		Maximum speed.
 * @param gravity	Gravity multiplier.
 * @param knockback	Knockback multiplier.
 * @return		An internal zombie class ID, or -1 on failure.
 */
native zp_register_zombie_class(const name[], const info[], const model[], const clawmodel[], hp, speed, Float:gravity, Float:knockback)

/**
 * Returns an extra item's ID.
 *
 * @param name		Item name to look for.
 * @return		Internal extra item ID, or -1 if not found.
 */
native zp_get_extra_item_id(const name[])

/**
 * Returns a zombie class' ID.
 *
 * @param name		Class name to look for.
 * @return		Internal zombie class ID, or -1 if not found.
 */
native zp_get_zombie_class_id(const name[])

/**
 * Called when the ZP round starts, i.e. first zombie
 * is chosen or a game mode begins.
 *
 * @param gamemode	Mode which has started.
 * @param id		Affected player's index (if applicable).
 */
forward zp_round_started(gamemode, id)

/**
 * Called when the round ends.
 *
 * @param winteam	Team which has won the round.
 */
forward zp_round_ended(winteam)

/**
 * Called when a player gets infected.
 *
 * @param id		Player index who was infected.
 * @param infector	Player index who infected him (if applicable).
 * @param nemesis	Whether the player was turned into a nemesis.
 */
forward zp_user_infected_pre(id, infector, nemesis)
forward zp_user_infected_post(id, infector, nemesis)

/**
 * Called when a player turns back to human.
 *
 * @param id		Player index who was cured.
 * @param survivor	Whether the player was turned into a survivor.
 */
forward zp_user_humanized_pre(id, survivor)
forward zp_user_humanized_post(id, survivor)

/**
 * Called on a player infect/cure attempt. You can use this to block
 * an infection/humanization by returning ZP_PLUGIN_HANDLED in your plugin.
 *
 * Note: Right now this is only available after the ZP round starts, since some
 * situations (like blocking a first zombie's infection) are not yet handled.
 */
forward zp_user_infect_attempt(id, infector, nemesis)
forward zp_user_humanize_attempt(id, survivor)

/**
 * Called when a player buys an extra item from the ZP menu.
 *
 * Note: You can now return ZP_PLUGIN_HANDLED in your plugin to block
 * the purchase and the player will be automatically refunded.
 *
 * @param id		Player index of purchaser.
 * @param itemid	Internal extra item ID.
 */
forward zp_extra_item_selected(id, itemid)

/**
 * Called when a player gets unfrozen (frostnades).
 *
 * @param id		Player index.
 */
forward zp_user_unfrozen(id)

/**
 * Called when a player becomes the last zombie.
 *
 * Note: This is called for the first zombie too.
 *
 * @param id		Player index.
 */
forward zp_user_last_zombie(id)

/**
 * Called when a player becomes the last human.
 *
 * @param id		Player index.
 */
forward zp_user_last_human(id)


/**
 * @deprecated - Do not use!
 * For backwards compatibility only.
 */
#define ZP_TEAM_ANY 0

/**
 * Set victim knockback.
 *
 * Note: This is called for the first zombie too.
 *
 * @param victim		Victim index.
 * @param attacker		Attacker index.
 * @param velocity		Velocity.
 * @param velocity_amt		Amount of velocity.
 */

#if defined ENABLE_KNOCKBACK_STOCK
	stock zp_set_victim_knockback(victim, attacker, Float:velocity[3], Float:velocity_amt)
	{
		if(!is_user_alive(victim) || !is_user_alive(attacker))
			return 0;
		
		new Float:oldvelocity[3]
		new Float:vicorigin[3];
		new Float:attorigin[3];
		
		#if defined USE_FAKEMETA_FOR_KNOCKBACK
			pev(victim, pev_velocity, oldvelocity)
			pev(victim, pev_origin, vicorigin)
			pev(attacker, pev_origin, attorigin)
		#else
			entity_get_vector(victim, EV_VEC_velocity, oldvelocity);
			entity_get_vector(victim, EV_VEC_origin, vicorigin);
			entity_get_vector(attacker, EV_VEC_origin, attorigin);
		#endif
	
		new Float:origin2[3]
		origin2[0] = vicorigin[0] - attorigin[0];
		origin2[1] = vicorigin[1] - attorigin[1];
	
		new Float:largestnum = 0.0;
	
		if(floatabs(origin2[0])>largestnum) largestnum = floatabs(origin2[0]);
		if(floatabs(origin2[1])>largestnum) largestnum = floatabs(origin2[1]);

		origin2[0] /= largestnum;
		origin2[1] /= largestnum;
	
		velocity[0] = (origin2[0] * (velocity_amt));
		velocity[1] = (origin2[1] * (velocity_amt));
		if(velocity[0] <= 20.0 || velocity[1] <= 20.0)
			velocity[2] = random_float(200.0 , 275.0);
		
		velocity[0] += oldvelocity[0];
		velocity[1] += oldvelocity[1];
		
		#if defined USE_FAKEMETA_FOR_KNOCKBACK
			set_pev(victim, pev_velocity, velocity);
		#else
			set_user_velocity(victim, velocity);
		#endif
		
		return 1;
	}
#endif
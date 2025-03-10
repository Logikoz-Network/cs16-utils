/* AMX Mod script.
*
*   SuperHero Mod (superheromod.sma)
*
*****************************************************************************/

// XP Saving Method
// Make sure only ONE is uncommented
#define SAVE_VAULT		//Saves XP to vault.ini (default)
//#define SAVE_MYSQL		//Saves XP to a MySQL database

/****************************************************************************
*
*   Version 1.17.6 - Date: 10/03/2004
*
*   Original by by {HOJ} Batman <johnbroderick@sbcglobal.net>
*
*   Currently being maintained by the SHERO DEV TEAM
*   http://shero.rocks-hideout.com/index.php?page=team
*
****************************************************************************
*
*  GOALS
*   1) keep # of binds small and determinable (i.e. no matter what new heroes come along)
*   2) reuse binds amongst heroes (so you don't have to keep rebinding)
*   3) modular heroes - can add and take away using plugins.ini and separate hero *.sma scripts
*   4) No C/D = No Powers Code
*
*  Admin Commands:
*
*    amx_shsetxp			- Allows admin to set a players XP to a specified amount
*    amx_shaddxp			- Allows admin to give a players a specified amount of XP
*    amx_shban				- Allows admins to ban players from using powers
*    amx_shunban			- Allows admins to un-ban players from using powers
*    amx_shsetlevel			- Allows admins to set a players level to a specified number
*    amx_shresetxp			- Allows admin with ADMIN_RCON to reset all the saved XP
*
*  Client Command:
*
*    say /help				- Shows help window with all other client commands.
*
*  CVARs: Plase See the shconfig.cfg for the cvar settings
*
*                     ******** FUN Module REQUIRED ********                     
*               ******** VexdUM Module REQUIRED for AMX ********                
*             ******** Engine Module REQUIRED for AMXModX ********              
*             ******** CStrike Module REQUIRED for AMXModX ********             
*                                                                               
*  Changelog:
*
*  v1.17.6 - JTP10181 - 10/03/04
*	- Made is so menu is not auto-displayed for spectators
*	- Fixed bug, giving wrong XP ammout if you get a HS and are using the HSMULT setting
*	- Fixed bug, reload ammo function would slow down user if using the drop weapon setting
*	- Added functionality to remeber XP for bots by thier names
*	- Eliminated cpalive CVAR, set sh_cmdprojector to "2" for the same effect
*	- Heroes using extradamage now send the correct weapon name if they are only multiplying the damage
*	- Added ability to send shExtraDamage as a headshot so the kill shows up correctly
*
*  v1.17.5 - JTP10181 - 10/03/04
*	- AMXX 0.20 Support (Vault and MySQL)
*	- Tweaks to godmode coding to prevent problems
*	- Fixed anubis errors on AMXX
*	- Fixed Batman "Reliable channel overflow" problems on AMXX
*	- Cleaned up code on all heroes, redid indenting, removed useless code.
*	- Successful bomb plant will now give entire alive team XP
*	- Added event to catch round end if triggered by sv_restart
*	- Tweaked hostage and bomb XP to make it more evenly distributed
*	- Added new function to include to reload clients ammo (see sh_punisher.sma for example)
*	- Fixed some stuff in the include for AMXX
*	- Reworked vault data parsing to remove hardcoded limit of loading only 20 skills (heroes)
*	- Rewrote readINI function to use new strbrkqt stock
*	- Moved all the shExtraDamage code into the core
*	- Fixed readXP so it will not get processed more than once on a player
*	- Added new hero command to set a shield restriction (see sh_batman.sma for example)
*	- Found a more reliable way to detect hostage rescue and get players id
*	- Fixed some bugs in the stun system
*
*  v1.17.4 - JTP10181 - 09/05/04
*	- Fixed "playerskills" bug with some skills getting cut off
*	- Fixed bug with XP not displaying until after freezetime
*	- Hero Levels should now load correctly from cvars on the first map
*	- Fixed "whohas" that has been broken for a long time I assume
*	- Fixed bug in "drop" command when client has the max powers allowed on the server
*	- Increased plugins available memory as it was teetering near the edge of runtime 3 issues.
*	- Tweaked string array lengths to make plugin use less memory
*	- Finally fixed menu bug causing it to say a hero was disabled when it wasn't
*	- Added code to restrict dropping while alive and a cvar to enable / disable it.
*	- Fixed bug in godmode code so one godmode wont cancel another out
*	- "File" saving support totally removed (vault saving is still the default)
*	- Added support for AMX 0.9.9
*
*  v1.17.3 - JTP10181 - 08/27/04
*	- Fixed bug with loadimmediate and some people loosing XP
*	- Fixed bug with ban code if file did not end in a newline
*	- Added checks to make sure authid is valid before trying to load XP
*	- Made autobalance setting get ignored when savexp is on
*	- Fixed more bugs with XP not loading correctly.
*	- Added admin command to reset all the XP
*	- Worked a lot on the MySQL include to make it work better overall
*	- Added a bunch of checks to cancel events for bots (better CZ support also)
*	- Found a way to reset speed without forcing a weapon switch
*	- Fixed bugs with menu resetting to page 1 while you are in it
*	- Made it so powers are not disabled (for freezetime) until the first person spawns
*	- Changed function of debug cvar, it is now the debugging level.
*
*  v1.17.2 - JTP10181 - 08/17/04
*	- Fixed runtime errors if you exceed the MAXHEROS amount
*	- Fixed bug with playSoundDenySelect, changed to client spk so others cannot hear it
*	- Made banning system use less files reads, with the old method it
*		would have caused lag with a large ban file
*	- Redid banning support, can now unban also.
*	- Changed debugMessage function again, to backward support non-stock heroes
*	- Fixed more bugs with stale menus after certain commands
*	- Fixed some issues with variables that could have been causing memory problems
*	- Fixed some menu issues that arose with the last release
*	- Added a cvar to put the menu back how it used to be where it hides disabled heroes
*	- Added a cvar to change (or disable) the level limiting in the menu
*	- Tweaked the way things load on first startup to hopefully fix cvar issues people are having
*	- Found recursion problem causing runtime error 3 and fixed it
*	- If a level is lost the plugin will remove heroes you should not have anymore
*	- Added HeadShot multiplyer cvar to give extra XP for headshots
*
*  v1.17.1 - JTP10181 - 08/12/04
*	- Redid the new round code, should have fixed some bugs with the feezetime being 0
*	- Fixed bug with sh_adminaccess not getting loaded from config before being set as level for commands
*	- Redid the debugging messages system
*	- Redid the readINI function to make it more versatile
*	- Fixed bug with giving XP for hostage rescue
*	- Removed some useless code in the hostage rescue system
*	- Added status messages for the XP given on bomb and hostage events
*	- Changed use of sh_bombhostxp cvar. It now sets the level of XP given/taken for the events
*		Set CVAR to -1 to disable the XP bonuses
*	- Changed the default admin flag because for some reason it was set to the admin_immunity flag
*	- Fixed vault saving by IP so it wont use the port anymore, only the IP
*	- Blocked fullupdate client command to prevent exploiting and resetting cooldown timers and other bad things.
*	- Changed the menu system to make it less confusing why some heroes are not available
*	- Added extra codes to the menu system
*	- Grayed out disabled menu items instead of hiding them
*	- Error message if no argument supplied to /whohas
*	- Added Power Number to /herolist output
*	- Fixed bug in the clearpower function causing hero ids to be out of place in the players array
*	- Redid the damage function in the inc file, blocking death messages with vexd and updating scoreboard properly
*	- Fixed bug with clearpowers when menu was on screen, it would be stale and not refresh
*	- Added function to adjust the servers sv_maxspeed so speed increasing heroes can work properly
*	- Redid the layout for most of the stock heroes so its more standardized.
*	- Removed xtrafun from all heroes possible to better support amx 0.9.9.
*
*  v1.17 - JTP10181 - 07/27/04
*	- Updated all motd box output to be more easy to follow
*	- Fixed bug if only one hero left to pick it would not be displayed
*	- Fixed bug with setting the speed system
*	- Fixed admin commands to follow better standards
*	- Added mercy XP system to give players who gained no XP a small boost each round
*	- cmd_projector merged in with this plugin
*
*  REV 1.16.0 - (ASSKICR) Fixed save by ip if sv_lan = 1
*  REV 1.14.8 - (ASSKICR) Fixed the 1.6 speed bug
*  REV 1.14.7 - (ASSKICR) Made some fixes in newround
*  REV 1.14.6 - (ASSKICR) Made it save XP by STEAMID for 1.6 and WONID for 1.5
*  REV 1.14.5 - (ASSKICR) - Made a few more commands for XP and a command to block powers
*  REV 1.14.4 - added ability to point mysql database to another database than the default amx database if these cvars exists: sh_mysql_db, sh_mysql_user, sh_mysql_pass, sh_mysql_db
*  REV 1.14.3 - bug fix playerpower missed 1 level.  amx_vaulttosql didn't strip shinfo. cleanXP() mysql delete now does sh_saveskills to
*  REV 1.14.2 - bug fix - "re"-joiners loose certain hero skills
*  REV 1.14.1 - mysql, cvars(sh_loadimmediate), say commands(playerskills, playerlevels, whohas),
*               command (amx_vaulttosql) if mysqlmode...
*               Initialize via server command instead of plugin_ini
*               depricated cvar( sh_usevault)
*               small Xavier disconect test
*               small change in displayPowers (now shows how many levels are earnable)
*  REV 1.13.3 - MSG_ONE gaurd to try and eliminate writedest crashes
*  REV 1.13.2 - unabomber radius change, bomberman, cyclops slightly, anubis
*  REV 1.13.1- changed xavier, rolled in aquaman
*  REV 1.12b - reviewing xtrafun based heroes: ironman, skeletor, spiderman, xavier ( make sure user is alive b4 getting origin on new_round), nightcrawler, windwalker
*              Going to try and eliminate xtrafun calls on new joiners to see if can elimnate the crashes.
*  REV 1.12a - fixed loadXP bug - ppl losing XP - various small checks
*  REV 1.11b  - not using max_players() function any longer - test...
*  REV 1.11a - Made hero levels a number instead of reading cvars..., changes cleanXP to make a little better
*  REV 1.10f - take out playerpowerflags..., gaurded key presses by gPlayerBinds instead of gPlayerPowers
*  REV 1.10d - make bomb/hostage, speed, health, armor, gravity turned into vars instead of cvar reads
*  REV 1.10c - refined speed hack bug fix, FIXED playerskills 4096 vs 2048 copy problem
*             changed batman and hob to zeus with weapons.  Batman no longer gets defuse packs.
*  REVE 1.10b
*  REV  1.10a
*  REV 1.09 - commented out client_connect code (should be done on disconnect), make sure user is alive on newRound(),
*             added startround,endround logic to pop client menus to people just joining
*  REV 1.08 - readMemoryTable make sure key is >0, sh_round_started only set once
*  REV 1.07 - fixed unabomber, fixed loading guy with more than sh_maxpowers, addes sh_endroundsave
*  REV 1.06 - removed messaging from heroes - wolv heals to 100, drac to 100
*  REV 1.05 - ADDED sh_maxpowers, removed register loops, added regMaxHealth
*  REV 1.04 - REMOVED CVARS AS A WAY TO COMMUNICATE PLAYER LEVELS AND PLAYER MAXHEALTH
*  REV 1.03 - PROVED CVARS WERE CRASHING SERVER
*  REV 1.02 Beta
*  6/1/2003  - strunpack to copies and changed diminsions - testing crashes large servers
*  5/16/2003 - Fixed mid-round join bug
*  5/17/2003 - Added amx_shsetlevel, amx_shxpspeed, console playerskills
*
*  Thanks to ST4life  for the orginal time projector that was used for the cmd projector
*  Thanks to asskicr for his verison which this is based off of
*
**************************************************************************/

// **** SEE BELOW VARIABLE DEFINITIONS FOR CUSTOMIZABLE SECTION ****

//Gives the plugin a little more memory to work with
#pragma dynamic 6144

//Sets the size of the memory table to hold data until the next save
#define gMemoryTableSize 64

//Amount of heroes to display in the amx_help style console listing
#define HEROAMOUNT 10

//Lets includes detect if the core is loading them or a hero
#define SHCORE

#include <amxmod>
#include <amxmisc>
#include <Vexd_Utilities>
#include <superheromod>

new SHVERSION[] = "1.17.6b"

// Parms Are: Hero, Power Description, Help Info, Needs A Bind?, Level Available At
#if defined AMX_NEW || defined AMXX_VERSION
enum enumHeros { hero[25], superpower[50], help[128], requiresKeys, availableLevel }
#else
enum enumHeros {
	hero: 100 char,
	superpower: 200 char,
	help: 512 char,
	requiresKeys,
	availableLevel,
}
#endif

// The Big Array that holds all of the heroes, superpowers, help, and other important info
new gSuperHeros[SH_MAXHEROS][enumHeros]
new gSuperHeroCount = 0

// Events that can be registered
new gEventKeyDown[SH_MAXHEROS][20]
new gEventKeyUp[SH_MAXHEROS][20]
new gEventInit[SH_MAXHEROS][20]
new gEventLevels[SH_MAXHEROS][20]   // Holds server functions to call when a person levels...
new gEventMaxHealth[SH_MAXHEROS][20]

// Changed these from CVARS to straight numbers...
new gHeroMaxSpeed[SH_MAXHEROS]
new gHeroSpeedWeapons[SH_MAXHEROS][128] // stringof weapons of weapon#s i.e. "[4][31]" Note:"[0]"=all
new gHeroMaxHealth[SH_MAXHEROS]
new Float:gHeroMinGravity[SH_MAXHEROS]
new gHeroMaxArmor[SH_MAXHEROS]
new bool:gHeroShieldRest[SH_MAXHEROS]
new gHeroLevelCVAR[SH_MAXHEROS][25]

//CVARS to be loaded into variables
new bool:gAutoBalance
new bool:gLongTermXP = true
new bool:gBombHostXP = true
new gCMDProj = 0

// Player Variables Used by Various Functions
// Player IDS are base 1 (i.e. 1-32 so we have to diminsion for 33)
new gPlayerPowers[SH_MAXSLOTS+1][SH_MAXLEVELS+1]      // List of all Powers - Slot 0 is the superpower count
new gPlayerBinds[SH_MAXSLOTS+1][SH_MAXBINDPOWERS+1]   // What superpowers are the bind keys bound
new gPlayerMenuOffset[SH_MAXSLOTS+1]
new gPlayerMenuChoices[SH_MAXSLOTS+1][SH_MAXHEROS+1]  // This will be filled in with # of heroes available
new maxPowersLeft[SH_MAXSLOTS+1][SH_MAXLEVELS+1]
new gCurrentWeapon[SH_MAXSLOTS+1]
new gPlayerStunTimer[SH_MAXSLOTS+1]
new Float:gPlayerStunSpeed[SH_MAXSLOTS+1]
new gPlayerGodTimer[SH_MAXSLOTS+1]
new gPlayerStartXP[SH_MAXSLOTS+1]
new gPlayerLevel[SH_MAXSLOTS+1]
new gPlayerXP[SH_MAXSLOTS+1]
new gXPLevel[SH_MAXLEVELS+1]
new gXPGiven[SH_MAXLEVELS+1]
new bool:NewRoundSpawn[SH_MAXSLOTS+1]
new bool:isPowerBanned[SH_MAXSLOTS+1]
new bool:inMenu[SH_MAXSLOTS+1]
new bool:gReadXPNextRound[SH_MAXSLOTS+1]
new bool:firstRound[SH_MAXSLOTS+1]
new bool:hudHelpStatus[SH_MAXSLOTS+1]
new bool:gShieldRestrict[SH_MAXSLOTS+1]
new gBombDefuser = -1
new gBombPlanter = -1
new gHostKillTime[SH_MAXSLOTS+1]
new gReloadTime[SH_MAXSLOTS+1]

//Other miscelaneous global variables
new help_hudmsg[501],debugt[256]
new statusMsg, gmsgScoreInfo, gmsgDeathMsg
new bool:roundfreeze = false
new bool:FirstSpawn = true
new bool:BetweenRounds = false
new gNumLevels = 0
new gMaxPowers = 0
new gMenuID = 0
new idt,idh

//Memory Table Variables
new gMemoryTableCount = 33
new gMemoryTableKeys[gMemoryTableSize][35]               // Table for storing xp lines that need to be flushed to file...
new gMemoryTableNames[gMemoryTableSize][32]              // table for storing the player name (for a given key)
new gMemoryTableXP[gMemoryTableSize]                     // How much XP does a player have?
new gMemoryTableHHelp[gMemoryTableSize]                  // Is the HUD Help on or off
new gMemoryTablePowers[gMemoryTableSize][SH_MAXLEVELS+1] // 0=# of powers, 1=hero index 1 etc.

//Config Files
new gSHFile[128]
new gBanFile[128]
new gSHConfig[128]

//==============================================================================================
// XP Saving Method, do not modify this here, please see the top of the file.
#if defined SAVE_VAULT
#include <superherovault>	//Saves XP to vault.ini (default)
#endif

#if defined SAVE_MYSQL
#include <superheromysql>	//Saves XP to a MySQL database
#endif
//==============================================================================================

//----------------------------------------------------------------------------------------------
public plugin_init()
{
	// Plugin Info
	register_plugin("SuperHero Mod",SHVERSION,"JTP10181/{HOJ}Batman/AssKicR")
	register_cvar("SuperHeroMod_Version",SHVERSION,FCVAR_SERVER|FCVAR_SPONLY)

	format(debugt,255,"plugin_init - Version: %s",SHVERSION)
	debugMessage(debugt)

	// Menus
	gMenuID = register_menuid("Select Super Power")
	new keys = (1<<0)|(1<<1)|(1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<7)|(1<<8)|(1<<9)
	register_menucmd(gMenuID,keys,"selectedSuperPower")

	// Variables
	//DO NOT EDIT THIS FILE TO CHANGE CVAR SETTINGS,
	//EDIT THE SHCONFIG.CFG THATS WHAT IT IS FOR
	register_cvar("sv_superheros", "1" )
	register_cvar("sh_adminaccess", "m")
	register_cvar("sh_alivedrop", "0")
	register_cvar("sh_autobalance", "0")
	register_cvar("sh_bombhostxp","0")
	register_cvar("sh_cdrequired", "0" )
	register_cvar("sh_cmdprojector", "1")
	register_cvar("sh_debug_messages", "0")
	register_cvar("sh_endroundsave", "0")
	register_cvar("sh_hsmult", "1.0")
	register_cvar("sh_loadimmediate", "0")
	register_cvar("sh_lvllimit", "1")
	register_cvar("sh_maxbinds", "3")
	register_cvar("sh_maxpowers", "20")
	register_cvar("sh_menumode", "1")
	register_cvar("sh_mercyxp", "0")
	register_cvar("sh_mercyxpmode", "1")
	register_cvar("sh_minlevel", "0")
	register_cvar("sh_round_started", "0")
	register_cvar("sh_savexp", "14" )
	register_cvar("sh_xpsavedays", "5")

	// API - Register a bunch of Server Command so that the Heros can Call them
	register_srvcmd("sh_createHero"     , "createHero" ) // Scripts need to register their heroes
	register_srvcmd("sh_regKeyUp"       , "regKeyUp"   ) // Hero can register a keyup event to fire
	register_srvcmd("sh_regKeyDown"     , "regKeyDown" ) // Hero can register a keydown event to fire
	register_srvcmd("sh_regLevels"      , "regLevels"     ) // Hero may want to what levels people are at...
	register_srvcmd("sh_regMaxHealth"   , "regMaxHealth"     ) // Hero may want to know what max health of a person is... doing this to cut down on server messages (woverine, dracula)
	register_srvcmd("sh_regInit"        , "regInit"    ) // Hero may need to init player gains or looses superpowers! 2 parms passed to script - id and hassuperpowers
	register_srvcmd("sh_setmaxspeed"    , "setMaxSpeed" ) // Hero may allow for speed Boosts
	register_srvcmd("sh_setmaxhealth"   , "setMaxHealth" ) // Hero may allow for health Boosts
	register_srvcmd("sh_setmingravity"  , "setMinGravity" ) // Hero may allow for gravity Boosts
	register_srvcmd("sh_setmaxarmor"    , "setMaxArmor" )   // Hero may allow for Armor Boosts
	register_srvcmd("sh_setshieldrest"  , "setShieldRestrict" )   // Hero may want to restrict the shield
	register_srvcmd("sh_resetshield"    , "svrResetShield")     // Rechecks a players shield restriction
	register_srvcmd("sh_remspeedpower"  , "svrRemSpeedPower" ) // Hero may need to relinquish speed powers on the fly (i.e. when the power is removed through clearAllPowers etc. )
	register_srvcmd("sh_setspeedpower"  , "svrSetSpeedPower")
	register_srvcmd("sh_remarmorpower"  , "svrRemArmorPower" ) // Hero may need to relinquish armor powers on the fly (i.e. when the power is removed through clearAllPowers etc. )
	register_srvcmd("sh_remhealthpower" , "svrRemHealthPower" ) // Hero may need to relinquish health powers on the fly (i.e. when the power is removed through clearAllPowers etc. )
	register_srvcmd("sh_remgravitypower", "svrRemGravityPower" ) // Hero may need to relinquish gravity powers on the fly (i.e. when the power is removed through clearAllPowers etc. )
	register_srvcmd("sh_setgravitypower", "svrSetGravityPower")
	register_srvcmd("sh_addxp"          , "addXP" ) // Hero may want to add xp for killing another player
	register_srvcmd("sh_extradamage"    , "srvExtraDamage" ) // Deals damage to a client with full message info and money giving on death
	register_srvcmd("sh_reloadammo"     , "reloadAmmo" ) // Reloads a clients ammo after doing some checking
	register_srvcmd("sh_stun"           , "stunPlayer" ) // Hero may want to stun <id> <howLong in secs>
	register_srvcmd("sh_god"            , "godPlayer"     ) // Hero may want to stun <id> <howLong in secs>

	//Init saving method commands/cvars/variables
	saving_init()

	//Load Config File
	loadConfig()

	// Events to Capture
	register_event("ResetHUD","newSpawn","b")
	register_event("CurWeapon","changeWeapon","be","1=1")
	register_logevent("round_start", 2, "1=Round_Start")
	register_logevent("round_end", 2, "1=Round_End")
	register_logevent("round_end", 2, "1&Restart_Round_")

	//Events to catch shield buying
	// Old Style Menus
	register_menucmd(register_menuid("BuyItem",1),(1<<7),"shieldbuy")
	// VGUI Menus
	register_menucmd(-34,(1<<8),"shieldbuy")
	// Steam console QuickBuys
	register_clcmd("shield","shieldqbuy")
	// Steam Autobuying
	register_clcmd("cl_setautobuy","fn_autobuy")
	register_clcmd("cl_autobuy","fn_autobuy")
	register_clcmd("cl_setrebuy","fn_autobuy")
	register_clcmd("cl_rebuy","fn_autobuy")

	// Events Needed for XP system
	register_event("StatusIcon", "gotBomb", "be", "1=1", "1=2", "2=c4")
	register_event("TextMsg", "hostKilled", "b", "2&#Killed_Hostage")
	register_event("51", "hostRescued", "a", "1=9", "2=2", "3!0", "4!0", "5=15")
	register_logevent("allHostRescued", 6, "2=triggered", "3=All_Hostages_Rescued")
	register_event("SendAudio", "bombPlanted", "a", "2&%!MRAD_BOMBPL")
	register_event("BarTime", "bombDefusing", "be", "1=10", "1=5")
	register_event("SendAudio", "bombDefused", "a", "2&%!MRAD_BOMBDEF")
	register_logevent("bombExploded", 6, "2=triggered", "3=Target_Bombed")
	register_event("DeathMsg", "deathEvent","a")

	// Client Commands
	register_clcmd("superpowermenu", "superPowerMenu", -1, "superpowermenu")
	register_clcmd("clearpowers", "cl_clearAllPowers", -1, "clearpowers" )
	register_clcmd("+power1", "powerKeyDown" , -1, "Power 1 Key Pressed")
	register_clcmd("-power1", "powerKeyUp"   , -1, "Power 1 Key Released")
	register_clcmd("+power2", "powerKeyDown" , -1, "Power 2 Key Pressed")
	register_clcmd("-power2", "powerKeyUp"   , -1, "Power 2 Key Released")
	register_clcmd("+power3", "powerKeyDown" , -1, "Power 3 Key Pressed")
	register_clcmd("-power3", "powerKeyUp"   , -1, "Power 3 Key Released")
	register_clcmd("+power4", "powerKeyDown" , -1, "Power 4 Key Pressed")
	register_clcmd("-power4", "powerKeyUp"   , -1, "Power 4 Key Released")
	register_clcmd("+power5", "powerKeyDown" , -1, "Power 5 Key Pressed")
	register_clcmd("-power5", "powerKeyUp"   , -1, "Power 5 Key Released")
	register_clcmd("+power6", "powerKeyDown" , -1, "Power 6 Key Pressed")
	register_clcmd("-power6", "powerKeyUp"   , -1, "Power 6 Key Released")
	register_clcmd("+power7", "powerKeyDown" , -1, "Power 7 Key Pressed")
	register_clcmd("-power7", "powerKeyUp"   , -1, "Power 7 Key Released")
	register_clcmd("+power8", "powerKeyDown" , -1, "Power 8 Key Pressed")
	register_clcmd("-power8", "powerKeyUp"   , -1, "Power 8 Key Released")
	register_clcmd("+power9", "powerKeyDown" , -1, "Power 9 Key Pressed")
	register_clcmd("-power9", "powerKeyUp"   , -1, "Power 9 Key Released")
	register_clcmd("say","HandleSay")
	register_clcmd("fullupdate","fullupdate")

	// Global Variables...
	statusMsg = get_user_msgid("StatusText")
	gmsgScoreInfo = get_user_msgid("ScoreInfo")
	gmsgDeathMsg = get_user_msgid("DeathMsg")

	//Init the rest of the functions after the config has loaded
	set_task(0.01, "initialize")
}
//----------------------------------------------------------------------------------------------
public initialize()
{
	// GIVES TIME FOR SERVER.CFG AND LISTENSERVER.CFG TO LOAD UP THEIR VARIABLES
	// AMX COMMANDS AND CONSOLE COMMAND

	debugMessage("Starting initialize() function")

	new accessLevel[10]
	get_cvar_string("sh_adminaccess", accessLevel, 9)

	register_concmd("amx_shsetxp", "adminSetXP", read_flags(accessLevel),"<nick | @team | @ALL | #userid> <xp> - Sets Players XP")
	register_concmd("amx_shaddxp", "adminSetXP", read_flags(accessLevel),"<nick | @team | @ALL | #userid> <xp> - Adds XP to Players")
	register_concmd("amx_shban", "adminBanXP", read_flags(accessLevel),"<nick or #userid> - Bans a player from using Powers")
	register_concmd("amx_shunban", "adminUnbanXP", read_flags(accessLevel),"<nick | #userid | authid | ip> - Unbans a player from using Powers")
	register_concmd("amx_shsetlevel","adminSetLevel", read_flags(accessLevel),"<nick | @team | @ALL | #userid> <level> - Sets SuperHero level on players")
	register_concmd("amx_shresetxp","adminEraseXP", ADMIN_RCON,"- Erases ALL saved XP (may take some time with a large vault file)")
	register_concmd("playerlevels","adminShowLevels",0,"<nick | @team | @ALL | #userid>")
	register_concmd("playerskills","adminShowSkills",0,"<nick | @team | @ALL | #userid>")
	register_concmd("herolist","adminHeroList",0,"[search] [start] - Lists/Searches available heroes in console")

	// Global Variables...
	gLongTermXP = get_cvar_num("sh_savexp") ? true : false
	gMaxPowers = get_cvar_num("sh_maxpowers")
	gBombHostXP = get_cvar_num("sh_bombhostxp") == -1 ? false : true
	if (!gLongTermXP) gAutoBalance = get_cvar_num("sh_autobalance") ? true : false
	gCMDProj = get_cvar_num("sh_cmdprojector")

	// Clean out old XP data
	cleanXP(false)
	
	// Setup XPGiven and XP
	readINI()      

	//Init CMD_PROJECTOR
	build_sh_hudmessage()

	// Tasks
	set_task(1.0, "loop1P0", 0, "", 0, "b")
	set_task(2.0, "set_sv_maxspeed")
	set_task(3.0, "set_HeroLevels")
}
//----------------------------------------------------------------------------------------------
public loadConfig() {

	//Set Up Config Files
	#if defined AMXX_VERSION
		new configDir[128]
		get_configsdir(configDir,127)
		format(gBanFile,127,"%s/shero/nopowers.cfg",configDir)
		format(gSHFile,127,"%s/shero/superhero.ini",configDir)
		format(gSHConfig,127,"%s/shero/shconfig.cfg",configDir)
	#else
		#if defined AMX_NEW
			format(gBanFile,127,"addons/amx/config/shero/nopowers.cfg")
			format(gSHFile,127,"addons/amx/config/shero/superhero.ini")
			format(gSHConfig,127,"addons/amx/config/shero/shconfig.cfg")
		#else
			format(gBanFile,127,"addons/amx/nopowers.cfg")
			format(gSHFile,127,"addons/amx/superhero.ini")
			format(gSHConfig,127,"addons/amx/shconfig.cfg")
		#endif
	#endif

	//Load Config Files
	if (file_exists(gSHConfig)) {
		log_message("[SH] Attempting to load the SuperHero Config File")
		server_cmd("exec %s",gSHConfig)
	}
	else {
		log_message("[SH] **WARNING** SuperHero Config File not found, correct location: %s",gSHConfig)
	}
}
//----------------------------------------------------------------------------------------------
public loop1P0()
{
	if ( !shModActive() ) return

	//Unstun Timer & GodMode Timer
	TimerAll()

	//Show the CMD Projector
	show_shcmd()
}
//----------------------------------------------------------------------------------------------
public set_sv_maxspeed()
{
	new maxspeed = 320
	for (new x = 0; x < gSuperHeroCount; x++) {
		if (gHeroMaxSpeed[x] > maxspeed) {
			maxspeed = gHeroMaxSpeed[x]
		}
	}
	format(debugt,255,"Setting server CVAR sv_maxspeed to: %d",maxspeed)
	debugMessage(debugt)
	server_cmd("sv_maxspeed %d",maxspeed)
}
//----------------------------------------------------------------------------------------------
public set_HeroLevels()
{
	debugMessage("Reloading Heroes Available Levels")
	for (new x = 0; x < gSuperHeroCount && x <= SH_MAXHEROS; x++) {
		gSuperHeros[x][availableLevel] = get_cvar_num(gHeroLevelCVAR[x])
	}
}
//----------------------------------------------------------------------------------------------
public plugin_precache()
{
	// Default Sounds
	precache_sound( "common/wpn_denyselect.wav" )
	precache_sound( "plats/elevbell1.wav")
}
//----------------------------------------------------------------------------------------------
public plugin_end()
{
	// SAVE EVERYTHING...
	log_message("[SH] Making final XP save before plugin unloads")
	writeMemoryTable()

	//Final cleanup in the saving include
	saving_end()
}
//----------------------------------------------------------------------------------------------
public createHero()
{
	new pHero[25], pPower[50], pHelp[128],pHeroLevel[25], temp[12]
	new bool:pRequiresKeys=false

	// What's the Heroes Name
	read_argv(1,pHero,24)

	// Short Power Description
	read_argv(2,pPower,49)

	// Help to show to user if they select this hero
	read_argv(3,pHelp,127)

	// Does hero need key events
	read_argv(4,temp,11)
	if ( str_to_num(temp) == 1 ) pRequiresKeys = true

	// What Level Does a person have to be to get this Hero - (CVAR! Not # - to change on the fly)
	read_argv(5,pHeroLevel,24)

	format(debugt,255,"Create Hero-> Name: %s  -  Power: %s  -  Level CVAR: %s", pHero, pPower, pHeroLevel)
	debugMessage(debugt,0,3)

	// Add Hero to Big Array!
	if (gSuperHeroCount >= SH_MAXHEROS) {
		debugMessage("Hero Is Being Rejected, Exceeded SH_MAXHEROS")
		return
	}
	new idx = gSuperHeroCount

	copy( gSuperHeros[idx][hero], 24, pHero)
	copy( gSuperHeros[idx][superpower], 49,  pPower)
	gSuperHeros[idx][requiresKeys] = pRequiresKeys
	copy(gSuperHeros[idx][help], 127, pHelp)

	gSuperHeros[idx][availableLevel] = get_cvar_num(pHeroLevel)
	copy(gHeroLevelCVAR[idx],24,pHeroLevel)

	gSuperHeroCount++
}
//----------------------------------------------------------------------------------------------
public regKeyUp()
{
	new pHero[25]
	new pFunction[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	//Get the function being registered
	read_argv(2,pFunction,19)

	format(debugt,255,"Register KeyUP -> Name: %s  - Function: %s", pHero, pFunction)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new idx = getHeroIndex(pHero)
	if ( idx >= 0 && idx<gSuperHeroCount ) {
		copy(gEventKeyUp[idx],19,pFunction)
	}
}
//----------------------------------------------------------------------------------------------
public regKeyDown()
{
	new pHero[25]
	new pFunction[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	//Get the function being registered
	read_argv(2,pFunction,19)

	format(debugt,255,"Register KeyDOWN -> Name: %s  - Function: %s", pHero, pFunction)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new idx = getHeroIndex(pHero)
	if ( idx >= 0 && idx<gSuperHeroCount) {
		copy(gEventKeyDown[idx],19,pFunction)
	}
}
//----------------------------------------------------------------------------------------------
public regLevels()
{
	new pHero[25]
	new pFunction[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	read_argv(2,pFunction,19)

	format(debugt,255,"Register Levels -> Name: %s  - Function: %s", pHero, pFunction)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new idx = getHeroIndex(pHero)
	if ( idx >= 0 && idx < gSuperHeroCount) {
		copy(gEventLevels[idx],19,pFunction)
	}
}
//----------------------------------------------------------------------------------------------
public regMaxHealth()
{
	new pHero[25]
	new pFunction[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	read_argv(2,pFunction,19)

	format(debugt,255,"Register MaxHealth -> Name: %s  - Function: %s", pHero, pFunction)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new idx = getHeroIndex(pHero)
	if ( idx >= 0 && idx < gSuperHeroCount) {
		copy(gEventMaxHealth[idx],19,pFunction)
	}
}
//----------------------------------------------------------------------------------------------
public regInit()
{
	new pHero[25]
	new pFunction[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	read_argv(2,pFunction,19)

	format(debugt,255,"Register Init -> Name: %s  - Function: %s", pHero, pFunction)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new idx = getHeroIndex(pHero)
	if ( idx >= 0 && idx < gSuperHeroCount) {
		copy(gEventInit[idx],19,pFunction)
	}
}
//----------------------------------------------------------------------------------------------
public bool:playerHasPower(id, heroIndex)
{
	for ( new x=1; x <= getPowerCount(id) && x <= SH_MAXLEVELS; x++) {
		if ( gPlayerPowers[id][x] == heroIndex ) return true
	}
	return false
}
//----------------------------------------------------------------------------------------------
public initHero(id, heroIndex )
{
	if ( heroIndex<0 || heroIndex >= gSuperHeroCount ) return

	new lHasPower = playerHasPower(id, heroIndex)

	// OK to pass this through when mod off... Let's heroes cleanup after themselves
	// init event is used to let hero know when a player has selected OR deselected a hero's power
	if ( strlen(gEventInit[heroIndex])>0 ) {
		if (lHasPower) {
			server_cmd( "%s %d 1", gEventInit[heroIndex], id )
		}
		else {
			server_cmd( "%s %d 0", gEventInit[heroIndex], id )
		}
	}
}
//----------------------------------------------------------------------------------------------
// Expecting id,heroname,maxspeed,weaponqulifier i.e. "[1][21]" etc.
public setMaxSpeed()
{
	new pHero[25]
	new pSpeed[19]
	new pWeapons[128]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	// What Speed
	read_argv(2,pSpeed,19)

	// What Weapon
	read_argv(3,pWeapons,127)

	format(debugt,255,"Set MaxSpeed -> Name: %s  -  Speed: %s  -  Weapon(s): %s", pHero, pSpeed, pWeapons)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new heroIndex = getHeroIndex(pHero)
	if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
		gHeroMaxSpeed[heroIndex] = get_cvar_num(pSpeed) // CVAR expected!
		copy( gHeroSpeedWeapons[heroIndex], 127, pWeapons )
	}
}
//----------------------------------------------------------------------------------------------
public setMaxHealth()
{
	new pHero[25]
	new pHealth[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	// What HPs
	read_argv(2,pHealth,19)

	format(debugt,255,"Set MaxHealth -> Name: %s  -  Health: %s", pHero, pHealth)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new heroIndex = getHeroIndex(pHero)
	if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
		gHeroMaxHealth[heroIndex]=get_cvar_num(pHealth) // CVAR expected!
	}
}
//----------------------------------------------------------------------------------------------
public setMinGravity()
{
	new pHero[25]
	new pGravity[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	// What Gravity
	read_argv(2,pGravity,19)

	format(debugt,255,"Set MinGravity -> Name: %s  -  Gravity: %s", pHero, pGravity)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new heroIndex = getHeroIndex(pHero)
	if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
		gHeroMinGravity[heroIndex]=get_cvar_float(pGravity) // CVAR expected!
	}
}
//----------------------------------------------------------------------------------------------
public setMaxArmor()
{
	new pHero[25]
	new pArmor[20]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	// What HPs
	read_argv(2,pArmor,19)

	format(debugt,255,"Set MaxArmor -> Name: %s  -  Armor: %s", pHero, pArmor)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new heroIndex = getHeroIndex(pHero)
	if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
		gHeroMaxArmor[heroIndex] = get_cvar_num(pArmor) // CVAR expected!
	}
}
//----------------------------------------------------------------------------------------------
public setShieldRestrict()
{
	new pHero[25]

	// What's the Heroes Name
	read_argv(1,pHero,24)

	format(debugt,255,"Set ShieldRestrict -> Name: %s", pHero)
	debugMessage(debugt,0,3)

	// Get Hero Index
	new heroIndex = getHeroIndex(pHero)
	if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
		gHeroShieldRest[heroIndex] = true
	}
}
//----------------------------------------------------------------------------------------------
// Called through Server Messages
// Rechecks players shield restriction
public svrResetShield()
{
	// What's the players index
	new pID[3]
	read_argv(1,pID,2)
	new id = str_to_num(pID)

	new heroIndex, bool:restricted = false
	for (new x = 1; x <= getPowerCount(id); x++ ) {
		heroIndex = gPlayerPowers[id][x]
		// Test crash gaurd
		if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
			if ( gHeroShieldRest[heroIndex] ) {
				restricted = true
				break
			}
		}
	}

	gShieldRestrict[id] = restricted

	//If they are alive make sure they don't have a shield already
	if (gShieldRestrict[id] && is_user_alive(id)) {
		new modelName[32]
		Entvars_Get_String(id, EV_SZ_viewmodel, modelName, 31)
		if ( containi(modelName,"v_shield_") != -1 ) {
			engclient_cmd(id,"drop")
		}

	}
}
//----------------------------------------------------------------------------------------------
public Float:getMaxSpeed(id, weapon)
{
	new Float:returnSpeed = -1.0
	new weaponString[10]
	new heroIndex

	format(weaponString,9,"[%d]",weapon)
	for (new idx = 1; idx <= getPowerCount(id); idx++ ) {
		heroIndex=gPlayerPowers[id][idx]
		if ( heroIndex>=0 && heroIndex < gSuperHeroCount && gHeroMaxSpeed[heroIndex] > 0 ) {
			format(debugt,255,"Looking for Speed Functions - %s, %s, %s", gSuperHeros[heroIndex][hero],gHeroSpeedWeapons[heroIndex],weaponString)
			debugMessage(debugt, id, 5)
			if ( contain(gHeroSpeedWeapons[heroIndex],"[0]") >= 0 || contain(gHeroSpeedWeapons[heroIndex],weaponString) >= 0 ) {
				format(debugt,255,"Looking up Speed cvar %d", gHeroMaxSpeed[heroIndex] )
				debugMessage(debugt, id, 5)
				returnSpeed = maxof( returnSpeed, gHeroMaxSpeed[heroIndex] * 1.0 )
			}
		}
	}
	return returnSpeed
}
//----------------------------------------------------------------------------------------------
public getMaxHealth(id)
{
	new returnHealth = 100
	new heroIndex

	for (new x = 1; x <= getPowerCount(id); x++ ) {
		heroIndex=gPlayerPowers[id][x]
		// Test crash gaurd
		if ( heroIndex>=0 && heroIndex < gSuperHeroCount ) {
			if ( gHeroMaxHealth[heroIndex] >0 ) {
				returnHealth = max( returnHealth, gHeroMaxHealth[heroIndex] )
			}
		}
	}

	// Ok let any heroes know that need to know...
	for ( new x = 0; x < gSuperHeroCount; x++ ) {
		if ( strlen( gEventMaxHealth[x] ) > 0 ) {
			server_cmd( "%s %d %d", gEventMaxHealth[x], id, returnHealth )
		}
	}

	return returnHealth
}
//----------------------------------------------------------------------------------------------
public Float:getMinGravity(id)
{
	new Float:minGravity=1.0
	new heroIndex

	for (new x = 1; x <= getPowerCount(id); x++ ) {
		heroIndex=gPlayerPowers[id][x]
		if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
			if ( gHeroMinGravity[heroIndex] > 0.0 ) {
				minGravity=minof( minGravity, gHeroMinGravity[heroIndex] )
			}
		}
	}
	return minGravity
}
//----------------------------------------------------------------------------------------------
public getMaxArmor(id)
{
	new returnArmor = 0
	new heroIndex

	for (new x = 1; x <= getPowerCount(id); x++ )
	{
		heroIndex=gPlayerPowers[id][x]
		if ( heroIndex >= 0 && heroIndex < gSuperHeroCount )
		{
			if ( gHeroMaxArmor[heroIndex] > 0 ) {
				returnArmor=max(returnArmor, gHeroMaxArmor[heroIndex] )
			}
		}
	}
	return returnArmor
}
//----------------------------------------------------------------------------------------------
public getHeroIndex(heroName[] )
{
	for ( new x=0; x < gSuperHeroCount; x++ ) {
		if ( containi(gSuperHeros[x][hero], heroName) != -1 ) return x
	}
	return -1
}
//----------------------------------------------------------------------------------------------
public getPowerCount(id)
{
	// I'll make this a function for now in case I want to change power mapping strategy
	// i.e. drop a power menu
	return max(gPlayerPowers[id][0],0)
}
//----------------------------------------------------------------------------------------------
public getBindNumber(id,heroIndex)
{
	new MaxBinds = min(get_cvar_num("sh_maxbinds"), SH_MAXBINDPOWERS)
	for (new x = 1; x <= MaxBinds; x++) {
		if (gPlayerBinds[id][x] == heroIndex) return x
	}
	return 0
}
//----------------------------------------------------------------------------------------------
public menuSuperPowers(id, menuOffset)
{
	// Don't show menu if mod off or they're not connected
	if ( !shModActive() || !is_user_connected(id) || gReadXPNextRound[id] ) return PLUGIN_HANDLED

	//Don't show menu to bots
	if ( is_user_bot(id) ) return PLUGIN_HANDLED

	inMenu[id] = false
	gPlayerMenuOffset[id] = 0

	// show menu super power
	new message[1801]
	new temp[128]
	new keys = 0
	new heroIndex, heroLevel, playerpowercount

	// check for cheat death
	if ( !passCheatDeathCheck(id) ) {
		client_print(id, print_center, "Get C/D From www.unitedadmins.com")
		return PLUGIN_HANDLED // Just don't show the gui menu
	}

	if ( isPowerBanned[id] ) {
		client_print(id, print_center, "You are not allowed to have powers")
		return PLUGIN_HANDLED // Just don't show the gui menu
	}

	// Don't show menu if they already have enough powers
	playerpowercount = getPowerCount(id)
	if ( playerpowercount >= gPlayerLevel[id] || playerpowercount >= gMaxPowers ) return PLUGIN_HANDLED

	// Figure out how many powers a person should be able to have
	// Example: At level 10 a person can pick a max of 1 lvl 10 hero
	//		and a max of 2 lvl 9 heroes, and a max of 3 lvl 8 heors, etc...
	new LvlLimit = get_cvar_num("sh_lvllimit")
	if (LvlLimit == 0) LvlLimit = SH_MAXLEVELS

	for ( new x = 0; x <= gNumLevels; x++) {
		if ( gPlayerLevel[id] >= x ) {
			maxPowersLeft[id][x] = gPlayerLevel[id] - x + LvlLimit
		}
		else maxPowersLeft[id][x] = 0

	}

	// Now decrement the level powers that they've picked
	for ( new x = 1; x <= getPowerCount(id) && x <= SH_MAXLEVELS; x++ ) {
		heroIndex = gPlayerPowers[id][x]
		if ( heroIndex < 0 || heroIndex > gSuperHeroCount) continue
		heroLevel = getHeroLevel(heroIndex)
		// Decrement all maxPowersLeft by 1 for the level hero they have and below
		for ( new y = heroLevel; y >= 0; y-- ) {
			if (--maxPowersLeft[id][y] < 0) maxPowersLeft[id][y] = 0
			//If none left on this level, there should be none left on any higher levels
			if (maxPowersLeft[id][y] <= 0 && y < SH_MAXLEVELS) {
				if (maxPowersLeft[id][y+1] != 0) {
					for ( new z = y; z <= gNumLevels; z++ ) {
						maxPowersLeft[id][z] = 0
					}
				}
			}
		}
	}

	// OK BUILD A LIST OF HEROS THIS PERSON CAN PICK FROM
	gPlayerMenuChoices[id][0] = 0  // <- 0 choices so far
	new count = 0, enabled = 0
	new MaxBinds = min(get_cvar_num("sh_maxbinds"), SH_MAXBINDPOWERS)
	new menuMode = get_cvar_num("sh_menumode")
	new bool:thisEnabled

	for ( new x = 0; x < gSuperHeroCount; x++ )  {
		heroIndex = x
		heroLevel = getHeroLevel(heroIndex)
		thisEnabled = false
		if ( gPlayerLevel[id] >= heroLevel ) {
			if (maxPowersLeft[id][heroLevel] > 0 && !(gPlayerBinds[id][0] >= MaxBinds && gSuperHeros[heroIndex][requiresKeys])) {
				thisEnabled = true
			}
			// Don't want to present this power if the player already has it!
			if ( !playerHasPower(id, heroIndex) && (thisEnabled || menuMode > 0)) {
				count++
				gPlayerMenuChoices[id][0] = count
				gPlayerMenuChoices[id][count] = heroIndex
				if (thisEnabled) enabled++
			}
		}
	}

	//menuOffset Stuff
	if (menuOffset <= 0 || menuOffset > gPlayerMenuChoices[id][0]) menuOffset = 1
	gPlayerMenuOffset[id] = menuOffset

	new total = min ( gMaxPowers, gPlayerLevel[id] )
	format(message,180, "\ySelect Super Power:%-16s\r(You've Selected %d/%d)^n^n", " ", playerpowercount, total )

	// OK Display the Menu
	for ( new x = menuOffset; x < menuOffset + 8; x++ ) {
		// Only allow a selection from powers the player doesn't have
		if (x > gPlayerMenuChoices[id][0]) {
			add(message, 1800, "^n")
			continue
		}
		heroIndex = gPlayerMenuChoices[id][x]
		heroLevel = getHeroLevel(heroIndex)
		if (maxPowersLeft[id][heroLevel] <= 0 || (gPlayerBinds[id][0] >= MaxBinds && gSuperHeros[heroIndex][requiresKeys])) {
			add(message,1800,"\d")
		}
		else {
			add(message,1800,"\w")
		}
		keys = keys | (1<<x-menuOffset) // enable this option
		format(temp, 127, "%s (%d%s)",gSuperHeros[heroIndex][hero],heroLevel,gSuperHeros[heroIndex][requiresKeys] ? "b" : "")
		format(temp, 127, "%d. %-20s- %s^n", x - menuOffset + 1, temp, gSuperHeros[heroIndex][superpower] )
		add(message, 1800, temp)
	}

	if ( gPlayerMenuChoices[id][0] > 8 ) {
		// Can only Display 8 heroes at a time
		add(message, 1800, "\w^n9. More Heroes")
		keys = keys | (1<<8)
	}
	else {
		add(message, 1800, "^n")
	}

	// Cancel
	add(message, 1800, "\w^n0. Cancel")
	keys = keys | (1<<9)

	if ((count > 0 && enabled > 0) || inMenu[id]) {
		format(debugt, 127, "Displaying Menu - offset: %d - count: %d - enabled: %d", menuOffset, count, enabled)
		debugMessage(debugt, id, 8)
		inMenu[id] = true
		show_menu(id, keys, message)
	}

	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public selectedSuperPower(id, key)
{
	if (!inMenu[id] || !shModActive()) return PLUGIN_HANDLED

	inMenu[id] = false

	if ( !passCheatDeathCheck(id) ) {
		client_print(id, print_center, "Get C/D From www.unitedadmins.com")
		return PLUGIN_HANDLED
	}
	if ( isPowerBanned[id] ) {
		client_print(id, print_center, "You are not allowed to have powers")
		return PLUGIN_HANDLED
	}

	// Next and Previous Super Hero Menus
	if ( key == 8 ) {
		menuSuperPowers(id, gPlayerMenuOffset[id] + 8)
		return PLUGIN_HANDLED
	}

	// Cancel
	if ( key == 9 ) {
		gPlayerMenuOffset[id] = 0
		return PLUGIN_HANDLED
	}

	// Hero was Picked!
	new powerCount = getPowerCount(id)
	if ( powerCount >= gNumLevels || powerCount >= gMaxPowers ) return PLUGIN_HANDLED

	new heroIndex = gPlayerMenuChoices[id][key + gPlayerMenuOffset[id]]

	// Just a crash check
	if ( heroIndex < 0 || heroIndex > gSuperHeroCount ) return PLUGIN_HANDLED

	new heroLevel = getHeroLevel(heroIndex)
	new MaxBinds = get_cvar_num("sh_maxbinds")
	if ((gPlayerBinds[id][0] >= MaxBinds && gSuperHeros[heroIndex][requiresKeys])) {
		client_print(id, print_chat, "[SH] You cannot choose more than %d heroes that require binds",MaxBinds)
		menuSuperPowers(id, gPlayerMenuOffset[id])
		return PLUGIN_HANDLED
	}
	else if ( maxPowersLeft[id][heroLevel] <= 0 ) {
		client_print(id, print_chat, "[SH] You cannot pick any more heroes from that level")
		menuSuperPowers(id, gPlayerMenuOffset[id])
		return PLUGIN_HANDLED
	}

	new message[256]
	if ( !gSuperHeros[heroIndex][requiresKeys] ) {
		format(message,256,"AUTOMATIC POWER: %s^n%s", gSuperHeros[heroIndex][superpower], gSuperHeros[heroIndex][help])
	}
	else {
		format(message,256,"BIND KEY TO ^"+POWER%d^": %s^n%s", gPlayerBinds[id][0]+1, gSuperHeros[heroIndex][superpower], gSuperHeros[heroIndex][help])
	}

	// Show the Hero Picked
	set_hudmessage(100,100,0,-1.0,0.2,0,1.0,5.0,0.1,0.2,84)
	show_hudmessage( id, message)

	// Bind Keys / Set Powers
	gPlayerPowers[id][0] = powerCount + 1
	gPlayerPowers[id][powerCount + 1] = heroIndex

	//Init This Hero!
	initHero(id, heroIndex)
	displayPowers(id, true)

	// Show the Menu Again if they don't have enough skills yet!
	menuSuperPowers(id, gPlayerMenuOffset[id])

	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
// An easy way to check for powers no matter the hero order
public bool:hasPower(id, heroName[])
{
	for (new x=0; x < gSuperHeroCount; x++ ) {
		if ( contain( gSuperHeros[x][hero], heroName ) != -1 ) {
			return playerHasPower(id, x)
		}
	}
	return false
}
//----------------------------------------------------------------------------------------------
public findHero( heroName[] )
{
	for ( new x=0; x<gSuperHeroCount; x++ ) {
		if ( equali(heroName, gSuperHeros[x][hero] ) ) {
			return x
		}
	}
	return -1
}
//----------------------------------------------------------------------------------------------
public clearPower(id, level)
{
	new heroIndex = gPlayerPowers[id][level]

	if ( heroIndex < 0 || heroIndex >= gSuperHeroCount ) return

	// Ok shift over any levels higher
	for ( new x = level; x <= getPowerCount(id) && x <= SH_MAXLEVELS; x++ ) {
		if (x != SH_MAXLEVELS) gPlayerPowers[id][x] = gPlayerPowers[id][x + 1]
	}

	gPlayerPowers[id][0]--
	if ( getPowerCount(id) < 0) gPlayerPowers[id][0] = 0

	//Clear out powers higher than powercount
	for ( new x = getPowerCount(id) + 1; x <= gNumLevels && x <= SH_MAXLEVELS; x++ ) {
		gPlayerPowers[id][x] = -1
	}

	// Disable this power
	initHero(id, heroIndex )

	// Display Levels will have to rebind this heroes powers...
	gPlayerBinds[id][0] = 0
}
//----------------------------------------------------------------------------------------------
public cl_clearAllPowers(id)
{
	if (!shModActive()) {
		console_print(id,"[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	if (!get_cvar_num("sh_alivedrop") && is_user_alive(id)) {
		console_print(id, "[SH] You are not allowed to drop heroes while alive")
		client_print(id, print_chat, "[SH] You are not allowed to drop heroes while alive")
		return PLUGIN_HANDLED
	}

	// When Client Fires, there won't be a 2nd parm (dispStatusText), so let's just make it true
	clearAllPowers(id,true)
	console_print(id,"[SH] All your powers have been cleared successfully")

	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public clearAllPowers(id, bool:dispStatusText)
{
	gPlayerPowers[id][0] = 0
	gPlayerBinds[id][0] = 0

	//Clear all Power slots for player
	for ( new x = 1; x < gNumLevels && x < SH_MAXLEVELS; x++ ) {
		gPlayerPowers[id][x] = -1
	}

	// OK to fire if mod is off since we want heroes to clean themselves up
	if (is_user_connected(id)) {
		for ( new heroIndex = 0; heroIndex < gSuperHeroCount; heroIndex++) {
			if ( strlen(gEventInit[heroIndex]) > 0 ) {
				initHero(id, heroIndex)  // Disable this power
			}
		}
		if (dispStatusText) {
			displayPowers(id, true)
			menuSuperPowers(id, gPlayerMenuOffset[id])
		}
	}
}
//----------------------------------------------------------------------------------------------
public superPowerMenu(id)
{
	menuSuperPowers(id, 0)
}
//----------------------------------------------------------------------------------------------
public newSpawn(id)
{

	if ( !shModActive() ) return PLUGIN_CONTINUE

	if (!NewRoundSpawn[id]) {
		displayPowers(id, true)
		return PLUGIN_CONTINUE
	}

	if (FirstSpawn && BetweenRounds) {
		FirstSpawn = false
		roundfreeze = true
		set_cvar_num("sh_round_started", 0)
	}

	//if (is_user_bot(id)) return PLUGIN_CONTINUE
	
	if (!BetweenRounds) setSpeedPowers(id)

	// Read the XP!
	if (firstRound[id] && is_user_alive(id) ) {
		firstRound[id] = false
	}
	else if ( !firstRound[id] && gReadXPNextRound[id] && is_user_alive(id) ) {
		readXP(id)
	}

	//MercyXP system
	if (!gReadXPNextRound[id] && is_user_alive(id)) {
		new mercyxpmode = get_cvar_num("sh_mercyxpmode")
		new mercyxp = get_cvar_num("sh_mercyxp")
		new XPtoGive = 0

		if (mercyxpmode != 0 && gPlayerStartXP[id] >= gPlayerXP[id] && get_playersnum() > 1) {

			if (mercyxpmode == 1) XPtoGive = mercyxp

			else if (mercyxpmode == 2 && gPlayerLevel[id] <= mercyxp) {
				new giveLvl = mercyxp - gPlayerLevel[id]
				XPtoGive = gXPGiven[giveLvl] / 2
			}

			if (XPtoGive != 0 ) {
				gPlayerXP[id] += XPtoGive
				client_print(id,print_chat,"[SH] You were given %d MercyXP points", XPtoGive)
			}
		}
		gPlayerStartXP[id] = gPlayerXP[id]
	}

	displayPowers(id, true)

	if ( is_user_alive(id) ) {
		//Shows menu if the person is not in it already and on a team
		if (!inMenu[id] && get_user_team(id) > 0) {
			menuSuperPowers(id, gPlayerMenuOffset[id])
		}
		//Prevents resetHUD from getting called twice in a round
		NewRoundSpawn[id] = false
		//Prevents People from going invisible randomly
		set_user_rendering(id)
	}

	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public round_start()
{
	if ( !shModActive() ) return PLUGIN_CONTINUE

	roundfreeze = false
	BetweenRounds = false

	set_task(0.05,"roundstart_delay")
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public round_end()
{
	for (new x = 1; x <= SH_MAXSLOTS; x++) {
		NewRoundSpawn[x] = true
		if (get_user_team(x) != 0 && is_user_connected(x)) {
			firstRound[x] = false
		}
	}

	BetweenRounds = true
	FirstSpawn = true
	if ( get_cvar_num("sh_endroundsave") ) writeMemoryTable()
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public roundstart_delay()
{
	for ( new x = 1; x <= SH_MAXSLOTS; x++ ) {
		displayPowers(x,true)
		//Prevents People from going invisible randomly
		if (is_user_alive(x)) set_user_rendering(x)
	}
	
	set_cvar_num("sh_round_started", 1)
}
//----------------------------------------------------------------------------------------------
public fullupdate(id)
{
	//This blocks "fullupdate" from resetting the HUD and doing bad things to heroes
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public powerKeyDown(id)
{
	if ( !shModActive() ) return PLUGIN_HANDLED

	new cmd[12],whichKey
	read_argv(0,cmd,11)
	whichKey = str_to_num(cmd[6])

	if ( whichKey > SH_MAXBINDPOWERS || whichKey <= 0 ) return PLUGIN_CONTINUE
	
	format(debugt,255,"power%d Pressed",whichKey)
	debugMessage(debugt, id, 5)

	// Make sure there is a power bound to this key!
	if ( whichKey > gPlayerBinds[id][0] ) {
		playSoundDenySelect(id)
		return PLUGIN_HANDLED
	}

	new heroIndex = gPlayerBinds[id][whichKey]
	if ( heroIndex < 0 || heroIndex >= gSuperHeroCount ) return PLUGIN_HANDLED

	if ( playerHasPower(id, heroIndex) ) {
		if ( strlen(gEventKeyDown[heroIndex]) != 0 ) {
			server_cmd("%s %d",gEventKeyDown[heroIndex], id )
		}
	}
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public powerKeyUp(id)
{
	if ( !shModActive() ) return PLUGIN_HANDLED

	new cmd[12],whichKey
	read_argv(0,cmd,11)
	whichKey = str_to_num(cmd[6])

	if ( whichKey > SH_MAXBINDPOWERS || whichKey <= 0 ) return PLUGIN_CONTINUE
	
	format(debugt,255,"power%d Released",whichKey)
	debugMessage(debugt, id, 5)

	// Make sure there is a power bound to this key!
	if ( whichKey > gPlayerBinds[id][0] ) return PLUGIN_HANDLED

	new heroIndex = gPlayerBinds[id][whichKey]
	if ( heroIndex < 0 || heroIndex >= gSuperHeroCount ) return PLUGIN_HANDLED

	if ( playerHasPower(id, heroIndex) ) {
		if ( strlen(gEventKeyUp[heroIndex]) != 0 ) {
			server_cmd( "%s %d",gEventKeyUp[heroIndex], id )
		}
	}
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public changeWeapon(id) {
	// Change Weapon gets called  even when a player fires a weapon
	// To avoid spamming - set speed only when weapon is not the current weapon
	// Changing Weapons Resets the User speed!

	if ( !shModActive() || !is_user_alive(id) ) return

	new weaponid = read_data(2)

	if ( gCurrentWeapon[id] != weaponid ) {
		gCurrentWeapon[id] = weaponid
		setSpeedPowers(id)
	}
}
//----------------------------------------------------------------------------------------------
// Called through Server Messages
// In the case of flash - etc. we don't want the user to able to keep the speed if they stop the power
// For other heroes that are gravity, hp, armor based TBD...
// Don't want a players selecting flash /canceling flash and then picking a new hero
// Similar for Superman etc. - i.e. get more hps etc.
public svrRemSpeedPower()
{
	if ( !shModActive() ) return
	new pID[10]
	read_argv(1,pID,9)
	setSpeedPowers( str_to_num(pID) )
}
//----------------------------------------------------------------------------------------------
public svrSetSpeedPower()
{
	if ( !shModActive() ) return
	new pID[10]
	read_argv(1,pID,9)
	setSpeedPowers( str_to_num(pID) )
}
//----------------------------------------------------------------------------------------------
// Called through Server Messages
// In the case of Superman - Don't want them to be able to keep>150 health etc. if they stop the power
// Don't want a players selecting superman and then picking a new hero
public svrRemHealthPower()
{
	if ( !shModActive() ) return

	new pID[10]
	read_argv(1,pID,9)
	new id=str_to_num(pID)
	new oldHealth = get_user_health(id)
	new newHealth = getMaxHealth( id )

	if ( oldHealth > newHealth && is_user_alive(id) ) {
		// Assume some damage for doing this?
		// Don't want players picking Superman let's say then removing his power - and trying to keep the HPs
		// If they do that - feel free to lose some hps
		// Also - Superman starts with around 150 Person could take some damage (i.e. reduced to 110 )
		// but then clear powers and start at 100 - like 40 free hps for doing that, trying to avoid expliots
		set_user_health(id, newHealth - (newHealth / 4) )
	}
}
//----------------------------------------------------------------------------------------------
// Called through Server Messages
// In the case of Superman - Don't want them to be able to keep armor etc. if they drop the power mid-game
// Don't want a players selecting superman and then dropping then picking a new hero
public svrRemArmorPower()
{
	if ( !shModActive() ) return
	new pID[10]
	read_argv(1,pID,9)
	new id = str_to_num(pID)
	new newArmor = getMaxArmor( id )

	if ( get_user_armor(id) > newArmor && is_user_alive(id) ) {
		// Remove Armor for doing this
		set_user_armor(id, 0)
	}
}
//----------------------------------------------------------------------------------------------
// Called through Server Messages
// In the case of Superman - Don't want them to be able to keep gravity etc. if they drop the power mid-game
// Don't want a players selecting superman and then dropping then picking a new hero
public svrRemGravityPower()
{
	if ( !shModActive() ) return
	new pID[10]
	read_argv(1,pID,9)
	new id = str_to_num(pID)
	new Float:newGravity = getMinGravity( id )

	if ( get_user_gravity(id) != newGravity && is_user_alive(id) ) {
		// Set to 1.0 or the next lowest Gravity
		set_user_gravity(id, newGravity)
	}
}
//----------------------------------------------------------------------------------------------
public setPowers(id)
{
	if ( !is_user_alive(id) ) return
	setSpeedPowers(id)
	setArmorPowers(id)
	setGravityPowers(id)
	setHealthPowers(id)
}
//----------------------------------------------------------------------------------------------
public svrSetGravityPower()
{
	if ( !shModActive() ) return
	new pID[10]
	read_argv(1,pID,9)
	new id = str_to_num(pID)
	new Float:newGravity = getMinGravity( id )

     // Set to 1.0 or the next lowest Gravity
	set_user_gravity(id, newGravity)
}
//----------------------------------------------------------------------------------------------
public setSpeedPowers(id)
{
	if ( !shModActive() || !is_user_connected(id) ) return
	if ( !is_user_alive(id) || roundfreeze || gReadXPNextRound[id] ) return

	if ( gPlayerStunTimer[id] > 0 ) {
		set_user_maxspeed(id, gPlayerStunSpeed[id] )
		format(debugt,255,"Setting Stun Speed To %f", gPlayerStunSpeed[id] )
		debugMessage(debugt, id, 5)
		return
	}

	new Float:oldSpeed = get_user_maxspeed(id)
	new Float:newSpeed = getMaxSpeed(id, gCurrentWeapon[id])
	new switchweapon = 0

	if (newSpeed == -1.0 && oldSpeed != 1.0) {
		newSpeed = 200.0
		switchweapon = 1
	}
	else if (newSpeed == -1.0) {
		newSpeed = 1.0
	}
	else {
		oldSpeed = -1.0
	}

	// OK SET THE SPEED
	if ( newSpeed != oldSpeed ) {
		set_user_maxspeed(id, newSpeed )
		if (switchweapon) {
			format(debugt,255,"Setting Speed To Default" )
			debugMessage(debugt, id, 5)
			new wpnid, clip, ammo, wpn[32]
			wpnid = get_user_weapon(id, clip, ammo)
			if (wpnid > 0) {
				get_weaponname(wpnid,wpn,31)
				engclient_cmd(id,wpn)
			}
		}
		else {
			format(debugt,255,"Setting Speed To %f", newSpeed )
			debugMessage(debugt, id, 5)
		}
	}
}
//----------------------------------------------------------------------------------------------
public setArmorPowers(id)
{
	if ( !shModActive() || !is_user_connected(id) ) return
	if ( !is_user_alive(id) || gReadXPNextRound[id] ) return

	new oldArmor = get_user_armor(id)
	new newArmor = getMaxArmor(id)

	// Try to avoid people getting armor in middle of round...
	if ( oldArmor < newArmor ) {
		set_user_armor(id, newArmor)
		format(debugt,255,"Setting Armor to %d", newArmor)
		debugMessage(debugt, id, 5)
	}
}
//----------------------------------------------------------------------------------------------
public setHealthPowers(id)
{
	if ( !shModActive() || !is_user_connected(id) ) return
	if ( !is_user_alive(id) || gReadXPNextRound[id] ) return

	new oldHealth = get_user_health(id)
	new newHealth = getMaxHealth(id)

	// Can't get health in the middle of a round UNLESS you didn't get shot...
	if ( oldHealth < newHealth && oldHealth >= 100 ) {
		format(debugt,255,"Setting Health to %d", newHealth)
		debugMessage(debugt, id, 5)
		set_user_health(id, newHealth)
	}
}
//----------------------------------------------------------------------------------------------
public setGravityPowers(id)
{
	if ( !shModActive() || !is_user_connected(id) ) return
	if ( !is_user_alive(id) || roundfreeze || gReadXPNextRound[id] ) return

	new Float:oldGravity = 1.0
	new Float:newGravity = getMinGravity(id)

	if ( oldGravity != newGravity ) {
		format(debugt,255,"Setting Gravity to %f", newGravity)
		debugMessage(debugt, id, 5)
		set_user_gravity(id, newGravity)
	}
}
//----------------------------------------------------------------------------------------------
public writeStatusMessage(id, message[])
{
	//Crash Check
	if ( id <= 0 || id > SH_MAXSLOTS ) return
	if (!is_user_connected(id) || is_user_bot(id)) return

	message_begin( MSG_ONE, statusMsg, {0,0,0}, id)
	write_byte(0)
	write_string(message)
	message_end()
}
//----------------------------------------------------------------------------------------------
public displayPowers(id, bool:setThePowers)
{
	if ( !shModActive() || !is_user_connected(id) ) return
	//if ( is_user_bot(id) ) return

	new message[256],temp[64]
	new heroIndex, MaxBinds, count = 0

	// To avoid recursion - displayPowers will call clearPowers<->Display Power Loop if we don't check for player powers
	if ( isPowerBanned[id] ) {
		clearAllPowers(id, false) // Avoids Recursion with false
		writeStatusMessage(id, "You are banned from using powers")
		return
	}
	else if ( !passCheatDeathCheck(id) ) {
		clearAllPowers(id, false) // Avoids Recursion with false
		writeStatusMessage(id, "Get CheatingDeath from www.unitedadmins.com for SuperHero Powers")
		return
	}
	else if ( gReadXPNextRound[id] ) {
		debugMessage("XP will load next round", id, 5)
		writeStatusMessage(id, "Your XP will be loaded next round")
		return
	}
	
	debugMessage("Displaying and Setting Powers", id, 5)

	// OK Test What Level this Fool is
	testLevel(id)

	if ( gPlayerLevel[id] < gNumLevels ) {
		format(message,255,"LEV:%d/%d XP:(%d/%d)", gPlayerLevel[id], gNumLevels, gPlayerXP[id], gXPLevel[ gPlayerLevel[id]+ 1] )
	}
	else {
		format(message,255,"LEV:%d/%d XP:(%d)", gPlayerLevel[id], gNumLevels, gPlayerXP[id] )
	}

	//Resets All Bind assignments
	MaxBinds = min(get_cvar_num("sh_maxbinds"), SH_MAXBINDPOWERS)
	for (new x = 1; x <= MaxBinds; x++) {
		gPlayerBinds[id][x] = -1
	}
	for (new x = 1; x <= gNumLevels && x <= getPowerCount(id); x++ ) {
		heroIndex=gPlayerPowers[id][x]
		if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
			// 2 types of heroes - auto heroes and bound heroes...
			// Bound Heroes require special work...
			if ( gSuperHeros[heroIndex][requiresKeys] ) {
				count++
				if (count <= 3) {
					if ( strlen(message) > 0 ) add(message,255," ")
					format(temp,63,"%d=%s", count, gSuperHeros[heroIndex] )
					add(message,255,temp)
				}
				// Make sure this players keys are bound correctly
				if ( count <= get_cvar_num("sh_maxbinds") && count <= SH_MAXBINDPOWERS ) {
					gPlayerBinds[id][count] = heroIndex
					gPlayerBinds[id][0] = count
				}
				else {
					clearPower(id,x)
				}
			}
		}
	}
	if (is_user_alive(id)) {
		writeStatusMessage(id, message)
		if (setThePowers) setPowers(id)
	}
	if (inMenu[id]) menuSuperPowers(id, gPlayerMenuOffset[id])
}
//----------------------------------------------------------------------------------------------
public addXP()
{
	new szid[4]
	new szvictim[4]
	new szmult[10]

	read_argv(1,szid,3)
	read_argv(2,szvictim,3)
	read_argv(3,szmult,9)

	new id = str_to_num(szid)
	new victim = str_to_num(szvictim)
	new mult = str_to_num(szmult)

	//stupid check - but checking prevents crashes
	if ( id<=0 || id>32 || victim <=0 || victim > 32 ) return
	gPlayerXP[id] += mult * gXPGiven[ gPlayerLevel[victim] ]
	displayPowers(id, false)
}
//----------------------------------------------------------------------------------------------
public srvExtraDamage()
{
	new szid[4],szattacker[4],szdamage[5],weaponDescription[32], szheadshot[4]
	read_argv(1,szid,3)
	read_argv(2,szattacker,3)
	read_argv(3,szdamage,4)
	read_argv(4,weaponDescription,31)
	read_argv(5,szheadshot,3)

	new id = str_to_num(szid)
	new attacker = str_to_num(szattacker)
	new damage = str_to_num(szdamage)
	new headshot = str_to_num(szheadshot)

	if ( !is_user_alive(id) || !is_user_connected(attacker) ) return
	if ( damage <= 0 ) return

	new userHealth = get_user_health(id)
	if ( userHealth - damage <= 0 ) {
		logKill(attacker, id, weaponDescription)
		if(get_user_team(id) == get_user_team(attacker)) {
			if (get_cvar_num("mp_friendlyfire")) {
				shAddXP( attacker, id, -1)
				if (id != attacker) {
					set_user_frags(attacker, get_user_frags(attacker) - 1)
					client_print(attacker,print_center,"You killed a teammate")
					new money = get_user_money(attacker)
					if (money != 0) set_user_money(attacker,money - 150,1)
				}
			}

		}
		else if (get_user_team(id) != get_user_team(attacker)) {
			shAddXP( attacker, id, 1)
			set_user_frags(attacker, get_user_frags(attacker) + 1)
			new money = get_user_money(attacker)
			if (money < 16000) set_user_money(attacker,money + 300,1)
		}

		//Kill the victim and block the messages
		MessageBlock(gmsgDeathMsg,BLOCK_ONCE)
		MessageBlock(gmsgScoreInfo,BLOCK_ONCE)
		user_kill(id)

		//user_kill removes a frag, this gives it back
		set_user_frags(id,get_user_frags(id) + 1)

		//Replaced HUD death message
		message_begin(MSG_ALL,gmsgDeathMsg,{0,0,0},0)
		write_byte(attacker)
		write_byte(id)
		write_byte(headshot)
		write_string(weaponDescription)
		message_end()

		//Update killers scorboard with new info
		message_begin(MSG_ALL,gmsgScoreInfo)
		write_byte(attacker)
		write_short(get_user_frags(attacker))
		write_short(get_user_deaths(attacker))
		write_short(0)
		write_short(get_user_team(attacker))
		message_end()

		//Update victims scoreboard with correct info
		message_begin(MSG_ALL,gmsgScoreInfo)
		write_byte(id)
		write_short(get_user_frags(id))
		write_short(get_user_deaths(id))
		write_short(0)
		write_short(get_user_team(id))
		message_end()

	}
	else {
		set_user_health(id, userHealth - damage )
		if(id != attacker && get_cvar_num("mp_friendlyfire") && get_user_team(id) == get_user_team(attacker)) {
			new name[33]
			get_user_name(attacker,name,32)
			client_print(0,print_chat,"%s attacked a teammate",name)
		}
	}

}
//---------------------------------------------------------------------------------------------
public reloadAmmo()
{
	new szid[4], szdrop[4]
	read_argv(1,szid,3)
	read_argv(2,szdrop,3)
	new id = str_to_num(szid)
	new dropwpn = str_to_num(szdrop)

	if (gReloadTime[id] >= get_systime() - 1) return
	gReloadTime[id] = get_systime()

	new clip, ammo, wpn[32]
	new wpnid = get_user_weapon(id, clip, ammo)

	if ( wpnid == CSW_C4 || wpnid == CSW_KNIFE ) return
	if ( wpnid == CSW_HEGRENADE || wpnid == CSW_SMOKEGRENADE || wpnid == CSW_FLASHBANG) return

	if ( clip == 0 ) {
		get_weaponname(wpnid,wpn,31)
		if ( dropwpn ) {
			engclient_cmd(id,"drop",wpn)
			give_item(id, wpn)
			engclient_cmd(id, wpn)
			setSpeedPowers(id)
		}
		else {
			#if defined AMXX_VERSION
			new iWPNidx = -1
			while ((iWPNidx = find_ent_by_class(iWPNidx, wpn)) != 0) {
				if (id == entity_get_edict(iWPNidx, EV_ENT_owner)) {
					cs_set_weapon_ammo(iWPNidx, getMaxClipAmmo(wpnid))
					break
				}
			}
			#else
			if ( ammo == getMaxBPAmmo(wpnid) ) {
				client_cmd(id, "-attack")
				client_cmd(id, "+reload")
				client_cmd(id, "-reload")
			}
			else {
				give_item(id, wpn)
				engclient_cmd(id, wpn)
			}
			#endif
		}
	}
}
//----------------------------------------------------------------------------------------------
public TimerAll()
{
	for ( idt = 1; idt <= SH_MAXSLOTS; idt++ ) {
		if ( is_user_alive(idt) ) {
			if ( gPlayerStunTimer[idt] != 0 ) {
				gPlayerStunTimer[idt]--
				gPlayerStunSpeed[idt] = get_user_maxspeed(idt)
				if (gPlayerStunTimer[idt] <= 0 ) {
					gPlayerStunTimer[idt] = 0
					setSpeedPowers(idt)
				}
			}
			if ( gPlayerGodTimer[idt] != 0 ) {
				gPlayerGodTimer[idt]--
				if (gPlayerGodTimer[idt] <= 0 ) {
					gPlayerGodTimer[idt] = 0
					set_user_godmode(idt, 0)
					shUnglow(idt)
				}
			}
		}
		else {
			gPlayerStunTimer[idt] = 0
			gPlayerGodTimer[idt] = 0
		}
	}
}
//----------------------------------------------------------------------------------------------
public stunPlayer()
{
	if ( !shModActive() ) return

	new pID[10], pHowLong[10]
	read_argv(1,pID,9)
	read_argv(2,pHowLong,9)
	new id = str_to_num(pID)
	new howLong = str_to_num(pHowLong)

	if (howLong > gPlayerStunTimer[id]) {
		format(debugt,255,"Stunning for %d seconds", howLong)
		debugMessage(debugt, id, 5)
		gPlayerStunTimer[id] = howLong
	}
}
//----------------------------------------------------------------------------------------------
public godPlayer()
{
	if ( !shModActive() ) return

	new pID[10], pHowLong[10]
	read_argv(1,pID,9)
	read_argv(2,pHowLong,9)
	new id = str_to_num(pID)
	new howLong = str_to_num(pHowLong)

	if (!is_user_alive(id)) return

	if (howLong > gPlayerGodTimer[id]) {
		format(debugt,255,"Has God Mode for %d seconds", howLong)
		debugMessage(debugt, id, 8)
		shGlow(id,0,0,128)
		set_user_godmode(id, 1)
		gPlayerGodTimer[id] = howLong
	}
}
//----------------------------------------------------------------------------------------------
public HandleSay(id)
{
	new said[192]
	read_args(said,191)
	remove_quotes(said)

	if (!shModActive()) {
		client_print(id, print_chat, "[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	if ( equali(said,"/superherohelp") || equali(said,"superherohelp") || equali(said,"/help") || equali(said,"help") ) {
		superHeroHelp(id)
		return PLUGIN_CONTINUE
	}
	else if (equali(said,"/herolist") || equali(said, "herolist")) {
		heroList(id)
		return PLUGIN_HANDLED
	}
	else if ( containi(said,"/playerskills") == 0 || containi(said,"playerskills") == 0 ) {
		new spaceIdx=contain(said," ")
		if (spaceIdx <= 0) spaceIdx = 14
		showPlayerSkills(id,1,said[spaceIdx+1])
		return PLUGIN_HANDLED
	}
	else if ( containi(said,"/playerlevels") == 0 || containi(said,"playerlevels") == 0 ) {
		new spaceIdx=contain(said," ")
		if (spaceIdx <= 0) spaceIdx = 14
		showPlayerLevels(id,1,said[spaceIdx+1])
		return PLUGIN_HANDLED
	}
	else if ( containi(said,"/whohas") == 0 || containi(said,"whohas") == 0 ) {
		new spaceIdx=contain(said," ")
		if (spaceIdx <= 0) {
			client_print(id,print_chat,"[SH] A partial hero is required for that command")
			return PLUGIN_HANDLED
		}
		showWhoHas(id,1,said[spaceIdx+1])
		return PLUGIN_HANDLED
	}
	else if (equali(said,"/myheroes") || equali(said, "myheroes") || equali(said,"/myheros") || equali(said, "myheros")) {
		showHeros(id)
		return PLUGIN_HANDLED
	}
	else if (equali(said,"/clearpowers") || equali(said, "clearpowers")) {
		if (!get_cvar_num("sh_alivedrop") && is_user_alive(id)) {
			client_print(id, print_chat, "[SH] You are not allowed to drop heroes while alive")
			return PLUGIN_HANDLED
		}
		clearAllPowers(id, true)
		client_print(id,print_chat,"[SH] All your powers have been cleared successfully")
		return PLUGIN_HANDLED
	}
	else if (equali(said,"/showmenu") || equali(said, "showmenu")) {
		menuSuperPowers(id, 0)
		return PLUGIN_HANDLED
	}
	else if ( equali(said, "/drop",5) || equali(said, "drop",4) ) {
		dropPower(id, said)
		return PLUGIN_HANDLED
	}
	else if ( equali(said,"/helpon") || equali(said,"helpon") ) {
		if (gCMDProj > 0) {
			client_print(id,print_chat, "[SH] Help HUD message enabled")
		}
		hudHelpStatus[id] = true
		return PLUGIN_HANDLED
	}
	else if ( equali(said,"/helpoff") || equali(said,"helpoff") ) {
		if (gCMDProj > 0) {
			client_print(id,print_chat, "[SH] Help HUD message disabled")
		}
		hudHelpStatus[id] = false
		return PLUGIN_HANDLED
	}
	else if ( equali(said,"/savexp") || equali(said,"savexp") ) {
		client_print(id,print_chat, "[SH] Your XP will be saved automatically, that command is useless")
		gPlayerXP[id] -= gXPGiven[0]
		displayPowers(id, false)
		return PLUGIN_HANDLED
	}
	else if((containi(said, "powers") != -1) || (containi(said, "superhero") != -1)) {
		client_print(id,print_chat, "[SH] For help with SuperHero Mod, say: /help")
		return PLUGIN_CONTINUE
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public dropPower(id, said[] )
{
	new heroName[32]
	new heroIndex
	new bool:found = false

	if (!get_cvar_num("sh_alivedrop") && is_user_alive(id)) {
		client_print(id, print_chat, "[SH] You are not allowed to drop heroes while alive")
		return
	}

	new spaceIdx = contain(said, " " )
	if ( spaceIdx > 0 && strlen(said) > spaceIdx+2 ) {
		copy(heroName, 31, said[spaceIdx+1] )
	}
	else {
		client_print(id, print_chat, "[SH] Please provide at least two letters from the hero name you wish to drop" )
		return
	}

	format(debugt,255,"Trying to Drop Hero: %s", heroName)
	debugMessage(debugt, id, 5)

	for ( new x = 1; x <= getPowerCount(id) && x <= SH_MAXLEVELS; x++ ) {
		heroIndex = gPlayerPowers[id][x]
		if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
			if ( containi( gSuperHeros[heroIndex][hero], heroName ) != -1 ) {
				format(debugt,255,"Dropping Hero: %s", gSuperHeros[heroIndex][hero])
				debugMessage(debugt, id)
				clearPower(id, x)
				client_print(id, print_chat, "[SH] Dropped Hero: %s", gSuperHeros[heroIndex][hero] )
				found = true
				break
			}
		}
	}

	// Show the menu and the loss of power... or a message...
	if ( found ) {
		displayPowers(id, true)
		menuSuperPowers(id, gPlayerMenuOffset[id])
	}
	else {
		client_print(id, print_chat, "[SH] Could Not Find Power to Drop: %s", heroName )
	}
}
//----------------------------------------------------------------------------------------------
public superHeroHelp(id)
{
	if ( !shModActive() ) return

	new len = 1600
	new buffer[1601]
	new n = 0

	#if !defined NO_STEAM
	n += copy(buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
	#endif

	n += copy(buffer[n],len-n,"How to get Heroes:^n")
	n += copy(buffer[n],len-n,"As you kill people you get XP points, once you have accumulated^n")
	n += copy(buffer[n],len-n,"enough for a level up you will be able to pick more heors.^n")
	n += copy(buffer[n],len-n,"The higher the level of the person you kill the more XP you get.^n")
	n += copy(buffer[n],len-n,"The default starting point is level 0 and you cannot select any heroes.^n^n")

	n += copy(buffer[n],len-n,"How to use Binds:^n")
	n += copy(buffer[n],len-n,"To use some of your powers have to bind a key to:^n^n +POWER#^n^n")
	n += copy(buffer[n],len-n,"In order to bind a key you must open your console and use the bind command: ^n^n")
	n += copy(buffer[n],len-n,"bind ^"key^" ^"command^" ^n^n")
	n += copy(buffer[n],len-n,"In this case the command is ^"+POWER#^".  Here are some examples:^n^n")
	n += copy(buffer[n],len-n,"   bind f +POWER1         bind MOUSE3 +POWER2^n^n")

	n += copy(buffer[n],len-n,"Available Say Commands:^n^n")
	n += copy(buffer[n],len-n,"say /superherohelp   - This help menu^n")
	n += copy(buffer[n],len-n,"say /showmenu        - to display power menu while your dead^n")
	n += copy(buffer[n],len-n,"say /herolist        - Lets you see a list of heroes and powers^n")
	n += copy(buffer[n],len-n,"say /myheroes         - Display Your Heroes^n")
	n += copy(buffer[n],len-n,"say /clearpowers     - to clear ALL powers^n")
	n += copy(buffer[n],len-n,"say /drop <hero>     - Drop one power so you can pick another^n")
	n += copy(buffer[n],len-n,"say /whohas <hero>   - Shows you who has a particular power^n")
	n += copy(buffer[n],len-n,"say /playerskills [@ALL|@CT|@T|name] - Shows you what skills other players have chosen^n")
	n += copy(buffer[n],len-n,"say /playerlevels [@ALL|@CT|@T|name] - Shows you what levels other players are^n^n")

	n += copy(buffer[n],len-n,"say /helpon    - Enable HUD Help message (by default only shown when dead)^n")
	n += copy(buffer[n],len-n,"say /helpoff   - Disable HUD Help message (by default only shown when dead)^n^n")

	//n += copy(buffer[n],len-n,"Many popular mods were used to build the current hero list and plugin so...^n")
	//n += copy(buffer[n],len-n,"Thanks: {HOJ} Batman, OLO, Spacedude, Ludwig, Lazy, f117, Johnny Got Gunz,^n")
	//n += copy(buffer[n],len-n,"            AssKicker, Vexd, GSIvan...")

	#if !defined NO_STEAM
	n += copy(buffer[n],len-n,"</pre></body></html>")
	#endif

	show_motd(id,buffer,"Extendable SuperHero Mod Help")
}
//----------------------------------------------------------------------------------------------
public heroList(id)
{
	if ( !shModActive() ) return

	new len = 1500
	new buffer[1501]
	new n = 0

	#if !defined NO_STEAM
	n += copy(buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
	#endif

	n += copy(buffer[n],len-n,"TIP: Use ^"herolist^" in the console for better output and searchability.^n^n")
	n += copy(buffer[n],len-n,"Installed Heroes:^n^n")

	for (new x = 0; x < gSuperHeroCount; x++ ) {
		n += format(buffer[n],len-n,"%s (%d%s) - %s^n", gSuperHeros[x][hero], getHeroLevel(x),gSuperHeros[x][requiresKeys] ? "b" : "", gSuperHeros[x][superpower] )
	}

	#if !defined NO_STEAM
	n += copy(buffer[n],len-n,"</pre></body></html>")
	#endif

	show_motd(id, buffer, "Super Hero List")
}
//----------------------------------------------------------------------------------------------
public showPlayerLevels(id, say, said[])
{
	if ( !shModActive() ) return

	new playerCount
	new players[SH_MAXSLOTS], name[32]

	if (equal(said,"")) copy(said,30,"@ALL")

	new len = 1500
	new buffer[1501]
	new n = 0

	#if !defined NO_STEAM
	if ( say == 1 ) {
		n += copy(buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
	}
	#endif

	if ( say == 1 ) {
		n += copy(buffer[n],len-n,"Player Levels:^n^n")
	}
	else {
		console_print(id,"Player Levels:^n")
	}

	if (said[0]=='@'){
		if (equali("T",said[1])) {
			copy(said[1],31,"TERRORIST")
		}
		if (equali("ALL",said[1])) {
			get_players(players,playerCount)
		}
		else {
			get_players(players,playerCount,"e",said[1])
		}
		if (playerCount == 0){
			console_print(id,"No clients in such team")
			return
		}
	}
	else {
		players[0] = cmd_target(id,said,2)
		if (!players[0]) return
		playerCount = 1
	}

	for (new team = 2; team >= 0; team-- ) {
		for (new x = 0; x < playerCount; x++) {
			new pid = players[x]
			if ( get_user_team(pid) != team) continue
			get_user_name(pid, name, 31)
			new teamName[5]
			if ( get_user_team(pid) == 1 ) copy(teamName,4,"T :")
			else if ( get_user_team(pid) == 2 ) copy(teamName,4,"CT:")
			else copy(teamName,4,"S :")

			if ( say == 1 ) {
				n += format(buffer[n],len-n,"%s%-24s (Level %d)(XP = %d)^n", teamName, name, gPlayerLevel[pid], gPlayerXP[pid] )
			}
			else {
				console_print(id,"%s%-24s (Level %d)(XP = %d)", teamName, name, gPlayerLevel[pid], gPlayerXP[pid] )
			}
		}
	}

	if ( say == 1 ) {
		#if !defined NO_STEAM
		n += copy(buffer[n],len-n,"</pre></body></html>")
		#endif
		
		show_motd(id, buffer, "Players SuperHero Levels")
	}
	else {
		console_print(id, "")
	}
}
//----------------------------------------------------------------------------------------------
public showPlayerSkills(id, say, said[]) {

	if ( !shModActive() ) return

	new playerCount
	new players[SH_MAXSLOTS]
	new name[32]

	if (equal(said,"")) copy(said,31,"@ALL")

	new len = 1500
	new buffer[1501]
	new n = 0
	new tn = 0, tlen = 511
	new temp[512]

	#if !defined NO_STEAM
	if ( say == 1 ) {
		n += copy(buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
	}
	#endif

	if (say == 1) {
		n += copy(buffer[n],len-n,"Player Skills:^n^n")
	}
	else {
		console_print(id,"Player Skills:^n")
	}

	if (said[0]=='@'){
		if (equali("T",said[1])) {
			copy(said[1],31,"TERRORIST")
		}
		if (equali("ALL",said[1])) {
			get_players(players,playerCount)
		}
		else {
			get_players(players,playerCount,"e",said[1])
		}
		if (playerCount==0) {
			console_print(id,"No clients in such team")
			return
		}
	}
	else {
		players[0] = cmd_target(id,said,2)
		if (!players[0]) return
		playerCount = 1
	}

	for ( new team = 2; team >= 0; team-- ) {
		for ( new x = 0; x < playerCount; x++) {
			tn = 0
			new pid = players[x]
			if ( get_user_team(pid) != team) continue
			get_user_name(pid, name, 31)
			new teamName[5]
			if ( get_user_team(pid) == 1 ) copy(teamName,4,"T :")
			else if ( get_user_team(pid) == 2 ) copy(teamName,4,"CT:")
			else copy(teamName,4,"S: ")
			tn += format(temp[tn],tlen-tn,"%s%-24s (Level %d)(XP = %d)^n   ", teamName, name, gPlayerLevel[pid], gPlayerXP[pid] )
			for ( new idx=1; idx <= gPlayerPowers[pid][0]; idx++ ) {
				new heroIndex=gPlayerPowers[pid][idx]
				tn += format(temp[tn],tlen-tn,"| %s ", gSuperHeros[heroIndex][hero] )
				if (idx % 6 == 0) {
					if (say == 1) {
						tn += copy(temp[tn],tlen-tn,"|^n   ")
					}
					else {
						tn += copy(temp[tn],tlen-tn,"|")
						console_print(id,temp)
						tn = 0
						tn += copy(temp[tn],tlen-tn,"   ")
					}
				}
			}

			if (say == 1) {
				tn += copy(temp[tn],tlen-tn,"^n^n")
				n += copy(buffer[n],len-n,temp)
			}
			else {
				console_print(id,temp)
			}
		}
	}

	if ( say == 1 ) {
		#if !defined NO_STEAM
		n += copy(buffer[n],len-n,"</pre></body></html>")
		#endif

		show_motd(id, buffer, "Players SuperHero Skills")
	}
	else {
		console_print(id, "")
	}
}
//----------------------------------------------------------------------------------------------
public showWhoHas(id, say, said[]) {
	if ( !shModActive() ) return

	new playerCount, heroIndex
	new players[SH_MAXSLOTS]
	new name[32], who[32]
	copy(who, 31, said)

	new len = 1500
	new buffer[1501]
	new n = 0

	heroIndex = getHeroIndex(who)

	if (heroIndex < 0) {
		if (say == 1) {
			client_print(id, print_chat, "[SH] Could not find a hero that matches: %s", who )
		}
		else {
			console_print(id, "[SH] Could not find a hero that matches: %s", who )
		}
		return
	}

	#if !defined NO_STEAM
	if ( say == 1 ) {
		n += copy(buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
	}
	#endif

	n += format(buffer[n],len-n,"WhoHas: %s^n^n",gSuperHeros[heroIndex][hero])

	// Get a List of Players
	get_players(players, playerCount)

	for ( new team = 2; team >= 0; team-- ) {
		for (new x = 0; x < playerCount; x++) {
			new pid=players[x]
			if ( get_user_team(pid) != team) continue
			get_user_name(pid, name, 31)
			new teamName[5]
			if (!playerHasPower(pid, heroIndex)) continue
			if ( get_user_team(pid) == 1 ) copy(teamName,4,"T :")
			else if ( get_user_team(pid) == 2 ) copy(teamName,4,"CT:")
			else copy(teamName,4,"S: ")
			n += format(buffer[n],len-n,"%s%-24s (Level %d)(XP = %d)^n", teamName, name, gPlayerLevel[pid], gPlayerXP[pid] )
		}
	}

	if ( say == 1 ) {
		#if !defined NO_STEAM
		n += copy(buffer[n],len-n,"</pre></body></html>")
		#endif

		new title[32]
		format(title,31,"SuperHero WhoHas: %s",who)
		show_motd(id, buffer, title)
	}
	else {
		console_print(id, buffer )
	}
}
//----------------------------------------------------------------------------------------------
public passCheatDeathCheck(id)
{
	// If C/D not required then everything is cool
	if ( !get_cvar_num("sh_cdrequired") ) return true
	if ( !is_user_connected(id) ) return true

	// Ok CD is required Check the Name
	new name[32]
	get_user_name(id, name, 31)
	if ( contain(name,"[No C-D]") == 0 || contain(name,"[Old C-D]") == 0 ) {
		return false
	}

	return true
}
//----------------------------------------------------------------------------------------------
public checkBan(id, key[35])
{
	if( !file_exists(gBanFile) ) return

	new line = 0, stxtsize
	new data[128]

	format(debugt,255,"Checking for ban using key: ^"%s^"",key)
	debugMessage(debugt,id, 4)

	while( (line = read_file(gBanFile,line,data,127,stxtsize)) != 0 && !isPowerBanned[id]) {
		if (stxtsize == 0) continue
		if (equali(data,key)) {
			isPowerBanned[id] = true
			format(debugt,255,"Ban loaded from banlist for this player")
			debugMessage(debugt,id)
		}
	}
}
//----------------------------------------------------------------------------------------------
public cleanBanFile() {

	if( !file_exists(gBanFile) ) return

	new line = 0, stxtsize
	new data[128],tempBanFile[128]

	format(tempBanFile,127,"%s~",gBanFile)
	if ( file_exists(tempBanFile) ) {
		if ( !delete_file(tempBanFile) ) return
	}

	while( (line = read_file(gBanFile,line,data,127,stxtsize)) != 0 ) {
		if (stxtsize != 0) {
			write_file(tempBanFile,data)
		}
	}

	if ( file_exists(gBanFile) ) {
		if ( !delete_file(gBanFile) ) {
			delete_file(tempBanFile)
			return
		}
	}

	line = 0
	if ( file_exists(tempBanFile) ) {
		while( (line = read_file(tempBanFile,line,data,127,stxtsize)) != 0 ) {
			if (stxtsize != 0) {
				write_file(gBanFile,data)
			}
		}
		delete_file(tempBanFile)
	}

	if ( !file_exists(gBanFile) ) write_file(gBanFile,"//List of SteamIDs / IPs Banned from using powers")
}
//----------------------------------------------------------------------------------------------
public getAverageXP()
{
	new count=0
	new Float:sum = 0.0
	for ( new x = 1; x <= SH_MAXSLOTS; x++) {
		if ( is_user_connected(x) && gPlayerXP[x] > 0 ) {
			count++
			sum += gPlayerXP[x]
		}
	}
	if ( count > 0 ) {
		return floatround(sum / count)
	}

	return 0
}
//----------------------------------------------------------------------------------------------
#if defined NO_STEAM
public client_connect(id)
#else
public client_authorized(id)
#endif
{
	if ( !shModActive() ) return
	if ( id <= 0 || id > SH_MAXSLOTS ) return

	// Don't want any left over residuals
	initPlayer(id)

	//if (is_user_bot(id)) return
	
	//Enable Help HUD Message by Default
	hudHelpStatus[id] = true

	// If autobalance is on - promote this player by avg XP?
	if ( gAutoBalance ) {
		gPlayerXP[id] = getAverageXP()
	}

	if ( gLongTermXP ) {
		// Mid-game loads allowed?
		if ( get_cvar_num("sh_loadimmediate") != 0 ) {
			//Delay to reading to the server can finish loading up when the map changes
			set_task(6.0,"readXP",id)
		}
		else {
			gReadXPNextRound[id] = true
		}
	}
}
//----------------------------------------------------------------------------------------------
public client_disconnect(id)
{
	// stupid check but lets see
	if ( id <=0 || id > 32 ) return

	// Yeah don't want any left over residuals
	initPlayer(id)
}
//----------------------------------------------------------------------------------------------
public initPlayer(id)
{
	if ( id <= 0 || id > SH_MAXSLOTS) return

	gPlayerXP[id] = 0
	gPlayerPowers[id][0] = 0
	gPlayerBinds[id][0] = 0
	gCurrentWeapon[id] = 0
	gPlayerStunTimer[id] = 0
	gPlayerGodTimer[id] = 0
	setLevel(id, 0)
	gShieldRestrict[id] = false
	firstRound[id] = true
	NewRoundSpawn[id] = true
	isPowerBanned[id] = false
	gReadXPNextRound[id] = gLongTermXP

	clearAllPowers(id, false)
}
//----------------------------------------------------------------------------------------------
// AMXModX Way of blocking the shield pickup
//----------------------------------------------------------------------------------------------
#if defined AMXX_VERSION
//
public pfn_touch(ptr, ptd)
{
	if ( !shModActive() ) return PLUGIN_CONTINUE
	if ( ptr <= 0 || ptd <= 0 || ptd > SH_MAXSLOTS ) return PLUGIN_CONTINUE
	if ( !gShieldRestrict[ptd] ) return PLUGIN_CONTINUE

	new entclass[32]
	Entvars_Get_String(ptr, EV_SZ_classname, entclass, 31)

	//Lets block the picking up of a shield
	if (equal(entclass,"weapon_shield")) {
		return PLUGIN_HANDLED
	}

	return PLUGIN_CONTINUE
}
//
#else
//----------------------------------------------------------------------------------------------
// AMX Way of blocking the shield pickup
//----------------------------------------------------------------------------------------------
#if defined AMX_NEW
public entity_touch(entity1, entity2) {
#else
public vexd_pfntouch(pToucher, pTouched) {
	new entity1 = pToucher
	new entity2 = pTouched
#endif

	if ( !shModActive() ) return PLUGIN_CONTINUE
	if ( !is_valid_ent(entity1) || !is_valid_ent(entity2) || entity2 > SH_MAXSLOTS ) return PLUGIN_CONTINUE
	if ( !gShieldRestrict[entity2] ) return PLUGIN_CONTINUE

	new entclass[32]
	Entvars_Get_String(entity1, EV_SZ_classname, entclass, 31)

	//Lets block the picking up of a shield
	if (equal(entclass,"weapon_shield")) {
		#if !defined AMX_NEW
		new parm[2]
		parm[0] = entity2
		parm[1] = entity1
		set_task(0.2,"shield_pucheck",0,parm,2)
		#endif
		return PLUGIN_HANDLED
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
// These are called by tasks in AMX98 only
//
#if !defined AMX_NEW
public shield_pucheck(parm[])
{
	new id = parm[0]
	new shdid = parm[1]

	if (!is_user_alive(id)) return

	new iCurrent = -1
	while ((iCurrent = FindEntity(iCurrent, "weapon_shield")) > 0) {
		// If true shield is on ground still, we are done here
		if (shdid == iCurrent) return
	}

	//Shield is gone, someone picked it up that touched it
	new clip, ammo
	parm[1] = get_user_weapon(id, clip, ammo)
	engclient_cmd(id,"weapon_knife")
	set_task(0.2,"shield_mdlcheck",0,parm,2)
}
//----------------------------------------------------------------------------------------------
public shield_mdlcheck(parm[])
{
	new id = parm[0]
	new wpnid = parm[1]
	new modelName[32], weapName[24]
	get_weaponname(wpnid, weapName, 23)
	Entvars_Get_String(id, EV_SZ_viewmodel, modelName, 31)
	if ( containi(modelName,"v_shield_") != -1 ) {
		client_print(id,print_center, "You are not allowed to have a SHIELD due to a hero selection you have made")
		engclient_cmd(id,"drop")
	}
	engclient_cmd(id,weapName)
}
//
#endif //Ending AMX98 only Block
#endif //Ending AMX Block
//----------------------------------------------------------------------------------------------
// This is called when a user tries to buy a shield via a menu
public shieldbuy(id)
{
	if ( !shModActive() ) return PLUGIN_CONTINUE
	if ( id <= 0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE

	if (gShieldRestrict[id]) {
		engclient_cmd(id,"menuselect","10")
		client_print(id,print_center, "You are not allowed to buy a SHIELD due to a hero selection you have made")
		return PLUGIN_HANDLED
	}

	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
// This gets called when a user tries to buy a shield with the console command
public shieldqbuy(id)
{
	if ( !shModActive() ) return PLUGIN_CONTINUE
	if ( id <= 0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE

	if (gShieldRestrict[id] && get_user_team(id) == 2) {
		console_print(id, "[SH] You are not allowed to buy a SHIELD due to a hero selection you have made")
		client_print(id,print_center, "You are not allowed to buy a SHIELD due to a hero selection you have made")
		return PLUGIN_HANDLED
	}

	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
// This gets called when a user tries to use the autobuy feature
// Just block autobuying all together because they should have weapons already
public fn_autobuy(id)
{
	if ( !shModActive() ) return PLUGIN_CONTINUE
	if ( id <= 0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE

	if (gShieldRestrict[id]) {
		console_print(id, "[SH] You are not allowed to use AUTOBUY due to a hero selection you have made")
		client_print(id,print_center, "You are not allowed to use AUTOBUY due to a hero selection you have made")
		return PLUGIN_HANDLED
	}

	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
// Use to set CVAR Variable to the proper level - If a Hero needs to know a level at least it's possible
public setLevel(id, newLevel)
{
	// MAKE SURE THE CVAR IS SET CORRECTLY...
	gPlayerLevel[id]=newLevel

	// Let any hero that wants to know about this level event
	for ( new x=0; x < gSuperHeroCount; x++ ) {
		if ( strlen( gEventLevels[x] ) > 0 ) {
			server_cmd( "%s %d %d", gEventLevels[x], id, newLevel )
		}
	}
}
//----------------------------------------------------------------------------------------------
public deathEvent()
{
	if (!shModActive() ) return PLUGIN_CONTINUE

	new killer_id = read_data(1)
	new victim_id = read_data(2)
	new headshot  = read_data(3)
	new Float:hsmult = get_cvar_float("sh_hsmult")

	if (killer_id && killer_id != victim_id && victim_id) {
		if (get_user_team(killer_id) == get_user_team(victim_id)) {
			//Killed wrong team
			gPlayerXP[killer_id] -= gXPGiven[gPlayerLevel[killer_id]]
		}
		else {
			if (headshot && hsmult > 1.0) {
				gPlayerXP[killer_id] += floatround(gXPGiven[gPlayerLevel[victim_id]] * hsmult)
			}
			else {
				gPlayerXP[killer_id] += gXPGiven[gPlayerLevel[victim_id]]
			}
		}
		displayPowers(killer_id, false)
	}
	gCurrentWeapon[victim_id] = 0
	displayPowers(victim_id, false)
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public hostKilled(id)
{
	if (!shModActive() || !gBombHostXP) return PLUGIN_CONTINUE
	if ( id<=0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE
	
	//Save system time user killed hostage, used in hostRescued function
	gHostKillTime[id] = get_systime()

	new XPtoTake = gXPGiven[get_cvar_num("sh_bombhostxp")]
	gPlayerXP[id] -= XPtoTake
	client_print(id,print_chat,"[SH] You lost %d XP for killing a hostage",XPtoTake)
	displayPowers(id, false)
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public hostRescued()
{
	new id = read_data(3)
	new entid = read_data(4)

	if ( !shModActive() || !gBombHostXP) return PLUGIN_CONTINUE
	if ( entid <= 0 || id <= 0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE
	if ( get_user_team(id) != 2 ) return PLUGIN_CONTINUE
	if ( get_playersnum() <= 1 ) return PLUGIN_CONTINUE
	
	new entclass[32]
	Entvars_Get_String(entid, EV_SZ_classname, entclass, 31)
	if (!equal(entclass,"hostage_entity")) return PLUGIN_CONTINUE

	//Give (1/4)th the XP because there's usually 4 hostages
	new XPtoGive = gXPGiven[get_cvar_num("sh_bombhostxp")] / 4
	gPlayerXP[id] += XPtoGive
	client_print(id,print_chat,"[SH] You got %d XP for rescuing a hostage",XPtoGive)
	displayPowers(id, false)
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public allHostRescued()
{
	if ( !shModActive() || !gBombHostXP) return PLUGIN_CONTINUE
	if (get_playersnum() <= 1 ) return PLUGIN_CONTINUE

	new players[32]
	new numplayers

	new XPtoGive = gXPGiven[get_cvar_num("sh_bombhostxp")]
	get_players(players,numplayers,"ace","CT")
	for (new i = 0; i < numplayers; i++) {
		gPlayerXP[players[i]] += XPtoGive
		client_print(players[i],print_chat,"[SH] Your team got %d XP for rescuing all the hostages",XPtoGive)
		displayPowers(players[i], false)
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public gotBomb(id)
{
	if ( !shModActive() || !gBombHostXP) return PLUGIN_CONTINUE
	if ( id<=0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE

	gBombPlanter = id
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public bombPlanted()
{
	if ( !shModActive() || !gBombHostXP ) return PLUGIN_CONTINUE
	if ( gBombPlanter <= 0 || gBombPlanter > SH_MAXSLOTS) return PLUGIN_CONTINUE
	if ( !is_user_connected(gBombPlanter) ) return PLUGIN_CONTINUE
	if ( get_user_team(gBombPlanter) != 1 ) return PLUGIN_CONTINUE
	if ( get_playersnum() <= 1 ) return PLUGIN_CONTINUE

	new XPtoGive = gXPGiven[get_cvar_num("sh_bombhostxp")]
	gPlayerXP[gBombPlanter] += XPtoGive
	client_print(gBombPlanter,print_chat,"[SH] You got %d XP for planting the bomb",XPtoGive)
	displayPowers(gBombPlanter, false)
	return PLUGIN_CONTINUE

}
//----------------------------------------------------------------------------------------------
public bombDefusing(id)
{
	if ( !shModActive() || !gBombHostXP ) return PLUGIN_CONTINUE
	if ( id <= 0 || id > SH_MAXSLOTS ) return PLUGIN_CONTINUE

	gBombDefuser = id
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public bombDefused()
{
	if ( !shModActive() || !gBombHostXP ) return PLUGIN_CONTINUE
	if ( gBombDefuser <= 0 || gBombDefuser > SH_MAXSLOTS) return PLUGIN_CONTINUE
	if ( !is_user_connected(gBombDefuser) ) return PLUGIN_CONTINUE
	if ( get_user_team(gBombDefuser) != 2 ) return PLUGIN_CONTINUE
	if ( get_playersnum() <= 1 ) return PLUGIN_CONTINUE

	new XPtoGive = gXPGiven[get_cvar_num("sh_bombhostxp")]
	gPlayerXP[gBombDefuser] += XPtoGive
	client_print(gBombDefuser,print_chat,"[SH] You got %d XP for defusing the bomb",XPtoGive)
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public bombExploded() {

	if ( !shModActive() || !gBombHostXP) return PLUGIN_CONTINUE
	if (get_playersnum() <= 1 ) return PLUGIN_CONTINUE

	new players[32]
	new numplayers

	new XPtoGive = gXPGiven[get_cvar_num("sh_bombhostxp")]
	get_players(players,numplayers,"ace","TERRORIST")
	for (new i = 0; i < numplayers; i++) {
		gPlayerXP[players[i]] += XPtoGive
		client_print(players[i],print_chat,"[SH] Your team got %d XP for a successful bomb explosion",XPtoGive)
		displayPowers(players[i], false)
	}
	return PLUGIN_CONTINUE
}
//----------------------------------------------------------------------------------------------
public getLevel(id)
{
	new newLevel = 0

	for ( new i = gNumLevels; i >= 0 ; i-- ) {
		if ( gXPLevel[i] <= gPlayerXP[id] ) {
			newLevel = i
			break
		}
	}

	// Now make sure this level is between the ranges
	new minLevel = get_cvar_num("sh_minlevel")
	if (minLevel < 0) minLevel = 0
	if (minLevel > gNumLevels) minLevel = gNumLevels

	if ( newLevel < minLevel && !gReadXPNextRound[id] ) {
		newLevel = minLevel
		gPlayerXP[id] = gXPLevel[newLevel]
	}

	if ( newLevel > gNumLevels ) newLevel = gNumLevels

	return newLevel
}
//----------------------------------------------------------------------------------------------
public testLevel(id)
{
	new newLevel, oldLevel, playerPowerNum

	oldLevel = gPlayerLevel[id]
	newLevel = getLevel(id)

	// Play a Sound on Level Change!
	if ( oldLevel != newLevel ) {
		setLevel(id, newLevel)
		if ( newLevel != 0 ) client_cmd(id,"spk plats/elevbell1.wav")
	}

	//Make sure player is allowed to have the heroes in thier list
	if (newLevel < oldLevel) {
		for (new x = 1; x <= gNumLevels && x <= getPowerCount(id); x++ ) {
			new heroIndex = gPlayerPowers[id][x]
			if ( heroIndex >= 0 && heroIndex < gSuperHeroCount ) {
				if ( getHeroLevel(heroIndex) > gPlayerLevel[id] ) {
					clearPower(id,x)
					x--
				}
			}
		}
	}

	// Uh oh - Rip away a level from powers if they loose a level
	playerPowerNum = getPowerCount(id)
	if (playerPowerNum > newLevel) {
		for (new x = newLevel + 1; x <= playerPowerNum && x <= SH_MAXLEVELS; x++ ) {
			clearPower(id, newLevel + 1) // Keep clearing level above cuz levels shift!
		}
		gPlayerPowers[id][0] = newLevel
	}

	// Go ahead and write this so it's not lost - hopefully no server crash!
	if ( passCheatDeathCheck(id) && !isPowerBanned[id]) updateMemoryTable(id)
}
//----------------------------------------------------------------------------------------------
public showHeros(id)
{
	if ( !shModActive() ) return PLUGIN_CONTINUE

	new len = 1500
	new buffer[1501]
	new n = 0
	new heroIndex, bindNum, x
	new bindNumtxt[128],name_lvl[128]

	#if !defined NO_STEAM
	n += copy(buffer[n],len-n,"<html><head><style type=^"text/css^">pre{color:#FFB000;}body{background:#000000;margin-left:8px;margin-top:0px;}</style></head><body><pre>^n")
	#endif

	n += copy(buffer[n],len-n,"Your Heroes Are:^n^n")
	for ( x = 1; x <= getPowerCount(id); x++ ) {
		heroIndex = gPlayerPowers[id][x]
		bindNum = getBindNumber(id,heroIndex)
		
		if ( bindNum > 0) {
			format(bindNumtxt,127,"- POWER #%d",bindNum)
		}
		else {
			format(bindNumtxt,127,"")
		}

		format(name_lvl,127,"%s (%d)",gSuperHeros[heroIndex][hero], getHeroLevel(heroIndex))
		n += format(buffer[n],len-n,"%d) %-18s- %s %s^n", x, name_lvl, gSuperHeros[heroIndex][superpower], bindNumtxt)
	}

	#if !defined NO_STEAM
	n += copy(buffer[n],len-n,"</pre></body></html>")
	#endif

	show_motd(id, buffer, "Your Super Heroes")
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminSetLevel(id,levelx,cidx)
{
	if (!cmd_access(id,levelx,cidx,3)) return PLUGIN_HANDLED

	new accessLevel[10]
	get_cvar_string("sh_adminaccess", accessLevel, 9)

	if ( !(get_user_flags(id) & read_flags(accessLevel)) ) {
		console_print(id,"You have no access to that command")
		return PLUGIN_HANDLED
	}

	if (!shModActive()) {
		console_print(id,"[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	new arg[32], arg2[32], name2[32]
	read_argv(1,arg,31)
	read_argv(2,arg2,31)
	new level = str_to_num(arg2)
	get_user_name(id,name2,31)

	if ( level < 0 || level > gNumLevels ) {
		console_print(id,"[SH] Invalid Level - Valid Levels = 0 - %d", gNumLevels )
		return PLUGIN_HANDLED
	}

	if (arg[0]=='@'){
		new players[32], inum
		if (equali("T",arg[1])) {
			copy(arg[1],31,"TERRORIST")
		}
		if (equali("ALL",arg[1])) {
			get_players(players,inum)
		}
		else	{
			get_players(players,inum,"e",arg[1])
		}

		if (inum==0){
			console_print(id,"No clients in such team")
			return PLUGIN_HANDLED
		}
		for(new a = 0;a < inum; ++a) {
			gPlayerXP[players[a]] = gXPLevel[level]
			displayPowers(players[a], false)
		}
		switch (get_cvar_num("amx_show_activity")) {
			case 2:	client_print(0,print_chat,"ADMIN %s: set level %d on %s players",name2,level,arg[1])
			case 1:	client_print(0,print_chat,"ADMIN: set level %d on %s players",level,arg[1])
		}
		console_print(id,"[SH] Set level %d on %s players",level,arg[1])
	}
	else {
		new player = cmd_target(id,arg,2)
		if (!player) return PLUGIN_HANDLED
		gPlayerXP[player] = gXPLevel[level]
		displayPowers(player, false)
		new name[32]
		get_user_name(player,name,31)

		switch(get_cvar_num("amx_show_activity")) {
			case 2:	client_print(0,print_chat,"ADMIN %s: set level %d on %s",name2,level,name)
			case 1:	client_print(0,print_chat,"ADMIN: set level %d on %s",level,name)
		}
		console_print(id,"[SH] Client ^"%s^" has been set to level %d",name,level)
	}
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminSetXP(id,levelx,cidx)
{
	if (!cmd_access(id,levelx,cidx,3)) return PLUGIN_HANDLED

	new accessLevel[10]
	get_cvar_string("sh_adminaccess", accessLevel, 9)

	if ( !(get_user_flags(id) & read_flags(accessLevel) ) ) {
		console_print(id,"You have no access to that command")
		return PLUGIN_HANDLED
	}

	if (!shModActive()) {
		console_print(id,"[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	new cmd[32], arg[32], arg2[32], name2[32]
	new bool:giveXP = false
	read_argv(0,cmd,31)
	read_argv(1,arg,31)
	read_argv(2,arg2,31)
	get_user_name(id,name2,31)
	new xp = str_to_num(arg2)

	if (equali(cmd,"amx_shaddxp")) giveXP = true

	if ( xp > gXPLevel[gNumLevels] || xp < 0 ) {
		console_print(id,"[SH] Invalid XP - Valid XP is setting is 0 - %d",gXPLevel[gNumLevels] )
		return PLUGIN_HANDLED
	}

	if (arg[0]=='@'){
		new players[32], inum
		if (equali("T",arg[1])) {
			copy(arg[1],31,"TERRORIST")
		}
		if (equali("ALL",arg[1])) {
			get_players(players,inum)
		}
		else {
			get_players(players,inum,"e",arg[1])
		}

		if (inum == 0) {
			console_print(id,"No clients in such team")
			return PLUGIN_HANDLED
		}
		for(new a = 0;a < inum; a++) {
			if (giveXP) gPlayerXP[players[a]] += xp
			else gPlayerXP[players[a]] = xp
			displayPowers(players[a], false)
		}
		switch(get_cvar_num("amx_show_activity")) {
			case 2:	client_print(0,print_chat,"ADMIN %s: %s %d XP on %s players",name2,giveXP ? "added" : "set",xp,arg[1])
			case 1:	client_print(0,print_chat,"ADMIN: set %s %d XP on %s players",giveXP ? "added" : "set",xp,arg[1])
		}
		console_print(id,"[SH] Set XP %d on %s players",xp,arg[1])
	}
	else {
		new player = cmd_target(id,arg,2)
		if (!player) return PLUGIN_HANDLED
		if (giveXP) gPlayerXP[player] += xp
		else gPlayerXP[player] = xp
		displayPowers(player, false)
		new name[32]
		get_user_name(player,name,31)
		switch(get_cvar_num("amx_show_activity")) {
			case 2:	client_print(0,print_chat,"ADMIN %s: %s %d XP on %s",name2,giveXP ? "added" : "set",xp,name)
			case 1:	client_print(0,print_chat,"ADMIN: %s %d XP on %s",giveXP ? "added" : "set",xp,name)
		}
		console_print(id,"[SH] Client ^"%s^" has been %s %d XP",name,giveXP ? "given" : "set to",xp)
	}
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminBanXP(id,levelx,cidx) {

	if (!cmd_access(id,levelx,cidx,2)) return PLUGIN_HANDLED

	new accessLevel[10]
	get_cvar_string("sh_adminaccess", accessLevel, 9)

	if ( !(get_user_flags(id) & read_flags(accessLevel)) ) {
		console_print(id,"You have no access to that command")
		return PLUGIN_HANDLED
	}

	new arg[32]
	read_argv(1, arg, 31)

	new player = cmd_target(id, arg, 9)
	if(!player) return PLUGIN_HANDLED

	clearAllPowers(player, false)	// Avoids Recursion with false
	writeStatusMessage(player, "You are banned from using powers")

	new authid[35],name[33],name2[32]
	get_user_name(player,name,32)
	get_user_name(id,name2,32)

	if (isPowerBanned[player]) {
		console_print(id,"[SH] Client is already SuperHero banned: ^"%s<%d><%s>^"",name,get_user_userid(player),authid)
		return PLUGIN_HANDLED
	}

	isPowerBanned[player] = true

	switch(get_cvar_num("amx_show_activity")) {
		case 2:	client_print(0,print_chat,"ADMIN %s: banned %s from using superhero powers",name2,name)
		case 1:	client_print(0,print_chat,"ADMIN: banned %s from using superhero powers",name)
	}
	client_print(player,print_chat,"[SH] You have been banned from using superhero powers")

	if (!getSaveKey(player, authid)) {
		console_print(id,"[SH] Unable to find valid Ban Key to write to file for client: ^"%s<%d><%s>^"",name)
		return PLUGIN_HANDLED
	}

	//Puts a file lock on the file and breaks everything else (tested in AMX)
	//if (file_exists(gBanFile) && !file_size(gBanFile, 2)) {
	//	write_file(gBanFile,"")
	//}

	//Workaround for above issue, this will force the file to be rewritten
	cleanBanFile()

	write_file(gBanFile,authid)

	console_print(id,"[SH] Successfully SuperHero banned ^"%s<%d><%s>^"",name,get_user_userid(player),authid)
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminUnbanXP(id,levelx,cidx) {

	if (!cmd_access(id,levelx,cidx,2)) return PLUGIN_HANDLED

	new accessLevel[10]
	get_cvar_string("sh_adminaccess", accessLevel, 9)

	if ( !(get_user_flags(id) & read_flags(accessLevel)) ) {
		console_print(id,"You have no access to that command")
		return PLUGIN_HANDLED
	}

	new arg[32]
	read_argv(1, arg, 31)

	new player = cmd_target(id, arg, 10)
	new authid[35]

	if (player) {
		new name[33],name2[32]
		get_user_name(player,name,32)
		get_user_name(id,name2,32)

		if (!isPowerBanned[player]) {
			console_print(id,"[SH] Client ^"%s<%d><%s>^" is not SuperHero banned ",name,get_user_userid(player),authid)
			return PLUGIN_HANDLED
		}

		isPowerBanned[player] = false
		displayPowers(player, false)

		switch(get_cvar_num("amx_show_activity")) {
			case 2:	client_print(0,print_chat,"ADMIN %s: unbanned %s from using superhero powers",name2,name)
			case 1:	client_print(0,print_chat,"ADMIN: unbanned %s from using superhero powers",name)
		}

		if (!getSaveKey(player, authid)) {
			console_print(id,"[SH] Unable to find valid Ban Key to remove from file for client: ^"%s<%d><%s>^"",name)
			return PLUGIN_HANDLED
		}

		console_print(id,"[SH] Successfully SuperHero unbanned ^"%s<%d><%s>^"",name,get_user_userid(player),authid)
	}
	//Assume attempting to unban by steamid or IP
	else {
		console_print(id,"[SH] Attemping to unban using argument as AuthID or IP")
		copy(authid,35,arg)
	}

	if( !file_exists(gBanFile) ) {
		console_print(id,"[SH] There is no ban file to modify")
		return PLUGIN_HANDLED
	}

	//Remove the authid (or ip) from the banfile
	new line, stxtsize
	new bool:found = false
	new data[128]
	while( (line = read_file(gBanFile,line,data,127,stxtsize)) != 0 ) {
		if (equali(data,authid)) {
			write_file(gBanFile,"",line - 1)
			found = true
		}
	}

	if (!player) {
		if (found) {
			console_print(id,"[SH] Successfully SuperHero unbanned: %s",authid)
			console_print(id,"[SH] WARNING: If this user is connected they need to reconnect to use powers",authid)
		}
		else {
			console_print(id,"[SH] AuthID or IP ^"%s^" is not SuperHero banned",authid)
		}
	}

	if (found) cleanBanFile()

	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminEraseXP(id,levelx,cidx)
{
	if (!cmd_access(id,levelx,cidx,1)) return PLUGIN_HANDLED

	console_print(id,"[SH] Please wait while the XP is erased")

	for (new x = 1; x <= SH_MAXSLOTS; x++) {
		gPlayerXP[x] = 0
		gPlayerLevel[x] = 0
		writeStatusMessage(x, "All XP has been ERASED")
		clearAllPowers(x, true)
	}

	cleanXP(true)

	new name[32]
	get_user_name(id,name,31)

	switch(get_cvar_num("amx_show_activity")) {
		case 2:	client_print(0,print_chat,"ADMIN %s: Erased ALL Saved XP",name)
		case 1:	client_print(0,print_chat,"ADMIN: Erased ALL Saved XP")
	}
	console_print(id,"[SH] All Saved XP has been Erased Successfully")

	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminShowSkills(id,levelx,cidx)
{
	if (!cmd_access(id,levelx,cidx,1)) return PLUGIN_HANDLED

	if (!shModActive()) {
		console_print(id,"[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	new arg1[32]
	read_argv(1,arg1,31)

	showPlayerSkills(id, 0, arg1)
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminShowLevels(id,levelx,cidx)
{
	if (!cmd_access(id,levelx,cidx,1)) return PLUGIN_HANDLED

	if (!shModActive()) {
		console_print(id,"[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	new arg1[32]
	read_argv(1,arg1,31)

	showPlayerLevels(id, 0, arg1)
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public adminHeroList(id)
{
	if (!shModActive()) {
		console_print(id,"[SH] SuperHero Mod is currently disabled")
		return PLUGIN_HANDLED
	}

	console_print(id,"^n----- Hero Listing -----")
	new argx[20]
	read_argv(1,argx, 19)
	new start=0,end=0
	if (!isdigit(argx[0]) && !equal("", argx)) {
		new tmp[8], n=1
		read_argv(2,tmp,7)
		start = str_to_num(tmp)
		if (start < 0) start = 0
		if (start != 0) start--
		end = start + HEROAMOUNT
		for(new x = 0; x < gSuperHeroCount; x++) {
			if ((containi(gSuperHeros[x][hero], argx) != -1) || (containi(gSuperHeros[x][help], argx) != -1)) {
				if (n > start && n <= end) {
					console_print(id,"%3d: %s (%d%s) - %s",n,gSuperHeros[x][hero],getHeroLevel(x),gSuperHeros[x][requiresKeys] ? "b" : "",gSuperHeros[x][help])
				}
				n++
			}
		}
		if (start+1 > n-1) {
			console_print(id,"----- Highest Entry: %d -----",n-1)
		}
		else if (n-1 == 0) {
			console_print(id,"----- No Matches for Your Search -----")
		}
		else if (n-1 < end) {
			console_print(id,"----- Entries %d - %d of %d -----",start+1,n-1,n-1)
		}
		else {
			console_print(id,"----- Entries %d - %d of %d -----",start+1,end,n-1)
		}

		if (end < n-1) {
			console_print(id,"----- Use 'herolist %s %d' for more -----",argx,end+1)
		}
	}
	else {
		new arg1[8]
		start = read_argv(1,arg1,7) ? str_to_num(arg1) : 1
		if (--start < 0) start = 0
		if (start >= gSuperHeroCount) start = gSuperHeroCount - 1
		end = start + HEROAMOUNT
		if (end > gSuperHeroCount) end = gSuperHeroCount
		for (new i = start; i < end; i++) {
			console_print(id,"%3d: %s (%d%s) - %s",i+1,gSuperHeros[i][hero],getHeroLevel(i),gSuperHeros[i][requiresKeys] ? "b" : "",gSuperHeros[i][help])
		}
		console_print(id,"----- Entries %d - %d of %d -----",start+1,end,gSuperHeroCount)
		if (end < gSuperHeroCount) {
			console_print(id,"----- Use 'herolist %d' for more -----",end+1)
		}
	}
	return PLUGIN_HANDLED
}
//----------------------------------------------------------------------------------------------
public build_sh_hudmessage() {
	new lenx = 500
	new n = 0

	n += copy(help_hudmsg[n],lenx-n,"Super Hero MOD Help^n^n")

	n += copy(help_hudmsg[n],lenx-n,"How To Use Powers:^n")
	n += copy(help_hudmsg[n],lenx-n,"--------------------^n")
	n += copy(help_hudmsg[n],lenx-n,"Input bind into console^n")
	n += copy(help_hudmsg[n],lenx-n,"Bind Example:^n")
	n += copy(help_hudmsg[n],lenx-n,"--------------------^n")
	n += copy(help_hudmsg[n],lenx-n,"bind h +power1^n")
	n += copy(help_hudmsg[n],lenx-n,"bind j +power2^n")
	n += copy(help_hudmsg[n],lenx-n,"bind k +power3^n^n")

	n += copy(help_hudmsg[n],lenx-n,"Client Commands:^n")
	n += copy(help_hudmsg[n],lenx-n,"/help^n")
	n += copy(help_hudmsg[n],lenx-n,"/clearpowers^n")
	n += copy(help_hudmsg[n],lenx-n,"/showmenu^n")
	n += copy(help_hudmsg[n],lenx-n,"/drop <hero>^n")
	n += copy(help_hudmsg[n],lenx-n,"/herolist^n")
	n += copy(help_hudmsg[n],lenx-n,"/playerskills^n")
	n += copy(help_hudmsg[n],lenx-n,"/myheroes^n")
	n += copy(help_hudmsg[n],lenx-n,"------------------------^n")
	n += copy(help_hudmsg[n],lenx-n,"Enable Help:  /helpon^n")
	n += copy(help_hudmsg[n],lenx-n,"Disable Help: /helpoff")
}
//----------------------------------------------------------------------------------------------
public show_shcmd() {
	if (!shModActive()) return
	if (gCMDProj <= 0) return

	set_hudmessage(230,100,10,0.80,0.28, 0, 1.0, 1.0, 0.9, 0.9, 83)
	for(idh = 1; idh <= SH_MAXSLOTS; ++idh) {
		if ((!is_user_alive(idh) || gCMDProj == 2) && !is_user_bot(idh) && is_user_connected(idh)) {
			if (hudHelpStatus[idh]) show_hudmessage(idh,help_hudmsg)
		}
	}
}
//----------------------------------------------------------------------------------------------
public getHeroLevel( heroIndex )
{
	return gSuperHeros[heroIndex][availableLevel]
}
//----------------------------------------------------------------------------------------------
public updateMemoryTable( id )
{
	if ( !shModActive() ) return
	if ( !gLongTermXP ) return
	if ( isPowerBanned[id] || !passCheatDeathCheck(id)) return
	//if ( is_user_bot(id) ) return

	// Update this XP line in Memory Table
	new key[35]
	new name[32]
	if (!getSaveKey(id, key)) return

	// Check to see if there's already another id in that slot... (disconnected etc.)
	if ( strlen(gMemoryTableKeys[id]) > 0 && !equali(gMemoryTableKeys[id], key ) ) {
		if ( gMemoryTableCount < gMemoryTableSize ) {
			copy( gMemoryTableKeys[gMemoryTableCount], 34, gMemoryTableKeys[id]  )
			copy( gMemoryTableNames[gMemoryTableCount], 31, gMemoryTableNames[id] )
			gMemoryTableXP[gMemoryTableCount] = gMemoryTableXP[id]
			gMemoryTableHHelp[gMemoryTableCount] = gMemoryTableHHelp[id]
			for ( new x = 0; x <= SH_MAXLEVELS && x <= gMemoryTablePowers[id][0]; x++ ) {
				gMemoryTablePowers[gMemoryTableCount][x] = gMemoryTablePowers[id][x]
			}
			gMemoryTableCount++  // started with position 33
		}
	}

	// OK copy to table now - might have had to write 1 record...
	get_user_name(id, name, 31)
	copy( gMemoryTableKeys[id], 34, key )
	copy( gMemoryTableNames[id], 31, name)
	gMemoryTableXP[id] = gPlayerXP[id]
	gMemoryTableHHelp[id] = hudHelpStatus[id] ? 1 : 0
	
	for ( new x = 0; x <= SH_MAXLEVELS && x <= getPowerCount(id); x++ ) {
		gMemoryTablePowers[id][x] = gPlayerPowers[id][x]
	}
}
//----------------------------------------------------------------------------------------------
public readMemoryTable(id, key[])
{
	if ( !shModActive() ) return false

	for ( new x = 1; x < gMemoryTableCount; x++ ) {
		if ( strlen(gMemoryTableKeys[x]) > 0 && equal( gMemoryTableKeys[x], key ) ) {
			gPlayerXP[id] = gMemoryTableXP[x]
			gPlayerLevel[id] = getLevel(id)
			setLevel(id, gPlayerLevel[id] )
			hudHelpStatus[id] = gMemoryTableHHelp[id] ? true : false

			// Load the Powers
			gPlayerPowers[id][0] = 0
			for ( new p = 0; p <= gPlayerLevel[id] && p <= gMemoryTablePowers[x][0]; p++ ) {
				gPlayerPowers[id][p] = gMemoryTablePowers[x][p]
				initHero(id, gMemoryTablePowers[x][p])
			}

			// Null this out so if the id changed - there won't be multiple copies of this guy in memory
			if ( id != x) {
				copy( gMemoryTableKeys[x], 34, "" )
				updateMemoryTable(id)
			}
			// Notify that this was found in memory...
			return true
		}
	}
	return false // If not found in memory table...
}
//----------------------------------------------------------------------------------------------
public readXP(id)
{
	if ( !shModActive() ||!gLongTermXP ) return
	//if ( is_user_bot(id) ) return

	//Players XP already loaded, no need to do this again
	if ( !gReadXPNextRound[id] ) return

	new key[35]

	// Get Key
	if (!getSaveKey(id, key)) {
		format(debugt,255,"Invalid KEY found will try to Load XP again: ^"%s^"",key)
		debugMessage(debugt,id)
		set_task(5.0,"readXP",id)
		return
	}

	// Set if player is banned from powers or not
	checkBan(id, key)

	// Check Memory Table First
	if ( readMemoryTable(id, key) ) {
		gReadXPNextRound[id] = false
		updateMemoryTable(id)
		displayPowers(id, false)
	}
	else {
		format(debugt,255,"Loading XP using key: ^"%s^"",key)
		debugMessage(debugt,id)
		if (loadXP(id, key)) {
			gReadXPNextRound[id] = false
			updateMemoryTable(id)
			displayPowers(id, false)
		}
	}
}
//----------------------------------------------------------------------------------------------
public getSaveKey(id, key[35] )
{
	if (is_user_bot(id)) {
		new botname[32]
		get_user_name(id,botname,31)

		//Get rid of bot tag
		
		//PODBot
		replace(botname,31,"[POD]","")
		replace(botname,31,"[P*D]","")
		replace(botname,31,"[P0D]","")
		
		//CZ Bots
		replace(botname,31,"[BOT] ","")

		//Attempt to get rid of the skill tag so we save with bots true name
		new lastchar = strlen(botname) - 1
		if ( equal(botname[lastchar],")",1) ) {
			for (new x = lastchar - 1; x > 0; x--) {
				if ( equal(botname[x],"(",1) ) {
					botname[x - 1] = 0
					break
				}
				if (!isdigit(botname[x]) ) break
			}
		}
		if (strlen(botname) > 0 ) {
			format(key,34,"[BOT]%s", botname)
		}
	}
	else {

		if (get_cvar_num("sv_lan") == 1) {
			get_user_ip(id,key,34,1)		// by ip without port
		}
		else {
			get_user_authid(id,key,34)		// by steamid
			if (equali(key,"STEAM_ID_LAN")) {
				get_user_ip(id,key,34,1)		// by ip without port
			}
		}
	}

	//Check to make sure we got something useable
	if (equali(key,"STEAM_ID_PENDING") || equali(key,"") ) return false

	return true
}
//----------------------------------------------------------------------------------------------
public readINI()
{
	if ( !file_exists(gSHFile) ) createINIFile()

	new readLine = 0
	new data[512], tag[20], lengthRead
	new numLevels[6], loadCount = -1
	new XP[512], XPG[512]
	new LeftXP[32], LeftXPG[32]

	while ((readLine = read_file(gSHFile,readLine,data,511,lengthRead)) != 0) {

		if ( equal(data[0],"##",2) ) continue

		if ( equali( data[0], "NUMLEVELS",9 ) ) {
			parse(data, tag, 19, numLevels, 5)
		}
		else if ( ( equali( data[0],"XPLEVELS",8 ) && !gLongTermXP) || ( equali(data[0], "LTXPLEVELS",10 ) && gLongTermXP ) ) {
			copy(XP,512,data)
		}
		else if ( ( equali( data[0],"XPGIVEN",7 ) && !gLongTermXP ) || ( equali( data[0],"LTXPGIVEN",9 ) && gLongTermXP ) ) {
			copy(XPG,512,data)
		}
	}

	if ( strlen(numLevels) == 0 ) { 
		debugMessage("No NUMLEVELS Data was found, aborting INI Loading")
		return
	}
	else if ( strlen(XP) == 0 ) { 
		debugMessage("No XP LEVELS Data was found, aborting INI Loading")
		return
	}
	else if ( strlen(XPG) == 0 ) { 
		debugMessage("No XP GIVEN Data was found, aborting INI Loading")
		return
	}

	format(debugt,255,"Loading %s XP Levels",gLongTermXP ? "Long Term" : "Short Term")
	debugMessage(debugt)

	gNumLevels = str_to_num(numLevels)

	//This prevents variables from getting overflown
	if (gNumLevels > SH_MAXLEVELS) {
		format(debugt,255,"NUMLEVELS in superhero.ini is defined higher than MAXLEVELS in the include file. Adjusting NUMLEVELS to %d", SH_MAXLEVELS)
		debugMessage(debugt)
		gNumLevels = SH_MAXLEVELS
	}

	//Get the data tag out of the way
	strbrkqt(XP, LeftXP, 31, XP, 511)
	strbrkqt(XPG, LeftXPG, 31, XPG, 511)

	while ( strlen(XP) > 0 && strlen(XPG) > 0 && loadCount < gNumLevels ) {
		loadCount++

		strbrkqt(XP, LeftXP, 31, XP, 511)
		strbrkqt(XPG, LeftXPG, 31, XPG, 511)

		gXPLevel[loadCount] = str_to_num(LeftXP)
		gXPGiven[loadCount] = str_to_num(LeftXPG)

		if (loadCount == 0 && gXPLevel[loadCount] != 0) {
			debugMessage("Level 0 must have an XP setting of 0, adjusting automatically")
			gXPLevel[loadCount] = 0
		}
		if (loadCount > 0 && gXPLevel[loadCount] < gXPLevel[loadCount - 1]) {
			format(debugt,255,"Level %d is less XP than the level before it, adjusting NUMLEVELS to %d", loadCount, loadCount - 1)
			debugMessage(debugt)
			gNumLevels = loadCount - 1
			break
		}
		
		format(debugt,255,"XP Loaded - Level: %d  -  XP Required: %d  -  XP Given for Kills: %d",loadCount,gXPLevel[loadCount],gXPGiven[loadCount])
		debugMessage(debugt,0,3)
	}

	if (loadCount < gNumLevels) {
		format(debugt,255,"Ran out of levels to load, check your superhero.ini for errors. Adjusting NUMLEVELS to %d", loadCount)
		debugMessage(debugt)
		gNumLevels = loadCount
	}

	// Set the CVAR to let heroes know how many levels there are...
	register_cvar("sh_numlevels", numLevels)
	set_cvar_string("sh_numlevels", numLevels)
}
//----------------------------------------------------------------------------------------------
public createINIFile()
{
	if ( file_exists(gSHFile) ) delete_file(gSHFile)

	write_file(gSHFile,"## NUMLEVELS  - The total Number of levels to award players",0)
	write_file(gSHFile,"## XPLEVELS   - How much XP does it take to earn each level (0..NUMLEVELS)",1)
	write_file(gSHFile,"## XPGIVEN    - How much XP is given when a Level(N) player is killed (0..NUMLEVELS)", 2)
	write_file(gSHFile,"## LTXPLEVELS - Same as XPLEVELS but for Long-Term mode (sh_savexp 1)",3)
	write_file(gSHFile,"## LTXPGIVEN  - Same as XPGIVEN but for Long-Term mode (sh_savexp 1)", 4)

	// Straight from WC3 - but feel free to change it in the INI file...
	write_file(gSHFile,"NUMLEVELS 10" , 5)
	write_file(gSHFile,"XPLEVELS   0 100 300 600 1000 1500 2100 2800 3600 4500 5500", 6)
	write_file(gSHFile,"XPGIVEN    60 80 100 120 140 160 180 200 220 240 260", 7)
	write_file(gSHFile,"LTXPLEVELS 0 100 200 400 800 1600 3200 6400 12800 25600 51200", 8)
	write_file(gSHFile,"LTXPGIVEN  6 8 10 12 14 16 20 24 28 32 40", 9)
}
//----------------------------------------------------------------------------------------------

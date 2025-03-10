/*
 * ===========================================================================
 *
 * $Id: plugin_CS.sma,v 1.1.1.1 2004/10/20 11:57:13 David Exp $
 *
 *
 * Copyright (c) 1999-2004 Alfred Reynolds, Florian Zschocke, Magua
 *
 *   This file is part of Admin Mod.
 *
 *   Admin Mod is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   Admin Mod is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Admin Mod; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA
 *
 * ===========================================================================
 *
 * Comments:
 *
 * This script contains commands specific for the Counter-Strike MOD
 *
 * Additions mentioned below are copyrighted by their respective authors.
 *
 * Restart round voting by Nathan O'Sullivan
 *
 * Weapon restriction by GIJoe (CSController@yahoo.com)
 *
 * Weapon restricton reworked for CS 1.6 by
 * Marco Hombach (marco.hombach@gmx.de),
 * Felix Kumm (fkumm@web.de) and
 * "Ravenous Bugblatter Beast" (ravenousbugblatterbeast@blueyonder.co.uk)
 *
 */

/* Includes */
#include <core>
#include <string>
#include <admin>
#include <plugin>
#include <adminlib>

new AM_VERSION_STRING[] = "2.50.14";

/************************
* Accesslevel constants *
************************/
#define ACCESS_VOTE_RESTART 1
#define ACCESS_RESTART 2
#define ACCESS_CHANGE_TEAM 128
#define ACCESS_RESTRICT 32
#define ACCESS_RESTRICT_SAVE 512
#define ACCESS_CVAR 512

/****************************************
* Constants used in code. Don't change! *
****************************************/
#define V15 1

#define MAX_ITEMS 32
#define MAX_MENUS 9
#define MAX_CVARS 23

#define ITEM_ENABLED 0
#define ITEM_RESTRICTED 1

#define MENU_NONE       0
#define MENU_PISTOLS    1
#define MENU_SHOTGUNS   2
#define MENU_SMGS       3
#define MENU_RIFLES     4
#define MENU_MG         5
#define MENU_SECAMMO    6
#define MENU_PRIMAMMO   7
#define MENU_EQUIPMENT  8
#define MENU_INVALID    9
#define MENU_CANCEL     10
#define MENU_MAIN       11
#define MENU_RESTRICT   12

#define FOUND_ERROR -1
#define FOUND_NONE   0
#define FOUND_LOOSE  1
#define FOUND_STRICT 2

/******************************************
* Global variables for weaponrestricitons *
******************************************/

/*
 For backward-compatibility, the CS-version currently
 running is stored. Version is determined by GetVersion().
*/
new g_CS_Version;

/*
 The names of the menues. Used for displaying, and matched
 against the data of admin_(un)restrict.
*/
new g_MenuNames[MAX_MENUS][] = {
    "",
    "pistols",
    "shotguns",
    "smg",
    "rifles",
    "machine guns",
    "",
    "",
    "equipment"
};

/*
 Full names of all items (from titles.txt). Used for
 displaying/reports and for the restrictmenu. Also
 are matched against the data of admin_(un)restrict
*/
new g_ItemName[MAX_ITEMS][]= {
    "9x19mm Sidearm",
    "K&M .45 Tactical",
    "228 Compact",
    "Night Hawk .50C",
    ".40 Dual Elites",
    "ES Five-Seven",
    "Leone 12 Gauge Super",
    "Leone YG1265 Auto Shotgun",
    "Ingram MAC-10",
    "K&M Sub-Machine Gun",
    "K&M UMP45",
    "ES C90",
    "Schmidt Machine Pistol",
    "IDF Defender",
    "CV-47",
    "Schmidt Scout",
    "Krieg 552 Commando",
    "Magnum Sniper Rifle",
    "D3/AU-1 Semi-Auto Sniper Rifle",
    "Clarion 5.56",
    "Bullpup",
    "Maverick M4A1 Carabine",
    "Krieg 550 Commando",
    "ES M249 Para",
    "Kevlar Vest",
    "Kevlar Vest & Helmet",
    "Flashbang",
    "HE Grenade",
    "Smoke Grenade",
    "Defuse Kit",
    "NightVision Goggles",
    "Tactical Shield"
};

/*
 Commands to directly buy weapons in CS 1.6 and later (old names).
 These also get matched against the data of admin_(un)restrict
*/
new g_ClientCommands1[MAX_ITEMS][]= {
    "glock",
    "usp",
    "p228",
    "deagle",
    "elites",
    "fn57",
    "m3",
    "xm1014",
    "mac10",
    "mp5",
    "ump45",
    "p90",
    "tmp",
    "galil",
    "ak47",
    "scout",
    "sg552",
    "awp",
    "g3sg1",
    "famas",
    "aug",
    "m4a1",
    "sg550",
    "m249",
    "vest",
    "vesthelm",
    "flash",
    "hegren",
    "sgren",
    "defuser",
    "nvgs",
    "shield"
};

/*
 Same as above, but new names. Both work as client commands.
 Empty items are the same as in g_ClientCommands1
*/
new g_ClientCommands2[MAX_ITEMS][]= {
    "9x19mm",
    "km45",
    "229compact",
    "nighthawk",
    "",
    "fiveseven",
    "12gauge",
    "autoshotgun",
    "",
    "smg",
    "",
    "c90",
    "mp",
    "defender",
    "cv47",
    "",
    "krieg552",
    "magnum",
    "d3au1",
    "clarion",
    "bullup",
    "",
    "krieg550",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    ""
};

/*
 Most important: This array stores the information about
 each item being restricted or not. Size is MAX_ITEMS + 1,
 so we have one fake item that is never restricted. Items
 that do not exist will point to it, see below for details.
 The 2nd dimension allows us to store both the actual
 restricitons, and the restrictions being saved either
 for this map or default.
*/
new g_ItemRestricted[2][MAX_ITEMS + 1] = {{ITEM_ENABLED},{ITEM_ENABLED}};

/*
 The start of items belonging to a specific menu is stored
 here. Useful for restricting whole menues and the like.
 E.g. the shotguns (menu 2) are all items with indices beween
 g_ItemIndexBegin[1] and g_ItemIndexBegin[2] - 1.
*/
new g_ItemIndexBegin[9] = {0,6,8,13,23,24,24,24,32};

/*
 Keep track of the menu the users are in by user index.
 Note: When a user is viewing a submenu of the restictmenu,
 this is the negative index of the menu, e.g. when he
 wants to restrict pistols, he'd be in menu -PISTOLS.
*/
new g_UserMenuSelected[MAX_PLAYERS] = MENU_NONE;

/*
 For resolving keys: Assigns the item index of a weapon
 by the menu/slot and the team. Size is not 8*8 (maximum
 of 8 items in 8 menues, because this leads to many items
 that do not exist, especially for primary/secondary ammo
 and machine gun. Items that do not exist point to our
 fake item (MAX_ITEMS).
*/
new g_ItemIndexByKeys[2][29] = {
    {0,1,2,3,4,6,7,8,9,10,11,13,14,15,16,17,18,23,24,25,26,27,28,30,MAX_ITEMS,MAX_ITEMS,MAX_ITEMS,MAX_ITEMS,MAX_ITEMS},
    {0,1,2,3,5,6,7,12,9,10,11,19,15,21,20,22,17,23,24,25,26,27,28,29,30,31,MAX_ITEMS,MAX_ITEMS,MAX_ITEMS}
};

/*
 To shorten above array, this array holds the index of
 the first item of any menu in above array, just like
 g_ItemIndexBegin for the items.
*/
new g_MenuEntriesIndexBegin[9] = {0,5,7,11,17,18,18,18,26};

/*
 For optimization: Checks are only enabled when at least
 one item is restricted, tracked with this variable.
*/
new g_RestrictedItemsNum = 0;

/*
 Titles for the restrictionmenu-submenus (from titles.txt)
*/
new g_SubMenuTitles[8][] = {
    "Handgun^n(Secondary weapon)",
    "Shotgun^n(Primary weapon)",
    "Sub-Machine Gun^n(Primary weapon)",
    "Rifle^n(Primary weapon)",
    "Machine Gun^n(Primary weapon)",
    "",
    "",
    "Equipment"
};

/*
 Only required in CS 1.6 or later: Stores whether to display
 restrictionmenu in T or CT layout for every user by userindex,
 because T and CT have their weapons at different numbers.
*/
new g_UserMenuOrder[MAX_PLAYERS];

/*************************************
* Global variables for cvar commands *
*************************************/

new g_sCvar[MAX_CVARS][] = {
     "autokick",
     "autoteambalance",
     "buytime",
     "c4timer",
     "chattime",
     "consistency",
     "fadetoblack",
     "flashlight",
     "footsteps",
     "forcecamera",
     "forcechasecam",
     "freezetime",
     "ghostfrequency",
     "hostagepenalty",
     "limitteams",
     "kickpercent",
     "maxrounds",
     "mapvoteratio",
     "playerid",
     "roundtime",
     "startmoney",
     "tkpunish",
     "winlimit"
};

new g_sDescription[MAX_CVARS][] = {
     "admin_autokick <1 or 0>: mp_autokick on or off",
     "admin_autoteambalance <#>: setting for mp_autoteambalance",
     "admin_buytime <#>: setting for mp_buytime",
     "admin_c4timer <#>: setting for mp_c4timer",
     "admin_chattime <#>: setting for mp_chattime",
     "admin_consistency <#>: setting for mp_consistency",
     "admin_fadetoblack <1 or 0>: mp_fadetoblack on or off",
     "admin_flashlight <1 or 0>: mp_flashlight on or off",
     "admin_footsteps <1 or 0>: mp_footsteps on or off",
     "admin_forcecamera <#>: setting for mp_forcecamera",
     "admin_forcechasecam <#>: setting for mp_forcechasecam",
     "admin_freezetime <#>: setting for mp_freezetime",
     "admin_ghostfrequency <#>: setting for mp_ghostfrequency",
     "admin_hpenalty <#>: setting for mp_hostagepenalty",
     "admin_limitteams <1 or 0>: mp_limitteams on or off",
     "admin_kickpercent <#>: setting for mp_kickpercent",
     "admin_maxrounds <#>: setting for mp_maxrounds",
     "admin_mapvoteratio <#>: setting for mp_mapvoteratio",
     "admin_playerid <#>: setting for mp_playerid",
     "admin_roundtime <#>: setting for mp_roundtime",
     "admin_startmoney <800/16000>: setting for mp_startmoney",
     "admin_tkpunish <1 or 0>: mp_tkpunish on or off",
     "admin_winlimit <#>: setting for mp_winlimit"
};

/***********************
* End global variables *
***********************/

public plugin_init(){
    new i;
    plugin_registerinfo("Counter-Strike Plugin","Team change / Restart Round / Weapons Restrictions",AM_VERSION_STRING);
    plugin_registercmd("admin_ct","admin_changeteam",ACCESS_CHANGE_TEAM,"admin_ct <target>: Changes target to the counter-terrorist team.");
    plugin_registercmd("admin_t","admin_changeteam",ACCESS_CHANGE_TEAM,"admin_t <target>: Changes target to the terrorist team.");
    plugin_registercmd("admin_vote_restart","admin_vote_restart",ACCESS_VOTE_RESTART,"admin_vote_restart: Starts a vote to restart the round.");
    plugin_registercmd("admin_restartround","admin_restartround",ACCESS_RESTART,"admin_restartround <seconds>: Restarts the round.");
    plugin_registercmd("admin_restart","admin_restartround",ACCESS_RESTART,"admin_restart <seconds>: Restarts the round.");
    /*
     Register commands for changing cvars.
    */
    new sCommand[MAX_TEXT_LENGTH];
    for(i=0;i<MAX_CVARS;i++){
        snprintf(sCommand,MAX_TEXT_LENGTH,"admin_%s",g_sCvar[i]);
        plugin_registercmd(sCommand,"set_cvar",ACCESS_ALL,g_sDescription[i]);
    }
    /*
     Stuff for weaponrestricitons from here on.
    */
    plugin_registercmd("admin_restrict","SetRestrictions",ACCESS_ALL,"admin_restrict: Control restrictions - admin_restrict help for details.");
    plugin_registercmd("admin_unrestrict","SetRestrictions",ACCESS_RESTRICT,"admin_unrestrict: Control restrictions - admin_unrestrict help for details.");
    plugin_registercmd("admin_restrictmenu","RestrictMenu",ACCESS_RESTRICT,"admin_restrictmenu: Displays menu for changing weaponrestrictions.");
    plugin_registercmd("buy","buy",ACCESS_ALL);
    plugin_registercmd("buyequip","buyequip",ACCESS_ALL);
    plugin_registercmd("menuselect","menuselect",ACCESS_ALL);
    plugin_registercmd("radio1","ClearMenu",ACCESS_ALL);
    plugin_registercmd("radio2","ClearMenu",ACCESS_ALL);
    plugin_registercmd("radio3","ClearMenu",ACCESS_ALL);
    plugin_registercmd("chooseteam","ClearMenu",ACCESS_ALL);
    /*
     Distiguish between 1.5 and newer:
     In 1.6 we need to hook all the clientcommands from g_ClientCommands1 & 2.
     In 1.5 we need to delete weapons that came with 1.6 and remap the
     g_ItemIndexByKeys-array.
    */
    g_CS_Version = GetVersion();
    if(g_CS_Version != V15) {
        new Function[MAX_COMMAND_LENGTH];
        for(i=0;i<MAX_ITEMS;i++) {
            strcpy(Function,"buy_",MAX_COMMAND_LENGTH);
            strcat(Function,g_ClientCommands1[i],MAX_COMMAND_LENGTH);
            plugin_registercmd(g_ClientCommands1[i],Function,ACCESS_ALL);
            if(g_ClientCommands2[i][0]) {
                plugin_registercmd(g_ClientCommands2[i],Function,ACCESS_ALL);
            }
        }
    } else {
        /* Delete new Items */
        strinit(g_ItemName[13]);
        strinit(g_ItemName[19]);
        strinit(g_ItemName[31]);
        strinit(g_ClientCommands1[13]);
        strinit(g_ClientCommands1[19]);
        strinit(g_ClientCommands1[31]);
        strinit(g_ClientCommands2[13]);
        strinit(g_ClientCommands2[19]);
        strinit(g_ClientCommands2[31]);
        /* 1.5 Keys */
        g_MenuEntriesIndexBegin = {0,6,8,13,21,22,22,22,29};
        new ItemIndexByKeys15[2][29] = {
            {1,0,3,2,4,MAX_ITEMS,6,7,9,MAX_ITEMS,11,8,10,14,16,MAX_ITEMS,MAX_ITEMS,15,17,18,MAX_ITEMS,23,24,25,26,27,28,MAX_ITEMS,30},
            {1,0,3,2,MAX_ITEMS,5,6,7,9,12,11,MAX_ITEMS,10,MAX_ITEMS,MAX_ITEMS,21,20,15,17,MAX_ITEMS,22,23,24,25,26,27,28,29,30}
        };
        /* Copy them */
        for(i=0;i<29;i++) {
            g_ItemIndexByKeys[0][i] = ItemIndexByKeys15[0][i];
            g_ItemIndexByKeys[1][i] = ItemIndexByKeys15[1][i];
        }
    }
    /*
     Read saved restrictions. get_vaultdata() returns false when
     no data for the key exists. First check for map-specific
     retrictions, then for defaults. Log what we found.
    */
    new strKey[MAX_ITEMS+1]; /* One char for every item plus terminating 0 */
    new strMap[100]; /* currentmap() buffer is BUF_SIZE == 100 */
    new strName[100];
    currentmap(strMap,100);
    strcpy(strName,"WeaponRestrictions_",100);
    strcat(strName,strMap,100);
    if(get_vaultdata(strName,strKey,MAX_ITEMS+1)) {
        plugin_message("Map-specific saved weapon restrictions found.");
    } else if(get_vaultdata("WeaponRestrictions",strKey,MAX_ITEMS+1)) {
        plugin_message("Default saved weapon restrictions found.");
    } else {
        plugin_message("No saved weapon restrictions found.");
    }
    /*
     Apply any restrictions found, and save them in g_ItemRestricted[1]
     for restoring them.
    */
    if(strKey[0] != 0) {
        for(i=0;i<MAX_ITEMS;i++) {
            if(strKey[i] == '1') {
                ChangeStatusItem(i,ITEM_RESTRICTED,1);
                g_ItemRestricted[1][i] = ITEM_RESTRICTED;
            }
        }
    }
    if(g_RestrictedItemsNum && getvar("admin_cs_restrict") == 0) {
        plugin_message("Saved restrictions will not take effect while admin_cs_restrict is 0.");
    }
    return PLUGIN_CONTINUE;
}

/****************************************************
* Command handlers for changeteam and restart(vote) *
****************************************************/

public admin_changeteam(HLCommand,HLData,HLUserName,UserIndex) {
    new Command[MAX_COMMAND_LENGTH];
    new Data[MAX_DATA_LENGTH];
    new TargetName[MAX_NAME_LENGTH];
    new Text[MAX_TEXT_LENGTH];
    new User[MAX_NAME_LENGTH];
    convert_string(HLCommand,Command,MAX_NAME_LENGTH);
    convert_string(HLData,Data,MAX_NAME_LENGTH);
    convert_string(HLUserName,User,MAX_NAME_LENGTH);
    if(!getvar("allow_client_exec")) {
        selfmessage("You cannot use this command because allow_client_exec is 0.");
    } else if(!check_user(Data)) {
        selfmessage("Unrecognized player: ");
        selfmessage(Data);
    } else {
        get_username(Data,TargetName,MAX_NAME_LENGTH);
        if(check_immunity(TargetName) != 0) {
            snprintf(Text, MAX_TEXT_LENGTH, "Laf. You can't move %s onto another team, you silly bear.", TargetName);
            messageex(User,Text,print_chat);
        } else {
            say_command(User,Command,TargetName);
            if(!strcmp(Command,"admin_ct")) {
                execclient(TargetName, "chooseteam;menuselect 2");
            } else {
                execclient(TargetName, "chooseteam;menuselect 1");
            }
        }
    }
    return PLUGIN_HANDLED;
}

public admin_restartround(HLCommand,HLData,HLUserName,UserIndex) {
    new Command[MAX_COMMAND_LENGTH];
    new Data[MAX_DATA_LENGTH];
    new User[MAX_NAME_LENGTH];
    convert_string(HLCommand,Command,MAX_COMMAND_LENGTH);
    convert_string(HLData,Data,MAX_DATA_LENGTH);
    convert_string(HLUserName,User,MAX_NAME_LENGTH);
    execute_command(User,Command,"sv_restartround",Data);
    return PLUGIN_HANDLED;
}

public admin_vote_restart(HLCommand,HLData,HLUserName,UserIndex) {
    if(getvar("map_ratio") == 0) {
        say("Restart vote is not enabled");
    } else if(vote_allowed() == 0) {
        selfmessage( "Vote not allowed at this time.");
    } else {
        vote("Restart map & begin play?","Yes","No","HandleRestartVote","");
    }
    return PLUGIN_HANDLED;
}

public HandleRestartVote(WinningOption,HLUser,VoteCount,UserCount) {
    if(WinningOption == 1 ) {
        new ratio = getvar("map_ratio");
        if(VoteCount < ((ratio / 100)*UserCount) ) {
            say("Not enough votes for map restart");
        } else {
            new Timelimit[MAX_NUMBER_LENGTH];
            numtostr((getvar("mp_timelimit") * 60 - timeleft() + 10) / 60,Timelimit);
            setstrvar("mp_timelimit",Timelimit);
            setstrvar("sv_restartround","10");
            say("Map restart vote succeeded.");
        }
    } else {
        say("Map restart vote failed.");
    }
}

public set_cvar(HLCommand,HLData,HLUserName,UserIndex) {
    new Text[MAX_TEXT_LENGTH];
    new Command[MAX_COMMAND_LENGTH];
    new Data[MAX_DATA_LENGTH];
    new User[MAX_NAME_LENGTH];
    new sCvar[MAX_COMMAND_LENGTH];
    convert_string(HLCommand,Command,MAX_COMMAND_LENGTH);
    convert_string(HLData,Data,MAX_DATA_LENGTH);
    convert_string(HLUserName,User,MAX_NAME_LENGTH);
    snprintf(sCvar,MAX_COMMAND_LENGTH,"mp_%s",Command[6]);
    if(Data[0] != 0 && access(ACCESS_CVAR)){
        execute_command(User,Command,sCvar,Data);
    } else if(Data[0] != 0) {
        snprintf(Data,100,"You cannot change the value of %s.^nType %s to view current setting.",sCvar,Command);
        selfmessage(Data);
    } else {
        getstrvar(sCvar,Data,MAX_DATA_LENGTH);
        snprintf(Text,MAX_TEXT_LENGTH,"%s is currently set to %s",sCvar,Data);
        selfmessage(Text);
    }
    return PLUGIN_HANDLED;
}

/**************************************************
* Handler for admin_restrict and helper functions *
**************************************************/

public SetRestrictions(HLCommand,HLData,HLUserName,UserIndex) {
    new Command[MAX_COMMAND_LENGTH];
    new UserName[MAX_NAME_LENGTH];
    new Data[MAX_DATA_LENGTH];
    new Status;

    convert_string(HLCommand,Command,MAX_COMMAND_LENGTH);
    convert_string(HLData,Data,MAX_DATA_LENGTH);
    convert_string(HLUserName,UserName,MAX_NAME_LENGTH);
    strstripquotes(Data);
    strtolower(Data);
    /* Look at the command name to see if we should lock or unlock */
    if(tolower(Command[6]) == 'r') {
        Status = ITEM_RESTRICTED;
    } else {
        Status = ITEM_ENABLED;
    }
    /* Handle the easy cases */
    if(Data[0] == '^0') {
        if(Status == ITEM_RESTRICTED) {
            ShowRestrictions();
        } else {
            Report(Status,0);
        }
        return PLUGIN_HANDLED;
    } else if(access(ACCESS_RESTRICT) == 0) {
        selfmessage("You do not have access to modify weapon restrictions.");
        selfmessage("Type admin_restrict to see current restrictions.");
        return PLUGIN_HANDLED;
    } else if(strcmp(Data,"help") == 0) {
        ShowHelp(Status);
    } else if(Status == ITEM_RESTRICTED) {
        if(strcmp(Data,"on") == 0) {
            if(getvar("admin_cs_restrict") == 0) {
                setstrvar("admin_cs_restrict","1");
                say_command(UserName,Command,Data);
                if(g_RestrictedItemsNum > 0) {
                    selfmessage("Weapon restrictions have been enabled.");
                } else {
                    selfmessage("Weapon restriction functions are now enabled, but no weapons are");
                    selfmessage("currenty marked as restricted. Use the admin_restrict command to");
                    selfmessage("select which weapons to restrict.");
                }
            } else {
                selfmessage("Weapon restrictions already are enabled.");
            }
            return PLUGIN_HANDLED;
        } else if(strcmp(Data,"off") == 0) {
            if(getvar("admin_cs_restrict") == 1) {
                setstrvar("admin_cs_restrict","0");
                say_command(UserName,Command,Data);
                selfmessage("Weapon restrictions have been disabled.");
            } else {
                selfmessage("Weapon restrictions already are disabled.");
            }
            return PLUGIN_HANDLED;
        } else if(strcmp(Data,"restore") == 0) {
            new i;
            for(i=0;i<MAX_ITEMS;i++) {
                ChangeStatusItem(i,g_ItemRestricted[1][i],0);
            }
            say_command(UserName,Command,Data);
            selfmessage("Weapon restrictions have been reset to default.");
            Report(Status,FOUND_STRICT);
            return PLUGIN_HANDLED;
        } else if(strncmp(Data,"save ",5) == 0) {
            if(access(ACCESS_RESTRICT_SAVE) == 0) {
                reject_message();
            } else if(strcmp(Data[5],"map") == 0) {
                log_command(UserName,Command,Data);
                SaveRestrictionsToVault(1);
            } else if(strcmp(Data[5],"default") == 0) {
                log_command(UserName,Command,Data);
                SaveRestrictionsToVault(0);
            } else {
                Report(Status,FOUND_NONE);
            }
            return PLUGIN_HANDLED;
        }
    }
    if(strcmp(Data,"all") == 0) {
        ChangeStatusAll(Status,1);
        say_command(UserName,Command,Data);
        Report(Status,FOUND_STRICT);
        return PLUGIN_HANDLED;
    } else if(strcmp(Data,"weapons") == 0) {
        ChangeStatusWeapons(Status,1);
        say_command(UserName,Command,Data);
        Report(Status,FOUND_STRICT);
        return PLUGIN_HANDLED;
    }

    new Index, retval = FOUND_NONE;
    if(strncmp(Data,"menu ",5) == 0) {
        if(IsNumeric(Data[5],Index) == 1) {
            if(Index < MAX_MENUS && g_MenuNames[Index][0] != '^0') {
                retval = FOUND_STRICT;
            } else {
                selfmessage("There is no menu with this number.");
                retval = FOUND_ERROR;
            }
        } else {
            retval = IsMenuString(Data[5],Index);
        }
        if(retval == FOUND_STRICT || retval == FOUND_LOOSE) {
            ChangeStatusMenu(Index,Status,1);
            say_command(UserName,Command,g_MenuNames[Index]);
        }
        Report(Status,retval);
        return PLUGIN_HANDLED;
    }
    retval = IsWeaponString(Data,Index);
    if(retval == FOUND_STRICT || retval == FOUND_LOOSE) {
        ChangeStatusItem(Index,Status,1);
        say_command(UserName,Command,g_ItemName[Index]);
    }
    Report(Status,retval);
    return PLUGIN_HANDLED;
}

Report(Status,retval) {
    if(retval == FOUND_NONE || retval == FOUND_ERROR) {
        if(Status == ITEM_RESTRICTED) {
            selfmessage("The data you supplied was invalid. Type ^"admin_restrict help^" to view a help-text.");
        } else {
            selfmessage("The data you supplied was invalid. Type ^"admin_unrestrict help^" to view a help-text.");
        }
    } else {
        if(Status && !getvar("admin_cs_restrict")) {
            selfmessage("Restriction configured. This will take effect when you use admin_restrict on");
        }
    }
}

ShowHelp(Status) {
    if(Status == ITEM_RESTRICTED) {
        selfmessage("admin_restrict usage:");
        selfmessage("admin_restrict: Show current restrictions");
        if(access(ACCESS_RESTRICT)) {
            selfmessage("admin_restrict on: Enable restrictions");
            selfmessage("admin_restrict off: Disable restrictions");
            if(access(ACCESS_RESTRICT_SAVE)) {
                selfmessage("admin_restrict save default: Save current restrictions as server default");
                selfmessage("admin_restrict save map: Save current restrictions for this map");
            }
            selfmessage("admin_restrict restore: Restore saved (map-)defaults");
            selfmessage("");
            selfmessage("admin_restrict all: Restrict all weapons and equipment.");
            selfmessage("admin_restrict weapons: Restrict all weapons.");
            selfmessage("admin_restrict menu <menu name or number>: Restrict menu.");
            selfmessage("admin_restrict <item name>: Restrict item.");
            selfmessage("admin_restrict <menu number> <item number>: Restrict item.");
        }
    } else {
        selfmessage("admin_unrestrict usage:");
        selfmessage("admin_unrestrict all: Allow all weapons and equipment.");
        selfmessage("admin_unrestrict weapons: Allow all weapons.");
        selfmessage("admin_unrestrict menu <menu name or number>: Allow menu.");
        selfmessage("admin_unrestrict <item name>: Allow item.");
        selfmessage("admin_unrestrict <menu number> <item number>: Allow item.");
    }
    if(access(ACCESS_RESTRICT)) {
        selfmessage("");
        selfmessage("All weapon / menu names can be entered as unique substring. Valid are all");
        selfmessage("names that are used in buy menu or console. You cannot restrict ammunition.");
        if(g_CS_Version != V15) {
            selfmessage("Note that restrictions by numbers only are accepted if the numbers");
            selfmessage("are the same for T and CT.");
        }
    }
}

SaveRestrictionsToVault(Mapspecific = 0) {
    new strName[100] = "WeaponRestrictions";
    new strKey[MAX_ITEMS+1]; /* +1 due to terminating 0 */
    new i;
    if(Mapspecific) {
        new strMap[100];
        currentmap(strMap,100);
        strcat(strName,"_",100);
        strcat(strName,strMap,100);
    }
    for(i=0;i<MAX_ITEMS;i++) {
        g_ItemRestricted[1][i] = g_ItemRestricted[0][i]; /* Update saved restriction array */
        if(g_ItemRestricted[0][i] == ITEM_RESTRICTED) {
            strKey[i] = '1';
        }
        else {
            strKey[i] = '0';
        }
    }
    strKey[MAX_ITEMS] = 0; /* Terminating 0 */
    set_vaultdata(strName,strKey);
}

/*
 Does first a string and then a substing match of string with
 the menunames (from g_MenuNames). Returns -1 on error (data
 matches more than one menu), 0 when it matches none, 1 when
 it matches exactly one as substing and 2 if it fully matches a
 menu. When returning 1 or 2, the index is put in parameter num.
*/
IsMenuString(string[],&num) {
    new i;
    new match = -1;
    for(i=0;i<MAX_MENUS;i++) {
        if(g_MenuNames[i][0]) {
            if(strcmp(g_MenuNames[i],string) == 0) {
                num = i;
                return FOUND_STRICT;
            }
        }
    }
    for(i=0;i<MAX_MENUS;i++) {
        if(g_MenuNames[i][0] && strstr(g_MenuNames[i],string) != -1) {
            if(match != -1) {
                DuplicateError(match,i,1);
                return FOUND_ERROR;
            }
            match = i;
        }
    }
    if(match != -1) {
        num = match;
        return FOUND_LOOSE;
    }
    return FOUND_NONE;
}

/*
 Returns 1 or 2 if the giveb string can be resolved into one item. If
 more items match the data, -1 is returned, if none matchen, 0.
 The index of the item is put in num if one was found.
 This function calls FindWeaponIndexShort, FindWeaponIndexLong and
 FindWeaponIndexNumber.
 */
IsWeaponString(string[],&num) {
    new Param1[MAX_DATA_LENGTH];
    new Param2[MAX_DATA_LENGTH];
    new num1,num2;
    strsep(string," ",Param1,MAX_DATA_LENGTH,Param2,MAX_DATA_LENGTH);
    if(IsNumeric(Param1,num1) && IsNumeric(Param2,num2)) {
        return FindWeaponIndexNumber(num1,num2,num);
    } else {
        new retval1, tmpnum1;
        if(Param2[0] == '^0') {
            retval1 = FindWeaponIndexShort(Param1,tmpnum1);
            if(retval1 == FOUND_STRICT) {
                num = tmpnum1;
                return FOUND_STRICT;
            } else if(retval1 == FOUND_ERROR) {
                return FOUND_ERROR;
            }
        }
        new retval2, tmpnum2;
        retval2 = FindWeaponIndexLong(string,tmpnum2);
        if(retval2 == FOUND_STRICT) {
            num = tmpnum2;
            return FOUND_STRICT;
        } else if(retval2 == FOUND_ERROR) {
            return FOUND_ERROR;
        } else if(retval1 == FOUND_LOOSE && retval2 == FOUND_LOOSE && tmpnum1 != tmpnum2) {
            DuplicateError(tmpnum1,tmpnum2);
            return FOUND_ERROR;
        } else if(retval1 == FOUND_LOOSE) {
            num = tmpnum1;
            return FOUND_LOOSE;
        } else if(retval2 == FOUND_LOOSE) {
            num = tmpnum2;
            return FOUND_LOOSE;
        }
    }
    return FOUND_NONE;
}

/*
 Does first a string and then a substing match of string with
 the short itemnames (from g_ClientCommands1 & 2). Returns -1
 on error (data matches more than one item), 0 when it matches
 none, 1 when it matches exactly one as substing and 2 if it
 fully matches an item. When returning 1 or 2, the index is
 put in parameter num.
*/
FindWeaponIndexShort(string[],&num) {
    new i;
    new match = -1;
    for(i=0;i<MAX_ITEMS;i++) {
            if( (g_ClientCommands1[i][0] && strcmp(g_ClientCommands1[i],string) == 0)
             || (g_ClientCommands2[i][0] && strcmp(g_ClientCommands2[i],string) == 0) ) {
            num = i;
            return FOUND_STRICT;
        }
    }
    for(i=0;i<MAX_ITEMS;i++) {
        if( (g_ClientCommands1[i][0] && strstr(g_ClientCommands1[i],string) != -1)
         || (g_ClientCommands2[i][0] && strstr(g_ClientCommands2[i],string) != -1) ) {
            if(match != -1) {
                DuplicateError(match,i);
                return FOUND_ERROR;
            }
            match = i;
        }
    }
    if(match != -1) {
        num = match;
        return FOUND_LOOSE;
    }
    return FOUND_NONE;
}

/*
 Does a substing match of string with the long itemnames (from
 g_ItemName). Returns -1 on error (data matches more than one
 item), 0 when it matches none, 1 when it matches exactly one.
 When returning 1, the index is put in parameter num.
*/
FindWeaponIndexLong(string[],&num) {
    new i;
    new match = -1;
    for(i=0;i<MAX_ITEMS;i++) {
        if(g_ItemName[i][0] && strcasestr(g_ItemName[i],string) != -1) {
            if(match != -1) {
                DuplicateError(match,i);
                return FOUND_ERROR;
            }
            match = i;
        }
    }
    if(match != -1) {
        num = match;
        return FOUND_LOOSE;
    }
    return FOUND_NONE;
}

/*
 Returns -1 if the 2 numbers cannot be resolved to exactly one
 item, 2 otherwise.
*/
FindWeaponIndexNumber(num1,num2,&num) {
    /* First check if the numbers are valid menues/weapons */
    if( (0 < num1 < MENU_PRIMAMMO || num1 == MENU_EQUIPMENT)
     && (0 < num2 <= g_MenuEntriesIndexBegin[num1] - g_MenuEntriesIndexBegin[num1 - 1]) ) {
        new ItemIndex = g_MenuEntriesIndexBegin[num1 - 1] + num2 - 1; /* get itemindex */
        new ItemT = g_ItemIndexByKeys[0][ItemIndex];
        new ItemCT = g_ItemIndexByKeys[1][ItemIndex];
        if(g_CS_Version == V15) {
            if(ItemT != MAX_ITEMS) {
                num = ItemT;
                return FOUND_STRICT;
            } else if(ItemCT != MAX_ITEMS) {
                num = ItemCT;
                return FOUND_STRICT;
            }
        } else {
            if(ItemT != ItemCT && ItemT != MAX_ITEMS) { /* if this combo has two items, don't restrict, but print an error */
                DuplicateError(ItemT,ItemCT);
                return FOUND_ERROR;
            } else {
                num = ItemT;
                return FOUND_STRICT;
            }
        }
    }
    return FOUND_NONE;
}

DuplicateError(Item1,Item2,bMenu = 0) {
    new Data[100];
    if(bMenu != 0) {
        snprintf(Data,100,"The data supplied matches both '%s' and '%s'",g_MenuNames[Item1],g_MenuNames[Item2]);
    } else {
        snprintf(Data,100,"The data supplied matches both '%s' (%s) and '%s' (%s)",g_ItemName[Item1],g_ClientCommands1[Item1],g_ItemName[Item2],g_ClientCommands1[Item2]);
    }
    selfmessage(Data);
}

/*
 These functions change the restriction status of
 one or several items.This inkludes reporting and
 incrementing/decrementing g_RestrictedItemsNum.
*/
ChangeStatusAll(Status,Verbose = 0) {
    new i;
    if(Verbose) {
        if(Status == ITEM_RESTRICTED) {
            selfmessage("All items restricted");
        } else {
            selfmessage("All items enabled");
        }
    }
    for(i=0;i<MAX_ITEMS;i++) {
        ChangeStatusItem(i,Status,0);
    }
}

ChangeStatusWeapons(Status,Verbose = 0) {
    new i;
    if(Verbose) {
        if(Status == ITEM_RESTRICTED) {
            selfmessage("All weapons restricted");
        } else {
            selfmessage("All weapons enabled");
        }
    }
    for(i=0;i<g_ItemIndexBegin[MENU_EQUIPMENT-1];i++) {
        ChangeStatusItem(i,Status,0);
    }
}

ChangeStatusMenu(Menu,Status,Verbose = 0) {
    new i;
    if(Verbose) {
        new Text[100];
        if(Status == ITEM_RESTRICTED) {
            snprintf(Text,100,"All items from menu %s restricted",g_MenuNames[Menu]);
        } else {
            snprintf(Text,100,"All items from menu %s enabled",g_MenuNames[Menu]);
        }
        selfmessage(Text);
    }
    for(i=g_ItemIndexBegin[Menu - 1];i<g_ItemIndexBegin[Menu];i++) {
        ChangeStatusItem(i,Status,0);
    }
}

ChangeStatusItem(Item,Status,Verbose = 0) {
    /* Check if item exists (1.6 has new items) */
    if(g_ClientCommands1[Item][0] == 0) {
        return; /* Exit function */
    }
    if(Verbose) {
        new Text[100];
        if(Status != g_ItemRestricted[0][Item]) {
            if(Status == ITEM_RESTRICTED) {
                snprintf(Text,100,"Item %s restricted",g_ItemName[Item]);
            } else {
                snprintf(Text,100,"Item %s enabled",g_ItemName[Item]);
            }
        } else {
            if(Status == ITEM_RESTRICTED) {
                snprintf(Text,100,"Item %s already is restricted",g_ItemName[Item]);
            } else {
                snprintf(Text,100,"Item %s already is enabled",g_ItemName[Item]);
            }
        }
        selfmessage(Text);
    }
    if(Status != g_ItemRestricted[0][Item]) {
        g_ItemRestricted[0][Item] = Status;
        if(Status == ITEM_RESTRICTED) {
            g_RestrictedItemsNum++;
        } else {
            g_RestrictedItemsNum--;
        }
    }
}

ShowRestrictions() {
    new enforced = getvar("admin_cs_restrict");
    new admin = access(ACCESS_RESTRICT);

    if(enforced || admin) {
        selfmessage("^nCurrent weapon restrictions:^n");
        ShowClass(MENU_PISTOLS);
        ShowClass(MENU_SHOTGUNS);
        ShowClass(MENU_SMGS);
        ShowClass(MENU_RIFLES);
        ShowClass(MENU_MG);
        ShowClass(MENU_EQUIPMENT);
    }  else {
        selfmessage("^nNo weapon restrictions are currently in force.");
    }
    if (!enforced && admin) {
        selfmessage("^nNOTE: Weapon restrictions are not currently enforced.");
        selfmessage("To enforce them use the command: admin_restict on");
    }
    if(enforced) {
        selfmessage("^nNOTE: Further weapon restrictions may be hard coded into this map.");
    } else {
        selfmessage("^nNOTE: Some weapon restrictions may be hard coded into this map.");
    }

}

ShowClass(class) {
    new Message[MAX_DATA_LENGTH];
    new TextRestricted[MAX_DATA_LENGTH];
    new TextEnabled[MAX_DATA_LENGTH];
    new First = g_ItemIndexBegin[class - 1];
    new Last = g_ItemIndexBegin[class] - 1;
    new i;

    new RestrictedNum = 0;
    new EnabledNum = 0;

    for(i=First;i<=Last;i++) {
        if(g_ClientCommands1[i][0]) {
            if(g_ItemRestricted[0][i] == ITEM_RESTRICTED) {
                if(RestrictedNum > 0) {
                    strcat(TextRestricted,", ",MAX_DATA_LENGTH);
                }
                RestrictedNum++;
                strcat(TextRestricted,g_ItemName[i],MAX_DATA_LENGTH);
            } else {
                if(EnabledNum > 0) {
                    strcat(TextEnabled,", ",MAX_DATA_LENGTH);
                }
                strcat(TextEnabled,g_ItemName[i],MAX_DATA_LENGTH);
                EnabledNum++;
            }
        }
    }
    if(EnabledNum == 0) {
        snprintf(Message,MAX_DATA_LENGTH,"%s: All restricted",g_MenuNames[class]);
    } else if(RestrictedNum == 0) {
        snprintf(Message,MAX_DATA_LENGTH,"%s: All available",g_MenuNames[class]);
    } else if(EnabledNum < RestrictedNum) {
        snprintf(Message,MAX_DATA_LENGTH,"%s: %s restricted",g_MenuNames[class],TextRestricted);
    } else {
        snprintf(Message,MAX_DATA_LENGTH,"%s: Only %s available",g_MenuNames[class],TextEnabled);
    }
    Message[0] = toupper(Message[0]); /* First char of menu name in capital letter */
    selfmessage(Message);
}

/**************************
* Restriction enforcement *
**************************/

public RestrictMenu(HLCommand,HLData,HLUserName,UserIndex) {
    if(!UserIndex) {
        selfmessage("This command cannot be used from console.");
        return PLUGIN_HANDLED;
    } else if(IsMenuEnabled() == 0) {
        selfmessage("This command cannot be used, because menues are disabled on this server.");
        selfmessage("Menues currently only have beta-status and need to get enabled by setting");
        selfmessage("amv_enable_beta to ^"menu1^" in the adminmod.cfg.");
        return PLUGIN_HANDLED;
    }
    DrawMainMenu(UserIndex);
    return PLUGIN_HANDLED;
}

public plugin_connect(HLUserName,HLIP,UserIndex) {
    if (0 < UserIndex < MAX_PLAYERS) {
        g_UserMenuSelected[UserIndex] = MENU_NONE;
    }
    return PLUGIN_CONTINUE;
}

public plugin_disconnect(HLUserName,UserIndex) {
    if (0 < UserIndex < MAX_PLAYERS) {
        g_UserMenuSelected[UserIndex] = MENU_NONE;
    }
    return PLUGIN_CONTINUE;
}

public buy(HLCommand,HLData,HLUserName,UserIndex){
    g_UserMenuSelected[UserIndex] = MENU_MAIN;
    return PLUGIN_CONTINUE;
}

public buyequip(HLCommand,HLData,HLUserName,UserIndex){
    g_UserMenuSelected[UserIndex] = MENU_EQUIPMENT;
    return PLUGIN_CONTINUE;
}

public ClearMenu(HLCommand,HLData,HLUserName,UserIndex) {
    g_UserMenuSelected[UserIndex] = MENU_NONE;
    return PLUGIN_CONTINUE;
}

public menuselect(HLCommand,HLData,HLUserName,UserIndex) {
    if(g_UserMenuSelected[UserIndex] != MENU_NONE) {
        static Data[MAX_DATA_LENGTH];
        new SelectedNumber;
        convert_string(HLData,Data,MAX_DATA_LENGTH);
        strstripquotes(Data);
        strtrim(Data," ",2);
        if( (IsNumeric(Data,SelectedNumber) == 0)
         || (SelectedNumber < 1 || SelectedNumber > 10) ) {
            return PLUGIN_HANDLED; /* Player tried to enter something invalid */
        }
        if(SelectedNumber == MENU_CANCEL) {
            /* A negative number is a restrict submenu */
            if(g_UserMenuSelected[UserIndex] < 0) {
                DrawMainMenu(UserIndex);
                return PLUGIN_HANDLED;
            } else {
                g_UserMenuSelected[UserIndex] = MENU_NONE;
            }
        } else if(g_UserMenuSelected[UserIndex] == MENU_RESTRICT) {
            DrawSubMenu(UserIndex,SelectedNumber);
            return PLUGIN_HANDLED;
        } else if(g_UserMenuSelected[UserIndex] < 0) {
            new Menu = -g_UserMenuSelected[UserIndex];
            new IndexOfFirstItemInMenu = g_MenuEntriesIndexBegin[Menu - 1];
            if(g_CS_Version != V15) {
                if(SelectedNumber == MENU_INVALID) {
                    if(g_UserMenuOrder[UserIndex] == 1) {
                        g_UserMenuOrder[UserIndex] = 0;
                    } else {
                        g_UserMenuOrder[UserIndex] = 1;
                    }
                } else {
                    new Order = g_UserMenuOrder[UserIndex];
                    new Item = g_ItemIndexByKeys[Order][IndexOfFirstItemInMenu + SelectedNumber - 1];
                    if(g_ItemRestricted[0][Item] == ITEM_RESTRICTED) {
                        plugin_exec("admin_unrestrict",g_ClientCommands1[Item]);
                    } else {
                        plugin_exec("admin_restrict",g_ClientCommands1[Item]);
                    }
                }
            } else {
                new Item = g_ItemIndexByKeys[0][IndexOfFirstItemInMenu + SelectedNumber - 1];
                if(Item == MAX_ITEMS) {
                    Item = g_ItemIndexByKeys[1][IndexOfFirstItemInMenu + SelectedNumber - 1];
                }
                if(g_ItemRestricted[0][Item] == ITEM_RESTRICTED) {
                    plugin_exec("admin_unrestrict",g_ClientCommands1[Item]);
                } else {
                    plugin_exec("admin_restrict",g_ClientCommands1[Item]);
                }
            }
            DrawSubMenu(UserIndex,Menu);
            return PLUGIN_HANDLED;
        } else if(g_RestrictedItemsNum && getvar("admin_cs_restrict")) {
            static UserName[MAX_NAME_LENGTH];
            convert_string(HLUserName,UserName,MAX_NAME_LENGTH);
            if(g_UserMenuSelected[UserIndex] == MENU_MAIN) {
                if(SelectedNumber == MENU_PRIMAMMO || SelectedNumber == MENU_SECAMMO || SelectedNumber == MENU_INVALID) {
                    if(getvar("allow_client_exec")) {
                        execclient(UserName,"menuselect 10");
                    }
                } else {
                    g_UserMenuSelected[UserIndex] = SelectedNumber;
                }
            } else {
                /* In 1.5 buyscripts often rely on that the menu stays open after a menuselect */
                if(g_CS_Version != V15) {
                    if(getvar("allow_client_exec")) {
                        execclient(UserName,"menuselect 10");
                    }
                }
                new IndexOfFirstItemInMenu = g_MenuEntriesIndexBegin[g_UserMenuSelected[UserIndex] - 1];
                new IndexOfFirstItemInNextMenu = g_MenuEntriesIndexBegin[g_UserMenuSelected[UserIndex]];
                if(SelectedNumber <=  IndexOfFirstItemInNextMenu - IndexOfFirstItemInMenu) {
                    new Team;
                    get_userTeam(UserName,Team);
                    Team = clamp(Team,1,2); /* to avoid AMX-error 4 (array out of bounds), keep Team between 1 and 2 */
                    new Item = g_ItemIndexByKeys[Team - 1][IndexOfFirstItemInMenu  + SelectedNumber - 1];
                    if(g_ItemRestricted[0][Item] == ITEM_RESTRICTED) {
                        messageex(UserName,"Item currently not allowed",print_center);
                        return PLUGIN_HANDLED;
                    }
                }
            }
        }
    }
    return PLUGIN_CONTINUE;
}

IsNumeric(string[],&num) {
    new i;
    new n = 0;
    if(string[0] == '^0') {
        return 0;
    }
    for(i=0;string[i] != '^0';i++) {
        if('0' <= string[i] <= '9') {
            n *= 10;
            n += (string[i] - '0');
        } else {
            return 0;
        }
    }
    num = n;
    return 1;
}

/*
 The cvar sv_region was introduced to CS 1.6. We change it,
 and look if getting the value again matches what we set it to.
 If it does, we have to reset it, and know it's 1.6.
*/
GetVersion() {
    new data[100];
    getstrvar("sv_region",data,100);
    setstrvar("sv_region","1");
    if(getvar("sv_region") == 1) {
        setstrvar("sv_region",data);
        /*
         Return anything, but not V15. When we check
         the value of g_CS_Version, we always must
         compare relative to V15.
        */
        return V15 + 1;
    }
    return V15;
}

IsMenuEnabled() {
    new data[100];
    getstrvar("amv_enable_beta",data,100);
    if(strstr(data,"menu1") != -1) {
        return 1;
    }
    return 0;
}

strtolower(String[]) {
    new i;
    for(i=0;String[i];i++) {
        String[i] = tolower(String[i]);
    }
}

/*
 Display the restrictmenu - main and submenu.
*/
DrawMainMenu(UserIndex) {
    new UserName[MAX_NAME_LENGTH];
    g_UserMenuSelected[UserIndex] = MENU_RESTRICT;
    playerinfo(UserIndex,UserName,MAX_NAME_LENGTH);
    if(g_CS_Version != V15) {
        new iTeam;
        get_userTeam(UserName,iTeam);
        g_UserMenuOrder[UserIndex] = clamp(iTeam - 1,0,1);
    }
    menu(UserName,"\yRestrict Item\w^n^n1. Handgun^n2. Shotgun^n3. Sub-Machine Gun^n4. Rifle^n5. Machine Gun^n^n6. Primary weapon ammo^n7. Secondary weapon ammo^n^n8. Equipment^n^n0. Exit",671,0);
}

DrawSubMenu(UserIndex,Menu) {
    new Menutext[512];
    new Text[100];
    new UserName[MAX_NAME_LENGTH];
    new i,j,k;
    new Keys;
    new Keymask = 1;
    snprintf(Menutext,512,"\y Restrict %s^n",g_SubMenuTitles[Menu-1]);
    for(i=g_MenuEntriesIndexBegin[Menu-1];i<g_MenuEntriesIndexBegin[Menu];i++) {
        j++;
        if(g_CS_Version == V15) {
            k = g_ItemIndexByKeys[0][i];
            if(k == MAX_ITEMS) {
                k = g_ItemIndexByKeys[1][i];
            }
        } else {
            k = g_ItemIndexByKeys[g_UserMenuOrder[UserIndex]][i];
            if(k == MAX_ITEMS) {
                break;
            }
        }
        if(g_ItemRestricted[0][k] == ITEM_RESTRICTED) {
            snprintf(Text,100,"^n\w%i. \r%s",j,g_ItemName[k]);
        } else {
            snprintf(Text,100,"^n\w%i. %s",j,g_ItemName[k]);
        }
        strcat(Menutext,Text,512);
        Keys |= Keymask;
        Keymask <<= 1;
    }
    if(g_CS_Version != V15) {
        if(g_UserMenuOrder[UserIndex] == 0) {
            strcat(Menutext,"^n^n\w9. \ySwitch to CT Layout",512);
        } else {
            strcat(Menutext,"^n^n\w9. \ySwitch to Terrorist Layout",512);
        }
        Keys |= 256;
    }
    strcat(Menutext,"^n^n\w0. Back",512);
    Keys |= 512;
    playerinfo(UserIndex,UserName,MAX_NAME_LENGTH);
    g_UserMenuSelected[UserIndex] = -Menu;
    menu(UserName,Menutext,Keys,0);
}

public buy_glock(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(0,HLUserName);
}

public buy_usp(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(1,HLUserName);
}

public buy_p228(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(2,HLUserName);
}

public buy_deagle(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(3,HLUserName);
}

public buy_elites(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(4,HLUserName);
}

public buy_fn57(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(5,HLUserName);
}

public buy_m3(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(6,HLUserName);
}

public buy_xm1014(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(7,HLUserName);
}

public buy_mac10(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(8,HLUserName);
}

public buy_mp5(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(9,HLUserName);
}

public buy_ump45(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(10,HLUserName);
}

public buy_p90(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(11,HLUserName);
}

public buy_tmp(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(12,HLUserName);
}

public buy_galil(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(13,HLUserName);
}

public buy_ak47(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(14,HLUserName);
}

public buy_scout(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(15,HLUserName);
}

public buy_sg552(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(16,HLUserName);
}

public buy_awp(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(17,HLUserName);
}

public buy_g3sg1(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(18,HLUserName);
}

public buy_famas(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(19,HLUserName);
}

public buy_aug(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(20,HLUserName);
}

public buy_m4a1(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(21,HLUserName);
}

public buy_sg550(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(22,HLUserName);
}

public buy_m249(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(23,HLUserName);
}

public buy_vest(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(24,HLUserName);
}

public buy_vesthelm(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(25,HLUserName);
}

public buy_flash(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(26,HLUserName);
}

public buy_hegren(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(27,HLUserName);
}

public buy_sgren(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(28,HLUserName);
}

public buy_defuser(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(29,HLUserName);
}

public buy_nvgs(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(30,HLUserName);
}

public buy_shield(HLCommand, HLData, HLUserName, UserIndex) {
    return buy_item(31,HLUserName);
}

buy_item(iItem,HLUserName) {
    if(g_ItemRestricted[0][iItem] == ITEM_RESTRICTED && getvar("admin_cs_restrict")) {
        new User[MAX_NAME_LENGTH];
        convert_string(HLUserName,User,MAX_NAME_LENGTH);
        messageex(User,"Item currently not allowed",print_center);
        return PLUGIN_HANDLED;
    }
    return PLUGIN_CONTINUE;
}

.PUBLIC
    buy_hegren
    buy_p90
    buy_sgren
    plugin_connect
    RestrictMenu
    buy_defuser
    buy_tmp
    buy_nvgs
    admin_restartround
    buy_glock
    buy_ak47
    ChangeMap
    buyequip
    buy_scout
    buy_sg552
    buy_usp
    buy_p228
    buy_shield
    buy_awp
    buy_deagle
    buy_galil
    buy_g3sg1
    buy_vest
    admin_changeteam
    buy_elites
    buy_famas
    admin_vote_restart
    buy_fn57
    menuselect
    plugin_init
    buy
    buy_aug
    buy_m3
    buy_m4a1
    buy_xm1014
    plugin_disconnect
    buy_sg550
    set_cvar
    buy_mac10
    buy_m249
    HandleRestartVote
    SetRestrictions
    buy_mp5
    buy_vesthelm
    ClearMenu
    buy_ump45
    buy_flash

.NATIVE
    menu
    playerinfo
    clamp
    get_userTeam
    plugin_exec
    strtrim
    toupper
    strcasestr
    strsep
    strstr
    set_vaultdata
    strncmp
    tolower
    setstrvar
    timeleft
    vote
    vote_allowed
    execclient
    strcmp
    messageex
    get_username
    check_user
    plugin_message
    get_vaultdata
    currentmap
    strcat
    plugin_registercmd
    plugin_registerinfo
    changelevel
    convert_string
    access
    getvar
    say
    selfmessage
    strcpy
    strlen
    getstrvar
    log
    exec
    snprintf

.DATA
    str_000 string "%s %s"
    str_001 string "Command: %s used command %s %s"
    str_002 string "admin_reject_msg"
    str_003 string "You do not have access to this command."
    str_004 string "admin_quiet"
    str_005 string "Admin"
    str_006 string "admin_ignore_immunity"
    AM_VERSION_STRING string "2.50.14"
    g_CS_Version variable ( 0x0 )
    g_MenuNames multiarray 9 - 
        variable ( 0x0 )
        string "pistols"
        string "shotguns"
        string "smg"
        string "rifles"
        string "machine guns"
        variable ( 0x0 )
        variable ( 0x0 )
        string "equipment"

    g_ItemName multiarray 32 - 
        string "9x19mm Sidearm"
        string "K&M .45 Tactical"
        string "228 Compact"
        string "Night Hawk .50C"
        string ".40 Dual Elites"
        string "ES Five-Seven"
        string "Leone 12 Gauge Super"
        string "Leone YG1265 Auto Shotgun"
        string "Ingram MAC-10"
        string "K&M Sub-Machine Gun"
        string "K&M UMP45"
        string "ES C90"
        string "Schmidt Machine Pistol"
        string "IDF Defender"
        string "CV-47"
        string "Schmidt Scout"
        string "Krieg 552 Commando"
        string "Magnum Sniper Rifle"
        string "D3/AU-1 Semi-Auto Sniper Rifle"
        string "Clarion 5.56"
        string "Bullpup"
        string "Maverick M4A1 Carabine"
        string "Krieg 550 Commando"
        string "ES M249 Para"
        string "Kevlar Vest"
        string "Kevlar Vest & Helmet"
        string "Flashbang"
        string "HE Grenade"
        string "Smoke Grenade"
        string "Defuse Kit"
        string "NightVision Goggles"
        string "Tactical Shield"

    g_ClientCommands1 multiarray 32 - 
        string "glock"
        string "usp"
        string "p228"
        string "deagle"
        string "elites"
        string "fn57"
        string "m3"
        string "xm1014"
        string "mac10"
        string "mp5"
        string "ump45"
        string "p90"
        string "tmp"
        string "galil"
        string "ak47"
        string "scout"
        string "sg552"
        string "awp"
        string "g3sg1"
        string "famas"
        string "aug"
        string "m4a1"
        string "sg550"
        string "m249"
        string "vest"
        string "vesthelm"
        string "flash"
        string "hegren"
        string "sgren"
        string "defuser"
        string "nvgs"
        string "shield"

    g_ClientCommands2 multiarray 32 - 
        string "9x19mm"
        string "km45"
        string "229compact"
        string "nighthawk"
        variable ( 0x0 )
        string "fiveseven"
        string "12gauge"
        string "autoshotgun"
        variable ( 0x0 )
        string "smg"
        variable ( 0x0 )
        string "c90"
        string "mp"
        string "defender"
        string "cv47"
        variable ( 0x0 )
        string "krieg552"
        string "magnum"
        string "d3au1"
        string "clarion"
        string "bullup"
        variable ( 0x0 )
        string "krieg550"
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )

    g_ItemRestricted multiarray 2 33 
        array 33 fill 0x0
        array 33 fill 0x0

    g_ItemIndexBegin array 42 
        ( 0x0 , 0x6 , 0x8 , 0xD , 0x17 , 0x18 , 0x18 , 0x18 , 0x20 , 0x0 , 
        0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 
        0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 
        0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 
        0x0 , 0x0 )
    g_ItemIndexByKeys multiarray 2 29 
        array 29 
            ( 0x0 , 0x1 , 0x2 , 0x3 , 0x4 , 0x6 , 0x7 , 0x8 , 0x9 , 0xA , 
            0xB , 0xD , 0xE , 0xF , 0x10 , 0x11 , 0x12 , 0x17 , 0x18 , 0x19 , 
            0x1A , 0x1B , 0x1C , 0x1E , 0x20 , 0x20 , 0x20 , 0x20 , 0x20 )
        array 29 
            ( 0x0 , 0x1 , 0x2 , 0x3 , 0x5 , 0x6 , 0x7 , 0xC , 0x9 , 0xA , 
            0xB , 0x13 , 0xF , 0x15 , 0x14 , 0x16 , 0x11 , 0x17 , 0x18 , 0x19 , 
            0x1A , 0x1B , 0x1C , 0x1D , 0x1E , 0x1F , 0x20 , 0x20 , 0x20 )

    g_MenuEntriesIndexBegin array 10 ( 0x0 , 0x5 , 0x7 , 0xB , 0x11 , 0x12 , 0x12 , 0x12 , 0x1A , 0x0 )
    g_SubMenuTitles multiarray 8 - 
        string "Handgun^n(Secondary weapon)"
        string "Shotgun^n(Primary weapon)"
        string "Sub-Machine Gun^n(Primary weapon)"
        string "Rifle^n(Primary weapon)"
        string "Machine Gun^n(Primary weapon)"
        variable ( 0x0 )
        variable ( 0x0 )
        string "Equipment"

    g_UserMenuOrder array 33 fill 0x0
    g_sCvar multiarray 23 - 
        string "autokick"
        string "autoteambalance"
        string "buytime"
        string "c4timer"
        string "chattime"
        string "consistency"
        string "fadetoblack"
        string "flashlight"
        string "footsteps"
        string "forcecamera"
        string "forcechasecam"
        string "freezetime"
        string "ghostfrequency"
        string "hostagepenalty"
        string "limitteams"
        string "kickpercent"
        string "maxrounds"
        string "mapvoteratio"
        string "playerid"
        string "roundtime"
        string "startmoney"
        string "tkpunish"
        string "winlimit"

    g_sDescription multiarray 23 - 
        string "admin_autokick <1 or 0>: mp_autokick on or off"
        string "admin_autoteambalance <#>: setting for mp_autoteambalance"
        string "admin_buytime <#>: setting for mp_buytime"
        string "admin_c4timer <#>: setting for mp_c4timer"
        string "admin_chattime <#>: setting for mp_chattime"
        string "admin_consistency <#>: setting for mp_consistency"
        string "admin_fadetoblack <1 or 0>: mp_fadetoblack on or off"
        string "admin_flashlight <1 or 0>: mp_flashlight on or off"
        string "admin_footsteps <1 or 0>: mp_footsteps on or off"
        string "admin_forcecamera <#>: setting for mp_forcecamera"
        string "admin_forcechasecam <#>: setting for mp_forcechasecam"
        string "admin_freezetime <#>: setting for mp_freezetime"
        string "admin_ghostfrequency <#>: setting for mp_ghostfrequency"
        string "admin_hpenalty <#>: setting for mp_hostagepenalty"
        string "admin_limitteams <1 or 0>: mp_limitteams on or off"
        string "admin_kickpercent <#>: setting for mp_kickpercent"
        string "admin_maxrounds <#>: setting for mp_maxrounds"
        string "admin_mapvoteratio <#>: setting for mp_mapvoteratio"
        string "admin_playerid <#>: setting for mp_playerid"
        string "admin_roundtime <#>: setting for mp_roundtime"
        string "admin_startmoney <800/16000>: setting for mp_startmoney"
        string "admin_tkpunish <1 or 0>: mp_tkpunish on or off"
        string "admin_winlimit <#>: setting for mp_winlimit"

    str_007 string "Counter-Strike Plugin"
    str_008 string "Team change / Restart Round / Weapons Restrictions"
    str_009 string "admin_ct"
    str_010 string "admin_changeteam"
    str_011 string "admin_ct <target>: Changes target to the counter-terrorist team."
    str_012 string "admin_t"
    str_013 string "admin_changeteam"
    str_014 string "admin_t <target>: Changes target to the terrorist team."
    str_015 string "admin_vote_restart"
    str_016 string "admin_vote_restart"
    str_017 string "admin_vote_restart: Starts a vote to restart the round."
    str_018 string "admin_restartround"
    str_019 string "admin_restartround"
    str_020 string "admin_restartround <seconds>: Restarts the round."
    str_021 string "admin_restart"
    str_022 string "admin_restartround"
    str_023 string "admin_restart <seconds>: Restarts the round."
    str_024 string "admin_%s"
    str_025 string "set_cvar"
    str_026 string "admin_restrict"
    str_027 string "SetRestrictions"
    str_028 string "admin_restrict: Control restrictions - admin_restrict help for details."
    str_029 string "admin_unrestrict"
    str_030 string "SetRestrictions"
    str_031 string "admin_unrestrict: Control restrictions - admin_unrestrict help for details."
    str_032 string "admin_restrictmenu"
    str_033 string "RestrictMenu"
    str_034 string "admin_restrictmenu: Displays menu for changing weaponrestrictions."
    str_035 string "buy"
    str_036 string "buy"
    var_000 variable ( 0x0 )
    str_037 string "buyequip"
    str_038 string "buyequip"
    str_039 string "menuselect"
    str_040 string "menuselect"
    str_041 string "radio1"
    str_042 string "ClearMenu"
    str_043 string "radio2"
    str_044 string "ClearMenu"
    str_045 string "radio3"
    str_046 string "ClearMenu"
    str_047 string "chooseteam"
    str_048 string "ClearMenu"
    str_049 string "buy_"
    arr_000 array 9 ( 0x0 , 0x6 , 0x8 , 0xD , 0x15 , 0x16 , 0x16 , 0x16 , 0x1D )
    mul_000 multiarray 2 29 
        array 29 
            ( 0x1 , 0x0 , 0x3 , 0x2 , 0x4 , 0x20 , 0x6 , 0x7 , 0x9 , 0x20 , 
            0xB , 0x8 , 0xA , 0xE , 0x10 , 0x20 , 0x20 , 0xF , 0x11 , 0x12 , 
            0x20 , 0x17 , 0x18 , 0x19 , 0x1A , 0x1B , 0x1C , 0x20 , 0x1E )
        array 29 
            ( 0x1 , 0x0 , 0x3 , 0x2 , 0x20 , 0x5 , 0x6 , 0x7 , 0x9 , 0xC , 
            0xB , 0x20 , 0xA , 0x20 , 0x20 , 0x15 , 0x14 , 0xF , 0x11 , 0x20 , 
            0x16 , 0x17 , 0x18 , 0x19 , 0x1A , 0x1B , 0x1C , 0x1D , 0x1E )

    str_050 string "WeaponRestrictions_"
    str_051 string "Map-specific saved weapon restrictions found."
    str_052 string "WeaponRestrictions"
    str_053 string "Default saved weapon restrictions found."
    str_054 string "No saved weapon restrictions found."
    str_055 string "admin_cs_restrict"
    str_056 string "Saved restrictions will not take effect while admin_cs_restrict is 0."
    str_057 string "allow_client_exec"
    str_058 string "You cannot use this command because allow_client_exec is 0."
    str_059 string "Unrecognized player: "
    str_060 string "Laf. You can't move %s onto another team, you silly bear."
    str_061 string "admin_ct"
    str_062 string "chooseteam;menuselect 2"
    str_063 string "chooseteam;menuselect 1"
    str_064 string "sv_restartround"
    str_065 string "map_ratio"
    str_066 string "Restart vote is not enabled"
    str_067 string "Vote not allowed at this time."
    str_068 string "Restart map & begin play?"
    str_069 string "Yes"
    str_070 string "No"
    str_071 string "HandleRestartVote"
    var_001 variable ( 0x0 )
    str_072 string "map_ratio"
    str_073 string "Not enough votes for map restart"
    str_074 string "mp_timelimit"
    str_075 string "mp_timelimit"
    str_076 string "sv_restartround"
    str_077 string "10"
    str_078 string "Map restart vote succeeded."
    str_079 string "Map restart vote failed."
    str_080 string "mp_%s"
    var_002 variable ( 0x0 )
    str_081 string "You cannot change the value of %s.^nType %s to view current setting."
    str_082 string "%s is currently set to %s"
    str_083 string "You do not have access to modify weapon restrictions."
    str_084 string "Type admin_restrict to see current restrictions."
    str_085 string "help"
    str_086 string "on"
    str_087 string "admin_cs_restrict"
    str_088 string "admin_cs_restrict"
    str_089 string "1"
    str_090 string "Weapon restrictions have been enabled."
    str_091 string "Weapon restriction functions are now enabled, but no weapons are"
    str_092 string "currenty marked as restricted. Use the admin_restrict command to"
    str_093 string "select which weapons to restrict."
    str_094 string "Weapon restrictions already are enabled."
    str_095 string "off"
    str_096 string "admin_cs_restrict"
    str_097 string "admin_cs_restrict"
    str_098 string "0"
    str_099 string "Weapon restrictions have been disabled."
    str_100 string "Weapon restrictions already are disabled."
    str_101 string "restore"
    str_102 string "Weapon restrictions have been reset to default."
    str_103 string "save "
    str_104 string "map"
    str_105 string "default"
    str_106 string "all"
    str_107 string "weapons"
    str_108 string "menu "
    str_109 string "There is no menu with this number."
    str_110 string "The data you supplied was invalid. Type "admin_restrict help" to view a help-text."
    str_111 string "The data you supplied was invalid. Type "admin_unrestrict help" to view a help-text."
    str_112 string "admin_cs_restrict"
    str_113 string "Restriction configured. This will take effect when you use admin_restrict on"
    str_114 string "admin_restrict usage:"
    str_115 string "admin_restrict: Show current restrictions"
    str_116 string "admin_restrict on: Enable restrictions"
    str_117 string "admin_restrict off: Disable restrictions"
    str_118 string "admin_restrict save default: Save current restrictions as server default"
    str_119 string "admin_restrict save map: Save current restrictions for this map"
    str_120 string "admin_restrict restore: Restore saved (map-)defaults"
    var_003 variable ( 0x0 )
    str_121 string "admin_restrict all: Restrict all weapons and equipment."
    str_122 string "admin_restrict weapons: Restrict all weapons."
    str_123 string "admin_restrict menu <menu name or number>: Restrict menu."
    str_124 string "admin_restrict <item name>: Restrict item."
    str_125 string "admin_restrict <menu number> <item number>: Restrict item."
    str_126 string "admin_unrestrict usage:"
    str_127 string "admin_unrestrict all: Allow all weapons and equipment."
    str_128 string "admin_unrestrict weapons: Allow all weapons."
    str_129 string "admin_unrestrict menu <menu name or number>: Allow menu."
    str_130 string "admin_unrestrict <item name>: Allow item."
    str_131 string "admin_unrestrict <menu number> <item number>: Allow item."
    var_004 variable ( 0x0 )
    str_132 string "All weapon / menu names can be entered as unique substring. Valid are all"
    str_133 string "names that are used in buy menu or console. You cannot restrict ammunition."
    str_134 string "Note that restrictions by numbers only are accepted if the numbers"
    str_135 string "are the same for T and CT."
    str_136 string "WeaponRestrictions"
    str_137 string "_"
    str_138 string " "
    str_139 string "The data supplied matches both '%s' and '%s'"
    str_140 string "The data supplied matches both '%s' (%s) and '%s' (%s)"
    str_141 string "All items restricted"
    str_142 string "All items enabled"
    str_143 string "All weapons restricted"
    str_144 string "All weapons enabled"
    str_145 string "All items from menu %s restricted"
    str_146 string "All items from menu %s enabled"
    str_147 string "Item %s restricted"
    str_148 string "Item %s enabled"
    str_149 string "Item %s already is restricted"
    str_150 string "Item %s already is enabled"
    str_151 string "admin_cs_restrict"
    str_152 string "^nCurrent weapon restrictions:^n"
    str_153 string "^nNo weapon restrictions are currently in force."
    str_154 string "^nNOTE: Weapon restrictions are not currently enforced."
    str_155 string "To enforce them use the command: admin_restict on"
    str_156 string "^nNOTE: Further weapon restrictions may be hard coded into this map."
    str_157 string "^nNOTE: Some weapon restrictions may be hard coded into this map."
    str_158 string ", "
    str_159 string ", "
    str_160 string "%s: All restricted"
    str_161 string "%s: All available"
    str_162 string "%s: %s restricted"
    str_163 string "%s: Only %s available"
    str_164 string "This command cannot be used from console."
    str_165 string "This command cannot be used, because menues are disabled on this server."
    str_166 string "Menues currently only have beta-status and need to get enabled by setting"
    str_167 string "amv_enable_beta to "menu1" in the adminmod.cfg."
    Data array 200 fill 0x0
    str_168 string " "
    str_169 string "admin_unrestrict"
    str_170 string "admin_restrict"
    str_171 string "admin_unrestrict"
    str_172 string "admin_restrict"
    str_173 string "admin_cs_restrict"
    UserName array 33 fill 0x0
    str_174 string "allow_client_exec"
    str_175 string "menuselect 10"
    str_176 string "allow_client_exec"
    str_177 string "menuselect 10"
    str_178 string "Item currently not allowed"
    str_179 string "sv_region"
    str_180 string "sv_region"
    str_181 string "1"
    str_182 string "sv_region"
    str_183 string "sv_region"
    str_184 string "amv_enable_beta"
    str_185 string "menu1"
    var_005 variable ( 0x0 )
    str_186 string "\yRestrict Item\w^n^n1. Handgun^n2. Shotgun^n3. Sub-Machine Gun^n4. Rifle^n5. Machine Gun^n^n6. Primary weapon ammo^n7. Secondary weapon ammo^n^n8. Equipment^n^n0. Exit"
    str_187 string "\y Restrict %s^n"
    str_188 string "^n\w%i. \r%s"
    str_189 string "^n\w%i. %s"
    str_190 string "^n^n\w9. \ySwitch to CT Layout"
    str_191 string "^n^n\w9. \ySwitch to Terrorist Layout"
    str_192 string "^n^n\w0. Back"
    str_193 string "admin_cs_restrict"
    str_194 string "Item currently not allowed"


.CODE

FILE
    file                 0x0   "plugin_CS.sma"
    file                 0x1   "..\include\core.inc"
    file                 0x2   "..\include\string.inc"
    file                 0x3   "..\include\admin.inc"
    file                 0x4   "..\include\plugin.inc"
    file                 0x5   "..\include\adminlib.inc"
    file                 0x6   "..\include\admin.inc"
    file                 0x7   "..\include\core.inc"
    file                 0x8   "..\include\string.inc"
ENDF

INFO
    symbol       "execute_command"  global  COD  function
ENDI

PROC  func_00
    line                0x51           0x5
    symbol           "sData"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol       "sHalfLifeCmd"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol        "sCommand"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol           "sUser"  local  FRM  array_ptr
    srange               0x0           0x0
    line                0x52           0x5
    symbol        "sRconCmd"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    line                0x54           0x5
    zero.pri  
    push.pri  
    load.s.pri          0x18
    push.pri  
    load.s.pri          0x10
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c              0x10
    call             func_05
    line                0x55           0x5
    load.s.pri          0x18
    push.pri  
    load.s.pri          0x14
    push.pri  
    zero.pri  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    line                0x56           0x5
    const.pri            0x1
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c               0x8
    sysreq.c            exec
    stack                0xC
    stack              0x320
    zero.pri  
    retn      
ENDP

INFO
    symbol       "format_command"  global  COD  function
ENDI

PROC  func_01
    line                0x5A           0x5
    symbol           "sText"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol           "sData"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol        "sCommand"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol           "sUser"  local  FRM  array_ptr
    srange               0x0           0x0
    line                0x5B           0x5
    load.s.pri          0x14
    push.pri  
    load.s.pri          0x10
    push.pri  
    load.s.pri           0xC
    push.pri  
    const.pri        str_001  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    load.s.pri          0x18
    push.pri  
    push.c              0x18
    sysreq.c        snprintf
    stack               0x1C
    zero.pri  
    retn      
ENDP

INFO
    symbol       "log_command"  global  COD  function
ENDI

PROC  func_02
    line                0x5F           0x5
    symbol           "sData"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol        "sCommand"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol           "sUser"  local  FRM  array_ptr
    srange               0x0           0x0
    line                0x60           0x5
    symbol           "sText"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    line                0x61           0x5
    addr.pri          -0x320
    push.pri  
    load.s.pri          0x14
    push.pri  
    load.s.pri          0x10
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c              0x10
    call             func_01
    line                0x62           0x5
    addr.pri          -0x320
    push.pri  
    push.c               0x4
    sysreq.c             log
    stack                0x8
    stack              0x320
    zero.pri  
    retn      
ENDP

INFO
    symbol        "numtostr"  global  COD  function
ENDI

PROC  func_03
    line                0x66           0x5
    symbol             "str"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol             "num"  local  FRM  variable
    line                0x67           0x5
    symbol            "Base"  local  FRM  variable
    stack               -0x4
    const.pri            0x1
    stor.s.pri          -0x4
    line                0x68           0x5
    symbol          "Digits"  local  FRM  variable
    stack               -0x4
    const.pri            0x1
    stor.s.pri          -0x8
    line                0x69           0x5
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0xC
    line                0x6C           0x5
    load.s.pri           0xC
    zero.alt  
    eq        
    jzer           jump_0000
    line                0x6D           0x5
    load.s.pri          0x10
    push.pri  
    load.s.pri          -0xC
    inc.s               -0xC
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri           0x30
    pop.alt   
    stor.i    
    line                0x6E           0x5
    load.s.pri          0x10
    push.pri  
    load.s.pri          -0xC
    inc.s               -0xC
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
    jump           jump_0001
 jump_0000:
    line                0x72           0x5
    load.s.pri           0xC
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sless     
    jzer           jump_0002
    line                0x73           0x5
    load.s.pri          0x10
    push.pri  
    load.s.pri          -0xC
    inc.s               -0xC
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri           0x2D
    pop.alt   
    stor.i    
    line                0x74           0x5
    load.s.pri           0xC
    const.alt           -0x1
    smul      
    stor.s.pri           0xC
 jump_0002:
    line                0x7B           0x5
 jump_0004:
    line                0x7B           0x5
    load.s.pri          -0x4
    push.pri  
    load.s.pri           0xC
    pop.alt   
    xchg      
    sleq      
    jzer           jump_0003
    line                0x7C           0x5
    load.s.pri          -0x4
    const.alt            0xA
    smul      
    stor.s.pri          -0x4
    line                0x7D           0x5
    load.s.pri          -0x8
    inc.s               -0x8
    jump           jump_0004
 jump_0003:
    line                0x82           0x5
 jump_0006:
    line                0x82           0x5
    dec.s               -0x8
    load.s.pri          -0x8
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sgrtr     
    jzer           jump_0005
    line                0x83           0x5
    load.s.pri          -0x4
    push.pri  
    const.pri            0xA
    pop.alt   
    sdiv.alt  
    stor.s.pri          -0x4
    line                0x84           0x5
    load.s.pri          0x10
    push.pri  
    load.s.pri          -0xC
    inc.s               -0xC
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    sdiv.alt  
    move.pri  
    pop.alt   
    sub.alt   
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    sdiv.alt  
    const.alt           0x30
    add       
    pop.alt   
    stor.i    
    line                0x85           0x5
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    sdiv.alt  
    move.pri  
    stor.s.pri           0xC
    jump           jump_0006
 jump_0005:
    line                0x87           0x5
    load.s.pri          0x10
    push.pri  
    load.s.pri          -0xC
    inc.s               -0xC
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
 jump_0001:
    stack                0xC
    zero.pri  
    retn      
ENDP

INFO
    symbol       "reject_message"  global  COD  function
ENDI

PROC  func_04
    line                0x8C           0x5
    symbol         "iPublic"  local  FRM  variable
    line                0x8D           0x5
    symbol           "sText"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    line                0x8F           0x5
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    const.pri        str_002  ;  ref to String  
    push.pri  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    line                0x90           0x5
    addr.pri          -0x320
    push.pri  
    push.c               0x4
    sysreq.c          strlen
    stack                0x8
    push.pri  
    const.pri            0x2
    pop.alt   
    xchg      
    sless     
    jzer           jump_0007
    line                0x91           0x5
    const.pri           0xC8
    push.pri  
    const.pri        str_003  ;  ref to String  
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c               0xC
    sysreq.c          strcpy
    stack               0x10
 jump_0007:
    line                0x92           0x5
    load.s.pri           0xC
    zero.alt  
    eq        
    jzer           jump_0008
    line                0x93           0x5
    addr.pri          -0x320
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0009
 jump_0008:
    line                0x95           0x5
    addr.pri          -0x320
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
 jump_0009:
    stack              0x320
    zero.pri  
    retn      
ENDP

INFO
    symbol       "say_command"  global  COD  function
ENDI

PROC  func_05
    line                0x9F           0x5
    symbol       "iOverride"  local  FRM  variable
    symbol           "sData"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol        "sCommand"  local  FRM  array_ptr
    srange               0x0           0x0
    symbol           "sUser"  local  FRM  array_ptr
    srange               0x0           0x0
    line                0xA0           0x5
    symbol          "iQuiet"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line                0xA1           0x5
    symbol           "sText"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x324
    fill               0x320
    line                0xA3           0x5
    const.pri        str_004  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    stor.s.pri          -0x4
    line                0xA4           0x5
    load.s.pri          -0x4
    zero.alt  
    eq        
    jzer           jump_0010
    line                0xA5           0x5
    addr.pri          -0x324
    push.pri  
    load.s.pri          0x14
    push.pri  
    load.s.pri          0x10
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c              0x10
    call             func_01
    line                0xA6           0x5
    addr.pri          -0x324
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0011
 jump_0010:
    line                0xA7           0x5
    load.s.pri          -0x4
    const.alt            0x1
    eq        
    jnz            jump_0012
    load.s.pri          0x18
    const.alt            0x1
    eq        
    jnz            jump_0012
    zero.pri  
    jump           jump_0014
 jump_0012:
    const.pri            0x1
 jump_0014:
    jzer           jump_0015
    line                0xA8           0x5
    addr.pri          -0x324
    push.pri  
    load.s.pri          0x14
    push.pri  
    load.s.pri          0x10
    push.pri  
    const.pri        str_005  ;  ref to String  
    push.pri  
    push.c              0x10
    call             func_01
    line                0xA9           0x5
    addr.pri          -0x324
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0011
 jump_0015:
    line                0xAB           0x5
    load.s.pri          0x14
    push.pri  
    load.s.pri          0x10
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c               0xC
    call             func_02
 jump_0011:
    stack              0x324
    zero.pri  
    retn      
ENDP

INFO
    symbol         "strinit"  global  COD  function
ENDI

PROC  func_06
    line               0x129           0x5
    symbol         "sString"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x12A           0x5
    load.s.pri           0xC
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
    zero.pri  
    retn      
ENDP

INFO
    symbol       "strstripquotes"  global  COD  function
ENDI

PROC  func_07
    line               0x138           0x5
    symbol             "str"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x139           0x5
    symbol          "maxlen"  local  FRM  variable
    stack               -0x4
    load.s.pri           0xC
    push.pri  
    push.c               0x4
    sysreq.c          strlen
    stack                0x8
    stor.s.pri          -0x4
    line               0x13A           0x5
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x8
    line               0x13C           0x5
    load.s.pri          -0x4
    zero.alt  
    eq        
    jzer           jump_0017
    line               0x13D           0x5
    zero.pri  
    stack                0x8
    retn      
 jump_0017:
    line               0x13F           0x5
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt           0x22
    eq        
    jzer           jump_0018
    line               0x140           0x5
    load.s.pri           0xC
    push.pri  
    dec.s               -0x4
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
 jump_0018:
    line               0x142           0x5
    load.s.pri           0xC
    load.i    
    const.alt           0x22
    eq        
    jzer           jump_0019
    line               0x143           0x5
    zero.pri  
    stor.s.pri          -0x8
    jump           jump_0020
 jump_0022:
    line               0x143           0x5
    load.s.pri          -0x8
    inc.s               -0x8
 jump_0020:
    load.s.pri          -0x8
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    xchg      
    sleq      
    jzer           jump_0021
    line               0x144           0x5
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x8
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x8
    const.alt            0x1
    add       
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    stor.i    
    jump           jump_0022
 jump_0021:
    line               0x145           0x5
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x8
    push.pri  
    const.pri            0x2
    pop.alt   
    sub.alt   
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
 jump_0019:
    stack                0x8
    zero.pri  
    retn      
ENDP

INFO
    symbol       "check_immunity"  global  COD  function
ENDI

PROC  func_08
    line               0x15C           0x5
    symbol         "sTarget"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x15E           0x5
    const.pri        str_006  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    neq       
    jzer           jump_0023
    line               0x15F           0x5
    zero.pri  
    retn      
 jump_0023:
    line               0x161           0x5
    load.s.pri           0xC
    push.pri  
    const.pri         0x1000
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    zero.alt  
    neq       
    jzer           jump_0024
    line               0x162           0x5
    const.pri            0x1
    retn      
 jump_0024:
    line               0x164           0x5
    zero.pri  
    retn      
ENDP

INFO
    symbol       "ChangeMap"  global  COD  function
ENDI

PROC  ChangeMap
    line               0x182           0x5
    symbol         "HLParam"  local  FRM  variable
    symbol          "HLUser"  local  FRM  variable
    symbol          "Repeat"  local  FRM  variable
    symbol           "Timer"  local  FRM  variable
    line               0x183           0x5
    symbol          "NewMap"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt           -0x84
    fill                0x84
    line               0x185           0x5
    const.pri           0x21
    push.pri  
    addr.pri           -0x84
    push.pri  
    load.s.pri          0x18
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x186           0x5
    addr.pri           -0x84
    push.pri  
    push.c               0x4
    sysreq.c          strlen
    stack                0x8
    zero.alt  
    neq       
    jzer           jump_0025
    line               0x187           0x5
    const.pri           -0x1
    push.pri  
    addr.pri           -0x84
    push.pri  
    push.c               0x8
    sysreq.c     changelevel
    stack                0xC
 jump_0025:
    stack               0x84
    zero.pri  
    retn      
ENDP

INFO
    symbol       "AM_VERSION_STRING"  global  DAT  array
    srange               0x0           0x8
    symbol       "g_CS_Version"  global  DAT  variable
    symbol       "g_MenuNames"  global  DAT  array
    srange               0x0           0x9
    srange               0x1           0x0
    symbol       "g_ItemName"  global  DAT  array
    srange               0x0          0x20
    srange               0x1           0x0
    symbol       "g_ClientCommands1"  global  DAT  array
    srange               0x0          0x20
    srange               0x1           0x0
    symbol       "g_ClientCommands2"  global  DAT  array
    srange               0x0          0x20
    srange               0x1           0x0
    symbol       "g_ItemRestricted"  global  DAT  array
    srange               0x0           0x2
    srange               0x1          0x21
    symbol       "g_ItemIndexBegin"  global  DAT  array
    srange               0x0           0x9
    symbol       "g_UserMenuSelected"  global  DAT  array
    srange               0x0          0x21
    symbol       "g_ItemIndexByKeys"  global  DAT  array
    srange               0x0           0x2
    srange               0x1          0x1D
    symbol       "g_MenuEntriesIndexBegin"  global  DAT  array
    srange               0x0           0x9
    symbol       "g_RestrictedItemsNum"  global  DAT  variable
    symbol       "g_SubMenuTitles"  global  DAT  array
    srange               0x0           0x8
    srange               0x1           0x0
    symbol       "g_UserMenuOrder"  global  DAT  array
    srange               0x0          0x21
    symbol         "g_sCvar"  global  DAT  array
    srange               0x0          0x17
    srange               0x1           0x0
    symbol       "g_sDescription"  global  DAT  array
    srange               0x0          0x17
    srange               0x1           0x0
    symbol       "plugin_init"  global  COD  function
ENDI

PROC  plugin_init
    line               0x174           0x0
    line               0x175           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x176           0x0
    const.pri    AM_VERSION_STRING  ;  ref to String  
    push.pri  
    const.pri        str_008  ;  ref to String  
    push.pri  
    const.pri        str_007  ;  ref to String  
    push.pri  
    push.c               0xC
    sysreq.c     plugin_registerinfo
    stack               0x10
    line               0x177           0x0
    const.pri        str_011  ;  ref to String  
    push.pri  
    const.pri           0x80
    push.pri  
    const.pri        str_010  ;  ref to String  
    push.pri  
    const.pri        str_009  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x178           0x0
    const.pri        str_014  ;  ref to String  
    push.pri  
    const.pri           0x80
    push.pri  
    const.pri        str_013  ;  ref to String  
    push.pri  
    const.pri        str_012  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x179           0x0
    const.pri        str_017  ;  ref to String  
    push.pri  
    const.pri            0x1
    push.pri  
    const.pri        str_016  ;  ref to String  
    push.pri  
    const.pri        str_015  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x17A           0x0
    const.pri        str_020  ;  ref to String  
    push.pri  
    const.pri            0x2
    push.pri  
    const.pri        str_019  ;  ref to String  
    push.pri  
    const.pri        str_018  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x17B           0x0
    const.pri        str_023  ;  ref to String  
    push.pri  
    const.pri            0x2
    push.pri  
    const.pri        str_022  ;  ref to String  
    push.pri  
    const.pri        str_021  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x17F           0x0
    symbol        "sCommand"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x324
    fill               0x320
    line               0x180           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0026
 jump_0028:
    line               0x180           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0026:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x17
    pop.alt   
    xchg      
    sless     
    jzer           jump_0027
    line               0x181           0x0
    const.pri        g_sCvar  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x17
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_024  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x324
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    line               0x182           0x0
    const.pri    g_sDescription  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x17
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_025  ;  ref to String  
    push.pri  
    addr.pri          -0x324
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    jump           jump_0028
 jump_0027:
    line               0x187           0x0
    const.pri        str_028  ;  ref to String  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_027  ;  ref to String  
    push.pri  
    const.pri        str_026  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x188           0x0
    const.pri        str_031  ;  ref to String  
    push.pri  
    const.pri           0x20
    push.pri  
    const.pri        str_030  ;  ref to String  
    push.pri  
    const.pri        str_029  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x189           0x0
    const.pri        str_034  ;  ref to String  
    push.pri  
    const.pri           0x20
    push.pri  
    const.pri        str_033  ;  ref to String  
    push.pri  
    const.pri        str_032  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    line               0x18A           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_036  ;  ref to String  
    push.pri  
    const.pri        str_035  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x18B           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_038  ;  ref to String  
    push.pri  
    const.pri        str_037  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x18C           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_040  ;  ref to String  
    push.pri  
    const.pri        str_039  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x18D           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_042  ;  ref to String  
    push.pri  
    const.pri        str_041  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x18E           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_044  ;  ref to String  
    push.pri  
    const.pri        str_043  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x18F           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_046  ;  ref to String  
    push.pri  
    const.pri        str_045  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x190           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    const.pri        str_048  ;  ref to String  
    push.pri  
    const.pri        str_047  ;  ref to String  
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x197           0x0
    push.c               0x0
    call             func_25
    stor.pri           0x238
    line               0x198           0x0
    load.pri           0x238
    const.alt            0x1
    neq       
    jzer           jump_0029
    line               0x199           0x0
    symbol        "Function"  local  FRM  array
    stack              -0x78
    srange               0x0          0x1E
    zero.pri  
    addr.alt          -0x39C
    fill                0x78
    line               0x19A           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0030
 jump_0033:
    line               0x19A           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0030:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0031
    line               0x19B           0x0
    const.pri           0x1E
    push.pri  
    const.pri        str_049  ;  ref to String  
    push.pri  
    addr.pri          -0x39C
    push.pri  
    push.c               0xC
    sysreq.c          strcpy
    stack               0x10
    line               0x19C           0x0
    const.pri           0x1E
    push.pri  
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri          -0x39C
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    line               0x19D           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    addr.pri          -0x39C
    push.pri  
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    line               0x19E           0x0
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0032
    line               0x19F           0x0
    const.pri        var_000  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    zero.pri  
    push.pri  
    addr.pri          -0x39C
    push.pri  
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
 jump_0032:
    jump           jump_0033
 jump_0031:
    stack               0x78
    jump           jump_0034
 jump_0029:
    line               0x1A4           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    const.alt           0x34
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1A5           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    const.alt           0x4C
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1A6           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    const.alt           0x7C
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1A7           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    const.alt           0x34
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1A8           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    const.alt           0x4C
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1A9           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    const.alt           0x7C
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1AA           0x0
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    const.alt           0x34
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1AB           0x0
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    const.alt           0x4C
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1AC           0x0
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    const.alt           0x7C
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x4
    call             func_06
    line               0x1AE           0x0
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    const.pri        arr_000  ;  ref to Array  
    pop.alt   
    movs                0x24
    line               0x1AF           0x0
    symbol       "ItemIndexByKeys15"  local  FRM  array
    stack              -0xF0
    srange               0x0           0x2
    srange               0x1          0x1D
    const.pri        mul_000  ;  ref to MultiArray  
    addr.alt          -0x414
    movs                0xF0
    line               0x1B4           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0035
 jump_0037:
    line               0x1B4           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0035:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x1D
    pop.alt   
    xchg      
    sless     
    jzer           jump_0036
    line               0x1B5           0x0
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    addr.pri          -0x414
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    stor.i    
    line               0x1B6           0x0
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    addr.pri          -0x414
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    stor.i    
    jump           jump_0037
 jump_0036:
    stack               0xF0
 jump_0034:
    line               0x1BE           0x0
    symbol          "strKey"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0x3A8
    fill                0x84
    line               0x1BF           0x0
    symbol          "strMap"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x538
    fill               0x190
    line               0x1C0           0x0
    symbol         "strName"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x6C8
    fill               0x190
    line               0x1C1           0x0
    const.pri           0x64
    push.pri  
    addr.pri          -0x538
    push.pri  
    push.c               0x8
    sysreq.c      currentmap
    stack                0xC
    line               0x1C2           0x0
    const.pri           0x64
    push.pri  
    const.pri        str_050  ;  ref to String  
    push.pri  
    addr.pri          -0x6C8
    push.pri  
    push.c               0xC
    sysreq.c          strcpy
    stack               0x10
    line               0x1C3           0x0
    const.pri           0x64
    push.pri  
    addr.pri          -0x538
    push.pri  
    addr.pri          -0x6C8
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    line               0x1C4           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x3A8
    push.pri  
    addr.pri          -0x6C8
    push.pri  
    push.c               0xC
    sysreq.c     get_vaultdata
    stack               0x10
    jzer           jump_0038
    line               0x1C5           0x0
    const.pri        str_051  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
    jump           jump_0039
 jump_0038:
    line               0x1C6           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x3A8
    push.pri  
    const.pri        str_052  ;  ref to String  
    push.pri  
    push.c               0xC
    sysreq.c     get_vaultdata
    stack               0x10
    jzer           jump_0040
    line               0x1C7           0x0
    const.pri        str_053  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
    jump           jump_0039
 jump_0040:
    line               0x1C9           0x0
    const.pri        str_054  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
 jump_0039:
    line               0x1CF           0x0
    addr.pri          -0x3A8
    load.i    
    zero.alt  
    neq       
    jzer           jump_0042
    line               0x1D0           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0043
 jump_0046:
    line               0x1D0           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0043:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0042
    line               0x1D1           0x0
    addr.pri          -0x3A8
    push.pri  
    load.s.pri          -0x4
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt           0x31
    eq        
    jzer           jump_0045
    line               0x1D2           0x0
    const.pri            0x1
    push.pri  
    const.pri            0x1
    push.pri  
    load.s.pri          -0x4
    push.pri  
    push.c               0xC
    call             func_21
    line               0x1D3           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    stor.i    
 jump_0045:
    jump           jump_0046
 jump_0042:
    line               0x1D7           0x0
    load.pri          0x1488
    jzer           jump_0047
    const.pri        str_055  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    eq        
    jzer           jump_0047
    const.pri            0x1
    jump           jump_0049
 jump_0047:
    zero.pri  
 jump_0049:
    jzer           jump_0050
    line               0x1D8           0x0
    const.pri        str_056  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
 jump_0050:
    line               0x1DA           0x0
    const.pri            0x1
    stack              0x6C8
    retn      
ENDP

INFO
    symbol       "admin_changeteam"  global  COD  function
ENDI

PROC  admin_changeteam
    line               0x1E1           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x1E2           0x0
    symbol         "Command"  local  FRM  array
    stack              -0x78
    srange               0x0          0x1E
    zero.pri  
    addr.alt           -0x78
    fill                0x78
    line               0x1E3           0x0
    symbol            "Data"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x398
    fill               0x320
    line               0x1E4           0x0
    symbol       "TargetName"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0x41C
    fill                0x84
    line               0x1E5           0x0
    symbol            "Text"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x73C
    fill               0x320
    line               0x1E6           0x0
    symbol            "User"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0x7C0
    fill                0x84
    line               0x1E7           0x0
    const.pri           0x21
    push.pri  
    addr.pri           -0x78
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x1E8           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x398
    push.pri  
    load.s.pri          0x10
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x1E9           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x7C0
    push.pri  
    load.s.pri          0x14
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x1EA           0x0
    const.pri        str_057  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    not       
    jzer           jump_0051
    line               0x1EB           0x0
    const.pri        str_058  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0052
 jump_0051:
    line               0x1EC           0x0
    addr.pri          -0x398
    push.pri  
    push.c               0x4
    sysreq.c      check_user
    stack                0x8
    not       
    jzer           jump_0053
    line               0x1ED           0x0
    const.pri        str_059  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x1EE           0x0
    addr.pri          -0x398
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0052
 jump_0053:
    line               0x1F0           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri          -0x398
    push.pri  
    push.c               0xC
    sysreq.c     get_username
    stack               0x10
    line               0x1F1           0x0
    addr.pri          -0x41C
    push.pri  
    push.c               0x4
    call             func_08
    zero.alt  
    neq       
    jzer           jump_0055
    line               0x1F2           0x0
    addr.pri          -0x41C
    push.pri  
    const.pri        str_060  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x73C
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    line               0x1F3           0x0
    const.pri            0x2
    push.pri  
    addr.pri          -0x73C
    push.pri  
    addr.pri          -0x7C0
    push.pri  
    push.c               0xC
    sysreq.c       messageex
    stack               0x10
    jump           jump_0052
 jump_0055:
    line               0x1F5           0x0
    zero.pri  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri          -0x7C0
    push.pri  
    push.c              0x10
    call             func_05
    line               0x1F6           0x0
    const.pri        str_061  ;  ref to String  
    push.pri  
    addr.pri           -0x78
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    not       
    jzer           jump_0057
    line               0x1F7           0x0
    const.pri        str_062  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c      execclient
    stack                0xC
    jump           jump_0052
 jump_0057:
    line               0x1F9           0x0
    const.pri        str_063  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c      execclient
    stack                0xC
 jump_0052:
    line               0x1FD           0x0
    const.pri           -0x1
    stack              0x7C0
    retn      
ENDP

INFO
    symbol       "admin_restartround"  global  COD  function
ENDI

PROC  admin_restartround
    line               0x200           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x201           0x0
    symbol         "Command"  local  FRM  array
    stack              -0x78
    srange               0x0          0x1E
    zero.pri  
    addr.alt           -0x78
    fill                0x78
    line               0x202           0x0
    symbol            "Data"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x398
    fill               0x320
    line               0x203           0x0
    symbol            "User"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0x41C
    fill                0x84
    line               0x204           0x0
    const.pri           0x1E
    push.pri  
    addr.pri           -0x78
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x205           0x0
    const.pri           0xC8
    push.pri  
    addr.pri          -0x398
    push.pri  
    load.s.pri          0x10
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x206           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x41C
    push.pri  
    load.s.pri          0x14
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x207           0x0
    addr.pri          -0x398
    push.pri  
    const.pri        str_064  ;  ref to String  
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c              0x10
    call             func_00
    line               0x208           0x0
    const.pri           -0x1
    stack              0x41C
    retn      
ENDP

INFO
    symbol       "admin_vote_restart"  global  COD  function
ENDI

PROC  admin_vote_restart
    line               0x20B           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x20C           0x0
    const.pri        str_065  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    eq        
    jzer           jump_0059
    line               0x20D           0x0
    const.pri        str_066  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0060
 jump_0059:
    line               0x20E           0x0
    push.c               0x0
    sysreq.c     vote_allowed
    stack                0x4
    zero.alt  
    eq        
    jzer           jump_0061
    line               0x20F           0x0
    const.pri        str_067  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0060
 jump_0061:
    line               0x211           0x0
    const.pri        var_001  ;  ref to Variable  
    push.pri  
    const.pri        str_071  ;  ref to String  
    push.pri  
    const.pri        str_070  ;  ref to String  
    push.pri  
    const.pri        str_069  ;  ref to String  
    push.pri  
    const.pri        str_068  ;  ref to String  
    push.pri  
    push.c              0x14
    sysreq.c            vote
    stack               0x18
 jump_0060:
    line               0x213           0x0
    const.pri           -0x1
    retn      
ENDP

INFO
    symbol       "HandleRestartVote"  global  COD  function
ENDI

PROC  HandleRestartVote
    line               0x216           0x0
    symbol       "UserCount"  local  FRM  variable
    symbol       "VoteCount"  local  FRM  variable
    symbol          "HLUser"  local  FRM  variable
    symbol       "WinningOption"  local  FRM  variable
    line               0x217           0x0
    load.s.pri           0xC
    const.alt            0x1
    eq        
    jzer           jump_0063
    line               0x218           0x0
    symbol           "ratio"  local  FRM  variable
    stack               -0x4
    const.pri        str_072  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    stor.s.pri          -0x4
    line               0x219           0x0
    load.s.pri          0x14
    push.pri  
    load.s.pri          -0x4
    push.pri  
    const.pri           0x64
    pop.alt   
    sdiv.alt  
    push.pri  
    load.s.pri          0x18
    pop.alt   
    smul      
    pop.alt   
    xchg      
    sless     
    jzer           jump_0064
    line               0x21A           0x0
    const.pri        str_073  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0065
 jump_0064:
    line               0x21C           0x0
    symbol       "Timelimit"  local  FRM  array
    stack              -0x50
    srange               0x0          0x14
    zero.pri  
    addr.alt           -0x54
    fill                0x50
    line               0x21D           0x0
    addr.pri           -0x54
    push.pri  
    const.pri        str_074  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    const.alt           0x3C
    smul      
    push.pri  
    const.pri            0x1
    push.pri  
    push.c               0x4
    sysreq.c        timeleft
    stack                0x8
    pop.alt   
    sub.alt   
    const.alt            0xA
    add       
    push.pri  
    const.pri           0x3C
    pop.alt   
    sdiv.alt  
    push.pri  
    push.c               0x8
    call             func_03
    line               0x21E           0x0
    addr.pri           -0x54
    push.pri  
    const.pri        str_075  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c       setstrvar
    stack                0xC
    line               0x21F           0x0
    const.pri        str_077  ;  ref to String  
    push.pri  
    const.pri        str_076  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c       setstrvar
    stack                0xC
    line               0x220           0x0
    const.pri        str_078  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    stack               0x50
 jump_0065:
    stack                0x4
    jump           jump_0066
 jump_0063:
    line               0x223           0x0
    const.pri        str_079  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c             say
    stack                0x8
 jump_0066:
    zero.pri  
    retn      
ENDP

INFO
    symbol        "set_cvar"  global  COD  function
ENDI

PROC  set_cvar
    line               0x227           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x228           0x0
    symbol            "Text"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    line               0x229           0x0
    symbol         "Command"  local  FRM  array
    stack              -0x78
    srange               0x0          0x1E
    zero.pri  
    addr.alt          -0x398
    fill                0x78
    line               0x22A           0x0
    symbol            "Data"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x6B8
    fill               0x320
    line               0x22B           0x0
    symbol            "User"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0x73C
    fill                0x84
    line               0x22C           0x0
    symbol           "sCvar"  local  FRM  array
    stack              -0x78
    srange               0x0          0x1E
    zero.pri  
    addr.alt          -0x7B4
    fill                0x78
    line               0x22D           0x0
    const.pri           0x1E
    push.pri  
    addr.pri          -0x398
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x22E           0x0
    const.pri           0xC8
    push.pri  
    addr.pri          -0x6B8
    push.pri  
    load.s.pri          0x10
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x22F           0x0
    const.pri           0x21
    push.pri  
    addr.pri          -0x73C
    push.pri  
    load.s.pri          0x14
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x230           0x0
    addr.pri          -0x398
    const.alt        str_001  ;  ref to String  
    add       
    push.pri  
    const.pri        str_080  ;  ref to String  
    push.pri  
    const.pri           0x1E
    push.pri  
    addr.pri          -0x7B4
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    line               0x231           0x0
    addr.pri          -0x6B8
    load.i    
    zero.alt  
    neq       
    jzer           jump_0067
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri          0x200
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0067
    const.pri            0x1
    jump           jump_0069
 jump_0067:
    zero.pri  
 jump_0069:
    jzer           jump_0070
    line               0x232           0x0
    addr.pri          -0x6B8
    push.pri  
    addr.pri          -0x7B4
    push.pri  
    addr.pri          -0x398
    push.pri  
    addr.pri          -0x73C
    push.pri  
    push.c              0x10
    call             func_00
    jump           jump_0071
 jump_0070:
    line               0x233           0x0
    addr.pri          -0x6B8
    load.i    
    zero.alt  
    neq       
    jzer           jump_0072
    line               0x234           0x0
    addr.pri          -0x398
    push.pri  
    addr.pri          -0x7B4
    push.pri  
    const.pri        str_081  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x6B8
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    line               0x235           0x0
    addr.pri          -0x6B8
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0071
 jump_0072:
    line               0x237           0x0
    const.pri           0xC8
    push.pri  
    addr.pri          -0x6B8
    push.pri  
    addr.pri          -0x7B4
    push.pri  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    line               0x238           0x0
    addr.pri          -0x6B8
    push.pri  
    addr.pri          -0x7B4
    push.pri  
    const.pri        str_082  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    line               0x239           0x0
    addr.pri          -0x320
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0071:
    line               0x23B           0x0
    const.pri           -0x1
    stack              0x7B4
    retn      
ENDP

INFO
    symbol       "SetRestrictions"  global  COD  function
ENDI

PROC  SetRestrictions
    line               0x242           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x243           0x0
    symbol         "Command"  local  FRM  array
    stack              -0x78
    srange               0x0          0x1E
    zero.pri  
    addr.alt           -0x78
    fill                0x78
    line               0x244           0x0
    symbol        "UserName"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt           -0xFC
    fill                0x84
    line               0x245           0x0
    symbol            "Data"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x41C
    fill               0x320
    line               0x246           0x0
    symbol          "Status"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x420
    line               0x248           0x0
    const.pri           0x1E
    push.pri  
    addr.pri           -0x78
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x249           0x0
    const.pri           0xC8
    push.pri  
    addr.pri          -0x41C
    push.pri  
    load.s.pri          0x10
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x24A           0x0
    const.pri           0x21
    push.pri  
    addr.pri           -0xFC
    push.pri  
    load.s.pri          0x14
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x24B           0x0
    addr.pri          -0x41C
    push.pri  
    push.c               0x4
    call             func_07
    line               0x24C           0x0
    addr.pri          -0x41C
    push.pri  
    push.c               0x4
    call             func_27
    line               0x24E           0x0
    addr.pri           -0x78
    const.alt        str_001  ;  ref to String  
    add       
    load.i    
    push.pri  
    push.c               0x4
    sysreq.c         tolower
    stack                0x8
    const.alt           0x72
    eq        
    jzer           jump_0074
    line               0x24F           0x0
    const.pri            0x1
    stor.s.pri        -0x420
    jump           jump_0075
 jump_0074:
    line               0x251           0x0
    zero.pri  
    stor.s.pri        -0x420
 jump_0075:
    line               0x254           0x0
    addr.pri          -0x41C
    load.i    
    zero.alt  
    eq        
    jzer           jump_0076
    line               0x255           0x0
    load.s.pri        -0x420
    const.alt            0x1
    eq        
    jzer           jump_0077
    line               0x256           0x0
    push.c               0x0
    call             func_22
    jump           jump_0078
 jump_0077:
    line               0x258           0x0
    zero.pri  
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
 jump_0078:
    line               0x25A           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0076:
    line               0x25B           0x0
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri           0x20
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    zero.alt  
    eq        
    jzer           jump_0079
    line               0x25C           0x0
    const.pri        str_083  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x25D           0x0
    const.pri        str_084  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x25E           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0079:
    line               0x25F           0x0
    const.pri        str_085  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0080
    line               0x260           0x0
    load.s.pri        -0x420
    push.pri  
    push.c               0x4
    call             func_10
    jump           jump_0081
 jump_0080:
    line               0x261           0x0
    load.s.pri        -0x420
    const.alt            0x1
    eq        
    jzer           jump_0081
    line               0x262           0x0
    const.pri        str_086  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0083
    line               0x263           0x0
    const.pri        str_087  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    eq        
    jzer           jump_0084
    line               0x264           0x0
    const.pri        str_089  ;  ref to String  
    push.pri  
    const.pri        str_088  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c       setstrvar
    stack                0xC
    line               0x265           0x0
    zero.pri  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
    line               0x266           0x0
    load.pri          0x1488
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sgrtr     
    jzer           jump_0085
    line               0x267           0x0
    const.pri        str_090  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0086
 jump_0085:
    line               0x269           0x0
    const.pri        str_091  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x26A           0x0
    const.pri        str_092  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x26B           0x0
    const.pri        str_093  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0086:
    jump           jump_0087
 jump_0084:
    line               0x26E           0x0
    const.pri        str_094  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0087:
    line               0x270           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0083:
    line               0x271           0x0
    const.pri        str_095  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0088
    line               0x272           0x0
    const.pri        str_096  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    const.alt            0x1
    eq        
    jzer           jump_0089
    line               0x273           0x0
    const.pri        str_098  ;  ref to String  
    push.pri  
    const.pri        str_097  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c       setstrvar
    stack                0xC
    line               0x274           0x0
    zero.pri  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
    line               0x275           0x0
    const.pri        str_099  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0090
 jump_0089:
    line               0x277           0x0
    const.pri        str_100  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0090:
    line               0x279           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0088:
    line               0x27A           0x0
    const.pri        str_101  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0091
    line               0x27B           0x0
ENDP

INFO
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x424
    line               0x27C           0x0
    zero.pri  
    stor.s.pri        -0x424
    jump           jump_0092
 jump_0094:
    line               0x27C           0x0
    load.s.pri        -0x424
    inc.s             -0x424
 jump_0092:
    load.s.pri        -0x424
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0093
    line               0x27D           0x0
    zero.pri  
    push.pri  
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x424
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    load.s.pri        -0x424
    push.pri  
    push.c               0xC
    call             func_21
    jump           jump_0094
 jump_0093:
    line               0x27F           0x0
    zero.pri  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
    line               0x280           0x0
    const.pri        str_102  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x281           0x0
    const.pri            0x2
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
    line               0x282           0x0
    const.pri           -0x1
    stack              0x424
    retn      
 jump_0091:
    line               0x283           0x0
    const.pri            0x5
    push.pri  
    const.pri        str_103  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0xC
    sysreq.c         strncmp
    stack               0x10
    zero.alt  
    eq        
    jzer           jump_0081
    line               0x284           0x0
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri          0x200
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    zero.alt  
    eq        
    jzer           jump_0096
    line               0x285           0x0
    zero.pri  
    push.pri  
    push.c               0x4
    call             func_04
    jump           jump_0097
 jump_0096:
    line               0x286           0x0
    const.pri        str_104  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    const.alt           0x14
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0098
    line               0x287           0x0
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c               0xC
    call             func_02
    line               0x288           0x0
    const.pri            0x1
    push.pri  
    push.c               0x4
    call             func_11
    jump           jump_0097
 jump_0098:
    line               0x289           0x0
    const.pri        str_105  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    const.alt           0x14
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0100
    line               0x28A           0x0
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c               0xC
    call             func_02
    line               0x28B           0x0
    zero.pri  
    push.pri  
    push.c               0x4
    call             func_11
    jump           jump_0097
 jump_0100:
    line               0x28D           0x0
    zero.pri  
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
 jump_0097:
    line               0x28F           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0081:
    line               0x292           0x0
    const.pri        str_106  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0102
    line               0x293           0x0
    const.pri            0x1
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_18
    line               0x294           0x0
    zero.pri  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
    line               0x295           0x0
    const.pri            0x2
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
    line               0x296           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0102:
    line               0x297           0x0
    const.pri        str_107  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0103
    line               0x298           0x0
    const.pri            0x1
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_19
    line               0x299           0x0
    zero.pri  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
    line               0x29A           0x0
    const.pri            0x2
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
    line               0x29B           0x0
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0103:
    line               0x29E           0x0
    symbol           "Index"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x424
    symbol          "retval"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x428
    line               0x29F           0x0
    const.pri            0x5
    push.pri  
    const.pri        str_108  ;  ref to String  
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0xC
    sysreq.c         strncmp
    stack               0x10
    zero.alt  
    eq        
    jzer           jump_0104
    line               0x2A0           0x0
    addr.pri          -0x424
    push.pri  
    addr.pri          -0x41C
    const.alt           0x14
    add       
    push.pri  
    push.c               0x8
    call             func_24
    const.alt            0x1
    eq        
    jzer           jump_0105
    line               0x2A1           0x0
    load.s.pri        -0x424
    push.pri  
    const.pri            0x9
    pop.alt   
    xchg      
    sless     
    jzer           jump_0106
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0x424
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    zero.alt  
    neq       
    jzer           jump_0106
    const.pri            0x1
    jump           jump_0108
 jump_0106:
    zero.pri  
 jump_0108:
    jzer           jump_0109
    line               0x2A2           0x0
    const.pri            0x2
    stor.s.pri        -0x428
    jump           jump_0110
 jump_0109:
    line               0x2A4           0x0
    const.pri        str_109  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2A5           0x0
    const.pri           -0x1
    stor.s.pri        -0x428
 jump_0110:
    jump           jump_0111
 jump_0105:
    line               0x2A8           0x0
    addr.pri          -0x424
    push.pri  
    addr.pri          -0x41C
    const.alt           0x14
    add       
    push.pri  
    push.c               0x8
    call             func_12
    stor.s.pri        -0x428
 jump_0111:
    line               0x2AA           0x0
    load.s.pri        -0x428
    const.alt            0x2
    eq        
    jnz            jump_0112
    load.s.pri        -0x428
    const.alt            0x1
    eq        
    jnz            jump_0112
    zero.pri  
    jump           jump_0114
 jump_0112:
    const.pri            0x1
 jump_0114:
    jzer           jump_0115
    line               0x2AB           0x0
    const.pri            0x1
    push.pri  
    load.s.pri        -0x420
    push.pri  
    load.s.pri        -0x424
    push.pri  
    push.c               0xC
    call             func_20
    line               0x2AC           0x0
    zero.pri  
    push.pri  
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0x424
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
 jump_0115:
    line               0x2AE           0x0
    load.s.pri        -0x428
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
    line               0x2AF           0x0
    const.pri           -0x1
    stack              0x428
    retn      
 jump_0104:
    line               0x2B1           0x0
    addr.pri          -0x424
    push.pri  
    addr.pri          -0x41C
    push.pri  
    push.c               0x8
    call             func_13
    stor.s.pri        -0x428
    line               0x2B2           0x0
    load.s.pri        -0x428
    const.alt            0x2
    eq        
    jnz            jump_0116
    load.s.pri        -0x428
    const.alt            0x1
    eq        
    jnz            jump_0116
    zero.pri  
    jump           jump_0118
 jump_0116:
    const.pri            0x1
 jump_0118:
    jzer           jump_0119
    line               0x2B3           0x0
    const.pri            0x1
    push.pri  
    load.s.pri        -0x420
    push.pri  
    load.s.pri        -0x424
    push.pri  
    push.c               0xC
    call             func_21
    line               0x2B4           0x0
    zero.pri  
    push.pri  
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0x424
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri           -0x78
    push.pri  
    addr.pri           -0xFC
    push.pri  
    push.c              0x10
    call             func_05
 jump_0119:
    line               0x2B6           0x0
    load.s.pri        -0x428
    push.pri  
    load.s.pri        -0x420
    push.pri  
    push.c               0x8
    call             func_09
    line               0x2B7           0x0
    const.pri           -0x1
    stack              0x428
    retn      
    symbol          "Report"  global  COD  function
ENDI

PROC  func_09
    line               0x2BA           0x0
    symbol          "retval"  local  FRM  variable
    symbol          "Status"  local  FRM  variable
    line               0x2BB           0x0
    load.s.pri          0x10
    zero.alt  
    eq        
    jnz            jump_0120
    load.s.pri          0x10
    const.alt           -0x1
    eq        
    jnz            jump_0120
    zero.pri  
    jump           jump_0122
 jump_0120:
    const.pri            0x1
 jump_0122:
    jzer           jump_0123
    line               0x2BC           0x0
    load.s.pri           0xC
    const.alt            0x1
    eq        
    jzer           jump_0124
    line               0x2BD           0x0
    const.pri        str_110  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0125
 jump_0124:
    line               0x2BF           0x0
    const.pri        str_111  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0125:
    jump           jump_0126
 jump_0123:
    line               0x2C2           0x0
    load.s.pri           0xC
    jzer           jump_0127
    const.pri        str_112  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    not       
    jzer           jump_0127
    const.pri            0x1
    jump           jump_0129
 jump_0127:
    zero.pri  
 jump_0129:
    jzer           jump_0126
    line               0x2C3           0x0
    const.pri        str_113  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0126:
    zero.pri  
    retn      
ENDP

INFO
    symbol        "ShowHelp"  global  COD  function
ENDI

PROC  func_10
    line               0x2C8           0x0
    symbol          "Status"  local  FRM  variable
    line               0x2C9           0x0
    load.s.pri           0xC
    const.alt            0x1
    eq        
    jzer           jump_0131
    line               0x2CA           0x0
    const.pri        str_114  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2CB           0x0
    const.pri        str_115  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2CC           0x0
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri           0x20
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0132
    line               0x2CD           0x0
    const.pri        str_116  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2CE           0x0
    const.pri        str_117  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2CF           0x0
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri          0x200
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0133
    line               0x2D0           0x0
    const.pri        str_118  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D1           0x0
    const.pri        str_119  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0133:
    line               0x2D3           0x0
    const.pri        str_120  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D4           0x0
    const.pri        var_003  ;  ref to Variable  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D5           0x0
    const.pri        str_121  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D6           0x0
    const.pri        str_122  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D7           0x0
    const.pri        str_123  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D8           0x0
    const.pri        str_124  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2D9           0x0
    const.pri        str_125  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0132:
    jump           jump_0134
 jump_0131:
    line               0x2DC           0x0
    const.pri        str_126  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2DD           0x0
    const.pri        str_127  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2DE           0x0
    const.pri        str_128  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2DF           0x0
    const.pri        str_129  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2E0           0x0
    const.pri        str_130  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2E1           0x0
    const.pri        str_131  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0134:
    line               0x2E3           0x0
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri           0x20
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0135
    line               0x2E4           0x0
    const.pri        var_004  ;  ref to Variable  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2E5           0x0
    const.pri        str_132  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2E6           0x0
    const.pri        str_133  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2E7           0x0
    load.pri           0x238
    const.alt            0x1
    neq       
    jzer           jump_0135
    line               0x2E8           0x0
    const.pri        str_134  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x2E9           0x0
    const.pri        str_135  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0135:
    zero.pri  
    retn      
ENDP

INFO
    symbol       "SaveRestrictionsToVault"  global  COD  function
ENDI

PROC  func_11
    line               0x2EE           0x0
    symbol       "Mapspecific"  local  FRM  variable
    line               0x2EF           0x0
    symbol         "strName"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    const.pri        str_136  ;  ref to String  
    addr.alt          -0x190
    movs                0x4C
    line               0x2F0           0x0
    symbol          "strKey"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0x214
    fill                0x84
    line               0x2F1           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x218
    line               0x2F2           0x0
    load.s.pri           0xC
    jzer           jump_0137
    line               0x2F3           0x0
    symbol          "strMap"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x3A8
    fill               0x190
    line               0x2F4           0x0
    const.pri           0x64
    push.pri  
    addr.pri          -0x3A8
    push.pri  
    push.c               0x8
    sysreq.c      currentmap
    stack                0xC
    line               0x2F5           0x0
    const.pri           0x64
    push.pri  
    const.pri        str_137  ;  ref to String  
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    line               0x2F6           0x0
    const.pri           0x64
    push.pri  
    addr.pri          -0x3A8
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    stack              0x190
 jump_0137:
    line               0x2F8           0x0
    zero.pri  
    stor.s.pri        -0x218
    jump           jump_0138
 jump_0142:
    line               0x2F8           0x0
    load.s.pri        -0x218
    inc.s             -0x218
 jump_0138:
    load.s.pri        -0x218
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0139
    line               0x2F9           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x218
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x218
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    stor.i    
    line               0x2FA           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x218
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0140
    line               0x2FB           0x0
    addr.pri          -0x214
    push.pri  
    load.s.pri        -0x218
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri           0x31
    pop.alt   
    stor.i    
    jump           jump_0141
 jump_0140:
    line               0x2FE           0x0
    addr.pri          -0x214
    push.pri  
    load.s.pri        -0x218
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri           0x30
    pop.alt   
    stor.i    
 jump_0141:
    jump           jump_0142
 jump_0139:
    line               0x301           0x0
    addr.pri          -0x214
    const.alt           0x80
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
    line               0x302           0x0
    addr.pri          -0x214
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c               0x8
    sysreq.c     set_vaultdata
    stack                0xC
    stack              0x218
    zero.pri  
    retn      
ENDP

INFO
    symbol       "IsMenuString"  global  COD  function
ENDI

PROC  func_12
    line               0x30C           0x0
    symbol             "num"  local  FRM  variable_ptr
    symbol          "string"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x30D           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x30E           0x0
    symbol           "match"  local  FRM  variable
    stack               -0x4
    const.pri           -0x1
    stor.s.pri          -0x8
    line               0x30F           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0143
 jump_0147:
    line               0x30F           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0143:
    load.s.pri          -0x4
    push.pri  
    const.pri            0x9
    pop.alt   
    xchg      
    sless     
    jzer           jump_0144
    line               0x310           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0145
    line               0x311           0x0
    load.s.pri           0xC
    push.pri  
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0145
    line               0x312           0x0
    load.s.pri          -0x4
    sref.s.pri          0x10
    line               0x313           0x0
    const.pri            0x2
    stack                0x8
    retn      
 jump_0145:
    jump           jump_0147
 jump_0144:
    line               0x317           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0148
 jump_0155:
    line               0x317           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0148:
    load.s.pri          -0x4
    push.pri  
    const.pri            0x9
    pop.alt   
    xchg      
    sless     
    jzer           jump_0149
    line               0x318           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0150
    load.s.pri           0xC
    push.pri  
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    neq       
    jzer           jump_0150
    const.pri            0x1
    jump           jump_0152
 jump_0150:
    zero.pri  
 jump_0152:
    jzer           jump_0153
    line               0x319           0x0
    load.s.pri          -0x8
    const.alt           -0x1
    neq       
    jzer           jump_0154
    line               0x31A           0x0
    const.pri            0x1
    push.pri  
    load.s.pri          -0x4
    push.pri  
    load.s.pri          -0x8
    push.pri  
    push.c               0xC
    call             func_17
    line               0x31B           0x0
    const.pri           -0x1
    stack                0x8
    retn      
 jump_0154:
    line               0x31D           0x0
    load.s.pri          -0x4
    stor.s.pri          -0x8
 jump_0153:
    jump           jump_0155
 jump_0149:
    line               0x320           0x0
    load.s.pri          -0x8
    const.alt           -0x1
    neq       
    jzer           jump_0156
    line               0x321           0x0
    load.s.pri          -0x8
    sref.s.pri          0x10
    line               0x322           0x0
    const.pri            0x1
    stack                0x8
    retn      
 jump_0156:
    line               0x324           0x0
    zero.pri  
    stack                0x8
    retn      
ENDP

INFO
    symbol       "IsWeaponString"  global  COD  function
ENDI

PROC  func_13
    line               0x32E           0x0
    symbol             "num"  local  FRM  variable_ptr
    symbol          "string"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x32F           0x0
    symbol          "Param1"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    line               0x330           0x0
    symbol          "Param2"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x640
    fill               0x320
    line               0x331           0x0
    symbol            "num1"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x644
    symbol            "num2"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x648
    line               0x332           0x0
    const.pri           0xC8
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    addr.pri          -0x640
    push.pri  
    const.pri           0xC8
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    addr.pri          -0x320
    push.pri  
    const.pri        str_138  ;  ref to String  
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c              0x18
    sysreq.c          strsep
    stack               0x1C
    heap                -0x8
    line               0x333           0x0
    addr.pri          -0x644
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c               0x8
    call             func_24
    jzer           jump_0157
    addr.pri          -0x648
    push.pri  
    addr.pri          -0x640
    push.pri  
    push.c               0x8
    call             func_24
    jzer           jump_0157
    const.pri            0x1
    jump           jump_0159
 jump_0157:
    zero.pri  
 jump_0159:
    jzer           jump_0160
    line               0x334           0x0
    load.s.pri          0x10
    push.pri  
    load.s.pri        -0x648
    push.pri  
    load.s.pri        -0x644
    push.pri  
    push.c               0xC
    call             func_16
    stack              0x648
    retn      
 jump_0160:
    line               0x336           0x0
ENDP

INFO
    symbol         "retval1"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x64C
    symbol         "tmpnum1"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x650
    line               0x337           0x0
    addr.pri          -0x640
    load.i    
    zero.alt  
    eq        
    jzer           jump_0161
    line               0x338           0x0
    addr.pri          -0x650
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c               0x8
    call             func_14
    stor.s.pri        -0x64C
    line               0x339           0x0
    load.s.pri        -0x64C
    const.alt            0x2
    eq        
    jzer           jump_0162
    line               0x33A           0x0
    load.s.pri        -0x650
    sref.s.pri          0x10
    line               0x33B           0x0
    const.pri            0x2
    stack              0x650
    retn      
 jump_0162:
    line               0x33C           0x0
    load.s.pri        -0x64C
    const.alt           -0x1
    eq        
    jzer           jump_0161
    line               0x33D           0x0
    const.pri           -0x1
    stack              0x650
    retn      
 jump_0161:
    line               0x340           0x0
    symbol         "retval2"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x654
    symbol         "tmpnum2"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x658
    line               0x341           0x0
    addr.pri          -0x658
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c               0x8
    call             func_15
    stor.s.pri        -0x654
    line               0x342           0x0
    load.s.pri        -0x654
    const.alt            0x2
    eq        
    jzer           jump_0164
    line               0x343           0x0
    load.s.pri        -0x658
    sref.s.pri          0x10
    line               0x344           0x0
    const.pri            0x2
    stack              0x658
    retn      
 jump_0164:
    line               0x345           0x0
    load.s.pri        -0x654
    const.alt           -0x1
    eq        
    jzer           jump_0165
    line               0x346           0x0
    const.pri           -0x1
    stack              0x658
    retn      
 jump_0165:
    line               0x347           0x0
    load.s.pri        -0x64C
    const.alt            0x1
    eq        
    jzer           jump_0166
    load.s.pri        -0x654
    const.alt            0x1
    eq        
    jzer           jump_0166
    load.s.pri        -0x650
    push.pri  
    load.s.pri        -0x658
    pop.alt   
    neq       
    jzer           jump_0166
    const.pri            0x1
    jump           jump_0169
 jump_0166:
    zero.pri  
 jump_0169:
    jzer           jump_0170
    line               0x348           0x0
    zero.pri  
    push.pri  
    load.s.pri        -0x658
    push.pri  
    load.s.pri        -0x650
    push.pri  
    push.c               0xC
    call             func_17
    line               0x349           0x0
    const.pri           -0x1
    stack              0x658
    retn      
 jump_0170:
    line               0x34A           0x0
    load.s.pri        -0x64C
    const.alt            0x1
    eq        
    jzer           jump_0171
    line               0x34B           0x0
    load.s.pri        -0x650
    sref.s.pri          0x10
    line               0x34C           0x0
    const.pri            0x1
    stack              0x658
    retn      
 jump_0171:
    line               0x34D           0x0
    load.s.pri        -0x654
    const.alt            0x1
    eq        
    jzer           jump_0172
    line               0x34E           0x0
    load.s.pri        -0x658
    sref.s.pri          0x10
    line               0x34F           0x0
    const.pri            0x1
    stack              0x658
    retn      
 jump_0172:
    stack               0x10
    line               0x352           0x0
    zero.pri  
    stack              0x648
    retn      
    symbol       "FindWeaponIndexShort"  global  COD  function
ENDI

PROC  func_14
    line               0x35D           0x0
    symbol             "num"  local  FRM  variable_ptr
    symbol          "string"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x35E           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x35F           0x0
    symbol           "match"  local  FRM  variable
    stack               -0x4
    const.pri           -0x1
    stor.s.pri          -0x8
    line               0x360           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0173
 jump_0185:
    line               0x360           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0173:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0174
    line               0x361           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0175
    load.s.pri           0xC
    push.pri  
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0175
    const.pri            0x1
    jump           jump_0177
 jump_0175:
    zero.pri  
 jump_0177:
    jnz            jump_0178
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0179
    load.s.pri           0xC
    push.pri  
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    eq        
    jzer           jump_0179
    const.pri            0x1
    jump           jump_0181
 jump_0179:
    zero.pri  
 jump_0181:
    jnz            jump_0178
    zero.pri  
    jump           jump_0183
 jump_0178:
    const.pri            0x1
 jump_0183:
    jzer           jump_0184
    line               0x363           0x0
    load.s.pri          -0x4
    sref.s.pri          0x10
    line               0x364           0x0
    const.pri            0x2
    stack                0x8
    retn      
 jump_0184:
    jump           jump_0185
 jump_0174:
    line               0x367           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0186
 jump_0199:
    line               0x367           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0186:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0187
    line               0x368           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0188
    load.s.pri           0xC
    push.pri  
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    neq       
    jzer           jump_0188
    const.pri            0x1
    jump           jump_0190
 jump_0188:
    zero.pri  
 jump_0190:
    jnz            jump_0191
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0192
    load.s.pri           0xC
    push.pri  
    const.pri    g_ClientCommands2  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    neq       
    jzer           jump_0192
    const.pri            0x1
    jump           jump_0194
 jump_0192:
    zero.pri  
 jump_0194:
    jnz            jump_0191
    zero.pri  
    jump           jump_0196
 jump_0191:
    const.pri            0x1
 jump_0196:
    jzer           jump_0197
    line               0x36A           0x0
    load.s.pri          -0x8
    const.alt           -0x1
    neq       
    jzer           jump_0198
    line               0x36B           0x0
    zero.pri  
    push.pri  
    load.s.pri          -0x4
    push.pri  
    load.s.pri          -0x8
    push.pri  
    push.c               0xC
    call             func_17
    line               0x36C           0x0
    const.pri           -0x1
    stack                0x8
    retn      
 jump_0198:
    line               0x36E           0x0
    load.s.pri          -0x4
    stor.s.pri          -0x8
 jump_0197:
    jump           jump_0199
 jump_0187:
    line               0x371           0x0
    load.s.pri          -0x8
    const.alt           -0x1
    neq       
    jzer           jump_0200
    line               0x372           0x0
    load.s.pri          -0x8
    sref.s.pri          0x10
    line               0x373           0x0
    const.pri            0x1
    stack                0x8
    retn      
 jump_0200:
    line               0x375           0x0
    zero.pri  
    stack                0x8
    retn      
ENDP

INFO
    symbol       "FindWeaponIndexLong"  global  COD  function
ENDI

PROC  func_15
    line               0x37E           0x0
    symbol             "num"  local  FRM  variable_ptr
    symbol          "string"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x37F           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x380           0x0
    symbol           "match"  local  FRM  variable
    stack               -0x4
    const.pri           -0x1
    stor.s.pri          -0x8
    line               0x381           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0201
 jump_0208:
    line               0x381           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0201:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0202
    line               0x382           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0203
    load.s.pri           0xC
    push.pri  
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri          -0x4
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    push.c               0x8
    sysreq.c      strcasestr
    stack                0xC
    const.alt           -0x1
    neq       
    jzer           jump_0203
    const.pri            0x1
    jump           jump_0205
 jump_0203:
    zero.pri  
 jump_0205:
    jzer           jump_0206
    line               0x383           0x0
    load.s.pri          -0x8
    const.alt           -0x1
    neq       
    jzer           jump_0207
    line               0x384           0x0
    zero.pri  
    push.pri  
    load.s.pri          -0x4
    push.pri  
    load.s.pri          -0x8
    push.pri  
    push.c               0xC
    call             func_17
    line               0x385           0x0
    const.pri           -0x1
    stack                0x8
    retn      
 jump_0207:
    line               0x387           0x0
    load.s.pri          -0x4
    stor.s.pri          -0x8
 jump_0206:
    jump           jump_0208
 jump_0202:
    line               0x38A           0x0
    load.s.pri          -0x8
    const.alt           -0x1
    neq       
    jzer           jump_0209
    line               0x38B           0x0
    load.s.pri          -0x8
    sref.s.pri          0x10
    line               0x38C           0x0
    const.pri            0x1
    stack                0x8
    retn      
 jump_0209:
    line               0x38E           0x0
    zero.pri  
    stack                0x8
    retn      
ENDP

INFO
    symbol       "FindWeaponIndexNumber"  global  COD  function
ENDI

PROC  func_16
    line               0x395           0x0
    symbol             "num"  local  FRM  variable_ptr
    symbol            "num2"  local  FRM  variable
    symbol            "num1"  local  FRM  variable
    line               0x397           0x0
    load.s.pri           0xC
    zero.alt  
    xchg      
    sless     
    push.pri  
    move.pri  
    push.pri  
    const.pri            0x7
    pop.alt   
    xchg      
    sless     
    swap.alt  
    and       
    pop.alt   
    jnz            jump_0210
    load.s.pri           0xC
    const.alt            0x8
    eq        
    jnz            jump_0210
    zero.pri  
    jump           jump_0212
 jump_0210:
    const.pri            0x1
 jump_0212:
    jzer           jump_0213
    load.s.pri          0x10
    zero.alt  
    xchg      
    sless     
    push.pri  
    move.pri  
    push.pri  
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    sub.alt   
    pop.alt   
    xchg      
    sleq      
    swap.alt  
    and       
    pop.alt   
    jzer           jump_0213
    const.pri            0x1
    jump           jump_0215
 jump_0213:
    zero.pri  
 jump_0215:
    jzer           jump_0216
    line               0x399           0x0
    symbol       "ItemIndex"  local  FRM  variable
    stack               -0x4
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    load.s.pri          0x10
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    stor.s.pri          -0x4
    line               0x39A           0x0
    symbol           "ItemT"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri          -0x8
    line               0x39B           0x0
    symbol          "ItemCT"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri          -0xC
    line               0x39C           0x0
    load.pri           0x238
    const.alt            0x1
    eq        
    jzer           jump_0217
    line               0x39D           0x0
    load.s.pri          -0x8
    const.alt           0x20
    neq       
    jzer           jump_0218
    line               0x39E           0x0
    load.s.pri          -0x8
    sref.s.pri          0x14
    line               0x39F           0x0
    const.pri            0x2
    stack                0xC
    retn      
 jump_0218:
    line               0x3A0           0x0
    load.s.pri          -0xC
    const.alt           0x20
    neq       
    jzer           jump_0219
    line               0x3A1           0x0
    load.s.pri          -0xC
    sref.s.pri          0x14
    line               0x3A2           0x0
    const.pri            0x2
    stack                0xC
    retn      
 jump_0219:
    jump           jump_0220
 jump_0217:
    line               0x3A5           0x0
    load.s.pri          -0x8
    push.pri  
    load.s.pri          -0xC
    pop.alt   
    neq       
    jzer           jump_0221
    load.s.pri          -0x8
    const.alt           0x20
    neq       
    jzer           jump_0221
    const.pri            0x1
    jump           jump_0223
 jump_0221:
    zero.pri  
 jump_0223:
    jzer           jump_0224
    line               0x3A6           0x0
    zero.pri  
    push.pri  
    load.s.pri          -0xC
    push.pri  
    load.s.pri          -0x8
    push.pri  
    push.c               0xC
    call             func_17
    line               0x3A7           0x0
    const.pri           -0x1
    stack                0xC
    retn      
 jump_0224:
    line               0x3A9           0x0
    load.s.pri          -0x8
    sref.s.pri          0x14
    line               0x3AA           0x0
    const.pri            0x2
    stack                0xC
    retn      
 jump_0220:
    stack                0xC
 jump_0216:
    line               0x3AE           0x0
    zero.pri  
    retn      
ENDP

INFO
    symbol       "DuplicateError"  global  COD  function
ENDI

PROC  func_17
    line               0x3B1           0x0
    symbol           "bMenu"  local  FRM  variable
    symbol           "Item2"  local  FRM  variable
    symbol           "Item1"  local  FRM  variable
    line               0x3B2           0x0
    symbol            "Data"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    line               0x3B3           0x0
    load.s.pri          0x14
    zero.alt  
    neq       
    jzer           jump_0225
    line               0x3B4           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri          0x10
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_139  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    jump           jump_0226
 jump_0225:
    line               0x3B6           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri          0x10
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri          0x10
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_140  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c              0x1C
    sysreq.c        snprintf
    stack               0x20
 jump_0226:
    line               0x3B8           0x0
    addr.pri          -0x190
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x190
    zero.pri  
    retn      
ENDP

INFO
    symbol       "ChangeStatusAll"  global  COD  function
ENDI

PROC  func_18
    line               0x3C0           0x0
    symbol         "Verbose"  local  FRM  variable
    symbol          "Status"  local  FRM  variable
    line               0x3C1           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x3C2           0x0
    load.s.pri          0x10
    jzer           jump_0227
    line               0x3C3           0x0
    load.s.pri           0xC
    const.alt            0x1
    eq        
    jzer           jump_0228
    line               0x3C4           0x0
    const.pri        str_141  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0227
 jump_0228:
    line               0x3C6           0x0
    const.pri        str_142  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0227:
    line               0x3C9           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0230
 jump_0232:
    line               0x3C9           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0230:
    load.s.pri          -0x4
    push.pri  
    const.pri           0x20
    pop.alt   
    xchg      
    sless     
    jzer           jump_0231
    line               0x3CA           0x0
    zero.pri  
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    push.pri  
    push.c               0xC
    call             func_21
    jump           jump_0232
 jump_0231:
    stack                0x4
    zero.pri  
    retn      
ENDP

INFO
    symbol       "ChangeStatusWeapons"  global  COD  function
ENDI

PROC  func_19
    line               0x3CE           0x0
    symbol         "Verbose"  local  FRM  variable
    symbol          "Status"  local  FRM  variable
    line               0x3CF           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x3D0           0x0
    load.s.pri          0x10
    jzer           jump_0233
    line               0x3D1           0x0
    load.s.pri           0xC
    const.alt            0x1
    eq        
    jzer           jump_0234
    line               0x3D2           0x0
    const.pri        str_143  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0233
 jump_0234:
    line               0x3D4           0x0
    const.pri        str_144  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0233:
    line               0x3D7           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0236
 jump_0238:
    line               0x3D7           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0236:
    load.s.pri          -0x4
    push.pri  
    const.pri    g_ItemIndexBegin  ;  ref to Array  
    const.alt           0x1C
    add       
    load.i    
    pop.alt   
    xchg      
    sless     
    jzer           jump_0237
    line               0x3D8           0x0
    zero.pri  
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    push.pri  
    push.c               0xC
    call             func_21
    jump           jump_0238
 jump_0237:
    stack                0x4
    zero.pri  
    retn      
ENDP

INFO
    symbol       "ChangeStatusMenu"  global  COD  function
ENDI

PROC  func_20
    line               0x3DC           0x0
    symbol         "Verbose"  local  FRM  variable
    symbol          "Status"  local  FRM  variable
    symbol            "Menu"  local  FRM  variable
    line               0x3DD           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x3DE           0x0
    load.s.pri          0x14
    jzer           jump_0239
    line               0x3DF           0x0
    symbol            "Text"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x194
    fill               0x190
    line               0x3E0           0x0
    load.s.pri          0x10
    const.alt            0x1
    eq        
    jzer           jump_0240
    line               0x3E1           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_145  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x194
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0241
 jump_0240:
    line               0x3E3           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_146  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x194
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
 jump_0241:
    line               0x3E5           0x0
    addr.pri          -0x194
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x190
 jump_0239:
    line               0x3E7           0x0
    const.pri    g_ItemIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri          -0x4
    jump           jump_0242
 jump_0244:
    line               0x3E7           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0242:
    load.s.pri          -0x4
    push.pri  
    const.pri    g_ItemIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    xchg      
    sless     
    jzer           jump_0243
    line               0x3E8           0x0
    zero.pri  
    push.pri  
    load.s.pri          0x10
    push.pri  
    load.s.pri          -0x4
    push.pri  
    push.c               0xC
    call             func_21
    jump           jump_0244
 jump_0243:
    stack                0x4
    zero.pri  
    retn      
ENDP

INFO
    symbol       "ChangeStatusItem"  global  COD  function
ENDI

PROC  func_21
    line               0x3EC           0x0
    symbol         "Verbose"  local  FRM  variable
    symbol          "Status"  local  FRM  variable
    symbol            "Item"  local  FRM  variable
    line               0x3EE           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    zero.alt  
    eq        
    jzer           jump_0245
    line               0x3EF           0x0
    zero.pri  
    retn      
 jump_0245:
    line               0x3F1           0x0
    load.s.pri          0x14
    jzer           jump_0246
    line               0x3F2           0x0
ENDP

INFO
    symbol            "Text"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    line               0x3F3           0x0
    load.s.pri          0x10
    push.pri  
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    neq       
    jzer           jump_0247
    line               0x3F4           0x0
    load.s.pri          0x10
    const.alt            0x1
    eq        
    jzer           jump_0248
    line               0x3F5           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_147  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0249
 jump_0248:
    line               0x3F7           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_148  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
 jump_0249:
    jump           jump_0250
 jump_0247:
    line               0x3FA           0x0
    load.s.pri          0x10
    const.alt            0x1
    eq        
    jzer           jump_0251
    line               0x3FB           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_149  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0250
 jump_0251:
    line               0x3FD           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_150  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
 jump_0250:
    line               0x400           0x0
    addr.pri          -0x190
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x190
 jump_0246:
    line               0x402           0x0
    load.s.pri          0x10
    push.pri  
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    neq       
    jzer           jump_0253
    line               0x403           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.s.pri          0x10
    pop.alt   
    stor.i    
    line               0x404           0x0
    load.s.pri          0x10
    const.alt            0x1
    eq        
    jzer           jump_0254
    line               0x405           0x0
    load.pri          0x1488
    inc               0x1488
    jump           jump_0253
 jump_0254:
    line               0x407           0x0
    load.pri          0x1488
    dec               0x1488
 jump_0253:
    zero.pri  
    retn      
    symbol       "ShowRestrictions"  global  COD  function
ENDI

PROC  func_22
    line               0x40C           0x0
    line               0x40D           0x0
    symbol        "enforced"  local  FRM  variable
    stack               -0x4
    const.pri        str_151  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    stor.s.pri          -0x4
    line               0x40E           0x0
    symbol           "admin"  local  FRM  variable
    stack               -0x4
    const.pri        var_002  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    move.pri  
    push.pri  
    const.pri           0x20
    push.pri  
    push.c               0x8
    sysreq.c          access
    stack                0xC
    heap                -0x4
    stor.s.pri          -0x8
    line               0x410           0x0
    load.s.pri          -0x4
    jnz            jump_0256
    load.s.pri          -0x8
    jnz            jump_0256
    zero.pri  
    jump           jump_0258
 jump_0256:
    const.pri            0x1
 jump_0258:
    jzer           jump_0259
    line               0x411           0x0
    const.pri        str_152  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x412           0x0
    const.pri            0x1
    push.pri  
    push.c               0x4
    call             func_23
    line               0x413           0x0
    const.pri            0x2
    push.pri  
    push.c               0x4
    call             func_23
    line               0x414           0x0
    const.pri            0x3
    push.pri  
    push.c               0x4
    call             func_23
    line               0x415           0x0
    const.pri            0x4
    push.pri  
    push.c               0x4
    call             func_23
    line               0x416           0x0
    const.pri            0x5
    push.pri  
    push.c               0x4
    call             func_23
    line               0x417           0x0
    const.pri            0x8
    push.pri  
    push.c               0x4
    call             func_23
    jump           jump_0260
 jump_0259:
    line               0x419           0x0
    const.pri        str_153  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0260:
    line               0x41B           0x0
    load.s.pri          -0x4
    not       
    jzer           jump_0261
    load.s.pri          -0x8
    jzer           jump_0261
    const.pri            0x1
    jump           jump_0263
 jump_0261:
    zero.pri  
 jump_0263:
    jzer           jump_0264
    line               0x41C           0x0
    const.pri        str_154  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x41D           0x0
    const.pri        str_155  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0264:
    line               0x41F           0x0
    load.s.pri          -0x4
    jzer           jump_0265
    line               0x420           0x0
    const.pri        str_156  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0266
 jump_0265:
    line               0x422           0x0
    const.pri        str_157  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0266:
    stack                0x8
    zero.pri  
    retn      
ENDP

INFO
    symbol       "ShowClass"  global  COD  function
ENDI

PROC  func_23
    line               0x427           0x0
    symbol           "class"  local  FRM  variable
    line               0x428           0x0
    symbol         "Message"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    line               0x429           0x0
    symbol       "TextRestricted"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x640
    fill               0x320
    line               0x42A           0x0
    symbol       "TextEnabled"  local  FRM  array
    stack             -0x320
    srange               0x0          0xC8
    zero.pri  
    addr.alt          -0x960
    fill               0x320
    line               0x42B           0x0
    symbol           "First"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri        -0x964
    line               0x42C           0x0
    symbol            "Last"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    stor.s.pri        -0x968
    line               0x42D           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x96C
    line               0x42F           0x0
    symbol       "RestrictedNum"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x970
    line               0x430           0x0
    symbol       "EnabledNum"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x974
    line               0x432           0x0
    load.s.pri        -0x964
    stor.s.pri        -0x96C
    jump           jump_0267
 jump_0274:
    line               0x432           0x0
    load.s.pri        -0x96C
    inc.s             -0x96C
 jump_0267:
    load.s.pri        -0x96C
    push.pri  
    load.s.pri        -0x968
    pop.alt   
    xchg      
    sleq      
    jzer           jump_0268
    line               0x433           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0x96C
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    load.i    
    jzer           jump_0269
    line               0x434           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x96C
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0270
    line               0x435           0x0
    load.s.pri        -0x970
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sgrtr     
    jzer           jump_0271
    line               0x436           0x0
    const.pri           0xC8
    push.pri  
    const.pri        str_158  ;  ref to String  
    push.pri  
    addr.pri          -0x640
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
 jump_0271:
    line               0x438           0x0
    load.s.pri        -0x970
    inc.s             -0x970
    line               0x439           0x0
    const.pri           0xC8
    push.pri  
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0x96C
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri          -0x640
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    jump           jump_0269
 jump_0270:
    line               0x43B           0x0
    load.s.pri        -0x974
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sgrtr     
    jzer           jump_0273
    line               0x43C           0x0
    const.pri           0xC8
    push.pri  
    const.pri        str_159  ;  ref to String  
    push.pri  
    addr.pri          -0x960
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
 jump_0273:
    line               0x43E           0x0
    const.pri           0xC8
    push.pri  
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0x96C
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri          -0x960
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    line               0x43F           0x0
    load.s.pri        -0x974
    inc.s             -0x974
 jump_0269:
    jump           jump_0274
 jump_0268:
    line               0x443           0x0
    load.s.pri        -0x974
    zero.alt  
    eq        
    jzer           jump_0275
    line               0x444           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_160  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0276
 jump_0275:
    line               0x445           0x0
    load.s.pri        -0x970
    zero.alt  
    eq        
    jzer           jump_0277
    line               0x446           0x0
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_161  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0276
 jump_0277:
    line               0x447           0x0
    load.s.pri        -0x974
    push.pri  
    load.s.pri        -0x970
    pop.alt   
    xchg      
    sless     
    jzer           jump_0279
    line               0x448           0x0
    addr.pri          -0x640
    push.pri  
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_162  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    jump           jump_0276
 jump_0279:
    line               0x44A           0x0
    addr.pri          -0x960
    push.pri  
    const.pri    g_MenuNames  ;  ref to MultiArray  
    push.pri  
    load.s.pri           0xC
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_163  ;  ref to String  
    push.pri  
    const.pri           0xC8
    push.pri  
    addr.pri          -0x320
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
 jump_0276:
    line               0x44C           0x0
    addr.pri          -0x320
    push.pri  
    addr.pri          -0x320
    load.i    
    push.pri  
    push.c               0x4
    sysreq.c         toupper
    stack                0x8
    pop.alt   
    stor.i    
    line               0x44D           0x0
    addr.pri          -0x320
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x974
    zero.pri  
    retn      
ENDP

INFO
    symbol       "RestrictMenu"  global  COD  function
ENDI

PROC  RestrictMenu
    line               0x454           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x455           0x0
    load.s.pri          0x18
    not       
    jzer           jump_0281
    line               0x456           0x0
    const.pri        str_164  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x457           0x0
    const.pri           -0x1
    retn      
 jump_0281:
    line               0x458           0x0
    push.c               0x0
    call             func_26
    zero.alt  
    eq        
    jzer           jump_0282
    line               0x459           0x0
    const.pri        str_165  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x45A           0x0
    const.pri        str_166  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x45B           0x0
    const.pri        str_167  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    line               0x45C           0x0
    const.pri           -0x1
    retn      
 jump_0282:
    line               0x45E           0x0
    load.s.pri          0x18
    push.pri  
    push.c               0x4
    call             func_28
    line               0x45F           0x0
    const.pri           -0x1
    retn      
ENDP

INFO
    symbol       "plugin_connect"  global  COD  function
ENDI

PROC  plugin_connect
    line               0x462           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol            "HLIP"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    line               0x463           0x0
    load.s.pri          0x14
    zero.alt  
    xchg      
    sless     
    push.pri  
    move.pri  
    push.pri  
    const.pri           0x21
    pop.alt   
    xchg      
    sless     
    swap.alt  
    and       
    pop.alt   
    jzer           jump_0283
    line               0x464           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x14
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
 jump_0283:
    line               0x466           0x0
    const.pri            0x1
    retn      
ENDP

INFO
    symbol       "plugin_disconnect"  global  COD  function
ENDI

PROC  plugin_disconnect
    line               0x469           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    line               0x46A           0x0
    load.s.pri          0x10
    zero.alt  
    xchg      
    sless     
    push.pri  
    move.pri  
    push.pri  
    const.pri           0x21
    pop.alt   
    xchg      
    sless     
    swap.alt  
    and       
    pop.alt   
    jzer           jump_0284
    line               0x46B           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x10
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
 jump_0284:
    line               0x46D           0x0
    const.pri            0x1
    retn      
ENDP

INFO
    symbol             "buy"  global  COD  function
ENDI

PROC  buy
    line               0x470           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x471           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri            0xB
    pop.alt   
    stor.i    
    line               0x472           0x0
    const.pri            0x1
    retn      
ENDP

INFO
    symbol        "buyequip"  global  COD  function
ENDI

PROC  buyequip
    line               0x475           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x476           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri            0x8
    pop.alt   
    stor.i    
    line               0x477           0x0
    const.pri            0x1
    retn      
ENDP

INFO
    symbol       "ClearMenu"  global  COD  function
ENDI

PROC  ClearMenu
    line               0x47A           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x47B           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
    line               0x47C           0x0
    const.pri            0x1
    retn      
ENDP

INFO
    symbol       "menuselect"  global  COD  function
ENDI

PROC  menuselect
    line               0x47F           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x480           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    zero.alt  
    neq       
    jzer           jump_0285
    line               0x481           0x0
    symbol            "Data"  static  DAT  array
    srange               0x0          0xC8
    line               0x482           0x0
    symbol       "SelectedNumber"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x483           0x0
    const.pri           0xC8
    push.pri  
    const.pri           Data  ;  ref to Array  
    push.pri  
    load.s.pri          0x10
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x484           0x0
    const.pri           Data  ;  ref to Array  
    push.pri  
    push.c               0x4
    call             func_07
    line               0x485           0x0
    const.pri            0x2
    push.pri  
    const.pri        str_168  ;  ref to String  
    push.pri  
    const.pri           Data  ;  ref to Array  
    push.pri  
    push.c               0xC
    sysreq.c         strtrim
    stack               0x10
    line               0x486           0x0
    addr.pri            -0x4
    push.pri  
    const.pri           Data  ;  ref to Array  
    push.pri  
    push.c               0x8
    call             func_24
    zero.alt  
    eq        
    jnz            jump_0286
    load.s.pri          -0x4
    push.pri  
    const.pri            0x1
    pop.alt   
    xchg      
    sless     
    jnz            jump_0287
    load.s.pri          -0x4
    push.pri  
    const.pri            0xA
    pop.alt   
    xchg      
    sgrtr     
    jnz            jump_0287
    zero.pri  
    jump           jump_0289
 jump_0287:
    const.pri            0x1
 jump_0289:
    jnz            jump_0286
    zero.pri  
    jump           jump_0291
 jump_0286:
    const.pri            0x1
 jump_0291:
    jzer           jump_0292
    line               0x488           0x0
    const.pri           -0x1
    stack                0x4
    retn      
 jump_0292:
    line               0x48A           0x0
    load.s.pri          -0x4
    const.alt            0xA
    eq        
    jzer           jump_0293
    line               0x48C           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sless     
    jzer           jump_0294
    line               0x48D           0x0
    load.s.pri          0x18
    push.pri  
    push.c               0x4
    call             func_28
    line               0x48E           0x0
    const.pri           -0x1
    stack                0x4
    retn      
 jump_0294:
    line               0x490           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
    jump           jump_0295
 jump_0293:
    line               0x492           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0xC
    eq        
    jzer           jump_0296
    line               0x493           0x0
    load.s.pri          -0x4
    push.pri  
    load.s.pri          0x18
    push.pri  
    push.c               0x8
    call             func_29
    line               0x494           0x0
    const.pri           -0x1
    stack                0x4
    retn      
 jump_0296:
    line               0x495           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    zero.pri  
    pop.alt   
    xchg      
    sless     
    jzer           jump_0297
    line               0x496           0x0
ENDP

INFO
    symbol            "Menu"  local  FRM  variable
    stack               -0x4
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    neg       
    stor.s.pri          -0x8
    line               0x497           0x0
    symbol       "IndexOfFirstItemInMenu"  local  FRM  variable
    stack               -0x4
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri          -0x8
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri          -0xC
    line               0x498           0x0
    load.pri           0x238
    const.alt            0x1
    neq       
    jzer           jump_0298
    line               0x499           0x0
    load.s.pri          -0x4
    const.alt            0x9
    eq        
    jzer           jump_0299
    line               0x49A           0x0
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0300
    line               0x49B           0x0
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    zero.pri  
    pop.alt   
    stor.i    
    jump           jump_0301
 jump_0300:
    line               0x49D           0x0
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    stor.i    
 jump_0301:
    jump           jump_0302
 jump_0299:
    line               0x4A0           0x0
    symbol           "Order"  local  FRM  variable
    stack               -0x4
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri         -0x10
    line               0x4A1           0x0
    symbol            "Item"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    load.s.pri         -0x10
    bounds               0x2
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0xC
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri         -0x14
    line               0x4A2           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri         -0x14
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0303
    line               0x4A3           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri         -0x14
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_169  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c     plugin_exec
    stack                0xC
    jump           jump_0304
 jump_0303:
    line               0x4A5           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri         -0x14
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_170  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c     plugin_exec
    stack                0xC
 jump_0304:
    stack                0x8
 jump_0302:
    jump           jump_0305
 jump_0298:
    line               0x4A9           0x0
    symbol            "Item"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0xC
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri         -0x10
    line               0x4AA           0x0
    load.s.pri         -0x10
    const.alt           0x20
    eq        
    jzer           jump_0306
    line               0x4AB           0x0
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0xC
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri         -0x10
 jump_0306:
    line               0x4AD           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri         -0x10
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0307
    line               0x4AE           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri         -0x10
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_171  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c     plugin_exec
    stack                0xC
    jump           jump_0308
 jump_0307:
    line               0x4B0           0x0
    const.pri    g_ClientCommands1  ;  ref to MultiArray  
    push.pri  
    load.s.pri         -0x10
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_172  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c     plugin_exec
    stack                0xC
 jump_0308:
    stack                0x4
 jump_0305:
    line               0x4B3           0x0
    load.s.pri          -0x8
    push.pri  
    load.s.pri          0x18
    push.pri  
    push.c               0x8
    call             func_29
    line               0x4B4           0x0
    const.pri           -0x1
    stack                0xC
    retn      
 jump_0297:
    line               0x4B5           0x0
    load.pri          0x1488
    jzer           jump_0309
    const.pri        str_173  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    jzer           jump_0309
    const.pri            0x1
    jump           jump_0311
 jump_0309:
    zero.pri  
 jump_0311:
    jzer           jump_0295
    line               0x4B6           0x0
    symbol        "UserName"  static  DAT  array
    srange               0x0          0x21
    line               0x4B7           0x0
    const.pri           0x21
    push.pri  
    const.pri       UserName  ;  ref to Array  
    push.pri  
    load.s.pri          0x14
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x4B8           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0xB
    eq        
    jzer           jump_0313
    line               0x4B9           0x0
    load.s.pri          -0x4
    const.alt            0x7
    eq        
    jnz            jump_0314
    load.s.pri          -0x4
    const.alt            0x6
    eq        
    jnz            jump_0314
    load.s.pri          -0x4
    const.alt            0x9
    eq        
    jnz            jump_0314
    zero.pri  
    jump           jump_0317
 jump_0314:
    const.pri            0x1
 jump_0317:
    jzer           jump_0318
    line               0x4BA           0x0
    const.pri        str_174  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    jzer           jump_0319
    line               0x4BB           0x0
    const.pri        str_175  ;  ref to String  
    push.pri  
    const.pri       UserName  ;  ref to Array  
    push.pri  
    push.c               0x8
    sysreq.c      execclient
    stack                0xC
 jump_0319:
    jump           jump_0320
 jump_0318:
    line               0x4BE           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    stor.i    
 jump_0320:
    jump           jump_0295
 jump_0313:
    line               0x4C2           0x0
    load.pri           0x238
    const.alt            0x1
    neq       
    jzer           jump_0322
    line               0x4C3           0x0
    const.pri        str_176  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    jzer           jump_0322
    line               0x4C4           0x0
    const.pri        str_177  ;  ref to String  
    push.pri  
    const.pri       UserName  ;  ref to Array  
    push.pri  
    push.c               0x8
    sysreq.c      execclient
    stack                0xC
 jump_0322:
    line               0x4C7           0x0
    symbol       "IndexOfFirstItemInMenu"  local  FRM  variable
    stack               -0x4
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri          -0x8
    line               0x4C8           0x0
    symbol       "IndexOfFirstItemInNextMenu"  local  FRM  variable
    stack               -0x4
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    const.pri         0x12F0
    push.pri  
    load.s.pri          0x18
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri          -0xC
    line               0x4C9           0x0
    load.s.pri          -0x4
    push.pri  
    load.s.pri          -0xC
    push.pri  
    load.s.pri          -0x8
    pop.alt   
    sub.alt   
    pop.alt   
    xchg      
    sleq      
    jzer           jump_0324
    line               0x4CA           0x0
    symbol            "Team"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri         -0x10
    line               0x4CB           0x0
    addr.pri           -0x10
    push.pri  
    const.pri       UserName  ;  ref to Array  
    push.pri  
    push.c               0x8
    sysreq.c     get_userTeam
    stack                0xC
    line               0x4CC           0x0
    const.pri            0x2
    push.pri  
    const.pri            0x1
    push.pri  
    load.s.pri         -0x10
    push.pri  
    push.c               0xC
    sysreq.c           clamp
    stack               0x10
    stor.s.pri         -0x10
    line               0x4CD           0x0
    symbol            "Item"  local  FRM  variable
    stack               -0x4
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    load.s.pri         -0x10
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x2
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x8
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri         -0x14
    line               0x4CE           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri         -0x14
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0325
    line               0x4CF           0x0
    const.pri            0x1
    push.pri  
    const.pri        str_178  ;  ref to String  
    push.pri  
    const.pri       UserName  ;  ref to Array  
    push.pri  
    push.c               0xC
    sysreq.c       messageex
    stack               0x10
    line               0x4D0           0x0
    const.pri           -0x1
    stack               0x14
    retn      
 jump_0325:
    stack                0x8
 jump_0324:
    stack                0x8
 jump_0295:
    stack                0x4
 jump_0285:
    line               0x4D6           0x0
    const.pri            0x1
    retn      
    symbol       "IsNumeric"  global  COD  function
ENDI

PROC  func_24
    line               0x4D9           0x0
    symbol             "num"  local  FRM  variable_ptr
    symbol          "string"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x4DA           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x4DB           0x0
    symbol               "n"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x8
    line               0x4DC           0x0
    load.s.pri           0xC
    load.i    
    zero.alt  
    eq        
    jzer           jump_0326
    line               0x4DD           0x0
    zero.pri  
    stack                0x8
    retn      
 jump_0326:
    line               0x4DF           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0327
 jump_0331:
    line               0x4DF           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0327:
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    zero.alt  
    neq       
    jzer           jump_0328
    line               0x4E0           0x0
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt           0x30
    xchg      
    sleq      
    push.pri  
    move.pri  
    push.pri  
    const.pri           0x39
    pop.alt   
    xchg      
    sleq      
    swap.alt  
    and       
    pop.alt   
    jzer           jump_0329
    line               0x4E1           0x0
    load.s.pri          -0x8
    const.alt            0xA
    smul      
    stor.s.pri          -0x8
    line               0x4E2           0x0
    load.s.pri          -0x8
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    const.pri           0x30
    pop.alt   
    sub.alt   
    pop.alt   
    add       
    stor.s.pri          -0x8
    jump           jump_0330
 jump_0329:
    line               0x4E4           0x0
    zero.pri  
    stack                0x8
    retn      
 jump_0330:
    jump           jump_0331
 jump_0328:
    line               0x4E7           0x0
    load.s.pri          -0x8
    sref.s.pri          0x10
    line               0x4E8           0x0
    const.pri            0x1
    stack                0x8
    retn      
ENDP

INFO
    symbol       "GetVersion"  global  COD  function
ENDI

PROC  func_25
    line               0x4F0           0x0
    line               0x4F1           0x0
    symbol            "data"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    line               0x4F2           0x0
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    const.pri        str_179  ;  ref to String  
    push.pri  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    line               0x4F3           0x0
    const.pri        str_181  ;  ref to String  
    push.pri  
    const.pri        str_180  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c       setstrvar
    stack                0xC
    line               0x4F4           0x0
    const.pri        str_182  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    const.alt            0x1
    eq        
    jzer           jump_0332
    line               0x4F5           0x0
    addr.pri          -0x190
    push.pri  
    const.pri        str_183  ;  ref to String  
    push.pri  
    push.c               0x8
    sysreq.c       setstrvar
    stack                0xC
    line               0x4FB           0x0
    const.pri            0x2
    stack              0x190
    retn      
 jump_0332:
    line               0x4FD           0x0
    const.pri            0x1
    stack              0x190
    retn      
ENDP

INFO
    symbol       "IsMenuEnabled"  global  COD  function
ENDI

PROC  func_26
    line               0x500           0x0
    line               0x501           0x0
    symbol            "data"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    line               0x502           0x0
    const.pri           0x64
    push.pri  
    addr.pri          -0x190
    push.pri  
    const.pri        str_184  ;  ref to String  
    push.pri  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    line               0x503           0x0
    const.pri        str_185  ;  ref to String  
    push.pri  
    addr.pri          -0x190
    push.pri  
    push.c               0x8
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    neq       
    jzer           jump_0333
    line               0x504           0x0
    const.pri            0x1
    stack              0x190
    retn      
 jump_0333:
    line               0x506           0x0
    zero.pri  
    stack              0x190
    retn      
ENDP

INFO
    symbol       "strtolower"  global  COD  function
ENDI

PROC  func_27
    line               0x509           0x0
    symbol          "String"  local  FRM  array_ptr
    srange               0x0           0x0
    line               0x50A           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    line               0x50B           0x0
    zero.pri  
    stor.s.pri          -0x4
    jump           jump_0334
 jump_0336:
    line               0x50B           0x0
    load.s.pri          -0x4
    inc.s               -0x4
 jump_0334:
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    jzer           jump_0335
    line               0x50C           0x0
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    push.pri  
    load.s.pri          -0x4
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    push.pri  
    push.c               0x4
    sysreq.c         tolower
    stack                0x8
    pop.alt   
    stor.i    
    jump           jump_0336
 jump_0335:
    stack                0x4
    zero.pri  
    retn      
ENDP

INFO
    symbol       "DrawMainMenu"  global  COD  function
ENDI

PROC  func_28
    line               0x513           0x0
    symbol       "UserIndex"  local  FRM  variable
    line               0x514           0x0
    symbol        "UserName"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt           -0x84
    fill                0x84
    line               0x515           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri            0xC
    pop.alt   
    stor.i    
    line               0x516           0x0
    const.pri        var_005  ;  ref to Variable  
    heap                0x9C
    movs                 0x4
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri           0x21
    push.pri  
    addr.pri           -0x84
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c              0x20
    sysreq.c      playerinfo
    stack               0x24
    heap               -0xAC
    line               0x517           0x0
    load.pri           0x238
    const.alt            0x1
    neq       
    jzer           jump_0337
    line               0x518           0x0
    symbol           "iTeam"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri         -0x88
    line               0x519           0x0
    addr.pri           -0x88
    push.pri  
    addr.pri           -0x84
    push.pri  
    push.c               0x8
    sysreq.c     get_userTeam
    stack                0xC
    line               0x51A           0x0
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    const.pri            0x1
    push.pri  
    zero.pri  
    push.pri  
    load.s.pri         -0x88
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    push.pri  
    push.c               0xC
    sysreq.c           clamp
    stack               0x10
    pop.alt   
    stor.i    
    stack                0x4
 jump_0337:
    line               0x51C           0x0
    zero.pri  
    push.pri  
    const.pri          0x29F
    push.pri  
    const.pri        str_186  ;  ref to String  
    push.pri  
    addr.pri           -0x84
    push.pri  
    push.c              0x10
    sysreq.c            menu
    stack               0x14
    stack               0x84
    zero.pri  
    retn      
ENDP

INFO
    symbol       "DrawSubMenu"  global  COD  function
ENDI

PROC  func_29
    line               0x51F           0x0
    symbol            "Menu"  local  FRM  variable
    symbol       "UserIndex"  local  FRM  variable
    line               0x520           0x0
    symbol        "Menutext"  local  FRM  array
    stack             -0x800
    srange               0x0         0x200
    zero.pri  
    addr.alt          -0x800
    fill               0x800
    line               0x521           0x0
    symbol            "Text"  local  FRM  array
    stack             -0x190
    srange               0x0          0x64
    zero.pri  
    addr.alt          -0x990
    fill               0x190
    line               0x522           0x0
    symbol        "UserName"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt          -0xA14
    fill                0x84
    line               0x523           0x0
    symbol               "i"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA18
    symbol               "j"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA1C
    symbol               "k"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA20
    line               0x524           0x0
    symbol            "Keys"  local  FRM  variable
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA24
    line               0x525           0x0
    symbol         "Keymask"  local  FRM  variable
    stack               -0x4
    const.pri            0x1
    stor.s.pri        -0xA28
    line               0x526           0x0
    const.pri    g_SubMenuTitles  ;  ref to MultiArray  
    push.pri  
    load.s.pri          0x10
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x8
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    const.pri        str_187  ;  ref to String  
    push.pri  
    const.pri          0x200
    push.pri  
    addr.pri          -0x800
    push.pri  
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    line               0x527           0x0
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri          0x10
    push.pri  
    const.pri            0x1
    pop.alt   
    sub.alt   
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri        -0xA18
    jump           jump_0338
 jump_0347:
    line               0x527           0x0
    load.s.pri        -0xA18
    inc.s             -0xA18
 jump_0338:
    load.s.pri        -0xA18
    push.pri  
    const.pri    g_MenuEntriesIndexBegin  ;  ref to Array  
    push.pri  
    load.s.pri          0x10
    bounds               0x9
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    pop.alt   
    xchg      
    sless     
    jzer           jump_0339
    line               0x528           0x0
    load.s.pri        -0xA1C
    inc.s             -0xA1C
    line               0x529           0x0
    load.pri           0x238
    const.alt            0x1
    eq        
    jzer           jump_0340
    line               0x52A           0x0
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0xA18
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri        -0xA20
    line               0x52B           0x0
    load.s.pri        -0xA20
    const.alt           0x20
    eq        
    jzer           jump_0341
    line               0x52C           0x0
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    const.alt            0x4
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0xA18
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri        -0xA20
 jump_0341:
    jump           jump_0342
 jump_0340:
    line               0x52F           0x0
    const.pri    g_ItemIndexByKeys  ;  ref to MultiArray  
    push.pri  
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    bounds               0x2
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0xA18
    bounds              0x1D
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    stor.s.pri        -0xA20
    line               0x530           0x0
    load.s.pri        -0xA20
    const.alt           0x20
    eq        
    jzer           jump_0342
    line               0x531           0x0
    jump           jump_0339
 jump_0342:
    line               0x534           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0xA20
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0345
    line               0x535           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0xA20
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri          -0xA1C
    push.pri  
    const.pri        str_188  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x990
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    jump           jump_0346
 jump_0345:
    line               0x537           0x0
    const.pri     g_ItemName  ;  ref to MultiArray  
    push.pri  
    load.s.pri        -0xA20
    bounds              0x20
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    addr.pri          -0xA1C
    push.pri  
    const.pri        str_189  ;  ref to String  
    push.pri  
    const.pri           0x64
    push.pri  
    addr.pri          -0x990
    push.pri  
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
 jump_0346:
    line               0x539           0x0
    const.pri          0x200
    push.pri  
    addr.pri          -0x990
    push.pri  
    addr.pri          -0x800
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    line               0x53A           0x0
    load.s.pri        -0xA24
    push.pri  
    load.s.pri        -0xA28
    pop.alt   
    or        
    stor.s.pri        -0xA24
    line               0x53B           0x0
    load.s.pri        -0xA28
    push.pri  
    const.pri            0x1
    pop.alt   
    xchg      
    shl       
    stor.s.pri        -0xA28
    jump           jump_0347
 jump_0339:
    line               0x53D           0x0
    load.pri           0x238
    const.alt            0x1
    neq       
    jzer           jump_0348
    line               0x53E           0x0
    const.pri    g_UserMenuOrder  ;  ref to Array  
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    zero.alt  
    eq        
    jzer           jump_0349
    line               0x53F           0x0
    const.pri          0x200
    push.pri  
    const.pri        str_190  ;  ref to String  
    push.pri  
    addr.pri          -0x800
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    jump           jump_0350
 jump_0349:
    line               0x541           0x0
    const.pri          0x200
    push.pri  
    const.pri        str_191  ;  ref to String  
    push.pri  
    addr.pri          -0x800
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
 jump_0350:
    line               0x543           0x0
    load.s.pri        -0xA24
    const.alt          0x100
    or        
    stor.s.pri        -0xA24
 jump_0348:
    line               0x545           0x0
    const.pri          0x200
    push.pri  
    const.pri        str_192  ;  ref to String  
    push.pri  
    addr.pri          -0x800
    push.pri  
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    line               0x546           0x0
    load.s.pri        -0xA24
    const.alt          0x200
    or        
    stor.s.pri        -0xA24
    line               0x547           0x0
    const.pri        var_005  ;  ref to Variable  
    heap                0x9C
    movs                 0x4
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri            0x0
    heap                 0x4
    stor.i    
    move.pri  
    push.pri  
    const.pri           0x21
    push.pri  
    addr.pri          -0xA14
    push.pri  
    load.s.pri           0xC
    push.pri  
    push.c              0x20
    sysreq.c      playerinfo
    stack               0x24
    heap               -0xAC
    line               0x548           0x0
    const.pri         0x12F0
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    push.pri  
    load.s.pri          0x10
    neg       
    pop.alt   
    stor.i    
    line               0x549           0x0
    zero.pri  
    push.pri  
    load.s.pri        -0xA24
    push.pri  
    addr.pri          -0x800
    push.pri  
    addr.pri          -0xA14
    push.pri  
    push.c              0x10
    sysreq.c            menu
    stack               0x14
    stack              0xA28
    zero.pri  
    retn      
ENDP

INFO
    symbol       "buy_glock"  global  COD  function
ENDI

PROC  buy_glock
    line               0x54C           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x54D           0x0
    load.s.pri          0x14
    push.pri  
    zero.pri  
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol         "buy_usp"  global  COD  function
ENDI

PROC  buy_usp
    line               0x550           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x551           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x1
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_p228"  global  COD  function
ENDI

PROC  buy_p228
    line               0x554           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x555           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x2
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_deagle"  global  COD  function
ENDI

PROC  buy_deagle
    line               0x558           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x559           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x3
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_elites"  global  COD  function
ENDI

PROC  buy_elites
    line               0x55C           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x55D           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x4
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_fn57"  global  COD  function
ENDI

PROC  buy_fn57
    line               0x560           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x561           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x5
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol          "buy_m3"  global  COD  function
ENDI

PROC  buy_m3
    line               0x564           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x565           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x6
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_xm1014"  global  COD  function
ENDI

PROC  buy_xm1014
    line               0x568           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x569           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x7
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_mac10"  global  COD  function
ENDI

PROC  buy_mac10
    line               0x56C           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x56D           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x8
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol         "buy_mp5"  global  COD  function
ENDI

PROC  buy_mp5
    line               0x570           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x571           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0x9
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_ump45"  global  COD  function
ENDI

PROC  buy_ump45
    line               0x574           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x575           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0xA
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol         "buy_p90"  global  COD  function
ENDI

PROC  buy_p90
    line               0x578           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x579           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0xB
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol         "buy_tmp"  global  COD  function
ENDI

PROC  buy_tmp
    line               0x57C           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x57D           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0xC
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_galil"  global  COD  function
ENDI

PROC  buy_galil
    line               0x580           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x581           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0xD
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_ak47"  global  COD  function
ENDI

PROC  buy_ak47
    line               0x584           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x585           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0xE
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_scout"  global  COD  function
ENDI

PROC  buy_scout
    line               0x588           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x589           0x0
    load.s.pri          0x14
    push.pri  
    const.pri            0xF
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_sg552"  global  COD  function
ENDI

PROC  buy_sg552
    line               0x58C           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x58D           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x10
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol         "buy_awp"  global  COD  function
ENDI

PROC  buy_awp
    line               0x590           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x591           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x11
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_g3sg1"  global  COD  function
ENDI

PROC  buy_g3sg1
    line               0x594           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x595           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x12
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_famas"  global  COD  function
ENDI

PROC  buy_famas
    line               0x598           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x599           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x13
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol         "buy_aug"  global  COD  function
ENDI

PROC  buy_aug
    line               0x59C           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x59D           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x14
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_m4a1"  global  COD  function
ENDI

PROC  buy_m4a1
    line               0x5A0           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5A1           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x15
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_sg550"  global  COD  function
ENDI

PROC  buy_sg550
    line               0x5A4           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5A5           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x16
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_m249"  global  COD  function
ENDI

PROC  buy_m249
    line               0x5A8           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5A9           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x17
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_vest"  global  COD  function
ENDI

PROC  buy_vest
    line               0x5AC           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5AD           0x0
    load.s.pri          0x14
    push.pri  
    const.pri        str_001  ;  ref to String  
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_vesthelm"  global  COD  function
ENDI

PROC  buy_vesthelm
    line               0x5B0           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5B1           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x19
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_flash"  global  COD  function
ENDI

PROC  buy_flash
    line               0x5B4           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5B5           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x1A
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_hegren"  global  COD  function
ENDI

PROC  buy_hegren
    line               0x5B8           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5B9           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x1B
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_sgren"  global  COD  function
ENDI

PROC  buy_sgren
    line               0x5BC           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5BD           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x1C
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_defuser"  global  COD  function
ENDI

PROC  buy_defuser
    line               0x5C0           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5C1           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x1D
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_nvgs"  global  COD  function
ENDI

PROC  buy_nvgs
    line               0x5C4           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5C5           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x1E
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol       "buy_shield"  global  COD  function
ENDI

PROC  buy_shield
    line               0x5C8           0x0
    symbol       "UserIndex"  local  FRM  variable
    symbol       "HLUserName"  local  FRM  variable
    symbol          "HLData"  local  FRM  variable
    symbol       "HLCommand"  local  FRM  variable
    line               0x5C9           0x0
    load.s.pri          0x14
    push.pri  
    const.pri           0x1F
    push.pri  
    push.c               0x8
    call             func_30
    retn      
ENDP

INFO
    symbol        "buy_item"  global  COD  function
ENDI

PROC  func_30
    line               0x5CC           0x0
    symbol       "HLUserName"  local  FRM  variable
    symbol           "iItem"  local  FRM  variable
    line               0x5CD           0x0
    const.pri    g_ItemRestricted  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    bounds              0x21
    shl.c.pri            0x2
    pop.alt   
    add       
    load.i    
    const.alt            0x1
    eq        
    jzer           jump_0351
    const.pri        str_193  ;  ref to String  
    push.pri  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    jzer           jump_0351
    const.pri            0x1
    jump           jump_0353
 jump_0351:
    zero.pri  
 jump_0353:
    jzer           jump_0354
    line               0x5CE           0x0
    symbol            "User"  local  FRM  array
    stack              -0x84
    srange               0x0          0x21
    zero.pri  
    addr.alt           -0x84
    fill                0x84
    line               0x5CF           0x0
    const.pri           0x21
    push.pri  
    addr.pri           -0x84
    push.pri  
    load.s.pri          0x10
    push.pri  
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    line               0x5D0           0x0
    const.pri            0x1
    push.pri  
    const.pri        str_194  ;  ref to String  
    push.pri  
    addr.pri           -0x84
    push.pri  
    push.c               0xC
    sysreq.c       messageex
    stack               0x10
    line               0x5D1           0x0
    const.pri           -0x1
    stack               0x84
    retn      
 jump_0354:
    line               0x5D3           0x0
    const.pri            0x1
    retn      
ENDP


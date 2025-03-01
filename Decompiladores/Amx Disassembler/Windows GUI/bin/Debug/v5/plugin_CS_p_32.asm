
.PUBLIC
    buy_glock
    buy_mac10
    buy_sg552
    ChangeMap
    set_cvar
    buy_fn57
    buy_galil
    buy_m4a1
    buy_defuser
    buyequip
    buy_vest
    buy_p228
    buy_ump45
    buy_g3sg1
    buy_flash
    HandleRestartVote
    plugin_init
    admin_restartround
    buy_xm1014
    buy_scout
    buy_m249
    buy_shield
    menuselect
    buy_elites
    buy_tmp
    buy_aug
    buy_sgren
    plugin_connect
    admin_vote_restart
    plugin_disconnect
    buy_usp
    buy_mp5
    buy_awp
    buy_vesthelm
    buy
    ClearMenu
    admin_changeteam
    SetRestrictions
    buy_m3
    buy_ak47
    buy_sg550
    RestrictMenu
    buy_nvgs
    buy_deagle
    buy_p90
    buy_famas
    buy_hegren

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
    str_000 string !"%s %s"
    str_001 string !"Command: %s used command %s %s"
    str_002 string !"admin_reject_msg"
    str_003 string !"You do not have access to this command."
    str_004 string !"admin_quiet"
    str_005 string !"Admin"
    str_006 string !"admin_ignore_immunity"
    str_007 string !"2.50.14"
    var_000 variable ( 0x0 )
    mul_000 multiarray 9 - 
        variable ( 0x0 )
        string !"pistols"
        string !"shotguns"
        string !"smg"
        string !"rifles"
        string !"machine guns"
        variable ( 0x0 )
        variable ( 0x0 )
        string !"equipment"

    mul_001 multiarray 32 - 
        string !"9x19mm Sidearm"
        string !"K&M .45 Tactical"
        string !"228 Compact"
        string !"Night Hawk .50C"
        string !".40 Dual Elites"
        string !"ES Five-Seven"
        string !"Leone 12 Gauge Super"
        string !"Leone YG1265 Auto Shotgun"
        string !"Ingram MAC-10"
        string !"K&M Sub-Machine Gun"
        string !"K&M UMP45"
        string !"ES C90"
        string !"Schmidt Machine Pistol"
        string !"IDF Defender"
        string !"CV-47"
        string !"Schmidt Scout"
        string !"Krieg 552 Commando"
        string !"Magnum Sniper Rifle"
        string !"D3/AU-1 Semi-Auto Sniper Rifle"
        string !"Clarion 5.56"
        string !"Bullpup"
        string !"Maverick M4A1 Carabine"
        string !"Krieg 550 Commando"
        string !"ES M249 Para"
        string !"Kevlar Vest"
        string !"Kevlar Vest & Helmet"
        string !"Flashbang"
        string !"HE Grenade"
        string !"Smoke Grenade"
        string !"Defuse Kit"
        string !"NightVision Goggles"
        string !"Tactical Shield"

    mul_002 multiarray 32 - 
        string !"glock"
        string !"usp"
        string !"p228"
        string !"deagle"
        string !"elites"
        string !"fn57"
        string !"m3"
        string !"xm1014"
        string !"mac10"
        string !"mp5"
        string !"ump45"
        string !"p90"
        string !"tmp"
        string !"galil"
        string !"ak47"
        string !"scout"
        string !"sg552"
        string !"awp"
        string !"g3sg1"
        string !"famas"
        string !"aug"
        string !"m4a1"
        string !"sg550"
        string !"m249"
        string !"vest"
        string !"vesthelm"
        string !"flash"
        string !"hegren"
        string !"sgren"
        string !"defuser"
        string !"nvgs"
        string !"shield"

    mul_003 multiarray 32 - 
        string !"9x19mm"
        string !"km45"
        string !"229compact"
        string !"nighthawk"
        variable ( 0x0 )
        string !"fiveseven"
        string !"12gauge"
        string !"autoshotgun"
        variable ( 0x0 )
        string !"smg"
        variable ( 0x0 )
        string !"c90"
        string !"mp"
        string !"defender"
        string !"cv47"
        variable ( 0x0 )
        string !"krieg552"
        string !"magnum"
        string !"d3au1"
        string !"clarion"
        string !"bullup"
        variable ( 0x0 )
        string !"krieg550"
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )
        variable ( 0x0 )

    mul_004 multiarray 2 33 
        array 33 fill 0x0
        array 33 fill 0x0

    arr_000 array 42 
        ( 0x0 , 0x6 , 0x8 , 0xD , 0x17 , 0x18 , 0x18 , 0x18 , 0x20 , 0x0 , 
        0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 
        0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 
        0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 0x0 , 
        0x0 , 0x0 )
    mul_005 multiarray 2 29 
        array 29 
            ( 0x0 , 0x1 , 0x2 , 0x3 , 0x4 , 0x6 , 0x7 , 0x8 , 0x9 , 0xA , 
            0xB , 0xD , 0xE , 0xF , 0x10 , 0x11 , 0x12 , 0x17 , 0x18 , 0x19 , 
            0x1A , 0x1B , 0x1C , 0x1E , 0x20 , 0x20 , 0x20 , 0x20 , 0x20 )
        array 29 
            ( 0x0 , 0x1 , 0x2 , 0x3 , 0x5 , 0x6 , 0x7 , 0xC , 0x9 , 0xA , 
            0xB , 0x13 , 0xF , 0x15 , 0x14 , 0x16 , 0x11 , 0x17 , 0x18 , 0x19 , 
            0x1A , 0x1B , 0x1C , 0x1D , 0x1E , 0x1F , 0x20 , 0x20 , 0x20 )

    arr_001 array 10 ( 0x0 , 0x5 , 0x7 , 0xB , 0x11 , 0x12 , 0x12 , 0x12 , 0x1A , 0x0 )
    mul_006 multiarray 8 - 
        string !"Handgun^n(Secondary weapon)"
        string !"Shotgun^n(Primary weapon)"
        string !"Sub-Machine Gun^n(Primary weapon)"
        string !"Rifle^n(Primary weapon)"
        string !"Machine Gun^n(Primary weapon)"
        variable ( 0x0 )
        variable ( 0x0 )
        string !"Equipment"

    arr_002 array 33 fill 0x0
    mul_007 multiarray 23 - 
        string !"autokick"
        string !"autoteambalance"
        string !"buytime"
        string !"c4timer"
        string !"chattime"
        string !"consistency"
        string !"fadetoblack"
        string !"flashlight"
        string !"footsteps"
        string !"forcecamera"
        string !"forcechasecam"
        string !"freezetime"
        string !"ghostfrequency"
        string !"hostagepenalty"
        string !"limitteams"
        string !"kickpercent"
        string !"maxrounds"
        string !"mapvoteratio"
        string !"playerid"
        string !"roundtime"
        string !"startmoney"
        string !"tkpunish"
        string !"winlimit"

    mul_008 multiarray 23 - 
        string !"admin_autokick <1 or 0>: mp_autokick on or off"
        string !"admin_autoteambalance <#>: setting for mp_autoteambalance"
        string !"admin_buytime <#>: setting for mp_buytime"
        string !"admin_c4timer <#>: setting for mp_c4timer"
        string !"admin_chattime <#>: setting for mp_chattime"
        string !"admin_consistency <#>: setting for mp_consistency"
        string !"admin_fadetoblack <1 or 0>: mp_fadetoblack on or off"
        string !"admin_flashlight <1 or 0>: mp_flashlight on or off"
        string !"admin_footsteps <1 or 0>: mp_footsteps on or off"
        string !"admin_forcecamera <#>: setting for mp_forcecamera"
        string !"admin_forcechasecam <#>: setting for mp_forcechasecam"
        string !"admin_freezetime <#>: setting for mp_freezetime"
        string !"admin_ghostfrequency <#>: setting for mp_ghostfrequency"
        string !"admin_hpenalty <#>: setting for mp_hostagepenalty"
        string !"admin_limitteams <1 or 0>: mp_limitteams on or off"
        string !"admin_kickpercent <#>: setting for mp_kickpercent"
        string !"admin_maxrounds <#>: setting for mp_maxrounds"
        string !"admin_mapvoteratio <#>: setting for mp_mapvoteratio"
        string !"admin_playerid <#>: setting for mp_playerid"
        string !"admin_roundtime <#>: setting for mp_roundtime"
        string !"admin_startmoney <800/16000>: setting for mp_startmoney"
        string !"admin_tkpunish <1 or 0>: mp_tkpunish on or off"
        string !"admin_winlimit <#>: setting for mp_winlimit"

    str_008 string !"Counter-Strike Plugin"
    str_009 string !"Team change / Restart Round / Weapons Restrictions"
    str_010 string !"admin_ct"
    str_011 string !"admin_changeteam"
    str_012 string !"admin_ct <target>: Changes target to the counter-terrorist team."
    str_013 string !"admin_t"
    str_014 string !"admin_changeteam"
    str_015 string !"admin_t <target>: Changes target to the terrorist team."
    str_016 string !"admin_vote_restart"
    str_017 string !"admin_vote_restart"
    str_018 string !"admin_vote_restart: Starts a vote to restart the round."
    str_019 string !"admin_restartround"
    str_020 string !"admin_restartround"
    str_021 string !"admin_restartround <seconds>: Restarts the round."
    str_022 string !"admin_restart"
    str_023 string !"admin_restartround"
    str_024 string !"admin_restart <seconds>: Restarts the round."
    str_025 string !"admin_%s"
    str_026 string !"set_cvar"
    str_027 string !"admin_restrict"
    str_028 string !"SetRestrictions"
    str_029 string !"admin_restrict: Control restrictions - admin_restrict help for details."
    str_030 string !"admin_unrestrict"
    str_031 string !"SetRestrictions"
    str_032 string !"admin_unrestrict: Control restrictions - admin_unrestrict help for details."
    str_033 string !"admin_restrictmenu"
    str_034 string !"RestrictMenu"
    str_035 string !"admin_restrictmenu: Displays menu for changing weaponrestrictions."
    str_036 string !"buy"
    str_037 string !"buy"
    var_001 variable ( 0x0 )
    str_038 string !"buyequip"
    str_039 string !"buyequip"
    str_040 string !"menuselect"
    str_041 string !"menuselect"
    str_042 string !"radio1"
    str_043 string !"ClearMenu"
    str_044 string !"radio2"
    str_045 string !"ClearMenu"
    str_046 string !"radio3"
    str_047 string !"ClearMenu"
    str_048 string !"chooseteam"
    str_049 string !"ClearMenu"
    str_050 string !"buy_"
    arr_003 array 9 ( 0x0 , 0x6 , 0x8 , 0xD , 0x15 , 0x16 , 0x16 , 0x16 , 0x1D )
    mul_009 multiarray 2 29 
        array 29 
            ( 0x1 , 0x0 , 0x3 , 0x2 , 0x4 , 0x20 , 0x6 , 0x7 , 0x9 , 0x20 , 
            0xB , 0x8 , 0xA , 0xE , 0x10 , 0x20 , 0x20 , 0xF , 0x11 , 0x12 , 
            0x20 , 0x17 , 0x18 , 0x19 , 0x1A , 0x1B , 0x1C , 0x20 , 0x1E )
        array 29 
            ( 0x1 , 0x0 , 0x3 , 0x2 , 0x20 , 0x5 , 0x6 , 0x7 , 0x9 , 0xC , 
            0xB , 0x20 , 0xA , 0x20 , 0x20 , 0x15 , 0x14 , 0xF , 0x11 , 0x20 , 
            0x16 , 0x17 , 0x18 , 0x19 , 0x1A , 0x1B , 0x1C , 0x1D , 0x1E )

    str_051 string !"WeaponRestrictions_"
    str_052 string !"Map-specific saved weapon restrictions found."
    str_053 string !"WeaponRestrictions"
    str_054 string !"Default saved weapon restrictions found."
    str_055 string !"No saved weapon restrictions found."
    str_056 string !"admin_cs_restrict"
    str_057 string !"Saved restrictions will not take effect while admin_cs_restrict is 0."
    str_058 string !"allow_client_exec"
    str_059 string !"You cannot use this command because allow_client_exec is 0."
    str_060 string !"Unrecognized player: "
    str_061 string !"Laf. You can't move %s onto another team, you silly bear."
    str_062 string !"admin_ct"
    str_063 string !"chooseteam;menuselect 2"
    str_064 string !"chooseteam;menuselect 1"
    str_065 string !"sv_restartround"
    str_066 string !"map_ratio"
    str_067 string !"Restart vote is not enabled"
    str_068 string !"Vote not allowed at this time."
    str_069 string !"Restart map & begin play?"
    str_070 string !"Yes"
    str_071 string !"No"
    str_072 string !"HandleRestartVote"
    var_002 variable ( 0x0 )
    str_073 string !"map_ratio"
    str_074 string !"Not enough votes for map restart"
    str_075 string !"mp_timelimit"
    str_076 string !"mp_timelimit"
    str_077 string !"sv_restartround"
    str_078 string !"10"
    str_079 string !"Map restart vote succeeded."
    str_080 string !"Map restart vote failed."
    str_081 string !"mp_%s"
    var_003 variable ( 0x0 )
    str_082 string !"You cannot change the value of %s.^nType %s to view current setting."
    str_083 string !"%s is currently set to %s"
    str_084 string !"You do not have access to modify weapon restrictions."
    str_085 string !"Type admin_restrict to see current restrictions."
    str_086 string !"help"
    str_087 string !"on"
    str_088 string !"admin_cs_restrict"
    str_089 string !"admin_cs_restrict"
    str_090 string !"1"
    str_091 string !"Weapon restrictions have been enabled."
    str_092 string !"Weapon restriction functions are now enabled, but no weapons are"
    str_093 string !"currenty marked as restricted. Use the admin_restrict command to"
    str_094 string !"select which weapons to restrict."
    str_095 string !"Weapon restrictions already are enabled."
    str_096 string !"off"
    str_097 string !"admin_cs_restrict"
    str_098 string !"admin_cs_restrict"
    str_099 string !"0"
    str_100 string !"Weapon restrictions have been disabled."
    str_101 string !"Weapon restrictions already are disabled."
    str_102 string !"restore"
    str_103 string !"Weapon restrictions have been reset to default."
    str_104 string !"save "
    str_105 string !"map"
    str_106 string !"default"
    str_107 string !"all"
    str_108 string !"weapons"
    str_109 string !"menu "
    str_110 string !"There is no menu with this number."
    str_111 string !"The data you supplied was invalid. Type "admin_restrict help" to view a help-text."
    str_112 string !"The data you supplied was invalid. Type "admin_unrestrict help" to view a help-text."
    str_113 string !"admin_cs_restrict"
    str_114 string !"Restriction configured. This will take effect when you use admin_restrict on"
    str_115 string !"admin_restrict usage:"
    str_116 string !"admin_restrict: Show current restrictions"
    str_117 string !"admin_restrict on: Enable restrictions"
    str_118 string !"admin_restrict off: Disable restrictions"
    str_119 string !"admin_restrict save default: Save current restrictions as server default"
    str_120 string !"admin_restrict save map: Save current restrictions for this map"
    str_121 string !"admin_restrict restore: Restore saved (map-)defaults"
    var_004 variable ( 0x0 )
    str_122 string !"admin_restrict all: Restrict all weapons and equipment."
    str_123 string !"admin_restrict weapons: Restrict all weapons."
    str_124 string !"admin_restrict menu <menu name or number>: Restrict menu."
    str_125 string !"admin_restrict <item name>: Restrict item."
    str_126 string !"admin_restrict <menu number> <item number>: Restrict item."
    str_127 string !"admin_unrestrict usage:"
    str_128 string !"admin_unrestrict all: Allow all weapons and equipment."
    str_129 string !"admin_unrestrict weapons: Allow all weapons."
    str_130 string !"admin_unrestrict menu <menu name or number>: Allow menu."
    str_131 string !"admin_unrestrict <item name>: Allow item."
    str_132 string !"admin_unrestrict <menu number> <item number>: Allow item."
    var_005 variable ( 0x0 )
    str_133 string !"All weapon / menu names can be entered as unique substring. Valid are all"
    str_134 string !"names that are used in buy menu or console. You cannot restrict ammunition."
    str_135 string !"Note that restrictions by numbers only are accepted if the numbers"
    str_136 string !"are the same for T and CT."
    str_137 string !"WeaponRestrictions"
    str_138 string !"_"
    str_139 string !" "
    str_140 string !"The data supplied matches both '%s' and '%s'"
    str_141 string !"The data supplied matches both '%s' (%s) and '%s' (%s)"
    str_142 string !"All items restricted"
    str_143 string !"All items enabled"
    str_144 string !"All weapons restricted"
    str_145 string !"All weapons enabled"
    str_146 string !"All items from menu %s restricted"
    str_147 string !"All items from menu %s enabled"
    str_148 string !"Item %s restricted"
    str_149 string !"Item %s enabled"
    str_150 string !"Item %s already is restricted"
    str_151 string !"Item %s already is enabled"
    str_152 string !"admin_cs_restrict"
    str_153 string !"^nCurrent weapon restrictions:^n"
    str_154 string !"^nNo weapon restrictions are currently in force."
    str_155 string !"^nNOTE: Weapon restrictions are not currently enforced."
    str_156 string !"To enforce them use the command: admin_restict on"
    str_157 string !"^nNOTE: Further weapon restrictions may be hard coded into this map."
    str_158 string !"^nNOTE: Some weapon restrictions may be hard coded into this map."
    str_159 string !", "
    str_160 string !", "
    str_161 string !"%s: All restricted"
    str_162 string !"%s: All available"
    str_163 string !"%s: %s restricted"
    str_164 string !"%s: Only %s available"
    str_165 string !"This command cannot be used from console."
    str_166 string !"This command cannot be used, because menues are disabled on this server."
    str_167 string !"Menues currently only have beta-status and need to get enabled by setting"
    str_168 string !"amv_enable_beta to "menu1" in the adminmod.cfg."
    arr_004 array 200 fill 0x0
    str_169 string !" "
    str_170 string !"admin_unrestrict"
    str_171 string !"admin_restrict"
    str_172 string !"admin_unrestrict"
    str_173 string !"admin_restrict"
    str_174 string !"admin_cs_restrict"
    arr_005 array 33 fill 0x0
    str_175 string !"allow_client_exec"
    str_176 string !"menuselect 10"
    str_177 string !"allow_client_exec"
    str_178 string !"menuselect 10"
    str_179 string !"Item currently not allowed"
    str_180 string !"sv_region"
    str_181 string !"sv_region"
    str_182 string !"1"
    str_183 string !"sv_region"
    str_184 string !"sv_region"
    str_185 string !"amv_enable_beta"
    str_186 string !"menu1"
    var_006 variable ( 0x0 )
    str_187 string !"\yRestrict Item\w^n^n1. Handgun^n2. Shotgun^n3. Sub-Machine Gun^n4. Rifle^n5. Machine Gun^n^n6. Primary weapon ammo^n7. Secondary weapon ammo^n^n8. Equipment^n^n0. Exit"
    str_188 string !"\y Restrict %s^n"
    str_189 string !"^n\w%i. \r%s"
    str_190 string !"^n\w%i. %s"
    str_191 string !"^n^n\w9. \ySwitch to CT Layout"
    str_192 string !"^n^n\w9. \ySwitch to Terrorist Layout"
    str_193 string !"^n^n\w0. Back"
    str_194 string !"admin_cs_restrict"
    str_195 string !"Item currently not allowed"


.CODE

PROC  func_00
    stack             -0x320
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    push.c               0x0
    push.s              0x18
    push.s              0x10
    push.s               0xC
    push.c              0x10
    call             func_05
    push.s              0x18
    push.s              0x14
    push.c               0x0
    push.c              0xC8
    pushaddr          -0x320
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    push.c               0x1
    pushaddr          -0x320
    push.c           str_001  ;  ref to String  
    sysreq.c            exec
    stack                0xC
    stack              0x320
    zero.pri  
    retn      
ENDP

PROC  func_01
    push.s              0x14
    push.s              0x10
    push.s               0xC
    push.c           str_001  ;  ref to String  
    push.c              0xC8
    push.s              0x18
    push.c              0x18
    sysreq.c        snprintf
    stack               0x1C
    zero.pri  
    retn      
ENDP

PROC  func_02
    stack             -0x320
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    pushaddr          -0x320
    push.s              0x14
    push.s              0x10
    push.s               0xC
    push.c              0x10
    call             func_01
    pushaddr          -0x320
    push.c               0x4
    sysreq.c             log
    stack                0x8
    stack              0x320
    zero.pri  
    retn      
ENDP

PROC  func_03
    stack               -0x4
    const.pri            0x1
    stor.s.pri          -0x4
    stack               -0x4
    const.pri            0x1
    stor.s.pri          -0x8
    stack               -0x4
    zero.pri  
    stor.s.pri          -0xC
    load.s.pri           0xC
    zero.alt  
    jneq           jump_0000
    push.s              0x10
    load.s.pri          -0xC
    inc.s               -0xC
    pop.alt   
    idxaddr   
    move.alt  
    const.pri           0x30
    stor.i    
    push.s              0x10
    load.s.pri          -0xC
    inc.s               -0xC
    pop.alt   
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
    jump           jump_0001
 jump_0000:
    push.s               0xC
    zero.pri  
    pop.alt   
    xchg      
    jsgeq          jump_0002
    push.s              0x10
    load.s.pri          -0xC
    inc.s               -0xC
    pop.alt   
    idxaddr   
    move.alt  
    const.pri           0x2D
    stor.i    
    load.s.pri           0xC
    smul.c              -0x1
    stor.s.pri           0xC
 jump_0002:
    load.s.alt          -0x4
    load.s.pri           0xC
    xchg      
    jsgrtr         jump_0003
    load.s.pri          -0x4
    smul.c               0xA
    stor.s.pri          -0x4
    inc.s               -0x8
    jump           jump_0002
 jump_0003:
    dec.s               -0x8
    push.s              -0x8
    zero.pri  
    pop.alt   
    xchg      
    jsleq          jump_0005
    load.s.alt          -0x4
    const.pri            0xA
    sdiv.alt  
    stor.s.pri          -0x4
    push.s              0x10
    load.s.pri          -0xC
    inc.s               -0xC
    pop.alt   
    idxaddr   
    push.pri  
    push.s               0xC
    load.s.alt           0xC
    load.s.pri          -0x4
    sdiv.alt  
    move.pri  
    pop.alt   
    sub.alt   
    move.alt  
    load.s.pri          -0x4
    sdiv.alt  
    add.c               0x30
    pop.alt   
    stor.i    
    load.s.alt           0xC
    load.s.pri          -0x4
    sdiv.alt  
    move.pri  
    stor.s.pri           0xC
    jump           jump_0003
 jump_0005:
    push.s              0x10
    load.s.pri          -0xC
    inc.s               -0xC
    pop.alt   
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
 jump_0001:
    stack                0xC
    zero.pri  
    retn      
ENDP

PROC  func_04
    stack             -0x320
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    push.c              0xC8
    pushaddr          -0x320
    push.c           str_002  ;  ref to String  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    pushaddr          -0x320
    push.c               0x4
    sysreq.c          strlen
    stack                0x8
    move.alt  
    const.pri            0x2
    xchg      
    jsgeq          jump_0007
    push.c              0xC8
    push.c           str_003  ;  ref to String  
    pushaddr          -0x320
    push.c               0xC
    sysreq.c          strcpy
    stack               0x10
 jump_0007:
    load.s.pri           0xC
    zero.alt  
    jneq           jump_0008
    pushaddr          -0x320
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0009
 jump_0008:
    pushaddr          -0x320
    push.c               0x4
    sysreq.c             say
    stack                0x8
 jump_0009:
    stack              0x320
    zero.pri  
    retn      
ENDP

PROC  func_05
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    stack             -0x320
    zero.pri  
    addr.alt          -0x324
    fill               0x320
    push.c           str_004  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    stor.s.pri          -0x4
    load.s.pri          -0x4
    zero.alt  
    jneq           jump_0010
    pushaddr          -0x324
    push.s              0x14
    push.s              0x10
    push.s               0xC
    push.c              0x10
    call             func_01
    pushaddr          -0x324
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0011
 jump_0010:
    load.s.pri          -0x4
    eq.c.pri             0x1
    jnz            jump_0012
    load.s.pri          0x18
    eq.c.pri             0x1
    jnz            jump_0012
    zero.pri  
    jump           jump_0014
 jump_0012:
    const.pri            0x1
 jump_0014:
    jzer           jump_0015
    pushaddr          -0x324
    push.s              0x14
    push.s              0x10
    push.c           str_005  ;  ref to String  
    push.c              0x10
    call             func_01
    pushaddr          -0x324
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0011
 jump_0015:
    push.s              0x14
    push.s              0x10
    push.s               0xC
    push.c               0xC
    call             func_02
 jump_0011:
    stack              0x324
    zero.pri  
    retn      
ENDP

PROC  func_06
    push.s               0xC
    zero.pri  
    pop.alt   
    stor.i    
    zero.pri  
    retn      
ENDP

PROC  func_07
    stack               -0x4
    push.s               0xC
    push.c               0x4
    sysreq.c          strlen
    stack                0x8
    stor.s.pri          -0x4
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x8
    load.s.pri          -0x4
    zero.alt  
    jneq           jump_0017
    zero.pri  
    stack                0x8
    retn      
 jump_0017:
    push.s               0xC
    load.s.alt          -0x4
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri            0x22
    jzer           jump_0018
    push.s               0xC
    dec.s               -0x4
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
 jump_0018:
    load.s.pri           0xC
    load.i    
    eq.c.pri            0x22
    jzer           jump_0019
    zero.s              -0x8
    jump           jump_0020
 jump_0022:
    inc.s               -0x8
 jump_0020:
    load.s.alt          -0x8
    load.s.pri          -0x4
    xchg      
    jsgrtr         jump_0021
    push.s               0xC
    load.s.pri          -0x8
    pop.alt   
    idxaddr   
    push.pri  
    push.s               0xC
    load.s.pri          -0x8
    add.c                0x1
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    stor.i    
    jump           jump_0022
 jump_0021:
    push.s               0xC
    load.s.alt          -0x8
    const.pri            0x2
    sub.alt   
    pop.alt   
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
 jump_0019:
    stack                0x8
    zero.pri  
    retn      
ENDP

PROC  func_08
    push.c           str_006  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    jeq            jump_0023
    zero.pri  
    retn      
 jump_0023:
    push.s               0xC
    push.c            0x1000
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    zero.alt  
    jeq            jump_0024
    const.pri            0x1
    retn      
 jump_0024:
    zero.pri  
    retn      
ENDP

PROC  ChangeMap
    stack              -0x84
    zero.pri  
    addr.alt           -0x84
    fill                0x84
    push.c              0x21
    pushaddr           -0x84
    push.s              0x18
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    pushaddr           -0x84
    push.c               0x4
    sysreq.c          strlen
    stack                0x8
    zero.alt  
    jeq            jump_0025
    push.c              -0x1
    pushaddr           -0x84
    push.c           str_001  ;  ref to String  
    sysreq.c     changelevel
    stack                0xC
 jump_0025:
    stack               0x84
    zero.pri  
    retn      
ENDP

PROC  plugin_init
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    push.c           str_007  ;  ref to String  
    push.c           str_009  ;  ref to String  
    push.c           str_008  ;  ref to String  
    push.c               0xC
    sysreq.c     plugin_registerinfo
    stack               0x10
    push.c           str_012  ;  ref to String  
    push.c              0x80
    push.c           str_011  ;  ref to String  
    push.c           str_010  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    push.c           str_015  ;  ref to String  
    push.c              0x80
    push.c           str_014  ;  ref to String  
    push.c           str_013  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    push.c           str_018  ;  ref to String  
    push.c               0x1
    push.c           str_017  ;  ref to String  
    push.c           str_016  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    push.c           str_021  ;  ref to String  
    push.c               0x2
    push.c           str_020  ;  ref to String  
    push.c           str_019  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    push.c           str_024  ;  ref to String  
    push.c               0x2
    push.c           str_023  ;  ref to String  
    push.c           str_022  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    stack             -0x320
    zero.pri  
    addr.alt          -0x324
    fill               0x320
    zero.s              -0x4
    jump           jump_0026
 jump_0028:
    inc.s               -0x4
 jump_0026:
    load.s.alt          -0x4
    const.pri           0x17
    xchg      
    jsgeq          jump_0027
    const.alt        mul_007  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_025  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x324
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    const.alt        mul_008  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x0
    push.c           str_026  ;  ref to String  
    pushaddr          -0x324
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    jump           jump_0028
 jump_0027:
    push.c           str_029  ;  ref to String  
    push.c               0x0
    push.c           str_028  ;  ref to String  
    push.c           str_027  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    push.c           str_032  ;  ref to String  
    push.c              0x20
    push.c           str_031  ;  ref to String  
    push.c           str_030  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    push.c           str_035  ;  ref to String  
    push.c              0x20
    push.c           str_034  ;  ref to String  
    push.c           str_033  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_037  ;  ref to String  
    push.c           str_036  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_039  ;  ref to String  
    push.c           str_038  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_041  ;  ref to String  
    push.c           str_040  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_043  ;  ref to String  
    push.c           str_042  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_045  ;  ref to String  
    push.c           str_044  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_047  ;  ref to String  
    push.c           str_046  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    push.c           str_049  ;  ref to String  
    push.c           str_048  ;  ref to String  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    push.c               0x0
    call             func_25
    stor.pri            0x98
    load.pri            0x98
    const.alt            0x1
    jeq            jump_0029
    stack              -0x78
    zero.pri  
    addr.alt          -0x39C
    fill                0x78
    zero.s              -0x4
    jump           jump_0030
 jump_0033:
    inc.s               -0x4
 jump_0030:
    load.s.alt          -0x4
    const.pri           0x20
    xchg      
    jsgeq          jump_0031
    push.c              0x1E
    push.c           str_050  ;  ref to String  
    pushaddr          -0x39C
    push.c               0xC
    sysreq.c          strcpy
    stack               0x10
    push.c              0x1E
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr          -0x39C
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    pushaddr          -0x39C
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c              0x10
    sysreq.c     plugin_registercmd
    stack               0x14
    heap                -0x4
    const.alt        mul_003  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0032
    const.pri        var_001  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c               0x0
    pushaddr          -0x39C
    const.alt        mul_003  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
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
    const.pri        mul_001  ;  ref to MultiArray  
    add.c               0x34
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_001  ;  ref to MultiArray  
    add.c               0x4C
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_001  ;  ref to MultiArray  
    add.c               0x7C
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_002  ;  ref to MultiArray  
    add.c               0x34
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_002  ;  ref to MultiArray  
    add.c               0x4C
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_002  ;  ref to MultiArray  
    add.c               0x7C
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_003  ;  ref to MultiArray  
    add.c               0x34
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_003  ;  ref to MultiArray  
    add.c               0x4C
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    const.pri        mul_003  ;  ref to MultiArray  
    add.c               0x7C
    move.alt  
    load.i    
    add       
    push.pri  
    push.c               0x4
    call             func_06
    push.c           arr_001  ;  ref to Array  
    const.pri        arr_003  ;  ref to Array  
    pop.alt   
    movs                0x24
    stack              -0xF0
    const.pri        mul_009  ;  ref to MultiArray  
    addr.alt          -0x414
    movs                0xF0
    zero.s              -0x4
    jump           jump_0035
 jump_0037:
    inc.s               -0x4
 jump_0035:
    load.s.alt          -0x4
    const.pri           0x1D
    xchg      
    jsgeq          jump_0036
    const.pri        mul_005  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    push.pri  
    addr.pri          -0x414
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    stor.i    
    const.pri        mul_005  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    push.pri  
    addr.pri          -0x414
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    stor.i    
    jump           jump_0037
 jump_0036:
    stack               0xF0
 jump_0034:
    stack              -0x84
    zero.pri  
    addr.alt          -0x3A8
    fill                0x84
    stack             -0x190
    zero.pri  
    addr.alt          -0x538
    fill               0x190
    stack             -0x190
    zero.pri  
    addr.alt          -0x6C8
    fill               0x190
    push.c           str_004  ;  ref to String  
    pushaddr          -0x538
    push.c           str_001  ;  ref to String  
    sysreq.c      currentmap
    stack                0xC
    push.c           str_004  ;  ref to String  
    push.c           str_051  ;  ref to String  
    pushaddr          -0x6C8
    push.c               0xC
    sysreq.c          strcpy
    stack               0x10
    push.c           str_004  ;  ref to String  
    pushaddr          -0x538
    pushaddr          -0x6C8
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    push.c              0x21
    pushaddr          -0x3A8
    pushaddr          -0x6C8
    push.c               0xC
    sysreq.c     get_vaultdata
    stack               0x10
    jzer           jump_0038
    push.c           str_052  ;  ref to String  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
    jump           jump_0039
 jump_0038:
    push.c              0x21
    pushaddr          -0x3A8
    push.c           str_053  ;  ref to String  
    push.c               0xC
    sysreq.c     get_vaultdata
    stack               0x10
    jzer           jump_0040
    push.c           str_054  ;  ref to String  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
    jump           jump_0039
 jump_0040:
    push.c           str_055  ;  ref to String  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
 jump_0039:
    addr.pri          -0x3A8
    load.i    
    zero.alt  
    jeq            jump_0042
    zero.s              -0x4
    jump           jump_0043
 jump_0046:
    inc.s               -0x4
 jump_0043:
    load.s.alt          -0x4
    const.pri           0x20
    xchg      
    jsgeq          jump_0042
    addr.alt          -0x3A8
    load.s.pri          -0x4
    lidx      
    eq.c.pri            0x31
    jzer           jump_0045
    push.c               0x1
    push.c               0x1
    push.s              -0x4
    push.c               0xC
    call             func_21
    const.pri        mul_004  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    move.alt  
    const.pri            0x1
    stor.i    
 jump_0045:
    jump           jump_0046
 jump_0042:
    load.pri           0x938
    jzer           jump_0047
    push.c           str_056  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    jneq           jump_0047
    const.pri            0x1
    jump           jump_0049
 jump_0047:
    zero.pri  
 jump_0049:
    jzer           jump_0050
    push.c           str_057  ;  ref to String  
    push.c               0x4
    sysreq.c     plugin_message
    stack                0x8
 jump_0050:
    const.pri            0x1
    stack              0x6C8
    retn      
ENDP

PROC  admin_changeteam
    stack              -0x78
    zero.pri  
    addr.alt           -0x78
    fill                0x78
    stack             -0x320
    zero.pri  
    addr.alt          -0x398
    fill               0x320
    stack              -0x84
    zero.pri  
    addr.alt          -0x41C
    fill                0x84
    stack             -0x320
    zero.pri  
    addr.alt          -0x73C
    fill               0x320
    stack              -0x84
    zero.pri  
    addr.alt          -0x7C0
    fill                0x84
    push.c              0x21
    pushaddr           -0x78
    push.s               0xC
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0x21
    pushaddr          -0x398
    push.s              0x10
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0x21
    pushaddr          -0x7C0
    push.s              0x14
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c           str_058  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    not       
    jzer           jump_0051
    push.c           str_059  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0052
 jump_0051:
    pushaddr          -0x398
    push.c               0x4
    sysreq.c      check_user
    stack                0x8
    not       
    jzer           jump_0053
    push.c           str_060  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    pushaddr          -0x398
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0052
 jump_0053:
    push.c              0x21
    pushaddr          -0x41C
    pushaddr          -0x398
    push.c               0xC
    sysreq.c     get_username
    stack               0x10
    pushaddr          -0x41C
    push.c               0x4
    call             func_08
    zero.alt  
    jeq            jump_0055
    pushaddr          -0x41C
    push.c           str_061  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x73C
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    push.c               0x2
    pushaddr          -0x73C
    pushaddr          -0x7C0
    push.c               0xC
    sysreq.c       messageex
    stack               0x10
    jump           jump_0052
 jump_0055:
    push.c               0x0
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr          -0x7C0
    push.c              0x10
    call             func_05
    push.c           str_062  ;  ref to String  
    pushaddr           -0x78
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    not       
    jzer           jump_0057
    push.c           str_063  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c      execclient
    stack                0xC
    jump           jump_0052
 jump_0057:
    push.c           str_064  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c      execclient
    stack                0xC
 jump_0052:
    const.pri           -0x1
    stack              0x7C0
    retn      
ENDP

PROC  admin_restartround
    stack              -0x78
    zero.pri  
    addr.alt           -0x78
    fill                0x78
    stack             -0x320
    zero.pri  
    addr.alt          -0x398
    fill               0x320
    stack              -0x84
    zero.pri  
    addr.alt          -0x41C
    fill                0x84
    push.c              0x1E
    pushaddr           -0x78
    push.s               0xC
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0xC8
    pushaddr          -0x398
    push.s              0x10
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0x21
    pushaddr          -0x41C
    push.s              0x14
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    pushaddr          -0x398
    push.c           str_065  ;  ref to String  
    pushaddr           -0x78
    pushaddr          -0x41C
    push.c              0x10
    call             func_00
    const.pri           -0x1
    stack              0x41C
    retn      
ENDP

PROC  admin_vote_restart
    push.c           str_066  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    jneq           jump_0059
    push.c           str_067  ;  ref to String  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0060
 jump_0059:
    push.c               0x0
    sysreq.c     vote_allowed
    stack                0x4
    zero.alt  
    jneq           jump_0061
    push.c           str_068  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0060
 jump_0061:
    push.c           var_002  ;  ref to Variable  
    push.c           str_072  ;  ref to String  
    push.c           str_071  ;  ref to String  
    push.c           str_070  ;  ref to String  
    push.c           str_069  ;  ref to String  
    push.c              0x14
    sysreq.c            vote
    stack               0x18
 jump_0060:
    const.pri           -0x1
    retn      
ENDP

PROC  HandleRestartVote
    load.s.pri           0xC
    eq.c.pri             0x1
    jzer           jump_0063
    stack               -0x4
    push.c           str_073  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    stor.s.pri          -0x4
    push.s              0x14
    load.s.alt          -0x4
    const.pri        str_004  ;  ref to String  
    sdiv.alt  
    move.alt  
    load.s.pri          0x18
    smul      
    pop.alt   
    xchg      
    jsgeq          jump_0064
    push.c           str_074  ;  ref to String  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    jump           jump_0065
 jump_0064:
    stack              -0x50
    zero.pri  
    addr.alt           -0x54
    fill                0x50
    pushaddr           -0x54
    push.c           str_075  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    smul.c              0x3C
    push.pri  
    push.c               0x1
    push.c               0x4
    sysreq.c        timeleft
    stack                0x8
    pop.alt   
    sub.alt   
    add.c                0xA
    move.alt  
    const.pri        str_003  ;  ref to String  
    sdiv.alt  
    push.pri  
    push.c           str_001  ;  ref to String  
    call             func_03
    pushaddr           -0x54
    push.c           str_076  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c       setstrvar
    stack                0xC
    push.c           str_078  ;  ref to String  
    push.c           str_077  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c       setstrvar
    stack                0xC
    push.c           str_079  ;  ref to String  
    push.c               0x4
    sysreq.c             say
    stack                0x8
    stack               0x50
 jump_0065:
    stack                0x4
    jump           jump_0066
 jump_0063:
    push.c           str_080  ;  ref to String  
    push.c               0x4
    sysreq.c             say
    stack                0x8
 jump_0066:
    zero.pri  
    retn      
ENDP

PROC  set_cvar
    stack             -0x320
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    stack              -0x78
    zero.pri  
    addr.alt          -0x398
    fill                0x78
    stack             -0x320
    zero.pri  
    addr.alt          -0x6B8
    fill               0x320
    stack              -0x84
    zero.pri  
    addr.alt          -0x73C
    fill                0x84
    stack              -0x78
    zero.pri  
    addr.alt          -0x7B4
    fill                0x78
    push.c              0x1E
    pushaddr          -0x398
    push.s               0xC
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0xC8
    pushaddr          -0x6B8
    push.s              0x10
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0x21
    pushaddr          -0x73C
    push.s              0x14
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    addr.pri          -0x398
    add.c               0x18
    push.pri  
    push.c           str_081  ;  ref to String  
    push.c              0x1E
    pushaddr          -0x7B4
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    addr.pri          -0x6B8
    load.i    
    zero.alt  
    jeq            jump_0067
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c             0x200
    push.c           str_001  ;  ref to String  
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
    pushaddr          -0x6B8
    pushaddr          -0x7B4
    pushaddr          -0x398
    pushaddr          -0x73C
    push.c              0x10
    call             func_00
    jump           jump_0071
 jump_0070:
    addr.pri          -0x6B8
    load.i    
    zero.alt  
    jeq            jump_0072
    pushaddr          -0x398
    pushaddr          -0x7B4
    push.c           str_082  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x6B8
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    pushaddr          -0x6B8
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0071
 jump_0072:
    push.c              0xC8
    pushaddr          -0x6B8
    pushaddr          -0x7B4
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    pushaddr          -0x6B8
    pushaddr          -0x7B4
    push.c           str_083  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x320
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    pushaddr          -0x320
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0071:
    const.pri           -0x1
    stack              0x7B4
    retn      
ENDP

PROC  SetRestrictions
    stack              -0x78
    zero.pri  
    addr.alt           -0x78
    fill                0x78
    stack              -0x84
    zero.pri  
    addr.alt           -0xFC
    fill                0x84
    stack             -0x320
    zero.pri  
    addr.alt          -0x41C
    fill               0x320
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x420
    push.c              0x1E
    pushaddr           -0x78
    push.s               0xC
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0xC8
    pushaddr          -0x41C
    push.s              0x10
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c              0x21
    pushaddr           -0xFC
    push.s              0x14
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    pushaddr          -0x41C
    push.c               0x4
    call             func_07
    pushaddr          -0x41C
    push.c               0x4
    call             func_27
    addr.pri           -0x78
    add.c               0x18
    load.i    
    push.pri  
    push.c               0x4
    sysreq.c         tolower
    stack                0x8
    eq.c.pri            0x72
    jzer           jump_0074
    const.pri            0x1
    stor.s.pri        -0x420
    jump           jump_0075
 jump_0074:
    zero.s            -0x420
 jump_0075:
    addr.pri          -0x41C
    load.i    
    zero.alt  
    jneq           jump_0076
    load.s.pri        -0x420
    eq.c.pri             0x1
    jzer           jump_0077
    push.c               0x0
    call             func_22
    jump           jump_0078
 jump_0077:
    push.c               0x0
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
 jump_0078:
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0076:
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c              0x20
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    heap                -0x4
    zero.alt  
    jneq           jump_0079
    push.c           str_084  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_085  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0079:
    push.c           str_086  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0080
    push.s            -0x420
    push.c               0x4
    call             func_10
    jump           jump_0081
 jump_0080:
    load.s.pri        -0x420
    eq.c.pri             0x1
    jzer           jump_0081
    push.c           str_087  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0083
    push.c           str_088  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    zero.alt  
    jneq           jump_0084
    push.c           str_090  ;  ref to String  
    push.c           str_089  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c       setstrvar
    stack                0xC
    push.c               0x0
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
    push               0x938
    zero.pri  
    pop.alt   
    xchg      
    jsleq          jump_0085
    push.c           str_091  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0086
 jump_0085:
    push.c           str_092  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_093  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_094  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0086:
    jump           jump_0087
 jump_0084:
    push.c           str_095  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0087:
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0083:
    push.c           str_096  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0088
    push.c           str_097  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    eq.c.pri             0x1
    jzer           jump_0089
    push.c           str_099  ;  ref to String  
    push.c           str_098  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c       setstrvar
    stack                0xC
    push.c               0x0
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
    push.c           str_100  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0090
 jump_0089:
    push.c           str_101  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0090:
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0088:
    push.c           str_102  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0091
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x424
    zero.s            -0x424
    jump           jump_0092
 jump_0094:
    inc.s             -0x424
 jump_0092:
    load.s.alt        -0x424
    const.pri           0x20
    xchg      
    jsgeq          jump_0093
    push.c               0x0
    const.pri        mul_004  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri        -0x424
    pop.alt   
    idxaddr   
    load.i    
    push.pri  
    push.s            -0x424
    push.c               0xC
    call             func_21
    jump           jump_0094
 jump_0093:
    push.c               0x0
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
    push.c           str_103  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c               0x2
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
    const.pri           -0x1
    stack              0x424
    retn      
 jump_0091:
    push.c               0x5
    push.c           str_104  ;  ref to String  
    pushaddr          -0x41C
    push.c               0xC
    sysreq.c         strncmp
    stack               0x10
    zero.alt  
    jneq           jump_0081
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c             0x200
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    heap                -0x4
    zero.alt  
    jneq           jump_0096
    push.c               0x0
    push.c               0x4
    call             func_04
    jump           jump_0097
 jump_0096:
    push.c           str_105  ;  ref to String  
    addr.pri          -0x41C
    add.c               0x14
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0098
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c               0xC
    call             func_02
    push.c               0x1
    push.c               0x4
    call             func_11
    jump           jump_0097
 jump_0098:
    push.c           str_106  ;  ref to String  
    addr.pri          -0x41C
    add.c               0x14
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0100
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c               0xC
    call             func_02
    push.c               0x0
    push.c               0x4
    call             func_11
    jump           jump_0097
 jump_0100:
    push.c               0x0
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
 jump_0097:
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0081:
    push.c           str_107  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0102
    push.c               0x1
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_18
    push.c               0x0
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
    push.c               0x2
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0102:
    push.c           str_108  ;  ref to String  
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0103
    push.c               0x1
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_19
    push.c               0x0
    pushaddr          -0x41C
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
    push.c               0x2
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
    const.pri           -0x1
    stack              0x420
    retn      
 jump_0103:
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x424
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x428
    push.c               0x5
    push.c           str_109  ;  ref to String  
    pushaddr          -0x41C
    push.c               0xC
    sysreq.c         strncmp
    stack               0x10
    zero.alt  
    jneq           jump_0104
    pushaddr          -0x424
    addr.pri          -0x41C
    add.c               0x14
    push.pri  
    push.c           str_001  ;  ref to String  
    call             func_24
    eq.c.pri             0x1
    jzer           jump_0105
    load.s.alt        -0x424
    const.pri            0x9
    xchg      
    jsgeq          jump_0106
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri        -0x424
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    zero.alt  
    jeq            jump_0106
    const.pri            0x1
    jump           jump_0108
 jump_0106:
    zero.pri  
 jump_0108:
    jzer           jump_0109
    const.pri            0x2
    stor.s.pri        -0x428
    jump           jump_0110
 jump_0109:
    push.c           str_110  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    const.pri           -0x1
    stor.s.pri        -0x428
 jump_0110:
    jump           jump_0111
 jump_0105:
    pushaddr          -0x424
    addr.pri          -0x41C
    add.c               0x14
    push.pri  
    push.c           str_001  ;  ref to String  
    call             func_12
    stor.s.pri        -0x428
 jump_0111:
    load.s.pri        -0x428
    eq.c.pri             0x2
    jnz            jump_0112
    load.s.pri        -0x428
    eq.c.pri             0x1
    jnz            jump_0112
    zero.pri  
    jump           jump_0114
 jump_0112:
    const.pri            0x1
 jump_0114:
    jzer           jump_0115
    push.c               0x1
    push.s            -0x420
    push.s            -0x424
    push.c               0xC
    call             func_20
    push.c               0x0
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri        -0x424
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
 jump_0115:
    push.s            -0x428
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
    const.pri           -0x1
    stack              0x428
    retn      
 jump_0104:
    pushaddr          -0x424
    pushaddr          -0x41C
    push.c           str_001  ;  ref to String  
    call             func_13
    stor.s.pri        -0x428
    load.s.pri        -0x428
    eq.c.pri             0x2
    jnz            jump_0116
    load.s.pri        -0x428
    eq.c.pri             0x1
    jnz            jump_0116
    zero.pri  
    jump           jump_0118
 jump_0116:
    const.pri            0x1
 jump_0118:
    jzer           jump_0119
    push.c               0x1
    push.s            -0x420
    push.s            -0x424
    push.c               0xC
    call             func_21
    push.c               0x0
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri        -0x424
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr           -0x78
    pushaddr           -0xFC
    push.c              0x10
    call             func_05
 jump_0119:
    push.s            -0x428
    push.s            -0x420
    push.c           str_001  ;  ref to String  
    call             func_09
    const.pri           -0x1
    stack              0x428
    retn      
ENDP

PROC  func_09
    load.s.pri          0x10
    zero.alt  
    jeq            jump_0120
    load.s.pri          0x10
    eq.c.pri            -0x1
    jnz            jump_0120
    zero.pri  
    jump           jump_0122
 jump_0120:
    const.pri            0x1
 jump_0122:
    jzer           jump_0123
    load.s.pri           0xC
    eq.c.pri             0x1
    jzer           jump_0124
    push.c           str_111  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0125
 jump_0124:
    push.c           str_112  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0125:
    jump           jump_0126
 jump_0123:
    load.s.pri           0xC
    jzer           jump_0127
    push.c           str_113  ;  ref to String  
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
    push.c           str_114  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0126:
    zero.pri  
    retn      
ENDP

PROC  func_10
    load.s.pri           0xC
    eq.c.pri             0x1
    jzer           jump_0131
    push.c           str_115  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_116  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c              0x20
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0132
    push.c           str_117  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_118  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c             0x200
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0133
    push.c           str_119  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_120  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0133:
    push.c           str_121  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           var_004  ;  ref to Variable  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_122  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_123  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_124  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_125  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_126  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0132:
    jump           jump_0134
 jump_0131:
    push.c           str_127  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_128  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_129  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_130  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_131  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_132  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0134:
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c              0x20
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    heap                -0x4
    jzer           jump_0135
    push.c           var_005  ;  ref to Variable  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_133  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_134  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    load.pri            0x98
    const.alt            0x1
    jeq            jump_0135
    push.c           str_135  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_136  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0135:
    zero.pri  
    retn      
ENDP

PROC  func_11
    stack             -0x190
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    const.pri        str_137  ;  ref to String  
    addr.alt          -0x190
    movs                0x14
    stack              -0x84
    zero.pri  
    addr.alt          -0x214
    fill                0x84
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x218
    load.s.pri           0xC
    jzer           jump_0137
    stack             -0x190
    zero.pri  
    addr.alt          -0x3A8
    fill               0x190
    push.c           str_004  ;  ref to String  
    pushaddr          -0x3A8
    push.c           str_001  ;  ref to String  
    sysreq.c      currentmap
    stack                0xC
    push.c           str_004  ;  ref to String  
    push.c           str_138  ;  ref to String  
    pushaddr          -0x190
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    push.c           str_004  ;  ref to String  
    pushaddr          -0x3A8
    pushaddr          -0x190
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    stack              0x190
 jump_0137:
    zero.s            -0x218
    jump           jump_0138
 jump_0142:
    inc.s             -0x218
 jump_0138:
    load.s.alt        -0x218
    const.pri           0x20
    xchg      
    jsgeq          jump_0139
    const.pri        mul_004  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri        -0x218
    pop.alt   
    idxaddr   
    push.pri  
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x218
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    stor.i    
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x218
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0140
    addr.alt          -0x214
    load.s.pri        -0x218
    idxaddr   
    move.alt  
    const.pri           0x31
    stor.i    
    jump           jump_0141
 jump_0140:
    addr.alt          -0x214
    load.s.pri        -0x218
    idxaddr   
    move.alt  
    const.pri           0x30
    stor.i    
 jump_0141:
    jump           jump_0142
 jump_0139:
    addr.pri          -0x214
    add.c               0x80
    move.alt  
    zero.pri  
    stor.i    
    pushaddr          -0x214
    pushaddr          -0x190
    push.c           str_001  ;  ref to String  
    sysreq.c     set_vaultdata
    stack                0xC
    stack              0x218
    zero.pri  
    retn      
ENDP

PROC  func_12
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    stack               -0x4
    const.pri           -0x1
    stor.s.pri          -0x8
    zero.s              -0x4
    jump           jump_0143
 jump_0147:
    inc.s               -0x4
 jump_0143:
    load.s.alt          -0x4
    const.pri            0x9
    xchg      
    jsgeq          jump_0144
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0145
    push.s               0xC
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0145
    load.s.pri          -0x4
    sref.s.pri          0x10
    const.pri            0x2
    stack                0x8
    retn      
 jump_0145:
    jump           jump_0147
 jump_0144:
    zero.s              -0x4
    jump           jump_0148
 jump_0155:
    inc.s               -0x4
 jump_0148:
    load.s.alt          -0x4
    const.pri            0x9
    xchg      
    jsgeq          jump_0149
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0150
    push.s               0xC
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    jeq            jump_0150
    const.pri            0x1
    jump           jump_0152
 jump_0150:
    zero.pri  
 jump_0152:
    jzer           jump_0153
    load.s.pri          -0x8
    const.alt           -0x1
    jeq            jump_0154
    push.c               0x1
    push.s              -0x4
    push.s              -0x8
    push.c               0xC
    call             func_17
    const.pri           -0x1
    stack                0x8
    retn      
 jump_0154:
    load.s.pri          -0x4
    stor.s.pri          -0x8
 jump_0153:
    jump           jump_0155
 jump_0149:
    load.s.pri          -0x8
    const.alt           -0x1
    jeq            jump_0156
    load.s.pri          -0x8
    sref.s.pri          0x10
    const.pri            0x1
    stack                0x8
    retn      
 jump_0156:
    zero.pri  
    stack                0x8
    retn      
ENDP

PROC  func_13
    stack             -0x320
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    stack             -0x320
    zero.pri  
    addr.alt          -0x640
    fill               0x320
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x644
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x648
    const.pri           0xC8
    heap                 0x4
    stor.i    
    push.alt  
    pushaddr          -0x640
    const.pri           0xC8
    heap                 0x4
    stor.i    
    push.alt  
    pushaddr          -0x320
    push.c           str_139  ;  ref to String  
    push.s               0xC
    push.c              0x18
    sysreq.c          strsep
    stack               0x1C
    heap                -0x8
    pushaddr          -0x644
    pushaddr          -0x320
    push.c           str_001  ;  ref to String  
    call             func_24
    jzer           jump_0157
    pushaddr          -0x648
    pushaddr          -0x640
    push.c           str_001  ;  ref to String  
    call             func_24
    jzer           jump_0157
    const.pri            0x1
    jump           jump_0159
 jump_0157:
    zero.pri  
 jump_0159:
    jzer           jump_0160
    push.s              0x10
    push.s            -0x648
    push.s            -0x644
    push.c               0xC
    call             func_16
    stack              0x648
    retn      
 jump_0160:
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x64C
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x650
    addr.pri          -0x640
    load.i    
    zero.alt  
    jneq           jump_0161
    pushaddr          -0x650
    pushaddr          -0x320
    push.c           str_001  ;  ref to String  
    call             func_14
    stor.s.pri        -0x64C
    load.s.pri        -0x64C
    eq.c.pri             0x2
    jzer           jump_0162
    load.s.pri        -0x650
    sref.s.pri          0x10
    const.pri            0x2
    stack              0x650
    retn      
 jump_0162:
    load.s.pri        -0x64C
    eq.c.pri            -0x1
    jzer           jump_0161
    const.pri           -0x1
    stack              0x650
    retn      
 jump_0161:
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x654
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x658
    pushaddr          -0x658
    push.s               0xC
    push.c           str_001  ;  ref to String  
    call             func_15
    stor.s.pri        -0x654
    load.s.pri        -0x654
    eq.c.pri             0x2
    jzer           jump_0164
    load.s.pri        -0x658
    sref.s.pri          0x10
    const.pri            0x2
    stack              0x658
    retn      
 jump_0164:
    load.s.pri        -0x654
    eq.c.pri            -0x1
    jzer           jump_0165
    const.pri           -0x1
    stack              0x658
    retn      
 jump_0165:
    load.s.pri        -0x64C
    eq.c.pri             0x1
    jzer           jump_0166
    load.s.pri        -0x654
    eq.c.pri             0x1
    jzer           jump_0166
    load.s.alt        -0x650
    load.s.pri        -0x658
    jeq            jump_0166
    const.pri            0x1
    jump           jump_0169
 jump_0166:
    zero.pri  
 jump_0169:
    jzer           jump_0170
    push.c               0x0
    push.s            -0x658
    push.s            -0x650
    push.c               0xC
    call             func_17
    const.pri           -0x1
    stack              0x658
    retn      
 jump_0170:
    load.s.pri        -0x64C
    eq.c.pri             0x1
    jzer           jump_0171
    load.s.pri        -0x650
    sref.s.pri          0x10
    const.pri            0x1
    stack              0x658
    retn      
 jump_0171:
    load.s.pri        -0x654
    eq.c.pri             0x1
    jzer           jump_0172
    load.s.pri        -0x658
    sref.s.pri          0x10
    const.pri            0x1
    stack              0x658
    retn      
 jump_0172:
    stack               0x10
    zero.pri  
    stack              0x648
    retn      
ENDP

PROC  func_14
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    stack               -0x4
    const.pri           -0x1
    stor.s.pri          -0x8
    zero.s              -0x4
    jump           jump_0173
 jump_0185:
    inc.s               -0x4
 jump_0173:
    load.s.alt          -0x4
    const.pri           0x20
    xchg      
    jsgeq          jump_0174
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0175
    push.s               0xC
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0175
    const.pri            0x1
    jump           jump_0177
 jump_0175:
    zero.pri  
 jump_0177:
    jnz            jump_0178
    const.alt        mul_003  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0179
    push.s               0xC
    const.alt        mul_003  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strcmp
    stack                0xC
    zero.alt  
    jneq           jump_0179
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
    load.s.pri          -0x4
    sref.s.pri          0x10
    const.pri            0x2
    stack                0x8
    retn      
 jump_0184:
    jump           jump_0185
 jump_0174:
    zero.s              -0x4
    jump           jump_0186
 jump_0199:
    inc.s               -0x4
 jump_0186:
    load.s.alt          -0x4
    const.pri           0x20
    xchg      
    jsgeq          jump_0187
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0188
    push.s               0xC
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    jeq            jump_0188
    const.pri            0x1
    jump           jump_0190
 jump_0188:
    zero.pri  
 jump_0190:
    jnz            jump_0191
    const.alt        mul_003  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0192
    push.s               0xC
    const.alt        mul_003  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    jeq            jump_0192
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
    load.s.pri          -0x8
    const.alt           -0x1
    jeq            jump_0198
    push.c               0x0
    push.s              -0x4
    push.s              -0x8
    push.c               0xC
    call             func_17
    const.pri           -0x1
    stack                0x8
    retn      
 jump_0198:
    load.s.pri          -0x4
    stor.s.pri          -0x8
 jump_0197:
    jump           jump_0199
 jump_0187:
    load.s.pri          -0x8
    const.alt           -0x1
    jeq            jump_0200
    load.s.pri          -0x8
    sref.s.pri          0x10
    const.pri            0x1
    stack                0x8
    retn      
 jump_0200:
    zero.pri  
    stack                0x8
    retn      
ENDP

PROC  func_15
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    stack               -0x4
    const.pri           -0x1
    stor.s.pri          -0x8
    zero.s              -0x4
    jump           jump_0201
 jump_0208:
    inc.s               -0x4
 jump_0201:
    load.s.alt          -0x4
    const.pri           0x20
    xchg      
    jsgeq          jump_0202
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0203
    push.s               0xC
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri          -0x4
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_001  ;  ref to String  
    sysreq.c      strcasestr
    stack                0xC
    const.alt           -0x1
    jeq            jump_0203
    const.pri            0x1
    jump           jump_0205
 jump_0203:
    zero.pri  
 jump_0205:
    jzer           jump_0206
    load.s.pri          -0x8
    const.alt           -0x1
    jeq            jump_0207
    push.c               0x0
    push.s              -0x4
    push.s              -0x8
    push.c               0xC
    call             func_17
    const.pri           -0x1
    stack                0x8
    retn      
 jump_0207:
    load.s.pri          -0x4
    stor.s.pri          -0x8
 jump_0206:
    jump           jump_0208
 jump_0202:
    load.s.pri          -0x8
    const.alt           -0x1
    jeq            jump_0209
    load.s.pri          -0x8
    sref.s.pri          0x10
    const.pri            0x1
    stack                0x8
    retn      
 jump_0209:
    zero.pri  
    stack                0x8
    retn      
ENDP

PROC  func_16
    load.s.pri           0xC
    zero.alt  
    xchg      
    sless     
    push.pri  
    const.pri            0x7
    xchg      
    sless     
    swap.alt  
    and       
    pop.alt   
    jnz            jump_0210
    load.s.pri           0xC
    eq.c.pri             0x8
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
    push.alt  
    const.alt        arr_001  ;  ref to Array  
    load.s.pri           0xC
    lidx      
    push.pri  
    push.c           arr_001  ;  ref to Array  
    load.s.alt           0xC
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    sub.alt   
    pop.alt   
    sgeq      
    pop.alt   
    and       
    jzer           jump_0213
    const.pri            0x1
    jump           jump_0215
 jump_0213:
    zero.pri  
 jump_0215:
    jzer           jump_0216
    stack               -0x4
    push.c           arr_001  ;  ref to Array  
    load.s.alt           0xC
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    move.alt  
    load.s.pri          0x10
    add       
    move.alt  
    const.pri            0x1
    sub.alt   
    stor.s.pri          -0x4
    stack               -0x4
    const.pri        mul_005  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri          -0x8
    stack               -0x4
    const.pri        mul_005  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri          -0xC
    load.pri            0x98
    eq.c.pri             0x1
    jzer           jump_0217
    load.s.pri          -0x8
    const.alt           0x20
    jeq            jump_0218
    load.s.pri          -0x8
    sref.s.pri          0x14
    const.pri            0x2
    stack                0xC
    retn      
 jump_0218:
    load.s.pri          -0xC
    const.alt           0x20
    jeq            jump_0219
    load.s.pri          -0xC
    sref.s.pri          0x14
    const.pri            0x2
    stack                0xC
    retn      
 jump_0219:
    jump           jump_0220
 jump_0217:
    load.s.alt          -0x8
    load.s.pri          -0xC
    jeq            jump_0221
    load.s.pri          -0x8
    const.alt           0x20
    jeq            jump_0221
    const.pri            0x1
    jump           jump_0223
 jump_0221:
    zero.pri  
 jump_0223:
    jzer           jump_0224
    push.c               0x0
    push.s              -0xC
    push.s              -0x8
    push.c               0xC
    call             func_17
    const.pri           -0x1
    stack                0xC
    retn      
 jump_0224:
    load.s.pri          -0x8
    sref.s.pri          0x14
    const.pri            0x2
    stack                0xC
    retn      
 jump_0220:
    stack                0xC
 jump_0216:
    zero.pri  
    retn      
ENDP

PROC  func_17
    stack             -0x190
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    load.s.pri          0x14
    zero.alt  
    jeq            jump_0225
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri          0x10
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_140  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    jump           jump_0226
 jump_0225:
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri          0x10
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri          0x10
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_141  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c              0x1C
    sysreq.c        snprintf
    stack               0x20
 jump_0226:
    pushaddr          -0x190
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x190
    zero.pri  
    retn      
ENDP

PROC  func_18
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    load.s.pri          0x10
    jzer           jump_0227
    load.s.pri           0xC
    eq.c.pri             0x1
    jzer           jump_0228
    push.c           str_142  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0227
 jump_0228:
    push.c           str_143  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0227:
    zero.s              -0x4
    jump           jump_0230
 jump_0232:
    inc.s               -0x4
 jump_0230:
    load.s.alt          -0x4
    const.pri           0x20
    xchg      
    jsgeq          jump_0231
    push.c               0x0
    push.s               0xC
    push.s              -0x4
    push.c               0xC
    call             func_21
    jump           jump_0232
 jump_0231:
    stack                0x4
    zero.pri  
    retn      
ENDP

PROC  func_19
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    load.s.pri          0x10
    jzer           jump_0233
    load.s.pri           0xC
    eq.c.pri             0x1
    jzer           jump_0234
    push.c           str_144  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0233
 jump_0234:
    push.c           str_145  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0233:
    zero.s              -0x4
    jump           jump_0236
 jump_0238:
    inc.s               -0x4
 jump_0236:
    push.s              -0x4
    const.pri        arr_000  ;  ref to Array  
    add.c               0x1C
    load.i    
    pop.alt   
    xchg      
    jsgeq          jump_0237
    push.c               0x0
    push.s               0xC
    push.s              -0x4
    push.c               0xC
    call             func_21
    jump           jump_0238
 jump_0237:
    stack                0x4
    zero.pri  
    retn      
ENDP

PROC  func_20
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    load.s.pri          0x14
    jzer           jump_0239
    stack             -0x190
    zero.pri  
    addr.alt          -0x194
    fill               0x190
    load.s.pri          0x10
    eq.c.pri             0x1
    jzer           jump_0240
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_146  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x194
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0241
 jump_0240:
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_147  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x194
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
 jump_0241:
    pushaddr          -0x194
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x190
 jump_0239:
    push.c           arr_000  ;  ref to Array  
    load.s.alt           0xC
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri          -0x4
    jump           jump_0242
 jump_0244:
    inc.s               -0x4
 jump_0242:
    push.s              -0x4
    const.alt        arr_000  ;  ref to Array  
    load.s.pri           0xC
    lidx      
    pop.alt   
    xchg      
    jsgeq          jump_0243
    push.c               0x0
    push.s              0x10
    push.s              -0x4
    push.c               0xC
    call             func_21
    jump           jump_0244
 jump_0243:
    stack                0x4
    zero.pri  
    retn      
ENDP

PROC  func_21
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    zero.alt  
    jneq           jump_0245
    zero.pri  
    retn      
 jump_0245:
    load.s.pri          0x14
    jzer           jump_0246
    stack             -0x190
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    push.s              0x10
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    jeq            jump_0247
    load.s.pri          0x10
    eq.c.pri             0x1
    jzer           jump_0248
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_148  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0249
 jump_0248:
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_149  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
 jump_0249:
    jump           jump_0250
 jump_0247:
    load.s.pri          0x10
    eq.c.pri             0x1
    jzer           jump_0251
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_150  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0250
 jump_0251:
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_151  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
 jump_0250:
    pushaddr          -0x190
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x190
 jump_0246:
    push.s              0x10
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    pop.alt   
    idxaddr   
    load.i    
    pop.alt   
    jeq            jump_0253
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    pop.alt   
    idxaddr   
    move.alt  
    load.s.pri          0x10
    stor.i    
    load.s.pri          0x10
    eq.c.pri             0x1
    jzer           jump_0254
    inc                0x938
    jump           jump_0253
 jump_0254:
    dec                0x938
 jump_0253:
    zero.pri  
    retn      
ENDP

PROC  func_22
    stack               -0x4
    push.c           str_152  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    stor.s.pri          -0x4
    stack               -0x4
    const.pri        var_003  ;  ref to Variable  
    heap                 0x4
    movs                 0x4
    push.alt  
    push.c              0x20
    push.c           str_001  ;  ref to String  
    sysreq.c          access
    stack                0xC
    heap                -0x4
    stor.s.pri          -0x8
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
    push.c           str_153  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c               0x1
    push.c               0x4
    call             func_23
    push.c               0x2
    push.c               0x4
    call             func_23
    push.c               0x3
    push.c               0x4
    call             func_23
    push.c               0x4
    push.c               0x4
    call             func_23
    push.c               0x5
    push.c               0x4
    call             func_23
    push.c           str_001  ;  ref to String  
    push.c               0x4
    call             func_23
    jump           jump_0260
 jump_0259:
    push.c           str_154  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0260:
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
    push.c           str_155  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_156  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0264:
    load.s.pri          -0x4
    jzer           jump_0265
    push.c           str_157  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    jump           jump_0266
 jump_0265:
    push.c           str_158  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
 jump_0266:
    stack                0x8
    zero.pri  
    retn      
ENDP

PROC  func_23
    stack             -0x320
    zero.pri  
    addr.alt          -0x320
    fill               0x320
    stack             -0x320
    zero.pri  
    addr.alt          -0x640
    fill               0x320
    stack             -0x320
    zero.pri  
    addr.alt          -0x960
    fill               0x320
    stack               -0x4
    push.c           arr_000  ;  ref to Array  
    load.s.alt           0xC
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri        -0x964
    stack               -0x4
    const.alt        arr_000  ;  ref to Array  
    load.s.pri           0xC
    lidx      
    move.alt  
    const.pri            0x1
    sub.alt   
    stor.s.pri        -0x968
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x96C
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x970
    stack               -0x4
    zero.pri  
    stor.s.pri        -0x974
    load.s.pri        -0x964
    stor.s.pri        -0x96C
    jump           jump_0267
 jump_0274:
    inc.s             -0x96C
 jump_0267:
    load.s.alt        -0x96C
    load.s.pri        -0x968
    xchg      
    jsgrtr         jump_0268
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri        -0x96C
    idxaddr   
    move.alt  
    load.i    
    add       
    load.i    
    jzer           jump_0269
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0x96C
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0270
    push.s            -0x970
    zero.pri  
    pop.alt   
    xchg      
    jsleq          jump_0271
    push.c              0xC8
    push.c           str_159  ;  ref to String  
    pushaddr          -0x640
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
 jump_0271:
    inc.s             -0x970
    push.c              0xC8
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri        -0x96C
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr          -0x640
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    jump           jump_0269
 jump_0270:
    push.s            -0x974
    zero.pri  
    pop.alt   
    xchg      
    jsleq          jump_0273
    push.c              0xC8
    push.c           str_160  ;  ref to String  
    pushaddr          -0x960
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
 jump_0273:
    push.c              0xC8
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri        -0x96C
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr          -0x960
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    inc.s             -0x974
 jump_0269:
    jump           jump_0274
 jump_0268:
    load.s.pri        -0x974
    zero.alt  
    jneq           jump_0275
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_161  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x320
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0276
 jump_0275:
    load.s.pri        -0x970
    zero.alt  
    jneq           jump_0277
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_162  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x320
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    jump           jump_0276
 jump_0277:
    load.s.alt        -0x974
    load.s.pri        -0x970
    xchg      
    jsgeq          jump_0279
    pushaddr          -0x640
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_163  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x320
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    jump           jump_0276
 jump_0279:
    pushaddr          -0x960
    const.alt        mul_000  ;  ref to MultiArray  
    load.s.pri           0xC
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_164  ;  ref to String  
    push.c              0xC8
    pushaddr          -0x320
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
 jump_0276:
    pushaddr          -0x320
    addr.pri          -0x320
    load.i    
    push.pri  
    push.c               0x4
    sysreq.c         toupper
    stack                0x8
    pop.alt   
    stor.i    
    pushaddr          -0x320
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    stack              0x974
    zero.pri  
    retn      
ENDP

PROC  RestrictMenu
    load.s.pri          0x18
    not       
    jzer           jump_0281
    push.c           str_165  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    const.pri           -0x1
    retn      
 jump_0281:
    push.c               0x0
    call             func_26
    zero.alt  
    jneq           jump_0282
    push.c           str_166  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_167  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    push.c           str_168  ;  ref to String  
    push.c               0x4
    sysreq.c     selfmessage
    stack                0x8
    const.pri           -0x1
    retn      
 jump_0282:
    push.s              0x18
    push.c               0x4
    call             func_28
    const.pri           -0x1
    retn      
ENDP

PROC  plugin_connect
    load.s.pri          0x14
    zero.alt  
    xchg      
    sless     
    push.pri  
    const.pri           0x21
    sgrtr     
    pop.alt   
    and       
    jzer           jump_0283
    const.alt          0x7A0
    load.s.pri          0x14
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
 jump_0283:
    const.pri            0x1
    retn      
ENDP

PROC  plugin_disconnect
    load.s.pri          0x10
    zero.alt  
    xchg      
    sless     
    push.pri  
    const.pri           0x21
    sgrtr     
    pop.alt   
    and       
    jzer           jump_0284
    const.alt          0x7A0
    load.s.pri          0x10
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
 jump_0284:
    const.pri            0x1
    retn      
ENDP

PROC  buy
    const.alt          0x7A0
    load.s.pri          0x18
    idxaddr   
    move.alt  
    const.pri            0xB
    stor.i    
    const.pri            0x1
    retn      
ENDP

PROC  buyequip
    const.alt          0x7A0
    load.s.pri          0x18
    idxaddr   
    move.alt  
    const.pri        str_001  ;  ref to String  
    stor.i    
    const.pri            0x1
    retn      
ENDP

PROC  ClearMenu
    const.alt          0x7A0
    load.s.pri          0x18
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
    const.pri            0x1
    retn      
ENDP

PROC  menuselect
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    zero.alt  
    jeq            jump_0285
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    push.c              0xC8
    push.c           arr_004  ;  ref to Array  
    push.s              0x10
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c           arr_004  ;  ref to Array  
    push.c               0x4
    call             func_07
    push.c               0x2
    push.c           str_169  ;  ref to String  
    push.c           arr_004  ;  ref to Array  
    push.c               0xC
    sysreq.c         strtrim
    stack               0x10
    pushaddr            -0x4
    push.c           arr_004  ;  ref to Array  
    push.c           str_001  ;  ref to String  
    call             func_24
    zero.alt  
    jeq            jump_0286
    load.s.alt          -0x4
    const.pri            0x1
    xchg      
    sless     
    jnz            jump_0287
    load.s.alt          -0x4
    const.pri            0xA
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
    const.pri           -0x1
    stack                0x4
    retn      
 jump_0292:
    load.s.pri          -0x4
    eq.c.pri             0xA
    jzer           jump_0293
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    move.alt  
    zero.pri  
    xchg      
    jsgeq          jump_0294
    push.s              0x18
    push.c               0x4
    call             func_28
    const.pri           -0x1
    stack                0x4
    retn      
 jump_0294:
    const.alt          0x7A0
    load.s.pri          0x18
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
    jump           jump_0295
 jump_0293:
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    eq.c.pri             0xC
    jzer           jump_0296
    push.s              -0x4
    push.s              0x18
    push.c           str_001  ;  ref to String  
    call             func_29
    const.pri           -0x1
    stack                0x4
    retn      
 jump_0296:
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    move.alt  
    zero.pri  
    xchg      
    jsgeq          jump_0297
    stack               -0x4
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    neg       
    stor.s.pri          -0x8
    stack               -0x4
    push.c           arr_001  ;  ref to Array  
    load.s.alt          -0x8
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri          -0xC
    load.pri            0x98
    const.alt            0x1
    jeq            jump_0298
    load.s.pri          -0x4
    eq.c.pri             0x9
    jzer           jump_0299
    const.alt        arr_002  ;  ref to Array  
    load.s.pri          0x18
    lidx      
    eq.c.pri             0x1
    jzer           jump_0300
    const.alt        arr_002  ;  ref to Array  
    load.s.pri          0x18
    idxaddr   
    move.alt  
    zero.pri  
    stor.i    
    jump           jump_0301
 jump_0300:
    const.alt        arr_002  ;  ref to Array  
    load.s.pri          0x18
    idxaddr   
    move.alt  
    const.pri            0x1
    stor.i    
 jump_0301:
    jump           jump_0302
 jump_0299:
    stack               -0x4
    const.alt        arr_002  ;  ref to Array  
    load.s.pri          0x18
    lidx      
    stor.s.pri         -0x10
    stack               -0x4
    const.alt        mul_005  ;  ref to MultiArray  
    load.s.pri         -0x10
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.alt          -0xC
    load.s.pri          -0x4
    add       
    move.alt  
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri         -0x14
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri         -0x14
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0303
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri         -0x14
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_170  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c     plugin_exec
    stack                0xC
    jump           jump_0304
 jump_0303:
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri         -0x14
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_171  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c     plugin_exec
    stack                0xC
 jump_0304:
    stack                0x8
 jump_0302:
    jump           jump_0305
 jump_0298:
    stack               -0x4
    const.pri        mul_005  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.alt          -0xC
    load.s.pri          -0x4
    add       
    move.alt  
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri         -0x10
    load.s.pri         -0x10
    eq.c.pri            0x20
    jzer           jump_0306
    const.pri        mul_005  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.alt          -0xC
    load.s.pri          -0x4
    add       
    move.alt  
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri         -0x10
 jump_0306:
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri         -0x10
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0307
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri         -0x10
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_172  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c     plugin_exec
    stack                0xC
    jump           jump_0308
 jump_0307:
    const.alt        mul_002  ;  ref to MultiArray  
    load.s.pri         -0x10
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_173  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c     plugin_exec
    stack                0xC
 jump_0308:
    stack                0x4
 jump_0305:
    push.s              -0x8
    push.s              0x18
    push.c           str_001  ;  ref to String  
    call             func_29
    const.pri           -0x1
    stack                0xC
    retn      
 jump_0297:
    load.pri           0x938
    jzer           jump_0309
    push.c           str_174  ;  ref to String  
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
    push.c              0x21
    push.c           arr_005  ;  ref to Array  
    push.s              0x14
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    eq.c.pri             0xB
    jzer           jump_0313
    load.s.pri          -0x4
    eq.c.pri             0x7
    jnz            jump_0314
    load.s.pri          -0x4
    eq.c.pri             0x6
    jnz            jump_0314
    load.s.pri          -0x4
    eq.c.pri             0x9
    jnz            jump_0314
    zero.pri  
    jump           jump_0317
 jump_0314:
    const.pri            0x1
 jump_0317:
    jzer           jump_0318
    push.c           str_175  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    jzer           jump_0319
    push.c           str_176  ;  ref to String  
    push.c           arr_005  ;  ref to Array  
    push.c           str_001  ;  ref to String  
    sysreq.c      execclient
    stack                0xC
 jump_0319:
    jump           jump_0320
 jump_0318:
    const.alt          0x7A0
    load.s.pri          0x18
    idxaddr   
    move.alt  
    load.s.pri          -0x4
    stor.i    
 jump_0320:
    jump           jump_0295
 jump_0313:
    load.pri            0x98
    const.alt            0x1
    jeq            jump_0322
    push.c           str_177  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    jzer           jump_0322
    push.c           str_178  ;  ref to String  
    push.c           arr_005  ;  ref to Array  
    push.c           str_001  ;  ref to String  
    sysreq.c      execclient
    stack                0xC
 jump_0322:
    stack               -0x4
    push.c           arr_001  ;  ref to Array  
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    move.alt  
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri          -0x8
    stack               -0x4
    push.c           arr_001  ;  ref to Array  
    const.alt          0x7A0
    load.s.pri          0x18
    lidx      
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri          -0xC
    push.s              -0x4
    load.s.alt          -0xC
    load.s.pri          -0x8
    sub.alt   
    pop.alt   
    xchg      
    jsgrtr         jump_0324
    stack               -0x4
    zero.pri  
    stor.s.pri         -0x10
    pushaddr           -0x10
    push.c           arr_005  ;  ref to Array  
    push.c           str_001  ;  ref to String  
    sysreq.c     get_userTeam
    stack                0xC
    push.c               0x2
    push.c               0x1
    push.s             -0x10
    push.c               0xC
    sysreq.c           clamp
    stack               0x10
    stor.s.pri         -0x10
    stack               -0x4
    push.c           mul_005  ;  ref to MultiArray  
    load.s.alt         -0x10
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.alt          -0x8
    load.s.pri          -0x4
    add       
    move.alt  
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri         -0x14
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri         -0x14
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0325
    push.c               0x1
    push.c           str_179  ;  ref to String  
    push.c           arr_005  ;  ref to Array  
    push.c               0xC
    sysreq.c       messageex
    stack               0x10
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
    const.pri            0x1
    retn      
ENDP

PROC  func_24
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x8
    load.s.pri           0xC
    load.i    
    zero.alt  
    jneq           jump_0326
    zero.pri  
    stack                0x8
    retn      
 jump_0326:
    zero.s              -0x4
    jump           jump_0327
 jump_0331:
    inc.s               -0x4
 jump_0327:
    push.s               0xC
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    zero.alt  
    jeq            jump_0328
    push.s               0xC
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    const.alt           0x30
    xchg      
    sleq      
    push.pri  
    const.pri           0x39
    sgeq      
    pop.alt   
    and       
    jzer           jump_0329
    load.s.pri          -0x8
    smul.c               0xA
    stor.s.pri          -0x8
    push.s              -0x8
    push.s               0xC
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    move.alt  
    const.pri           0x30
    sub.alt   
    pop.alt   
    add       
    stor.s.pri          -0x8
    jump           jump_0330
 jump_0329:
    zero.pri  
    stack                0x8
    retn      
 jump_0330:
    jump           jump_0331
 jump_0328:
    load.s.pri          -0x8
    sref.s.pri          0x10
    const.pri            0x1
    stack                0x8
    retn      
ENDP

PROC  func_25
    stack             -0x190
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c           str_180  ;  ref to String  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    push.c           str_182  ;  ref to String  
    push.c           str_181  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c       setstrvar
    stack                0xC
    push.c           str_183  ;  ref to String  
    push.c               0x4
    sysreq.c          getvar
    stack                0x8
    eq.c.pri             0x1
    jzer           jump_0332
    pushaddr          -0x190
    push.c           str_184  ;  ref to String  
    push.c           str_001  ;  ref to String  
    sysreq.c       setstrvar
    stack                0xC
    const.pri            0x2
    stack              0x190
    retn      
 jump_0332:
    const.pri            0x1
    stack              0x190
    retn      
ENDP

PROC  func_26
    stack             -0x190
    zero.pri  
    addr.alt          -0x190
    fill               0x190
    push.c           str_004  ;  ref to String  
    pushaddr          -0x190
    push.c           str_185  ;  ref to String  
    push.c               0xC
    sysreq.c       getstrvar
    stack               0x10
    push.c           str_186  ;  ref to String  
    pushaddr          -0x190
    push.c           str_001  ;  ref to String  
    sysreq.c          strstr
    stack                0xC
    const.alt           -0x1
    jeq            jump_0333
    const.pri            0x1
    stack              0x190
    retn      
 jump_0333:
    zero.pri  
    stack              0x190
    retn      
ENDP

PROC  func_27
    stack               -0x4
    zero.pri  
    stor.s.pri          -0x4
    zero.s              -0x4
    jump           jump_0334
 jump_0336:
    inc.s               -0x4
 jump_0334:
    push.s               0xC
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    load.i    
    jzer           jump_0335
    push.s               0xC
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
    push.pri  
    push.s               0xC
    load.s.pri          -0x4
    pop.alt   
    idxaddr   
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

PROC  func_28
    stack              -0x84
    zero.pri  
    addr.alt           -0x84
    fill                0x84
    const.alt          0x7A0
    load.s.pri           0xC
    idxaddr   
    move.alt  
    const.pri            0xC
    stor.i    
    const.pri        var_006  ;  ref to Variable  
    heap                0x9C
    movs                 0x4
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    push.c              0x21
    pushaddr           -0x84
    push.s               0xC
    push.c              0x20
    sysreq.c      playerinfo
    stack               0x24
    heap               -0xAC
    load.pri            0x98
    const.alt            0x1
    jeq            jump_0337
    stack               -0x4
    zero.pri  
    stor.s.pri         -0x88
    pushaddr           -0x88
    pushaddr           -0x84
    push.c           str_001  ;  ref to String  
    sysreq.c     get_userTeam
    stack                0xC
    const.alt        arr_002  ;  ref to Array  
    load.s.pri           0xC
    idxaddr   
    push.pri  
    push.c               0x1
    push.c               0x0
    load.s.alt         -0x88
    const.pri            0x1
    sub.alt   
    push.pri  
    push.c               0xC
    sysreq.c           clamp
    stack               0x10
    pop.alt   
    stor.i    
    stack                0x4
 jump_0337:
    push.c               0x0
    push.c             0x29F
    push.c           str_187  ;  ref to String  
    pushaddr           -0x84
    push.c              0x10
    sysreq.c            menu
    stack               0x14
    stack               0x84
    zero.pri  
    retn      
ENDP

PROC  func_29
    stack             -0x800
    zero.pri  
    addr.alt          -0x800
    fill               0x800
    stack             -0x190
    zero.pri  
    addr.alt          -0x990
    fill               0x190
    stack              -0x84
    zero.pri  
    addr.alt          -0xA14
    fill                0x84
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA18
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA1C
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA20
    stack               -0x4
    zero.pri  
    stor.s.pri        -0xA24
    stack               -0x4
    const.pri            0x1
    stor.s.pri        -0xA28
    push.c           mul_006  ;  ref to MultiArray  
    load.s.alt          0x10
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    push.c           str_188  ;  ref to String  
    push.c             0x200
    pushaddr          -0x800
    push.c              0x10
    sysreq.c        snprintf
    stack               0x14
    push.c           arr_001  ;  ref to Array  
    load.s.alt          0x10
    const.pri            0x1
    sub.alt   
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri        -0xA18
    jump           jump_0338
 jump_0347:
    inc.s             -0xA18
 jump_0338:
    push.s            -0xA18
    const.alt        arr_001  ;  ref to Array  
    load.s.pri          0x10
    lidx      
    pop.alt   
    xchg      
    jsgeq          jump_0339
    inc.s             -0xA1C
    load.pri            0x98
    eq.c.pri             0x1
    jzer           jump_0340
    const.pri        mul_005  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0xA18
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri        -0xA20
    load.s.pri        -0xA20
    eq.c.pri            0x20
    jzer           jump_0341
    const.pri        mul_005  ;  ref to MultiArray  
    add.c                0x4
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri        -0xA18
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri        -0xA20
 jump_0341:
    jump           jump_0342
 jump_0340:
    push.c           mul_005  ;  ref to MultiArray  
    const.alt        arr_002  ;  ref to Array  
    load.s.pri           0xC
    lidx      
    pop.alt   
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    load.s.pri        -0xA18
    pop.alt   
    idxaddr   
    load.i    
    stor.s.pri        -0xA20
    load.s.pri        -0xA20
    eq.c.pri            0x20
    jzer           jump_0342
    jump           jump_0339
 jump_0342:
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri        -0xA20
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0345
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri        -0xA20
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr          -0xA1C
    push.c           str_189  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x990
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
    jump           jump_0346
 jump_0345:
    const.alt        mul_001  ;  ref to MultiArray  
    load.s.pri        -0xA20
    idxaddr   
    move.alt  
    load.i    
    add       
    push.pri  
    pushaddr          -0xA1C
    push.c           str_190  ;  ref to String  
    push.c           str_004  ;  ref to String  
    pushaddr          -0x990
    push.c              0x14
    sysreq.c        snprintf
    stack               0x18
 jump_0346:
    push.c             0x200
    pushaddr          -0x990
    pushaddr          -0x800
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    load.s.alt        -0xA24
    load.s.pri        -0xA28
    or        
    stor.s.pri        -0xA24
    load.s.alt        -0xA28
    const.pri            0x1
    xchg      
    shl       
    stor.s.pri        -0xA28
    jump           jump_0347
 jump_0339:
    load.pri            0x98
    const.alt            0x1
    jeq            jump_0348
    const.alt        arr_002  ;  ref to Array  
    load.s.pri           0xC
    lidx      
    zero.alt  
    jneq           jump_0349
    push.c             0x200
    push.c           str_191  ;  ref to String  
    pushaddr          -0x800
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    jump           jump_0350
 jump_0349:
    push.c             0x200
    push.c           str_192  ;  ref to String  
    pushaddr          -0x800
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
 jump_0350:
    load.s.pri        -0xA24
    const.alt          0x100
    or        
    stor.s.pri        -0xA24
 jump_0348:
    push.c             0x200
    push.c           str_193  ;  ref to String  
    pushaddr          -0x800
    push.c               0xC
    sysreq.c          strcat
    stack               0x10
    load.s.pri        -0xA24
    const.alt          0x200
    or        
    stor.s.pri        -0xA24
    const.pri        var_006  ;  ref to Variable  
    heap                0x9C
    movs                 0x4
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    zero.pri  
    heap                 0x4
    stor.i    
    push.alt  
    push.c              0x21
    pushaddr          -0xA14
    push.s               0xC
    push.c              0x20
    sysreq.c      playerinfo
    stack               0x24
    heap               -0xAC
    const.alt          0x7A0
    load.s.pri           0xC
    idxaddr   
    push.pri  
    load.s.pri          0x10
    neg       
    pop.alt   
    stor.i    
    push.c               0x0
    push.s            -0xA24
    pushaddr          -0x800
    pushaddr          -0xA14
    push.c              0x10
    sysreq.c            menu
    stack               0x14
    stack              0xA28
    zero.pri  
    retn      
ENDP

PROC  buy_glock
    push.s              0x14
    push.c               0x0
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_usp
    push.s              0x14
    push.c               0x1
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_p228
    push.s              0x14
    push.c               0x2
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_deagle
    push.s              0x14
    push.c               0x3
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_elites
    push.s              0x14
    push.c               0x4
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_fn57
    push.s              0x14
    push.c               0x5
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_m3
    push.s              0x14
    push.c               0x6
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_xm1014
    push.s              0x14
    push.c               0x7
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_mac10
    push.s              0x14
    push.c           str_001  ;  ref to String  
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_mp5
    push.s              0x14
    push.c               0x9
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_ump45
    push.s              0x14
    push.c               0xA
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_p90
    push.s              0x14
    push.c               0xB
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_tmp
    push.s              0x14
    push.c               0xC
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_galil
    push.s              0x14
    push.c               0xD
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_ak47
    push.s              0x14
    push.c               0xE
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_scout
    push.s              0x14
    push.c               0xF
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_sg552
    push.s              0x14
    push.c              0x10
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_awp
    push.s              0x14
    push.c              0x11
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_g3sg1
    push.s              0x14
    push.c              0x12
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_famas
    push.s              0x14
    push.c              0x13
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_aug
    push.s              0x14
    push.c              0x14
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_m4a1
    push.s              0x14
    push.c              0x15
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_sg550
    push.s              0x14
    push.c              0x16
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_m249
    push.s              0x14
    push.c              0x17
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_vest
    push.s              0x14
    push.c              0x18
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_vesthelm
    push.s              0x14
    push.c              0x19
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_flash
    push.s              0x14
    push.c              0x1A
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_hegren
    push.s              0x14
    push.c              0x1B
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_sgren
    push.s              0x14
    push.c              0x1C
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_defuser
    push.s              0x14
    push.c              0x1D
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_nvgs
    push.s              0x14
    push.c              0x1E
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  buy_shield
    push.s              0x14
    push.c              0x1F
    push.c           str_001  ;  ref to String  
    call             func_30
    retn      
ENDP

PROC  func_30
    const.pri        mul_004  ;  ref to MultiArray  
    push.pri  
    load.i    
    pop.alt   
    add       
    push.pri  
    load.s.pri           0xC
    pop.alt   
    idxaddr   
    load.i    
    eq.c.pri             0x1
    jzer           jump_0351
    push.c           str_194  ;  ref to String  
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
    stack              -0x84
    zero.pri  
    addr.alt           -0x84
    fill                0x84
    push.c              0x21
    pushaddr           -0x84
    push.s              0x10
    push.c               0xC
    sysreq.c     convert_string
    stack               0x10
    push.c               0x1
    push.c           str_195  ;  ref to String  
    pushaddr           -0x84
    push.c               0xC
    sysreq.c       messageex
    stack               0x10
    const.pri           -0x1
    stack               0x84
    retn      
 jump_0354:
    const.pri            0x1
    retn      
ENDP


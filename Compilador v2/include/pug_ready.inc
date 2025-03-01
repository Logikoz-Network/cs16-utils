#if defined _pug_ready_included
  #endinput
#endif
#define _pug_ready_included

// Rukia: A ready plugin must impliment these functions:

// Rukia: Starts a ready session. Leave pluginid = -1 to mean the plugin calling from
native pug_ready_players(funcid,pluginid = -1)

// Rukia: Registers the function to be called to display ready menus
native register_ready_display(funcid,pluginid = -1)
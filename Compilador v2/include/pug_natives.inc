#if defined _pug_natives_included
  #endinput
#endif
#define _pug_natives_included


// Rukia: 
//	The helper and mod specific plugins may use these to impliment new features.

native pug_call_roundstart()
native pug_call_roundend(winner)

native pug_call_start()
native pug_call_end()

native pug_call_reset()

native pug_pause()
native pug_unpause()
native pug_set_pause_call(func_id,plugin_id = -1)

native pug_num_teams()
native pug_register_team(name[])
native pug_swap_teams(team_a,team_b)

native pug_get_team_score(team)
native pug_set_team_score(team,val)

native pug_get_team_name(team,name[32])
native pug_set_team_name(team,name[32])


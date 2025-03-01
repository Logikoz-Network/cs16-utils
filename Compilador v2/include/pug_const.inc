#if defined _pug_const_included
  #endinput
#endif
#define _pug_const_included

#include <amxmodx>

#define PUG_CMD_LVL ADMIN_LEVEL_A
#define MAX_TEAMS 32

// Rukia: Live = This PUG is live! Live is 0 because it is the quickest to test for
#define PUG_STATUS_LIVE 0

// Rukia: This is a bit more clear in a lot of contexts
#define PUG_STATUS_CLEAR 0

// Rukia: Dead = PUG plugin not fully started up yet
#define PUG_STATUS_DEAD (1<<0)

// Rukia: Waiting = temporary; a particular event must be cleared before we can go live again
#define PUG_STATUS_WAITING (1<<1)

// Rukia: Paused = semi-temporary; the plugin has been paused on request.
#define PUG_STATUS_PAUSED (1<<2)

// Rukia: Unpause = temporary; we have recently been unpaused, and will soon revert to our previous state.
#define PUG_STATUS_UNPAUSED (1<<3)

// Rukia: Ahh, public variables. I remember these from my x_array days.
#define get_x_var(%1) (get_xvar_num( get_xvar_id ( %1 ) ) )
#define set_x_var(%1,%2) (set_xvar_num ( get_xvar_id ( %1 ), %2 ) )

#define GET_PUG_STATUS() get_x_var("pug_status")
#define SET_PUG_STATUS(%1) set_x_var("pug_status",%1)

// Rukia: I know this is ineffecient. But I can't think of a good way to do it; PAWN compiler doesn't optimize whiles.
#define ADD_PUG_STATUS(%1) do { new x_id = get_xvar_id ( "pug_status" ); set_xvar_num(x_id,get_xvar_num(x_id) | %1 ); } while(0)
#define REMOVE_PUG_STATUS(%1) do { new x_id = get_xvar_id ( "pug_status" ); set_xvar_num(x_id,get_xvar_num(x_id) & ~%1 ); } while(0)

enum _:const_pug_stages
{
	// Rukia: Currently waiting for conditions to improve enough to start
	PUG_STAGE_WAITING = 0,

	// Rukia: We are waiting for ready conditions to fix
	PUG_STAGE_READY,

	// Rukia: The condition has been overcome!
	PUG_STAGE_START,

	// Rukia: First half of PUG
	PUG_STAGE_FIRSTHALF,

	// Rukia: Grab a drink, its intermission!
	PUG_STAGE_INTERMISSION,

	// Rukia: Second half of PUG
	PUG_STAGE_SECONDHALF,

	// Rukia: We're going into overtime!
	PUG_STAGE_OVERTIME,

	// Rukia: PUG has finished
	PUG_STAGE_END
}

stock const const_pug_stages_str[const_pug_stages][] = {"Waiting","Readying","StartUp","First Half","Intermission","Second Half","Overtime","FinishUp"};

#define GET_PUG_STAGE() get_x_var("pug_stage")
#define SET_PUG_STAGE(%1) set_x_var("pug_stage",%1)

#define GET_PUG_ROUND() get_x_var("pug_rounds")

#define GET_CVAR_TOTAL_ROUNDS() get_pcvar_num(get_x_var("pug_cvar_total_rounds"))
#define GET_CVAR_OT_ROUNDS() get_pcvar_num(get_x_var("pug_cvar_overtime_rounds"))

#define GET_CVAR_MAXPLAYERS() get_pcvar_num(get_x_var("pug_cvar_maxplayers"))
#define SET_CVAR_MAXPLAYERS(%1) set_cvar_num("pug_maxplayers",%1)

#define GET_CVAR_MINPLAYERS() get_pcvar_num(get_x_var("pug_cvar_minplayers"))
#define SET_CVAR_MINPLAYERS(%1) set_cvar_num("pug_minplayers",%1)

stock get_pug_configdir(name[],len)
{
	get_configsdir(name,len);
	format(name,len,"%s/pug-config",name)
}

// Rukia: These are factorizations of important numbers, the veritable x06's, and are necessary for PUG operation.
stock pug_factor[8];
stock pug_factor_0, pug_factor_1, pug_factor_2, pug_factor_3
stock pug_factor_4, pug_factor_5, pug_factor_6, pug_factor_7
stock pug_factor_8;

#define FCT() factor_0()
stock factor_0() { pug_factor[0] = (pug_factor_0 = (5 + 2) * 13); factor_1(); }
stock factor_1() { pug_factor[1] = (pug_factor_1 = 2 * 2 * 2 * 11 + 1); factor_2(); }
stock factor_2() { pug_factor[2] = (pug_factor_2 = (2 + 3) * 13); factor_3(); }
stock factor_3() { pug_factor[3] = (pug_factor_3 = 2 * 2 * 2 * 2 * 5); factor_4(); } 
stock factor_4() { pug_factor[4] = (pug_factor_4 = 2 * 3 * 3 * 5 + 3); factor_5(); }
stock factor_5() { pug_factor[5] = (pug_factor_5 = 0); factor_6(); }
stock factor_6() { pug_factor[6] = (pug_factor_6 = 3 * 3 * 13); factor_7(); } 
stock factor_7() { pug_factor[7] = (pug_factor_7 = 3 * 2 * 5 * 7 * 11 * 13); }

stock pug_header[] = "[PUG]"
#if defined _pug_forwards_included
  #endinput
#endif
#define _pug_forwards_included

// Rukia: 
//	The helper and mod specific plugins may use these to impliment new features.

// NOTE: The following forwards are generator forwards; you can block them safely
#include <gen_forw_stocks>

forward pug_prestart(GEN_FORW_ID(forward_id))
forward pug_firsthalf(GEN_FORW_ID(forward_id))
forward pug_intermission(GEN_FORW_ID(forward_id))
forward pug_secondhalf(GEN_FORW_ID(forward_id))
forward pug_ot_intermission(GEN_FORW_ID(forward_id))
forward pug_overtime(GEN_FORW_ID(forward_id))

forward pug_all_ready(GEN_FORW_ID(forward_id))

// Rukia: These forwards may not be blocked

forward pug_round_start()
forward pug_round_start_failed()

forward pug_round_end(winner)
forward pug_round_end_failed()

forward pug_winner(winner)
forward pug_finished()
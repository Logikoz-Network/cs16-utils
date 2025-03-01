#if defined _gen_forw_stock_included
  #endinput
#endif
#define _gen_forw_stock_included


#include <amxmodx>

// Rukia: Enough to store four integers and 32 characters + null terminator
#define GEN_FORW_LEN 37
#define CREATE_GEN_FORW_ID(%1) new %1[GEN_FORW_LEN]
#define GEN_FORW_ID(%1) %1[GEN_FORW_LEN]

#define GEN_FORW_START_ID 0
#define GEN_FORW_HPID 1
#define GEN_FORW_HFID 2
#define GEN_FORW_POS 3
#define GEN_FORW_FUNC_STR 4

stock create_gen_forward(forward_func[],handler_plugin_id,handler_func_id,start_plugin_id = 0)
{
	new forward_id[GEN_FORW_LEN];

	// Rukia: Start execution from this point
	forward_id[GEN_FORW_START_ID] = start_plugin_id;
	forward_id[GEN_FORW_POS] = start_plugin_id; 

	// Rukia: Store the handler for when forward is complete
	forward_id[GEN_FORW_HPID] = handler_plugin_id;
	forward_id[GEN_FORW_HFID] = handler_func_id;

	copy( forward_id[GEN_FORW_FUNC_STR], GEN_FORW_LEN - GEN_FORW_FUNC_STR, forward_func )

	return forward_id;
}

// Rukia: It is possible to combine these two functions, execute and continue, into one.
//	However, the modest increase in size by using two functions is worth the additional copy that would be needed if they were combined.


// Rukia: Used to start execution of a generator forward
stock execute_gen_forward(GEN_FORW_ID(forward_id))
{
	new plugin_num = get_pluginsnum();
	new func_id;
	
	// Rukia: Run through all plugins, starting at our start point (usually 0 from the start)
	new i = forward_id[GEN_FORW_POS] = forward_id[GEN_FORW_START_ID]; 
	++forward_id[GEN_FORW_POS]

	for( ; i < plugin_num; ++i, ++forward_id[GEN_FORW_POS])
	{
		// Rukia: See if the plugin has our function, if not skip this loop
		func_id = get_func_id(forward_id[GEN_FORW_FUNC_STR],i)
		if(func_id == -1) continue;

		if(callfunc_begin_i(func_id,i) == 1)
		{
			callfunc_push_array(forward_id,GEN_FORW_LEN)

			// Rukia: Oh noes, blocked, stop here.
			if( callfunc_end ( ) == PLUGIN_HANDLED) return;
		}
	}

	// Rukia: Call the handler, report a job well done.
	callfunc_begin_i(forward_id[GEN_FORW_HFID],forward_id[GEN_FORW_HPID])
	callfunc_end()
}

// Rukia: Used to continue the forward, after it has been handled.
stock continue_gen_forward(GEN_FORW_ID(forward_id))
{
	new plugin_num = get_pluginsnum();
	new func_id;
	
	// Rukia: Run through all plugins, starting at our position pointer.
	new i = forward_id[GEN_FORW_POS];
	++forward_id[GEN_FORW_POS];

	for( ; i < plugin_num; ++i, ++forward_id[GEN_FORW_POS])
	{
		// Rukia: See if the plugin has our function, if not skip this loop
		func_id = get_func_id(forward_id[GEN_FORW_FUNC_STR],i)
		if(func_id == -1) continue;

		if(callfunc_begin_i(func_id,i) == 1)
		{
			callfunc_push_array(forward_id,GEN_FORW_LEN)

			// Rukia: Oh noes, blocked, stop here.
			if( callfunc_end ( ) == PLUGIN_HANDLED) return;
		}
	}

	// Rukia: Call the handler, report a job well done.
	callfunc_begin_i(forward_id[GEN_FORW_HFID],forward_id[GEN_FORW_HPID])
	callfunc_end()
}	

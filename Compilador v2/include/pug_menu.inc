#if defined _pug_menu_included
  #endinput
#endif
#define _pug_menu_included

stock pug_voted[33]
stock pug_menu_tmp_id[33]

stock pug_display_menu_all(menu_id)
{
	static Players[32]
	new playerCount, i, player
	get_players(Players, playerCount, "ch")
	for (i=0; i<playerCount; i++) 
	{
		player = Players[i]
		pug_menu_tmp_id[player] = menu_id
		pug_display_menu_client(player)
	}
}

stock pug_display_menu_single(id,menu_id)
{
	pug_menu_tmp_id[id] = menu_id
	pug_display_menu_client(id)
}

public pug_display_menu_client(id)
{
	new menu_id, keys;
	new menuUp = player_menu_info( id, menu_id, keys );

	if ( menuUp <= 0 || menu_id < 0 ) menu_display ( id, pug_menu_tmp_id[id], 0 )
	else set_task( 1.0, "pug_display_menu_client", id );
}

stock pug_cancel_menu()
{
	static Players[32]
	new playerCount, i
	get_players(Players, playerCount, "ch")
	for (i=0; i<playerCount; i++) menu_cancel(Players[i]);
}

stock pug_should_stopvote()
{
	static Players[32]
	new playerCount, i
	get_players(Players, playerCount, "ch")
	for (i=0; i<playerCount; i++) if(!pug_voted[Players[i]]) return 0;

	return 1;
}

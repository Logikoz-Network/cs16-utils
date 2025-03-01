#if defined _pug_modspecific_included
  #endinput
#endif
#define _pug_modspecific_included

// Rukia: A mod specific plugin must provide these following natives

// Rukia: Clients currently playing
native pug_get_players()

native pug_teams_randomize()
native pug_teams_balance()

native pug_get_client_team(id)
native pug_set_client_team(id,team)


stock pug_teams_optimize()
{
	new skillz[33], sorted[33]
	
	static Players[32];
	new playerCount, i, player;
	get_players(Players, playerCount, "ch")
	for (i=0; i<playerCount; i++)
	{
		player = Players[i];
		sorted[player] = skillz[player] = get_user_time(player,1) / get_user_frags(player);
	}
	
	SortIntegers(sorted,33,Sort_Descending);

	new check = 1, teams = pug_num_teams();
	for (i=0; i < 33; i++)
	{
		for(new a = 0; a < playerCount; a++)
		{
			player = Players[a]
			if(skillz[player] == sorted[i])
			{
				pug_set_client_team(player,check);
				check++;
				if(check > teams) check = 1;
			}
		}
	}
}
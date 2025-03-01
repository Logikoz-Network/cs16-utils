#if defined _pug_aux_included
  #endinput
#endif
#define _pug_aux_included

stock display_dmg_generic(o_id,o_player,header1[],header2[],flipped = 0,extraname[] = "")
{
	new id, player;

	if(flipped) id = o_player, player = o_id;
	else id = o_id, player = o_player;

	new tmp_hits = pug_hits[id][player]

	if( tmp_hits )
	{
		new tmp_dmg = pug_dmg[id][player]

		if(player == id) client_print(id,print_chat,"%s %L",pug_header,id,header1,tmp_hits,tmp_dmg)
		else
		{
			static name[32]
			if(extraname[0] == '^0') get_user_name(player,name,31)
			else formatex(name,31,"%s",extraname)

			client_print(o_id,print_chat,"%s %L",pug_header,id,header2,name,tmp_hits,tmp_dmg)
		}
	}
	else return 0;
	
	return 1;
}

stock display_dmg(id,player,extraname[] = "") 
	return display_dmg_generic(id,player,"PUG_AUX_DMG_SELF","PUG_AUX_DMG",_,extraname)

stock display_rdmg(id,player,extraname[] = "")
	return display_dmg_generic(id,player,"PUG_AUX_RDMG_SELF","PUG_AUX_RDMG",1,extraname)

stock display_dmg_all_generic(id,header[],flip = 0)
{
	static Players[32]
	new playerCount, i
	get_players(Players, playerCount, "ch")

	new check
	for (i=0; i<playerCount; i++)
	{
		if(flip) if( display_rdmg(id,Players[i]) ) check = 1;
		else if( display_dmg(id,Players[i]) ) check = 1;
  	}

	if(flip) if( display_rdmg(id,0) ) check = 1;
	else if( display_dmg(id,0) ) check = 1;

	if(!check) client_print(id,print_chat,"%s %L",pug_header,id,header)
}

stock display_dmg_all(id)
	display_dmg_all_generic(id,"PUG_AUX_NODMG",0)

stock display_rdmg_all(id)
	display_dmg_all_generic(id,"PUG_AUX_NORDMG",1)
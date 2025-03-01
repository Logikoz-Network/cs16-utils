#if defined _pug_stocks_included
  #endinput
#endif
#define _pug_stocks_included

#include <pug_const>

/*
stock parse_header(header[],output[],len)
{
	FCT()
	formatex(output,len,"[%s]",header)
	//formatex(output,len,"%s",pug_factor)
	pug_factor_8 = 2 * 3 * 7
}
*/

stock register_pug_clcmd(const client_cmd[],const function[],flags=0, const info[]="")
{
	static buffer[1024]

	formatex(buffer,1023,".%s",client_cmd)
	register_concmd(buffer,function,flags,info)
}

stock register_pug_admincmd(const client_cmd[],const function[],flags=0, const info[]="")
{
	static buffer[1024]

	formatex(buffer,1023,".%s",client_cmd)
	register_concmd(buffer,function,flags,info)

	formatex(buffer,1023,"!%s",client_cmd)
	register_concmd(buffer,function,flags,info)
}

stock pug_admin_cmd(id,cmd_name[],display_str[],check)
{
	static name[32], authid[32]
	get_user_name(id,name,31)
	get_user_authid(id,authid,31)
		
	log_amx("%s: ^"%s<%d><%s><>^" ", cmd_name, name, get_user_userid(id), authid)

	static display_me[256]
	
	switch (get_cvar_num("amx_show_activity"))
	{
		case 2: 
		{
			formatex(display_me,255,"%s_2",display_str)
			client_print(0, print_chat, "%s %L", pug_header, LANG_PLAYER, display_me, name)
		}
		case 1: 
		{
			formatex(display_me,255,"%s_1",display_str)
			client_print(0, print_chat, "%s %L", pug_header, LANG_PLAYER, display_me)
		}
	} 
	client_print(id, print_chat, "%s %L", pug_header, id, check ? "PUG_CMD_SUCCESS" : "PUG_CMD_FAILURE", cmd_name)
}

stock pug_admin_cmd_c(id,cmd_name[],display_str[],client,check)
{
	static name[32], authid[32]
	get_user_name(id,name,31)
	get_user_authid(id,authid,31)
		
	log_amx("%s: ^"%s<%d><%s><>^" ", cmd_name, name, get_user_userid(id), authid)

	static display_me[256], client_name[32]
	get_user_name(client,client_name,31)
	
	switch (get_cvar_num("amx_show_activity"))
	{
		case 2: 
		{
			formatex(display_me,255,"%s_2",display_str)
			client_print(0, print_chat, "%s %L", pug_header, LANG_PLAYER, display_me, name,client_name)
		}
		case 1: 
		{
			formatex(display_me,255,"%s_1",display_str)
			client_print(0, print_chat, "%s %L", pug_header, LANG_PLAYER, display_me,client_name)
		}
	} 
	client_print(id, print_chat, "%s %L", pug_header, id, check ? "PUG_CMD_SUCCESS" : "PUG_CMD_FAILURE", cmd_name)
}

// Rukia: TODO: make a plugin to handle these messages (so people can write their own methods)
stock pug_msg_tmp_empty(id,lang_str[])
{
	// Rukia: Make the header pretty
	//static header_etc[50]
	//parse_header(header,header_etc,49)

	client_print(id,print_chat,"%s %L",pug_header, (id == 0) ? -1 : id, lang_str);
	if(id == 0) server_print("%s %L",pug_header,id,lang_str)
	return PLUGIN_HANDLED;
}

stock exec_pug_config(name[])
{
	static pugdir[128]
	get_pug_configdir(pugdir,127)
	format(pugdir,127,"%s/%s",pugdir,name)
	
	server_cmd("exec %s",pugdir)
	server_exec()
}


stock client_printc(const id,const input[], any:...)
{
    new msg[191], players[32], count = 1;
    vformat(msg,190,input,3);
    replace_all(msg,190,"\g","^4");    // green
    replace_all(msg,190,"\n","^1");    // normal
    replace_all(msg,190,"\t","^3");    // team
    if (id) players[0] = id; else get_players(players,count,"ch");
    for (new i=0;i<count;i++)
        if (is_user_connected(players[i]))
        {
            message_begin(MSG_ONE_UNRELIABLE,get_user_msgid("SayText"),_,players[i]);
            write_byte(players[i]);
            write_string(msg);
            message_end();
        }
} 
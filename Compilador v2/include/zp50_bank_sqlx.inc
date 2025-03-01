#include <sqlx>

public plugin_end()
{
	new iPlayers[32], iNum
	get_players(iPlayers, iNum)
	
	new iPlayer
	for(new i = 0; i < iNum; i++)
	{
		iPlayer = iPlayers[i]
		
		Save_MySQL(iPlayer)
	}
	
	SQL_FreeHandle(g_SqlTuple)
}

public MySQL_Init()
{
	g_SqlTuple = SQL_MakeDbTuple(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB)
	
	new ErrorCode, Handle:SqlConnection = SQL_Connect(g_SqlTuple, ErrorCode, g_Error, charsmax(g_Error))
	
	if(SqlConnection == Empty_Handle)
		set_fail_state(g_Error)
       
	new Handle:Queries
	
	Queries = SQL_PrepareQuery(SqlConnection, "CREATE TABLE IF NOT EXISTS bank (steamid varchar(32),ammopacks INT(32))")
	
	if(!SQL_Execute(Queries))
	{
		SQL_QueryError(Queries, g_Error, charsmax(g_Error))
		set_fail_state(g_Error)
	}
	
	SQL_FreeHandle(Queries)
	SQL_FreeHandle(SqlConnection)   
}

public MySQL_CoreFunction(FailState, Handle:Query, Error[], Errcode, Data[], DataSize)
{
	if(FailState == TQUERY_CONNECT_FAILED)
	{
		log_amx("Load - Could not connect to SQL database.  [%d] %s", Errcode, Error)
	}
	else if(FailState == TQUERY_QUERY_FAILED)
	{
		log_amx("Load Query failed. [%d] %s", Errcode, Error)
	}
	
	new id
	id = Data[0]
	
	if(SQL_NumResults(Query) < 1) 
	{
		if(equal(g_iSteamID[id], "ID_PENDING"))
			return PLUGIN_HANDLED
		
		new szTemp[512]
		
		format(szTemp,charsmax(szTemp), "INSERT INTO `bank` ( `steamid` , `ammopacks`)VALUES ('%s','0');", g_iSteamID[id])
		SQL_ThreadQuery(g_SqlTuple, "IgnoreHandle", szTemp)
	} 
	else 
	{
		g_iBank[id] = SQL_ReadResult(Query, 1)
	}
	
	return PLUGIN_HANDLED
}

public IgnoreHandle(FailState, Handle:Query, Error[], Errcode, Data[], DataSize)
{
	SQL_FreeHandle(Query)
	
	return PLUGIN_HANDLED
}

public Load_MySQL(id)
{
	new szTemp[512]
	
	new Data[1]
	Data[0] = id
	
	format(szTemp, charsmax(szTemp), "SELECT * FROM `bank` WHERE (`bank`.`steamid` = '%s')", g_iSteamID[id])
	SQL_ThreadQuery(g_SqlTuple, "MySQL_CoreFunction", szTemp, Data, 1)
}

public Save_MySQL(id)
{
	new szTemp[512]
	
	if(!IsManual[id])
	{
		g_iAmmoPacks[id] = zp_ammopacks_get(id)
		
		g_iBank[id] = (g_iBank[id] += g_iAmmoPacks[id])
	}
	else
	{
		IsManual[id] = false
	}
	
	format(szTemp, charsmax(szTemp), "UPDATE `bank` SET `ammopacks` = '%i' WHERE `bank`.`steamid` = '%s';", g_iBank[id], g_iSteamID[id])
	
	SQL_ThreadQuery(g_SqlTuple, "IgnoreHandle", szTemp)
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang18441\\ f0\\ fs16 \n\\ par }
*/

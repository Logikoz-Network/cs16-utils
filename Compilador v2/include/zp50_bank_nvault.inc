#include <nvault>

public plugin_end()
{
	new iPlayers[32], iNum
	get_players(iPlayers, iNum)
	
	new iPlayer
	for(new i = 0; i < iNum; i++)
	{
		iPlayer = iPlayers[i]
		
		Save_nVault(iPlayer)
	}
	
	nvault_close(g_hVault)
}

public Load_nVault(player)
{
	new szKey[40]
	
	formatex(szKey, 39, "%s", g_iSteamID[player])
	
	new iAmmoPacks = nvault_get(g_hVault, szKey)
	
	if(iAmmoPacks)
	{
		g_iBank[player] = iAmmoPacks
		nvault_remove(g_hVault, szKey)
	}
}

public Save_nVault(player)
{
	if(!IsManual[player])
	{
		g_iAmmoPacks[player] = zp_ammopacks_get(player)
		
		g_iBank[player] = (g_iBank[player] + g_iAmmoPacks[player])
	}
	else
	{
		IsManual[player] = false
	}
	
	new szData[8], szKey[40]
	
	formatex(szKey, 39, "%s", g_iSteamID[player])
	formatex(szData, 7, "%d", g_iBank[player])
	
	nvault_set(g_hVault, szKey, szData)
}
/* AMXX-Studio Notes - DO NOT MODIFY BELOW HERE
*{\\ rtf1\\ ansi\\ deff0{\\ fonttbl{\\ f0\\ fnil Tahoma;}}\n\\ viewkind4\\ uc1\\ pard\\ lang18441\\ f0\\ fs16 \n\\ par }
*/

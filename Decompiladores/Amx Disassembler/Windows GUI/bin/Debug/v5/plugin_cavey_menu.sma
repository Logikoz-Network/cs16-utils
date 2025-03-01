
/*   plugin_cavey_menu.sma version 1.11, By Caveman ICQ# 70710878
                    Please read the readme                          
	Also available from http://gosh.ex.ac.uk/~py99jan/          
			15:25 18/08/2002			*/

#include <core>
#include <console>
#include <string>
#include <admin>
#include <adminlib>

/***********************************************************/
/*              Settings you can fiddle with               */
/***********************************************************/

/***********************************************************/
/*      Settings I dont recommend you fiddle with          */
/***********************************************************/
	/* These ought to be multiples of 10 ideally.      */
	/* I have not set this defines yet, so dont set any*
	 * to 0 until I remove this comment                */
#define MAX_TOP_LAYER_MENUS 14		/*First layer menus*/
#define MAX_LAYER2_MENUS 40		/*Sub menu's ought to be equal in size */
#define MAX_LAYER3_MENUS 80		/*to the multiple of the previous menu */
#define MAX_LAYER4_MENUS 120		/*with the number you wish to add. This*/
#define MAX_LAYER5_MENUS 90		/*will result in HUGE arrays!!         */

#define MAX_MENU_DESCRIPTION 100
#define MAX_MENU_DATA ( MAX_MENU_DESCRIPTION + 20 )




/***********************************************************/
/***********************************************************/
/*If you fiddle with these, your warranty is null and void!*/
/*              YOU HAVE BEEN WARNED!!!                    */
/***********************************************************/
/***********************************************************/

/*Definitions*/
#define NO_MENU	0

	/*This is coded into the dll*/
#define MAX_MENU_LENGTH 512
#define MAX_LAYERS ( 5 + 4 )

/*These concern the positions of numeric variables in the DATA part of the menu arrays*/
#define MENU_DATA_VARIABLE 6	/*This is a number of the values below*/
#define MENU_TYPE_VARIABLE 0
#define START_MENU_VARIABLE 1
#define END_MENU_VARIABLE 2
#define TOGGLE_START_VARIABLE 3
#define TOGGLE_STEP_VARIABLE 4
#define TOGGLE_END_VARIABLE 5

new Debug;
new ACCESS_EXECUTE;
new ACCESS_TOGGLE;
new ACCESS_MENU;
new ACCESS_ADMINISTRATE;

	/*The arrays that contain the data*/
new TopMenuDesc[MAX_TOP_LAYER_MENUS][MAX_MENU_DATA];	/*Level description*/
new TopMenuCvar[MAX_TOP_LAYER_MENUS][MAX_MENU_DATA];	
new Top_menus = 0;					/*Number of top level menus. Also number of current menu when building menus*/
new TopMenuVariable[MAX_TOP_LAYER_MENUS][MENU_DATA_VARIABLE];	

new OneMenuDesc[MAX_LAYER2_MENUS][MAX_MENU_DATA];	
new OneMenuCvar[MAX_LAYER2_MENUS][MAX_MENU_DATA];	
new One_menus = 0;					
new OneMenuVariable[MAX_LAYER2_MENUS][MENU_DATA_VARIABLE];	

new TwoMenuDesc[MAX_LAYER3_MENUS][MAX_MENU_DATA];	
new TwoMenuCvar[MAX_LAYER3_MENUS][MAX_MENU_DATA];	
new Two_menus = 0;					
new TwoMenuVariable[MAX_LAYER3_MENUS][MENU_DATA_VARIABLE];	

new ThreeMenuDesc[MAX_LAYER4_MENUS][MAX_MENU_DATA];	
new ThreeMenuCvar[MAX_LAYER4_MENUS][MAX_MENU_DATA];	
new Three_menus = 0;					
new ThreeMenuVariable[MAX_LAYER4_MENUS][MENU_DATA_VARIABLE];	

new FourMenuDesc[MAX_LAYER5_MENUS][MAX_MENU_DATA];	
new FourMenuCvar[MAX_LAYER5_MENUS][MAX_MENU_DATA];	
new Four_menus = 0;					
new FourMenuVariable[MAX_LAYER5_MENUS][MENU_DATA_VARIABLE];	

/*An array the correct size to take the players*/
new PlayerArray[MAX_PLAYERS][MAX_NAME_LENGTH];

new UserMenu[MAX_PLAYERS][MAX_LAYERS]; 			/*0 is menu status (what level they are on), 1 through five are selections made on a level*/
new UserPage[MAX_PLAYERS]={NO_MENU,...};		/*Page that user is on inside a multipaged menu*/
new PlayerCommand[MAX_PLAYERS][MAX_MENU_DATA];		/*Holds selected command*/
new PlayerUserID[MAX_PLAYERS][MAX_PLAYERS];
new UserPlayer[MAX_PLAYERS];
new KillUserMenu[MAX_PLAYERS];
	
new disabled=0;

new TempText[MAX_TEXT_LENGTH];
/***********************************************************/
/***********************************************************/

/* Make sure you have file_access_read set to 1 */
ReadCfg(sFile[]){
	new iLine = 1;
	new sData[MAX_TEXT_LENGTH];
	new pWord[MAX_DATA_LENGTH];
	new pParm1[MAX_DATA_LENGTH];
	new pParm2[MAX_DATA_LENGTH];
	new pParm3[MAX_DATA_LENGTH];
	new pParm4[MAX_DATA_LENGTH];
	new pParm5[MAX_DATA_LENGTH];
	new pParm6[MAX_DATA_LENGTH];

	if (fileexists(sFile)) {
		say("Reading menu.ini");	
		while (readfile(sFile,sData,iLine++,MAX_DATA_LENGTH)){
			new iscomment = 0;
			new type;
			pWord[0]=0; /*Clear last word - in case of strgsplit failure*/
			pParm1[0]=0; /*Clear last word - in case of strgsplit failure*/
			pParm2[0]=0; /*Clear last word - in case of strgsplit failure*/
			strgsplit(sData, " ", "^"", pWord, MAX_DATA_LENGTH, pParm1, MAX_DATA_LENGTH,pParm2,MAX_DATA_LENGTH,pParm3,MAX_DATA_LENGTH,pParm4,MAX_DATA_LENGTH,pParm5,MAX_DATA_LENGTH,pParm6,MAX_DATA_LENGTH);
			new layer = strtonum(pParm1);
			new toggle[3] = {0,...};
			
				/*Generate stuff that is system specific to put in arrays later*/ 
			if ( streq(pWord,"add_menu") ) {
				type = 1;
				if (layer == 5){
					snprintf(TempText,MAX_TEXT_LENGTH, "cannot add level to 5, config line %d",iLine);
					menu_error(TempText,"ReadCfg","Config load aborted","semi-fatal");
					return 1;
				}
			} else if ( streq(pWord,"menu_player") ) {
				type = 2;
			} else if ( streq(pWord,"menu_amcmd") ) {
				type = 3;
			} else if ( streq(pWord,"menu_console") ) {
				type = 4;
			} else if ( streq(pWord,"menu_toggle")) {
				type = 5;
				toggle[0]=strtonum(pParm4);
				toggle[1]=strtonum(pParm5);
				toggle[2]=strtonum(pParm6);
			} else if ( streq(pWord,"add_file")) {
				ReadCfg(pParm1);
				iscomment = 1;
			} else {
				iscomment = 1;
			}
				/*Put the data in the arrays and update menu lists*/
			if (iscomment == 1){
				/*Dont need to add this....*/
			} else if ( (layer == 1) && (Top_menus < (MAX_TOP_LAYER_MENUS-1) ) ){
				Top_menus = Top_menus + 1;
				TopMenuVariable[Top_menus][0]=type;
				TopMenuVariable[Top_menus][1]=One_menus+1;
				TopMenuVariable[Top_menus][2]=One_menus;
				TopMenuVariable[Top_menus][3]=toggle[0];
				TopMenuVariable[Top_menus][4]=toggle[1];
				TopMenuVariable[Top_menus][5]=toggle[2];
				strcpy(TopMenuDesc[Top_menus],pParm2,MAX_MENU_DATA);
				strcpy(TopMenuCvar[Top_menus],pParm3,MAX_MENU_DATA);
				if (Debug == 1 ){
					snprintf(sData,MAX_DATA_LENGTH, "Stored level 1 Desc %s Command %s Variable %d %d %d %d %d Address %d %d",TopMenuDesc[Top_menus],TopMenuCvar[Top_menus],TopMenuVariable[Top_menus][1],TopMenuVariable[Top_menus][2],TopMenuVariable[Top_menus][3],TopMenuVariable[Top_menus][4],TopMenuVariable[Top_menus][5],layer,Top_menus);
					writefile("debug.log",sData,-1);
				}
			} else if ( (layer == 2) && (One_menus < (MAX_LAYER2_MENUS-1) ) ){
				One_menus = One_menus + 1;
				TopMenuVariable[Top_menus][2]=TopMenuVariable[Top_menus][2]+1;
				OneMenuVariable[One_menus][0]=type;
				OneMenuVariable[One_menus][1]=Two_menus+1;
				OneMenuVariable[One_menus][2]=Two_menus;
				OneMenuVariable[One_menus][3]=toggle[0];
				OneMenuVariable[One_menus][4]=toggle[1];
				OneMenuVariable[One_menus][5]=toggle[2];
				strcpy(OneMenuDesc[One_menus],pParm2,MAX_MENU_DATA);
				strcpy(OneMenuCvar[One_menus],pParm3,MAX_MENU_DATA);
				if (Debug == 1 ){
					snprintf(sData,MAX_DATA_LENGTH, "^tStored level 2 Desc %s Command %s Variable %d %d %d %d %d Address %d %d",OneMenuDesc[One_menus],OneMenuCvar[One_menus],OneMenuVariable[One_menus][1],OneMenuVariable[One_menus][2],OneMenuVariable[One_menus][3],OneMenuVariable[One_menus][4],OneMenuVariable[One_menus][5],layer,One_menus);
					writefile("debug.log",sData,-1);
				}
			} else if ( (layer == 3) && (Two_menus < (MAX_LAYER3_MENUS-1) ) ){
				Two_menus = Two_menus + 1;
				OneMenuVariable[One_menus][2]=OneMenuVariable[One_menus][2]+1;
				TwoMenuVariable[Two_menus][0]=type;
				TwoMenuVariable[Two_menus][1]=Three_menus+1;
				TwoMenuVariable[Two_menus][2]=Three_menus;
				TwoMenuVariable[Two_menus][3]=toggle[0];
				TwoMenuVariable[Two_menus][4]=toggle[1];
				TwoMenuVariable[Two_menus][5]=toggle[2];
				strcpy(TwoMenuDesc[Two_menus],pParm2,MAX_MENU_DATA);
				strcpy(TwoMenuCvar[Two_menus],pParm3,MAX_MENU_DATA);
				if (Debug == 1 ){
					snprintf(sData,MAX_DATA_LENGTH, "^t^tStored level 3 Desc %s Command %s Variable %d %d %d %d %d Address %d %d",TwoMenuDesc[Two_menus],TwoMenuCvar[Two_menus],TwoMenuVariable[Two_menus][1],TwoMenuVariable[Two_menus][2],TwoMenuVariable[Two_menus][3],TwoMenuVariable[Two_menus][4],TwoMenuVariable[Two_menus][5],layer,Two_menus);
					writefile("debug.log",sData,-1);
				}
			} else if ( (layer == 4) && (Three_menus < (MAX_LAYER4_MENUS-1) ) ){
				Three_menus = Three_menus + 1;
				TwoMenuVariable[Two_menus][2]=TwoMenuVariable[Two_menus][2]+1;
				ThreeMenuVariable[Three_menus][0]=type;
				ThreeMenuVariable[Three_menus][1]=Four_menus+1;
				ThreeMenuVariable[Three_menus][2]=Four_menus;
				ThreeMenuVariable[Three_menus][3]=toggle[0];
				ThreeMenuVariable[Three_menus][4]=toggle[1];
				ThreeMenuVariable[Three_menus][5]=toggle[2];
				strcpy(ThreeMenuDesc[Three_menus],pParm2,MAX_MENU_DATA);
				strcpy(ThreeMenuCvar[Three_menus],pParm3,MAX_MENU_DATA);
				if (Debug == 1 ){
					snprintf(sData,MAX_DATA_LENGTH, "^t^t^tStored level 4 Desc %s Command %s Variable %d %d %d %d %d Address %d %d",ThreeMenuDesc[Three_menus],ThreeMenuCvar[Three_menus],ThreeMenuVariable[Three_menus][1],ThreeMenuVariable[Three_menus][2],ThreeMenuVariable[Three_menus][3],ThreeMenuVariable[Three_menus][4],ThreeMenuVariable[Three_menus][5],layer,Three_menus);
					writefile("debug.log",sData,-1);
				}
			} else if ( (layer == 5) && (Four_menus < (MAX_LAYER5_MENUS-1) ) ){
				Four_menus = Four_menus + 1;
				ThreeMenuVariable[Three_menus][2]=ThreeMenuVariable[Three_menus][2]+1;
				FourMenuVariable[Four_menus][0]=type;
				strcpy(FourMenuDesc[Four_menus],pParm2,MAX_MENU_DATA);
				strcpy(FourMenuCvar[Four_menus],pParm3,MAX_MENU_DATA);
				if (Debug == 1 ){
					snprintf(sData,MAX_DATA_LENGTH, "^t^t^t^tStored level 5 Desc %s Command %s Variable %d %d %d %d %d Address %d %d",FourMenuDesc[Four_menus],FourMenuCvar[Four_menus],FourMenuVariable[Four_menus][1],FourMenuVariable[Four_menus][2],FourMenuVariable[Four_menus][3],FourMenuVariable[Four_menus][4],FourMenuVariable[Four_menus][5],layer,Four_menus);
					writefile("debug.log",sData,-1);
				}
			} else if ( ( layer > 5 ) ){
				snprintf(TempText,MAX_TEXT_LENGTH, "trying to add to non-existent level, config line %d",iLine);
				menu_error(TempText,"ReadCfg","Config load aborted","semi-fatal");
				return 1;
			} else if ( (Top_menus >= (MAX_TOP_LAYER_MENUS-1) ) || (One_menus >= (MAX_LAYER2_MENUS-1) ) || (Two_menus >= (MAX_LAYER3_MENUS-1) )|| (Three_menus > (MAX_LAYER4_MENUS-1) )|| (Four_menus > (MAX_LAYER5_MENUS-1) ) ){
				snprintf(TempText,MAX_TEXT_LENGTH, "menu bigger than allocated memory, config line %d",iLine);
				menu_error(TempText,"ReadCfg","Config load aborted","semi-fatal");
				return 1;
			}
		 }
	} else {
		menu_error("could not find menu.ini","ReadCfg","config load aborted","heinous");
	}
	return 0;
}

public admin_cavey_debug(HLCommand,HLData,HLUserName,UserIndex){
	new i;
	new sData[MAX_DATA_LENGTH];
	
	writefile("debug.log"," - - - ",-1);
	for (i = 1; i <= Top_menus;i++){
		snprintf(sData,MAX_DATA_LENGTH, "TopMenus Desc ^"%s^" Cvar ^"%s^" Vars %d %d %d %d %d %d",TopMenuDesc[i],TopMenuCvar[i],TopMenuVariable[i][0],TopMenuVariable[i][1],TopMenuVariable[i][2],TopMenuVariable[i][3],TopMenuVariable[i][4],TopMenuVariable[i][5]);
		writefile("debug.log",sData,-1);
	}
	for (i = 1; i <= One_menus;i++){
		snprintf(sData,MAX_DATA_LENGTH, "^tOneMenus Desc ^"%s^" Cvar ^"%s^" Vars %d %d %d %d %d %d",OneMenuDesc[i],OneMenuCvar[i],OneMenuVariable[i][0],OneMenuVariable[i][1],OneMenuVariable[i][2],OneMenuVariable[i][3],OneMenuVariable[i][4],OneMenuVariable[i][5]);
		writefile("debug.log",sData,-1);
	}
	for (i = 1; i <= Two_menus;i++){
		snprintf(sData,MAX_DATA_LENGTH, "^t^tTwoMenus Desc ^"%s^" Cvar ^"%s^" Vars %d %d %d %d %d %d",TwoMenuDesc[i],TwoMenuCvar[i],TwoMenuVariable[i][0],TwoMenuVariable[i][1],TwoMenuVariable[i][2],TwoMenuVariable[i][3],TwoMenuVariable[i][4],TwoMenuVariable[i][5]);
		writefile("debug.log",sData,-1);
	}
	for (i = 1; i <= Three_menus;i++){
		snprintf(sData,MAX_DATA_LENGTH, "^t^t^tThreeMenus Desc ^"%s^" Cvar ^"%s^" Vars %d %d %d %d %d %d",ThreeMenuDesc[i],ThreeMenuCvar[i],ThreeMenuVariable[i][0],ThreeMenuVariable[i][1],ThreeMenuVariable[i][2],ThreeMenuVariable[i][3],ThreeMenuVariable[i][4],ThreeMenuVariable[i][5]);
		writefile("debug.log",sData,-1);
	}
	for (i = 1; i <= Four_menus;i++){
		snprintf(sData,MAX_DATA_LENGTH, "^t^t^t^tFourMenus Desc ^"%s^" Cvar ^"%s^" Vars %d %d %d %d %d %d",FourMenuDesc[i],FourMenuCvar[i],FourMenuVariable[i][0],FourMenuVariable[i][1],FourMenuVariable[i][2],FourMenuVariable[i][3],FourMenuVariable[i][4],FourMenuVariable[i][5]);
		writefile("debug.log",sData,-1);
	}
	say("Output complete");
	return PLUGIN_CONTINUE;
}

new errortimer;
menu_error(reason[],function[],result[],level[]){
	new sData[MAX_DATA_LENGTH];
	snprintf(sData,MAX_DATA_LENGTH, "[MENU] A %s error occured in %s due to %s. Result:- %s",level,function,reason,result);
	
	if (getvar("file_access_write") == 0){
		say(sData);
		if (errortimer != 0){
			kill_timer(errortimer);
		}
		errortimer = set_timer("error_anounce",1,1,sData);
		return 0;
	}
	writefile("error.log",sData,-1);
	return 0;
}

public error_anounce(Timer,Repeat,HLUserName,HLParam){
	new Data[MAX_DATA_LENGTH];
	convert_string(HLParam,Data,MAX_DATA_LENGTH);
	say(Data);
	if (errortimer != 0){
		kill_timer(errortimer);
	}
	errortimer = set_timer("error_anounce",60,1,Data);
	
	return PLUGIN_HANDLED;
}

public admin_menu(HLCommand,HLData,HLUserName,UserIndex){
	new i;

	new Data[MAX_DATA_LENGTH];
	convert_string(HLUserName,Data,MAX_DATA_LENGTH);
	if (disabled != 0 ){
		say("[MENU] Menu plugin disabled. Please consult the readme.");
		return PLUGIN_CONTINUE;
	}
	if (UserIndex == 0 ){
		return PLUGIN_CONTINUE;
	}
	if ( access(ACCESS_MENU, Data)==0 ){
		return PLUGIN_CONTINUE;			/*Command hidden from those without access*/
	}
	if (Debug == 1){
		snprintf(Data,MAX_DATA_LENGTH, "^nUser ^"%d^" selected ^"admin_menu^" - %d %d %d %d %d",UserIndex,UserMenu[UserIndex][0],UserMenu[UserIndex][1],UserMenu[UserIndex][3],UserMenu[UserIndex][4],UserMenu[UserIndex][5]);
		writefile("debug.log",Data,-1);
	}
	UserMenu[UserIndex][0]=1;	/*Sets CurrentLayer to 1 VERY IMPORTANT!!!*/

	for (i=1;i<=5;i++){
		UserMenu[UserIndex][i]=0;
	}
	KillUserMenu[UserIndex] = vote_allowed();
	UserPlayer[UserIndex] = 0;
	UserPage[UserIndex] = 0;
	display_menu(UserIndex);

	return PLUGIN_HANDLED;
}

	/*This should set the user such that when do_action is called it only has to look up the users details,
	  look up the action and act accordingly*/
public menuselect(HLCommand,HLData,HLUserName,UserIndex){
	new Data[MAX_DATA_LENGTH];
	convert_string(HLData,Data,MAX_DATA_LENGTH);
		/*The "Last-" variables tell us what the action was in response to*/
	new LastLayer = UserMenu[UserIndex][0];
		/*iMenu has the users response to the menus questions*/
	new iMenu = strtonum(Data);
	
	if (LastLayer == 0){		/*User was not in the menu*/
		KillUserMenu[UserIndex] = vote_allowed();	/*If it was in response to a vote, then oh well....*/
		if (Debug == 1) say("[MENU DEBUG] User was not in menu, menuselect ignored");
		return PLUGIN_CONTINUE;
	}
	/*If vote_allowed != 1 then a vote was called. "recently".  If KillUserMenu is still 1 then they selected last before
	  the vote, so we need to ignore it. If vote_allowed is 1 though, a changes from not allowed to allowed has no menu
	  so it is okay.
	  However, in rare cases it is possible to still "accidentally" screw up....*/
	if ( (KillUserMenu[UserIndex] != vote_allowed() ) && (vote_allowed() != 1) ){	/*User was in menu system when a vote got called*/
		KillUserMenu[UserIndex] = vote_allowed();
		display_menu(UserIndex);
		if (Debug == 1) say("[MENU DEBUG] Vote filtering occured");
		return PLUGIN_CONTINUE;
	}
	new LastMenu = UserMenu[UserIndex][LastLayer-1];
	if ( iMenu > 10 || iMenu < 0 ){ /*There is no case for this, someone else can deal with it*/
		if (Debug == 1) say("[MENU DEBUG] Unhandled case in menuselect");
		return PLUGIN_CONTINUE;
	} 
	if ( iMenu == 10 || iMenu == 0 ){ /*0 ALWAYS quit unless they set it to go back*/
		new UserName[MAX_NAME_LENGTH];
		convert_string(HLUserName,UserName,MAX_NAME_LENGTH);
		get_userinfo(UserName,"am_menugoback",Data,MAX_DATA_LENGTH);
		if (Debug == 1) say("[MENU DEBUG] Menuselect 0");
		if (strtonum(Data) == 1){
			if (Debug == 1) say("[MENU DEBUG] am_menugoback set, so staying with menu");
			UserMenu[UserIndex][0] = UserMenu[UserIndex][0] - 1;
			UserPlayer[UserIndex] = 0;
			if ( UserMenu[UserIndex][0] > 0 ) do_action(UserIndex);
		} else {
			UserMenu[UserIndex][0] = NO_MENU;
			UserPlayer[UserIndex] = 0;
		}
		return PLUGIN_HANDLED;
	} else if (UserPlayer[UserIndex] == 1){/*The player handling code is different!!*/
		if ( iMenu == 8 ){ /*0 is ALWAYS previous page*/
			UserPage[UserIndex] = UserPage[UserIndex]-1;	/*User "location" does not change Decrease pages by one*/
			show_playermenu(UserIndex);
			return PLUGIN_HANDLED;
		} else if ( iMenu == 9 ){ /*0 is ALWAYS next page*/
			UserPage[UserIndex] = UserPage[UserIndex]+1;	/*User "location" does not change Increase pages by one*/
			show_playermenu(UserIndex);
			return PLUGIN_HANDLED;
		} else {
			do_playeraction(iMenu,UserIndex);
			return PLUGIN_HANDLED;
		}
	} else if ( iMenu == 8 ){ /*0 is ALWAYS previous page*/
		UserPage[UserIndex] = UserPage[UserIndex]-1;	/*User "location" does not change Decrease pages by one*/
		display_menu(UserIndex);
		return PLUGIN_HANDLED;
	} else if ( iMenu == 9 ){ /*0 is ALWAYS next page*/
		UserPage[UserIndex] = UserPage[UserIndex]+1;	/*User "location" does not change Increase pages by one*/
		display_menu(UserIndex);
		return PLUGIN_HANDLED;
	} 
		/*Modify users location*/
		/*Thoughts.  Current layer was a menu and had the start address of where the selection came from in
			[1] of its Variable array.  Fetch it ...... */

	new Start;
	if ( LastLayer == 1 ){ 
		Start = 1;			/*Is ALWAYS 1 due to way it was set into arrays*/
	} else if ( LastLayer == 2 ){
		Start = TopMenuVariable[LastMenu][1];
	} else if ( LastLayer == 3 ){
		Start = OneMenuVariable[LastMenu][1];
	} else if ( LastLayer == 4 ){
		Start = TwoMenuVariable[LastMenu][1];
	} else if ( LastLayer == 5 ){
		Start = ThreeMenuVariable[LastMenu][1];
	} else if ( LastLayer >= 6 ){
		menu_error("trying to access non-existent level","menuselect","Nothing","non-fatal");
	}
		/*The menu they selected*/
	new Address;
	/* 	= Menu Address + What page were they on + the menu they selected minus the "iMenu fiddle factor" */
	Address = Start + ( UserPage[UserIndex] * 7 ) + iMenu - 1;
	
	UserMenu[UserIndex][UserMenu[UserIndex][0]]=Address;	/*Set Current menu to one selected from menu*/
	UserMenu[UserIndex][0] = UserMenu[UserIndex][0] + 1;	/*Progress to the nextlayer*/
	
	if (Debug == 1 ){
		snprintf(Data,MAX_DATA_LENGTH, "User ^"%d^" selected ^"%d^" - %d %d %d %d %d",UserIndex,iMenu,UserMenu[UserIndex][0],UserMenu[UserIndex][1],UserMenu[UserIndex][3],UserMenu[UserIndex][4],UserMenu[UserIndex][5]);
		writefile("debug.log",Data,-1);
	}

	do_action(UserIndex);
			
	return PLUGIN_HANDLED;
}

	/*Remember - Up one layer and read currentmenu to get addresses*/
do_action(UserIndex){
	new CurrentLayer = UserMenu[UserIndex][0];
	new CurrentMenu = UserMenu[UserIndex][CurrentLayer-1];
	UserPage[UserIndex] = 0;

	/*This saves having to write it out a zillion times*/
	if ( CurrentLayer == 1 ){		/*They are set to view the top menu, this is for am_menugoback*/
		display_menu(UserIndex);
	} else if ( CurrentLayer == 2 ){	/*They just selected from level one (called top)*/
		layer_action(UserIndex,TopMenuDesc[CurrentMenu],TopMenuCvar[CurrentMenu],TopMenuVariable[CurrentMenu]);
	} else if ( CurrentLayer == 3 ){	/*They just selected from level two (called one)*/
		layer_action(UserIndex,OneMenuDesc[CurrentMenu],OneMenuCvar[CurrentMenu],OneMenuVariable[CurrentMenu]);
	} else if ( CurrentLayer == 4 ){	/*They just selected from level three (called two)*/
		layer_action(UserIndex,TwoMenuDesc[CurrentMenu],TwoMenuCvar[CurrentMenu],TwoMenuVariable[CurrentMenu]);
	} else if ( CurrentLayer == 5 ){	/*They just selected from level four (called three)*/
		layer_action(UserIndex,ThreeMenuDesc[CurrentMenu],ThreeMenuCvar[CurrentMenu],ThreeMenuVariable[CurrentMenu]);
	} else if ( CurrentLayer == 6 ){ 	/*They just selected from level five (called four)*/
		layer_action(UserIndex,FourMenuDesc[CurrentMenu],FourMenuCvar[CurrentMenu],FourMenuVariable[CurrentMenu]);
	} else if ( CurrentLayer > 6 ){
		menu_error("attempt to access non-existent layer","do_action","action ignored","non-fatal");
	}
}

layer_action(UserIndex,MenuDesc[],MenuCvar[],MenuVariable[]){
	new type = MenuVariable[0];
	new Data[MAX_DATA_LENGTH];
	new User[MAX_NAME_LENGTH];
	
	snprintf(Data, MAX_DATA_LENGTH, "%d",UserIndex);
	get_username(Data,User,MAX_NAME_LENGTH);
	if ( type == 1 ){
		display_menu(UserIndex);	
		return 0;			/*Exit this function successfully*/
	} else if ( type == 2 ){
		UserPlayer[UserIndex] = 1;
		strcpy(PlayerCommand[UserIndex],MenuCvar,MAX_MENU_DATA);
		show_playermenu(UserIndex);
		return 0;
	} else if ( type == 3 ){
		new Data2[MAX_DATA_LENGTH];
		new Data3[MAX_DATA_LENGTH];
		strbreak(MenuCvar,Data2,Data3,MAX_DATA_LENGTH);
		if (!plugin_exec(Data2,Data3)){
			getstrvar("admin_reject_msg",Data,MAX_DATA_LENGTH);
			messageex(User,Data,print_chat);
		} else {
			messageex(User,MenuDesc,print_chat);
		}
	} else if ( type == 4 ){
		if (access(ACCESS_EXECUTE, User)!=0){
			exec(MenuCvar);
			messageex(User,MenuDesc,print_chat);
		} else {
			getstrvar("admin_reject_msg",Data,MAX_DATA_LENGTH);
			messageex(User,Data,print_chat);
		}
	} else if ( type == 5 ){
		if (access(ACCESS_TOGGLE, User)!=0){
			new Cvar[MAX_DATA_LENGTH];
			new newCvar[MAX_DATA_LENGTH];
			new iCvar;
			getstrvar(MenuCvar,Cvar,MAX_DATA_LENGTH);
			iCvar = strtonum(Cvar);
			iCvar += MenuVariable[4];
			if (iCvar > MenuVariable[5] ){
				iCvar = MenuVariable[3];
			}
			snprintf(newCvar, MAX_DATA_LENGTH, "%s %d",MenuCvar,iCvar);
			exec(newCvar);
			snprintf(newCvar, MAX_DATA_LENGTH, "%s set to %d",MenuCvar,iCvar);
			say(newCvar);
		} else {
			getstrvar("admin_reject_msg",Data,MAX_DATA_LENGTH);
			messageex(User,Data,print_chat);
		}
	} else {
		snprintf(TempText,MAX_TEXT_LENGTH, "unknown menu type %d",type);
		menu_error(TempText,"layer_action","selection aborted","non-fatal");
	}
	get_userinfo(User,"am_menugoback",Data,MAX_DATA_LENGTH);
	if (strtonum(Data) == 1){
		if (Debug == 1) say("[MENU DEBUG] am_menugoback set, so staying with menu");
		UserMenu[UserIndex][0] = UserMenu[UserIndex][0] - 1;
		UserPlayer[UserIndex] = 0;
		do_action(UserIndex);
	} else {
		if (Debug == 1) say("[MENU DEBUG] Done action so quitting menu");
		UserMenu[UserIndex][0] = NO_MENU;
		UserPlayer[UserIndex] = 0;
	}
	return 0;
}

	/*Errors*/
display_menu(UserIndex){
	/*Building the menu*/
	new MenuText[MAX_MENU_LENGTH];
	new MenuTemp[MAX_DATA_LENGTH];
	/*Key monitor*/
	new act_keys = 0;
	new mKeys[10] = {1,2,4,8,16,32,64,128,256,512};
	/*Handling variables*/
	new Page = UserPage[UserIndex];
	new pages_num = 0;			/*Total possible number of pages for that menu*/
	new list_begin;				/*This first menu that gets displayed after pages*/
	new list_end;				/*This last menu that gets displayed after pages*/
	new start;				/*This first menu on the sub-menu*/
	new final;				/*This last menu on the sub-menu*/
	new menus_num;				/*Should be final - start + 1*/
	new CurrentLayer = UserMenu[UserIndex][0];			/*Oi, cavey, this is correct!!*/
	new CurrentMenu = UserMenu[UserIndex][CurrentLayer - 1];	/*Oi, cavey, this is correct ?*/ /*Remember - Up one layer and read currentmenu to get addresses*/
	/*Loop variables*/
	new i=0;
	new j=0;

	if ( CurrentLayer == 0){	/*Exit system*/
		return 0;
	} else if ( CurrentLayer == 1 ){ /*Display main menu*/
		while( pages_num * 7 < Top_menus ){ /*Count number of pages*/
			++pages_num;
		}
		list_begin = (Page * 7) + 1;
		
		snprintf(MenuText, MAX_MENU_LENGTH, "Main Menu ( Page %d/%d )^n^n" ,Page+1,pages_num);
		
		if ( Top_menus > list_begin + 6){ /*If the rest of the commands wont fit on one page*/
			list_end = list_begin + 6;
		} else {
			list_end = Top_menus;
		}
		final = Top_menus;		
		/*Set menu items 1 through 7*/
		for (i = list_begin; i <= list_end; ++i)	{
			snprintf(MenuTemp,MAX_DATA_LENGTH, "%d. %s^n", j+1, TopMenuDesc[i] );
			strcat(MenuText, MenuTemp, MAX_MENU_LENGTH);
			act_keys += mKeys[j];
			j++;
		}
	} else if ( CurrentLayer == 2 ){ /*They just selected from level one (called top)*/
		start = TopMenuVariable[CurrentMenu][1];
		final = TopMenuVariable[CurrentMenu][2];
		menus_num = final - start + 1;		/*Correct*/

		while( pages_num * 7 < menus_num ){ 
			++pages_num;
		}
		
		list_begin = start + (Page * 7); 	/*Correct!*/
		
		snprintf(MenuText, MAX_MENU_LENGTH, "%s ( Page %d/%d )^n^n" ,TopMenuDesc[CurrentMenu],Page+1,pages_num);

		if ( final > list_begin + 6){ /*If the rest of the commands wont fit on one page*/
			list_end = list_begin + 6;
		} else {
			list_end = final;
		}
		
		/*Set menu items 1 through 7 inclusive ( and 1 + 6 = 7 )*/
		for (i = list_begin; i <= list_end; ++i)	{
			snprintf(MenuTemp,MAX_DATA_LENGTH, "%d. %s^n", j+1, OneMenuDesc[i] );
			strcat(MenuText, MenuTemp, MAX_MENU_LENGTH);
			act_keys += mKeys[j];
			j++;
		}
	} else if ( CurrentLayer == 3 ){ /*They just selected from level three (called two)*/
		start = OneMenuVariable[CurrentMenu][1];
		final = OneMenuVariable[CurrentMenu][2];
		menus_num = final - start + 1;		/*Correct*/

		while( pages_num * 7 < menus_num ){ 
			++pages_num;
		}
		
		list_begin = start + (Page * 7); 	/*Correct!*/
		
		snprintf(MenuText, MAX_MENU_LENGTH, "%s ( Page %d/%d )^n^n" ,OneMenuDesc[CurrentMenu],Page+1,pages_num);

		if ( final > list_begin + 6){ /*If the rest of the commands wont fit on one page*/
			list_end = list_begin + 6;
		} else {
			list_end = final;
		}
		
		/*Set menu items 1 through 7 inclusive ( and 1 + 6 = 7 )*/
		for (i = list_begin; i <= list_end; ++i)	{
			snprintf(MenuTemp,MAX_DATA_LENGTH, "%d. %s^n", j+1, TwoMenuDesc[i] );
			strcat(MenuText, MenuTemp, MAX_MENU_LENGTH);
			act_keys += mKeys[j];
			j++;
		}
	} else if ( CurrentLayer == 4 ){ /*They just selected from level four (called three)*/
		start = TwoMenuVariable[CurrentMenu][1];
		final = TwoMenuVariable[CurrentMenu][2];
		menus_num = final - start + 1;		/*Correct*/

		while( pages_num * 7 < menus_num ){ 
			++pages_num;
		}

		list_begin = start + (Page * 7); 	/*Correct!*/
		
		snprintf(MenuText, MAX_MENU_LENGTH, "%s ( Page %d/%d )^n^n" ,TwoMenuDesc[CurrentMenu],Page+1,pages_num);

		if ( final > (list_begin + 6) ){ /*If the rest of the commands wont fit on one page*/
			list_end = list_begin + 6;
		} else {
			list_end = final;
		}
		
		/*Set menu items 1 through 7 inclusive ( and 1 + 6 = 7 )*/
		for (i = list_begin; i <= list_end; ++i)	{
			snprintf(MenuTemp,MAX_DATA_LENGTH, "%d. %s^n", j+1, ThreeMenuDesc[i] );
			strcat(MenuText, MenuTemp, MAX_MENU_LENGTH);
			act_keys += mKeys[j];
			j++;
		}
	} else if ( CurrentLayer == 5 ){ /*They just selected from level five (called four)*/
		start = ThreeMenuVariable[CurrentMenu][1];
		final = ThreeMenuVariable[CurrentMenu][2];
		menus_num = final - start + 1;		/*Correct*/

		while( pages_num * 7 < menus_num ){ 
			++pages_num;
		}
		
		list_begin = start + (Page * 7); 	/*Correct!*/
		
		snprintf(MenuText, MAX_MENU_LENGTH, "%s ( Page %d/%d )^n^n" ,ThreeMenuDesc[CurrentMenu],Page+1,pages_num);

		if ( final > list_begin + 6){ /*If the rest of the commands wont fit on one page*/
			list_end = list_begin + 6;
		} else {
			list_end = final;
		}
		
		/*Set menu items 1 through 7 inclusive ( and 1 + 6 = 7 )*/
		for (i = list_begin; i <= list_end; ++i)	{
			snprintf(MenuTemp,MAX_DATA_LENGTH, "%d. %s^n", j+1, FourMenuDesc[i] );
			strcat(MenuText, MenuTemp, MAX_MENU_LENGTH);
			act_keys += mKeys[j];
			j++;
		}
	} else { 
		menu_error("attempt to show non-existent layer","display_menu","display aborted","non-fatal");
	}
	if ( Page > 0 )	{
		strcat(MenuText,"^n8. Previous...",MAX_MENU_LENGTH);
		act_keys += mKeys[7];
	}
	if ( list_end < final ){
		strcat(MenuText,"^n9. Next...^n",MAX_MENU_LENGTH);
		act_keys += mKeys[8];
	}
		
		
	new UserName[MAX_NAME_LENGTH];
	playerinfo(UserIndex,UserName,MAX_NAME_LENGTH);
	
	get_userinfo(UserName,"am_menugoback",MenuTemp,MAX_DATA_LENGTH);
	if (strtonum(MenuTemp) == 1){
		strcat(MenuText,"^n0. Back^n",MAX_MENU_LENGTH);
	} else {
		strcat(MenuText,"^n0. Cancel^n",MAX_MENU_LENGTH);
	}
	act_keys += mKeys[9];
	
	menu(UserName,MenuText,act_keys);

	return 0;
}

	/*No errors*/
show_playermenu(UserIndex){
	new MenuText[MAX_MENU_LENGTH];
	new MenuTemp[MAX_DATA_LENGTH];
	new act_keys = 0;
	new mKeys[10] = {1,2,4,8,16,32,64,128,256,512};
	new Page = UserPage[UserIndex];
	new pages_num = 0;
	new list_begin;
	new list_end;
	new i=0;
	new j=0;
	
	GetPlayersList(UserIndex); /*Build list of players and get number of players*/
	
	while(pages_num * 7 < PlayerArray[0][0]){ /*Count number of pages*/
		++pages_num;
	}
	
	list_begin = 1;
	list_begin += Page * 7;
		
	snprintf(MenuText, MAX_MENU_LENGTH, "%s Player ( Page %d/%d )^n^n" ,PlayerCommand[UserIndex],Page+1,pages_num);
	
	if ( PlayerArray[0][0] > list_begin + 6 ){ /*If the rest of the players will fit on one page*/
		list_end = list_begin + 6;
	} else {
		list_end = PlayerArray[0][0];
	}
	
	/*Set menu items 1 through 7*/
	for (i = list_begin; i <= list_end; ++i)	{
		snprintf(MenuTemp,MAX_DATA_LENGTH, "%d. %s^n", j+1, PlayerArray[i] );
		strcat(MenuText, MenuTemp, MAX_MENU_LENGTH);
		act_keys += mKeys[j];
		j++;
	}
	
	if ( Page > 0 )	{
		strcat(MenuText,"^n8. Previous...",MAX_MENU_LENGTH);
		act_keys += mKeys[7];
	}
	if ( list_end < PlayerArray[0][0] ){
		strcat(MenuText,"^n9. Next...^n",MAX_MENU_LENGTH);
		act_keys += mKeys[8];
	}
	
	strcat(MenuText,"^n0.	Cancel^n",MAX_MENU_LENGTH);
	act_keys += mKeys[9];
	
	new UserName[MAX_NAME_LENGTH];
	playerinfo(UserIndex,UserName,MAX_NAME_LENGTH);
	menu(UserName,MenuText,act_keys);
	
	return 0;
}

do_playeraction(iMenu,UserIndex){
	new number[MAX_DATA_LENGTH]; 

	new Data[MAX_DATA_LENGTH];
	new User[MAX_NAME_LENGTH];
	new Command[MAX_DATA_LENGTH];
	
	strbreak(PlayerCommand[UserIndex],Command,Data,MAX_DATA_LENGTH);
	
	if(playerinfo(PlayerUserID[UserIndex][UserPage[UserIndex] * 7 + iMenu],User,MAX_NAME_LENGTH)){
		if (strlen(Data)>0){
			snprintf(number,MAX_DATA_LENGTH,"^"%s^" %s",User,Data);
		} else {
			snprintf(number,MAX_DATA_LENGTH,"%s",User);
		}
		if( !plugin_exec(Command,number) ){
			getstrvar("admin_reject_msg",Data,MAX_DATA_LENGTH);
			messageex(User,Data,print_chat);
		} else {
			snprintf(Data, MAX_DATA_LENGTH, "%s %s",PlayerCommand[UserIndex],number);
			messageex(User,Data,print_chat);
		}
	}
	/*FIND*/
	playerinfo(UserIndex,User,MAX_NAME_LENGTH);
	get_userinfo(User,"am_menugoback",Data,MAX_DATA_LENGTH);
	if (strtonum(Data) == 1){
		if (Debug == 1) say("[MENU DEBUG] am_menugoback set, so staying with menu");
		//UserMenu[UserIndex][0] = UserMenu[UserIndex][0] - 1;
		//UserPlayer[UserIndex] = 0;
		do_action(UserIndex);
	} else {
		if (Debug == 1) say("[MENU DEBUG] Done action so quitting menu");
		UserMenu[UserIndex][0] = NO_MENU;
		UserPlayer[UserIndex] = 0;
	}
	return 0;
}

/* << Everything past here is FINE! >> */

/*Get indexes of players for menu*/
GetPlayersList(UserIndex){
	new maxplayers = maxplayercount();
	new isvalid[MAX_NAME_LENGTH]; /*To check if player is in game*/
	new i, j = 0;
	
	for (i = 1; i <=maxplayers ; ++i){
		if (playerinfo(i,isvalid,MAX_NAME_LENGTH)){
			j++;
			snprintf(PlayerArray[j],MAX_NAME_LENGTH,"%s",isvalid);
			PlayerUserID[UserIndex][j] = i;
		}
	}
	PlayerArray[0][0]=j;
	return j; /*return number of players*/
}

/*CS Commands like "buy" or "radio1" display new menu so reset state in this plugin*/
public reset_state(HLCommand,HLData,HLUserName,UserIndex){
	UserMenu[UserIndex][0] = NO_MENU;
	return PLUGIN_CONTINUE;
}

public plugin_connect(HLUserName, HLIP, UserIndex) {
	if (UserIndex >= 1 && UserIndex <= MAX_PLAYERS) {
		UserMenu[UserIndex][0] = NO_MENU; /*Reset menu state*/
	}
	KillUserMenu[UserIndex] = vote_allowed();
	return PLUGIN_CONTINUE;
}

public plugin_disconnect(HLUserName,UserIndex) {
	if (UserIndex >= 1 && UserIndex <= MAX_PLAYERS) {
		UserMenu[UserIndex][0] = NO_MENU;	/*Reset menu state*/
	}
	return PLUGIN_CONTINUE;
}

public err(HLCommand,HLData,HLUserName,UserIndex){
	say("Cavey's menu plugin has been disabled. Please see the readme.");
	return PLUGIN_CONTINUE;
}

/*Back end functions required to keep the plugin working*/
public plugin_init(){
	
	new Text[MAX_TEXT_LENGTH];
	
	strinit(Text);
	get_vaultdata("CAVEY_MENU_DEBUG",Text, MAX_TEXT_LENGTH);
	Debug = strtonum(Text);
	snprintf(Text,MAX_TEXT_LENGTH,"%d",Debug);
	set_vaultdata("CAVEY_MENU_DEBUG",Text);
	
	if (Debug != 0) {
		plugin_registercmd("admin_cavey_debug","admin_cavey_debug",ACCESS_ALL,"admin_cavey_debug: Outputs debug info to the debug.log.");
	}

	if ((getvar("file_access_read") == 0) || ((getvar("file_access_read") == 0) && (Debug !=0)) ) {
		disabled = 1;
		plugin_registerinfo("AdminMod Menu Plugin","(Disabled) Please see the readme","1.1");
		plugin_registercmd("admin_menu","err",ACCESS_ALL,"admin_menu: (Disabled) Please see the readme.");
		if (getvar("file_access_read") == 0){
			menu_error("file_access_read set to 0","plugin_init","plugin disabled","fatal");
		} else {
			menu_error("file_access_write set to 0 for debug level","plugin_init","plugin disabled","fatal");
		}
		return PLUGIN_CONTINUE;
	} else if (!fileexists("menu.ini")){
		plugin_registerinfo("AdminMod Menu Plugin","(Disabled) Please see the readme","1.1");
		plugin_registercmd("admin_menu","err",ACCESS_ALL,"admin_menu: (Disabled) Please see the readme.");
		return PLUGIN_CONTINUE;
	}
	
	plugin_registerinfo("AdminMod Menu Plugin","AdminMenu Plugin by Joe 'Caveman' Noyes.","1.1");
	plugin_registercmd("admin_menu","admin_menu",ACCESS_ALL,"admin_menu: Displays AdminMenu.");
	
	plugin_registercmd("menuselect","menuselect",ACCESS_ALL);
	plugin_registercmd("radio1","reset_state",ACCESS_ALL);
	plugin_registercmd("radio2","reset_state",ACCESS_ALL);
	plugin_registercmd("radio3","reset_state",ACCESS_ALL);
	plugin_registercmd("buy","reset_state",ACCESS_ALL);
	plugin_registercmd("buyequip","reset_state",ACCESS_ALL);
	plugin_registercmd("chooseteam","reset_state",ACCESS_ALL);
	plugin_registercmd("admin_menu_admin","admin_menu_admin",ACCESS_ALL,"admin_menu_admin : Allows admins to alter MENU setting son the fly");

	strinit(Text);
	get_vaultdata("MENU_ACCESS_CONTROL",Text, MAX_TEXT_LENGTH);
	if (strlen(Text) == 0){
		ACCESS_ADMINISTRATE = ACCESS_RCON;
	} else {
		ACCESS_ADMINISTRATE = strtonum(Text);
	}
	snprintf(Text,MAX_TEXT_LENGTH,"%d",ACCESS_TOGGLE);
	set_vaultdata("MENU_ACCESS_CONTROL",Text);
	
	strinit(Text);
	get_vaultdata("MENU_ACCESS_TOGGLE",Text, MAX_TEXT_LENGTH);
	ACCESS_TOGGLE = strtonum(Text);
	if (strlen(Text) == 0){
		ACCESS_TOGGLE = ACCESS_KICK;
	} else {
		ACCESS_TOGGLE = strtonum(Text);
	}
	snprintf(Text,MAX_TEXT_LENGTH,"%d",ACCESS_TOGGLE);
	set_vaultdata("MENU_ACCESS_TOGGLE",Text);
	
	strinit(Text);
	get_vaultdata("MENU_ACCESS_EXECUTE",Text, MAX_TEXT_LENGTH);
	ACCESS_EXECUTE = strtonum(Text);
	if (strlen(Text) == 0){
		ACCESS_EXECUTE = ACCESS_RCON;
	} else {
		ACCESS_TOGGLE = strtonum(Text);
	}
	snprintf(Text,MAX_TEXT_LENGTH,"%d",ACCESS_EXECUTE);
	set_vaultdata("MENU_ACCESS_EXECUTE",Text);
	
	strinit(Text);
	get_vaultdata("MENU_ACCESS_MENU",Text, MAX_TEXT_LENGTH);
	ACCESS_MENU = strtonum(Text);
	if (strlen(Text) == 0){
		ACCESS_MENU = ACCESS_ALL;
	} else {
		ACCESS_TOGGLE = strtonum(Text);
	}
	snprintf(Text,MAX_TEXT_LENGTH,"%d",ACCESS_MENU);
	set_vaultdata("MENU_ACCESS_MENU",Text);
	
	if (Debug == 1 ){
		resetfile("debug.log");
	}
	
	ReadCfg("menu.ini");

	return PLUGIN_CONTINUE;
}

public admin_menu_admin(HLCommand,HLData,HLUserName,UserIndex){
	new Command[MAX_COMMAND_LENGTH];
	new Data[MAX_DATA_LENGTH];
	new UserName[MAX_NAME_LENGTH];
	
	convert_string(HLUserName, UserName, MAX_NAME_LENGTH);
	convert_string(HLCommand,Command,MAX_COMMAND_LENGTH);
	convert_string(HLData,Data,MAX_DATA_LENGTH);
	
	if ( access(ACCESS_ADMINISTRATE, UserName)==0 ){
		return PLUGIN_CONTINUE;			/*Command hidden from those without access*/
	}
	if ( strlen(Data) == 0 ){
			/*Give general instructions*/
		messageex(UserName, "Information sent to console" ,print_chat);
		selfmessage("-------- AdminMenu Function -------------------------------------------------------");
		selfmessage("  admin_menu_admin acs_control  - Who is able to access this configuration function.");
		selfmessage("  admin_menu_admin acs_menu  - Who is able to use the admin_menu function.");
		selfmessage("  admin_menu_admin acs_toggle  - Who is able to use menu ^"toggle^" functions.");
		selfmessage("  admin_menu_admin acs_exec  - Who is able to use menu ^"execute^" functions.");
		selfmessage("  admin_menu_admin add_file  - Adds a file to the menu structure.");
		selfmessage("  ");
		selfmessage("  Type in one of the strings to see details on that section");
		selfmessage("-------- End AdminMenu -----------------------------------------------------------");
	} else {
		new Section[MAX_DATA_LENGTH];
		new Value[MAX_DATA_LENGTH];
		strbreak(Data,Section,Value, MAX_DATA_LENGTH);
		new iValue = strtonum(Value);

		if (strcasestr(Section, "acs_control") != -1){
			if ( strlen(Value) == 0 ){
				/*Section instructions*/
				selfmessage("-------- AdminMenu Function -- Administrator Access -------------------------------------------");
				snprintf(Data, MAX_DATA_LENGTH, "  admin_menu_admin acs_control <value> - %d ACCESS_CHAT",ACCESS_CHAT);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_KICK",ACCESS_KICK);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_BAN",ACCESS_BAN);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_IMMUNITY",ACCESS_IMMUNITY);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_RCON",ACCESS_RCON);
				selfmessage(Data);
				selfmessage("  ");
				snprintf(Data, MAX_DATA_LENGTH, "  Setting currently %d - default is %d", ACCESS_ADMINISTRATE, ACCESS_RCON);
				selfmessage(Data);
				selfmessage("-------- End AdminMenu -----------------------------------------------------------");
			} else if ( iValue == ACCESS_CHAT || iValue == ACCESS_KICK || iValue == ACCESS_BAN || iValue == ACCESS_IMMUNITY || iValue == ACCESS_RCON ){
				set_vaultdata("MENU_ACCESS_CONTROL",Value);
				ACCESS_ADMINISTRATE = iValue;
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] ^"Administrator Access^" successfully set to %s", Value);
				selfmessage(Data);
			} else {
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] Unable to set ^"Administrator Access^" to ^"%s^"", Value);
				selfmessage(Data);
			}
		} else if (strcasestr(Section, "acs_menu") != -1){
			if ( strlen(Value) == 0 ){
				/*Section instructions*/
				selfmessage("-------- AdminMenu Function -- Menu Access -------------------------------------------");
				snprintf(Data, MAX_DATA_LENGTH, "  admin_menu_admin acs_menu <value> - %d ACCESS_ALL",ACCESS_ALL);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_CHAT",ACCESS_CHAT);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_RESERVE_NICK",ACCESS_RESERVE_NICK);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_KICK",ACCESS_KICK);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_BAN",ACCESS_BAN);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_IMMUNITY",ACCESS_IMMUNITY);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_RCON",ACCESS_RCON);
				selfmessage(Data);
				selfmessage("  ");
				snprintf(Data, MAX_DATA_LENGTH, "  Setting currently %d - default is %d", ACCESS_MENU, ACCESS_ALL);
				selfmessage(Data);
				selfmessage("-------- End AdminMenu -----------------------------------------------------------");
			} else if ( iValue == ACCESS_CHAT || iValue == ACCESS_ALL || iValue == ACCESS_RESERVE_NICK || iValue == ACCESS_KICK || iValue == ACCESS_BAN || iValue == ACCESS_IMMUNITY || iValue == ACCESS_RCON ){
				set_vaultdata("MENU_ACCESS_MENU",Value);
				ACCESS_MENU = iValue;
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] ACCESS_MENU successfully set to %s", Value);
				selfmessage(Data);
			} else {
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] Unable to set ^"ACCESS_MENU^" to ^"%s^"", Value);
				selfmessage(Data);
			}
		} else if (strcasestr(Section, "acs_toggle") != -1){
			if ( strlen(Value) == 0 ){
				/*Section instructions*/
				selfmessage("-------- AdminMenu Function -- Menu Toggle Access -------------------------------------------");
				snprintf(Data, MAX_DATA_LENGTH, "  admin_menu_admin acs_toggle <value> - %d ACCESS_CHAT",ACCESS_CHAT);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_KICK",ACCESS_KICK);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_BAN",ACCESS_BAN);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_IMMUNITY",ACCESS_IMMUNITY);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_RCON",ACCESS_RCON);
				selfmessage(Data);
				selfmessage("  ");
				snprintf(Data, MAX_DATA_LENGTH, "  Setting currently %d - default is %d", ACCESS_TOGGLE, ACCESS_KICK);
				selfmessage(Data);
				selfmessage("-------- End AdminMenu -----------------------------------------------------------");
			} else if ( iValue == ACCESS_CHAT || iValue == ACCESS_KICK || iValue == ACCESS_BAN || iValue == ACCESS_IMMUNITY || iValue == ACCESS_RCON ){
				set_vaultdata("MENU_ACCESS_TOGGLE",Value);
				ACCESS_TOGGLE = iValue;
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] ACCESS_TOGGLE successfully set to ^"%s^"", Value);
				selfmessage(Data);
			} else {
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] Unable to set ^"ACCESS_TOGGLE^" to ^"%s^"", Value);
				selfmessage(Data);
			}
		} else if (strcasestr(Section, "acs_exec") != -1){
			if ( strlen(Value) == 0 ){
				/*Section instructions*/
				selfmessage("-------- AdminMenu Function -- Menu Exec Access -------------------------------------------");
				snprintf(Data, MAX_DATA_LENGTH, "  admin_menu_admin acs_exec <value> - %d ACCESS_CHAT",ACCESS_CHAT);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_KICK",ACCESS_KICK);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_BAN",ACCESS_BAN);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_IMMUNITY",ACCESS_IMMUNITY);
				selfmessage(Data);
				snprintf(Data, MAX_DATA_LENGTH, "                                   - %d ACCESS_RCON",ACCESS_RCON);
				selfmessage(Data);
				selfmessage("  ");
				snprintf(Data, MAX_DATA_LENGTH, "  Setting currently %d - default is %d", ACCESS_EXECUTE, ACCESS_RCON);
				selfmessage(Data);
				selfmessage("-------- End AdminMenu -----------------------------------------------------------");
			} else if ( iValue == ACCESS_CHAT || iValue == ACCESS_KICK || iValue == ACCESS_BAN || iValue == ACCESS_IMMUNITY || iValue == ACCESS_RCON ){
				set_vaultdata("MENU_ACCESS_EXECUTE",Value);
				ACCESS_EXECUTE = iValue;
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] ACCESS_EXECUTE setting set to ^"%s^"", Value);
				selfmessage(Data);
			} else {
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] Unable to set ^"ACCESS_EXECUTE^" to ^"%s^"", Value);
				selfmessage(Data);
			}
		} else if (strcasestr(Section, "add_file") != -1){
			if ( strlen(Value) == 0 ){
				/*Section instructions*/
				selfmessage("-------- Menu Function -- Adding a menu -------------------------------------------");
				selfmessage("  admin_menu_admin add_file <filename>");
				selfmessage(" ");
				selfmessage("  WARNING - if the file is not formatted correctly this WILL go tits up ");
				selfmessage(" ");
				selfmessage("-------- End AdminMenu -----------------------------------------------------------");
			} else if ( fileexists(Value) ){
				if ( ReadCfg(Value) == 0 ){
					snprintf(Data, MAX_DATA_LENGTH, "[MENU] File ^"%s^" successfully added", Value);
					selfmessage(Data);
				} else {
					snprintf(Data, MAX_DATA_LENGTH, "[MENU] An error occured while adding file ^"%s^"", Value);
					selfmessage(Data);
				}
			} else {
				snprintf(Data, MAX_DATA_LENGTH, "[MENU] Unable to add file ^"%s^": File Not Found", Value);
				selfmessage(Data);
			}
		} else {
			/*Error*/
		}
	}
	return PLUGIN_HANDLED;
}
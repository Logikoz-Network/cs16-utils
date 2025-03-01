#include <core>
#include <string>
#include <admin>
#include <adminlib>

new AM_VERSION_STRING[] = "0.2";

new g_stringtypes[4][] = {
	"",
	"unpacked",
	!"",
	!"packed"
};

new g_stringarray[9][] = {
    "",
    "last was empty",
    "short",
    "longlonglong longlonglong longlonglong",
    "text",
    "a",
    "",
    "a other empty",
    "last one"
};

new g_array[4] = { 0xaa, ... };

new g_multiarray[4][4] = { { 1, ... }, {2, ... }, {3, ... }, {4, ... } };

new AM_NAME_STRING[] = "Wraith, test plugin";
new AM_PLUGIN_STRING[] = "tests various things";

public plugin_external(){
	g_stringtypes[1][0]='u';
	g_multiarray[0][0] = 5;
	g_array[0] = 0xbb;
	new tType = -1;
	switch( 'j' )
	{
		case 'i','j','k':
			tType=uid_index;
		case 's':
			tType=uid_sessionID;
		case 'w':
			tType=uid_wonID;
		default:
			tType=uid_invalid;
	}
	return tType;
}

plugin_internal(){
	plugin_external();
}

public plugin_init() {
	plugin_registerinfo(AM_NAME_STRING,AM_PLUGIN_STRING,AM_VERSION_STRING);
	plugin_registercmd(g_stringarray[4],g_stringarray[5],ACCESS_ALL);
	plugin_registercmd("test_export","plugin_external",ACCESS_ALL);
	plugin_internal();
	return PLUGIN_CONTINUE;
}
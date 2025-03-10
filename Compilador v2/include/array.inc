/* Array Module
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/

#if defined _array_main_included
    #endinput
#endif
#define _array_main_included

#if AMXX_VERSION_NUM >= 175
 #pragma reqlib array
 #if !defined AMXMODX_NOAUTOLOAD
  #pragma loadlib array
 #endif
#else
 #pragma library array
#endif

#include <array_func>
#include <bintrie_func>
#include <keytable_func>
#include <hashtable_func> 
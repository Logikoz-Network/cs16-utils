#if defined _zp50_class_chuck_included
  #endinput
#endif
#define _zp50_class_chuck_included

#include <zp50_class_human>

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_class_chuck
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_class_chuck
	#endif
#else
	#pragma library zp50_class_chuck
#endif


/**
 * Returns whether a player is a chuck.
 *
 * @param id		Player index.
 * @return			True if it is, false otherwise.
 */
native zp_class_chuck_get(id)

/**
 * Forces a player to become a chuck.
 *
 * @param id		Player index.
 * @return			True on success, false otherwise.
 */
native zp_class_chuck_set(id)

/**
 * Returns number of alive chuck.
 *
 * @return		chuck count.
 */
native zp_class_chuck_get_count()

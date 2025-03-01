#if defined _zp50_class_padre_included
  #endinput
#endif
#define _zp50_class_padre_included

#include <zp50_class_human>

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_class_padre
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_class_padre
	#endif
#else
	#pragma library zp50_class_padre
#endif


/**
 * Returns whether a player is apadre.
 *
 * @param id		Player index.
 * @return			True if it is, false otherwise.
 */
native zp_class_padre_get(id)

/**
 * Forces a player to become apadre.
 *
 * @param id		Player index.
 * @return			True on success, false otherwise.
 */
native zp_class_padre_set(id)

/**
 * Returns number of alivepadre.
 *
 * @return		padre count.
 */
native zp_class_padre_get_count()

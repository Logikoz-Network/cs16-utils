#if defined _zp50_class_cachorro_included
  #endinput
#endif
#define _zp50_class_cachorro_included

#include <zp50_class_zombie>

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_class_cachorro
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_class_cachorro
	#endif
#else
	#pragma library zp50_class_cachorro
#endif


/**
 * Returns whether a player is a cachorro.
 *
 * @param id		Player index.
 * @return			True if it is, false otherwise.
 */
native zp_class_cachorro_get(id)

/**
 * Forces a player to become a cachorro.
 *
 * @param id		Player index.
 * @return			True on success, false otherwise.
 */
native zp_class_cachorro_set(id)

/**
 * Returns number of alive cachorro.
 *
 * @return		cachorro count.
 */
native zp_class_cachorro_get_count()

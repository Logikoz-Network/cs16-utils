#if defined _zp50_class_galinha_included
  #endinput
#endif
#define _zp50_class_galinha_included

#include <zp50_class_human>

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_class_galinha
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_class_galinha
	#endif
#else
	#pragma library zp50_class_galinha
#endif


/**
 * Returns whether a player is a galinha.
 *
 * @param id		Player index.
 * @return			True if it is, false otherwise.
 */
native zp_class_galinha_get(id)

/**
 * Forces a player to become a galinha.
 *
 * @param id		Player index.
 * @return			True on success, false otherwise.
 */
native zp_class_galinha_set(id)

/**
 * Returns number of alive galinha.
 *
 * @return		galinha count.
 */
native zp_class_galinha_get_count()

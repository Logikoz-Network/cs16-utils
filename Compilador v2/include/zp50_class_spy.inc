#if defined _zp50_class_spy_included
  #endinput
#endif
#define _zp50_class_spy_included

#include <zp50_class_human>

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_class_spy
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_class_spy
	#endif
#else
	#pragma library zp50_class_spy
#endif


/**
 * Returns whether a player is a spy.
 *
 * @param id		Player index.
 * @return			True if it is, false otherwise.
 */
native zp_class_spy_get(id)

/**
 * Forces a player to become a spy.
 *
 * @param id		Player index.
 * @return			True on success, false otherwise.
 */
native zp_class_spy_set(id)

/**
 * Returns number of alive spy.
 *
 * @return		spy count.
 */
native zp_class_spy_get_count()

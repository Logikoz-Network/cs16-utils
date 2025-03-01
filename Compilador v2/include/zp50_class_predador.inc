#if defined _zp50_class_predador_included
  #endinput
#endif
#define _zp50_class_predador_included

#include <zp50_class_human>

#if AMXX_VERSION_NUM >= 175
	#pragma reqlib zp50_class_predador
	#if !defined AMXMODX_NOAUTOLOAD
		#pragma loadlib zp50_class_predador
	#endif
#else
	#pragma library zp50_class_predador
#endif


/**
 * Returns whether a player is a predador.
 *
 * @param id		Player index.
 * @return			True if it is, false otherwise.
 */
native zp_class_predador_get(id)

/**
 * Forces a player to become a predador.
 *
 * @param id		Player index.
 * @return			True on success, false otherwise.
 */
native zp_class_predador_set(id)

/**
 * Returns number of alive predador.
 *
 * @return		predador count.
 */
native zp_class_predador_get_count()

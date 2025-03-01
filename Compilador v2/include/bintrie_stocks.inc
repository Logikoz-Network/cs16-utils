/* Bintrie stocks
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/

#if defined _bintrie_stocks_included
    #endinput
#endif
#define _bintrie_stocks_included

stock bintrie_push_back(bintrie_id, set_type, bool:val)
	return bintrie_push(bintrie_id,PUSH_BACK, val)
stock bintrie_push_front(bintrie_id, set_type, bool:val)
	return bintrie_push(bintrie_id,PUSH_FRONT, val)

stock bintrie_pop_back(bintrie_id)
	return bintrie_pop(bintrie_id,POP_BACK)
stock bintrie_pop_front(bintrie_id)
	return bintrie_pop(bintrie_id,POP_FRONT)

stock bintrie_peek_back(bintrie_id, &bool:val)
	return bintrie_peek(bintrie_id,PEEK_BACK, val )
stock bintrie_peek_front(bintrie_id, &bool:val)
	return bintrie_peek(bintrie_id,PEEK_FRONT, val )


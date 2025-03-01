/* array stocks
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/

#if defined _array_stocks_included
    #endinput
#endif
#define _array_stocks_included

// Stocks for get_nth, to ease use.
stock array_get_nth_bool(array_id, nth, start = 0,&success = 0,&bool:val)
	return array_get_nth(array_id, nth, start, success, val, 1)
stock array_get_nth_int(array_id, nth, start = 0,&success = 0,&val)
	return array_get_nth(array_id, nth, start, success, val, 1)
stock array_get_nth_float(array_id, nth, start = 0,&success = 0,&Float:val)
	return array_get_nth(array_id, nth, start, success, val, 1)
stock array_get_nth_string(array_id, nth, start = 0,&success = 0,val[],len)
	return array_get_nth(array_id, nth, start, success, val, len)
stock array_get_nth_vector(array_id, nth, start = 0,&success = 0,Float:val[3])
	return array_get_nth(array_id, nth, start, success, val, 3)

// Stocks for first, to ease use.
stock array_first_bool(array_id, index, &success = 0, &bool:val)
	return array_first(array_id,index,ret,len,success,val,1)
stock array_first_int(array_id, index, &success = 0, &val)
	return array_first(array_id,index,ret,len,success,val,1)
stock array_first_float(array_id, index, &success = 0, &Float:val)
	return array_first(array_id,index,ret,len,success,val,1)
stock array_first_string(array_id, index, &success = 0, val[], len)
	return array_first(array_id,index,ret,len,success,val,len)
stock array_first_vector(array_id, index, &success = 0, Float:val[3])
	return array_first(array_id,index,ret,len,success,val,3)

// Stocks for next, to ease use.
stock array_next_bool(array_id, index, &success = 0, &bool:val)
	return array_next(array_id,index,ret,len,success,val,1)
stock array_next_int(array_id, index, &success = 0, &val)
	return array_next(array_id,index,ret,len,success,val,1)
stock array_next_float(array_id, index, &success = 0, &Float:val)
	return array_next(array_id,index,ret,len,success,val,1)
stock array_next_string(array_id, index, &success = 0, val[], len)
	return array_next(array_id,index,ret,len,success,val,len)
stock array_next_vector(array_id, index, &success = 0, Float:val[3])
	return array_next(array_id,index,ret,len,success,val,3)

// Stocks for prev, to ease use.
stock array_prev_bool(array_id, index, &success = 0, &bool:val)
	return array_prev(array_id,index,ret,len,success,val,1)
stock array_prev_int(array_id, index, &success = 0, &val)
	return array_prev(array_id,index,ret,len,success,val,1)
stock array_prev_float(array_id, index, &success = 0, &Float:val)
	return array_prev(array_id,index,ret,len,success,val,1)
stock array_prev_string(array_id, index, &success = 0, val[], len)
	return array_prev(array_id,index,ret,len,success,val,len)
stock array_prev_vector(array_id, index, &success = 0, Float:val[3])
	return array_prev(array_id,index,ret,len,success,val,3)

// Stocks for last, to ease use.
stock array_last_bool(array_id, index, &success = 0, &bool:val)
	return array_last(array_id,index,ret,len,success,val,1)
stock array_last_int(array_id, index, &success = 0, &val)
	return array_last(array_id,index,ret,len,success,val,1)
stock array_last_float(array_id, index, &success = 0, &Float:val)
	return array_last(array_id,index,ret,len,success,val,1)
stock array_last_string(array_id, index, &success = 0, val[], len)
	return array_last(array_id,index,ret,len,success,val,len)
stock array_last_vector(array_id, index, &success = 0, Float:val[3])
	return array_last(array_id,index,ret,len,success,val,3)


stock array_push_back(array_id, set_type, {Float,Sql,Result,_}:...)
	return array_push(array_id,PUSH_BACK, getarg(3))
stock array_push_front(array_id, set_type, {Float,Sql,Result,_}:...)
	return array_push(array_id,PUSH_FRONT, getarg(3))

stock array_pop_back(array_id)
	return array_pop(array_id,POP_BACK)
stock array_pop_front(array_id)
	return array_pop(array_id,POP_FRONT)

stock array_peek_back(array_id, {Float,Sql,Result,_}:...)
	return array_peek(array_id,PEEK_BACK, getarg(3),getarg(4) )
stock array_peek_front(array_id, {Float,Sql,Result,_}:...)
	return array_peek(array_id,PEEK_FRONT, getarg(3),getarg(4) )

#include <array_fake_stocks>

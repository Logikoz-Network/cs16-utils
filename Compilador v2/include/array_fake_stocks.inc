/* Vector/Queue/Stack stocks
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/

#if defined _fakearray_stocks_included
    #endinput
#endif
#define _fakearray_stocks_included

// Rukia: These were added to make which structure you are emulating more readily apparent.

// Vector: Random Access, dynamic array data structure
#define vector_create array_create
#define vector_destroy array_destroy
stock vector_push(array_id, set_type, {Float,Sql,Result,_}:...)
	return array_push(array_id,VECTOR_PUSH, getarg(3))
stock vector_pop(array_id)
	return array_pop(array_id,VECTOR_POP)
stock vector_peek(array_id, {Float,Sql,Result,_}:...)
	return array_peek(array_id,VECTOR_PEEK, getarg(3),getarg(4) )

// Queue: FIFO data structure
#define queue_create array_create
#define queue_destroy array_destroy
stock queue_push(array_id, set_type, {Float,Sql,Result,_}:...)
	return array_push(array_id,QUEUE_PUSH, getarg(3))
stock queue_pop(array_id)
	return array_pop(array_id,QUEUE_POP)
stock queue_peek(array_id, {Float,Sql,Result,_}:...)
	return array_peek(array_id,QUEUE_PEEK, getarg(3),getarg(4) )

// Stack: FILO data structure
#define stack_create array_create
#define stack_destroy array_destroy
stock stack_push(array_id, set_type, {Float,Sql,Result,_}:...)
	return array_push(array_id,STACK_PUSH, getarg(3))
stock stack_pop(array_id)
	return array_pop(array_id,STACK_POP)
stock stack_peek(array_id, {Float,Sql,Result,_}:...)
	return array_peek(array_id,STACK_PEEK, getarg(3),getarg(4) )
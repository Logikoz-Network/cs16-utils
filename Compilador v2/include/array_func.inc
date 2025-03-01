/* Array data type
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/
// Arrays are not nearly as fast as bintries, but can hold a pointer, and thus any value.
// They are extremely fast, and reliable, and use a very small amount of memory.

#if defined _array_array_included
    #endinput
#endif
#define _array_array_included

#include <array_const>

////* Array / Vector

///* Master Edit Functions

// Creates a new array
native array_create()

// Destroys a created array, and sets the pointer back to NULL. You MUST destroy all array's you create.
native array_destroy(&array_id)

// Clears a array without deleting it
native array_clear(array_id)

// If array_id = 0, returns the array master table, which can be manipulated as an array.
// Else, returns the array's master table array_id.
native array_convert(array_id=0)

// Saves/loads arrays from file. array_id must be to an already created array.
native array_save(array_id,file[])
native array_load(array_id,file[])

///* Master Amount Functions

// Counts the amount of arrays in the master table.
native array_count(start = 0, stop = -1)

// Returns the nth array in the master table, into ret_array. Return value is its master table array_id.
native array_bycount(nth, start = -1, &ret_array = 0)

///* Slave Amount Functions

// Returns how many indexes are in the array
native array_size(array_id, start = 0, stop = -1)

// Returns the nth index in the array. 
// NOTE: After success, use get format ( [ret_val,len] ) to retrieve index. See array_const for details.
native array_get_nth(array_id, nth, start = -1,&success = 0,{Float,Sql,Result,_}:...)

///* Slave Edit Functions

// Returns the amount of memory this array has used
native array_memory(array_id)

// Returns if index is used or not.
native array_isfilled(array_id, index)
native array_isempty(array_id, index)

///* Slave Set/Get/Delete Functions
// These don't need explaining.

// Gets the type of value stored in index. Uses pawn_type_* enum, see array_const for details.
native array_get_type(id, index, disable_check = 0)

// Deletes an index from array
native array_delete(array_id, index)

// set_type is from AP_* list in array_const
native array_set(array_id, index, set_type,{Float,Sql,Result,_}:...)

// get format is [ret_val,len]. See array_const for details.
native array_get(array_id, index, disable_check = 0,{Float,Sql,Result,_}:...)

native array_set_bool(array_id, index, bool:set_bool)
native bool:array_get_bool(array_id, index, disable_check = 0)

native array_set_int(array_id, index, set_int)
native array_get_int(array_id, index, disable_check = 0)

native array_set_float(array_id, index, Float:set_flo)
native Float:array_get_float(array_id, index, disable_check = 0)

native array_set_string(array_id, index, set_str[])
native array_get_string(array_id, index, val[], len, disable_check = 0)

native array_set_vector(array_id, index, Float:set_vec[3])
native array_get_vector(array_id, index, Float:val[3], disable_check = 0)

///* Slave Search Functions

//* Filled Index Search Functions
// NOTE: After success, use get format ( [ret_val,len] ) to retrieve index. See array_const for details.

// Finds the first filled index starting at provarray_ided index, returns value is found key.
native array_first(array_id, index[], &success = 0,{Float,Sql,Result,_}:...)

// Finds the filled index after provarray_ided index, return value is found key.
native array_next(array_id, index[], &success = 0,{Float,Sql,Result,_}:...)

// Finds the filled index before provarray_ided index, return value is found key.
native array_prev(array_id, index[], &success = 0,{Float,Sql,Result,_}:...)

// Finds the last filled index starting at provarray_ided index, return value is found key.
native array_last(array_id, index[], &success = 0,{Float,Sql,Result,_}:...)

//* Empty Index Search Functions

// Returns the first empty index starting at provarray_ided index.
native array_firstempty(array_id, index, &success = 0)

// Returns the first empty index after provarray_ided index.
native array_nextempty(array_id, index, &success = 0)

// Returns the first empty index before provarray_ided index.
native array_prevempty(array_id, index, &success = 0)

// Returns the last empty index starting at provarray_ided index.
native array_lastempty(array_id, index, &success = 0)

///* Push/Pop/Peek Functions

// Pushes a value into the array.
// NOTE: push_type is from PUSH_* list in array_const.
// NOTE: set_type is from AP_* list in array_const.
// See array_const for more details.
native array_push(array_id,push_type,set_type,{Float,Sql,Result,_}:...)

// Pops an index off the array.
// NOTE: pop_type is from POP_* list in array_const. See array_const for more details.
native array_pop(array_id,pop_type)

// Peeks into the array.
// NOTE: peek_type is from PEEK_* list in array_const. 
// NOTE: After success, use get format ( [ret_val,len] ) to retrieve index. 
// See array_const for details.
native array_peek(array_id,peek_type,{Float,Sql,Result,_}:...)

#include <array_stocks>
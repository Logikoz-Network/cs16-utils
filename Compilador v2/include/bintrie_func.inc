/* Bintrie data type
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/
// Bintries are extremely effecient list types that hold boolean values

#if defined _array_bintrie_included
    #endinput
#endif
#define _array_bintrie_included

#include <array_const>

///* Master Edit Functions

// Creates a new bintrie
native bintrie_create()

// Destroys a created bintrie, and sets the pointer back to NULL. You MUST destroy all bintrie's you create.
native bintrie_destroy(&bintrie_id)

// Clears a bintrie without deleting it
native bintrie_clear(bintrie_id)

// If bintrie_id = 0, returns the bintrie master table, which can be manipulated as an array.
// Else, returns the bintrie's master table bintrie_id.
native bintrie_convert(bintrie_id=0)

// Saves/loads bintries from file. bintrie_id must be to an already created bintrie.
native bintrie_save(bintrie_id,file[])
native bintrie_load(bintrie_id,file[])

///* Master Amount Functions

// Counts the amount of bintries in the master table.
native bintrie_count(start = 0, stop = -1)

// Returns the nth bintrie in the master table, into ret_array. Return value is its master table bintrie_id.
native bintrie_bycount(nth, start = -1, &ret_array = 0)

///* Slave Amount Functions

// Returns how many indexes are in the bintrie
native bintrie_size(bintrie_id, start = 0, stop = -1)

// Returns the nth index in the bintrie. 
// NOTE: Pass a variable to hold the index, and its length, after success. 
// Length is 1 for bool/int/flo, 3 for vec, x for string.
native bintrie_get_nth(bintrie_id, nth, start = -1,&success = 0,&bool:ret_val)

///* Slave Edit Functions

// Returns the amount of memory this bintrie has used
native bintrie_memory(bintrie_id)

// Returns if index is used or not.
native bintrie_isfilled(bintrie_id, index)
native bintrie_isempty(bintrie_id, index)

///* Slave Set/Get/Delete Functions
// These don't need explaining.

// Gets the type of value stored in index. Uses pawn_type_* enum, see array_const for details.
native bintrie_get_type(id, index, disable_check = 0)

// Deletes an index from bintrie
native bintrie_delete(bintrie_id, index)

native bintrie_set(bintrie_id, index, bool:set_bool)
native bool:bintrie_get(bintrie_id, index, disable_check = 0)

///* Slave Search Functions
// NOTE: Pass a variable to hold the index, and its length, after success. 
// Length is 1 for bool/int/flo, 3 for vec, x for string.
// If you do not wish to recieve the index, do not pass anything past success.

///* Slave Search Functions
// NOTE: Pass a variable to hold the index, and its length, after success. 
// Length is 1 for bool/int/flo, 3 for vec, x for string.
// If you do not wish to recieve the index, do not pass anything past success.

//* Filled Index Search Functions

// Finds the first filled index starting at provbintrie_ided index, returns value is found key.
native bintrie_first(bintrie_id, index, &success = 0,&bool:ret_val=false)

// Finds the filled index after provbintrie_ided index, return value is found key.
native bintrie_next(bintrie_id, index, &success = 0,&bool:ret_val=false)

// Finds the filled index before provbintrie_ided index, return value is found key.
native bintrie_prev(bintrie_id, index, &success = 0,&bool:ret_val=false)

// Finds the last filled index starting at provbintrie_ided index, return value is found key.
native bintrie_last(bintrie_id, index, &success = 0,&bool:ret_val=false)

//* Empty Index Search Functions

// Returns the first empty index starting at provbintrie_ided index.
native bintrie_firstempty(bintrie_id, index, &success = 0)

// Returns the first empty index after provbintrie_ided index.
native bintrie_nextempty(bintrie_id, index, &success = 0)

// Returns the first empty index before provbintrie_ided index.
native bintrie_prevempty(bintrie_id, index, &success = 0)

// Returns the last empty index starting at provbintrie_ided index.
native bintrie_lastempty(bintrie_id, index, &success = 0)

///* Push/Pop/Peek Functions

// Pushes a value into the bintrie.
// NOTE: push_type is from PUSH_* list in array_const.
// See array_const for more details.
native bintrie_push(bintrie_id,push_type,&bool:val)

// Pops an index off the bintrie.
// NOTE: pop_type is from POP_* list in array_const. See array_const for more details.
native bintrie_pop(bintrie_id,pop_type)

// Peeks into the bintrie.
// NOTE: peek_type is from PEEK_* list in array_const. 
// See array_const for details.
native bintrie_peek(bintrie_id,peek_type,&bool:val)

#include <bintrie_stocks>
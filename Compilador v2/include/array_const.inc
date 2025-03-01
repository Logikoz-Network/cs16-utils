/* Array const
*
* by Twilight Suzuka + Kuchiki Rukia + Urahara Kisuke
* 
*
* This file is provided as is (no warranties).
*/
// This file explains how to use some of the trickier portions of array.


#if defined _array_const_included
    #endinput
#endif
#define _array_const_included

//* Enumeration for *_get_type. pawn_type_none means it does not exist.
enum 
{
	pawn_type_none = 0,
	pawn_type_bool,
	pawn_type_int,
	pawn_type_flo,
	pawn_type_vec,
	pawn_type_str
};

//* &success
// create a variable and pass it into success. This variable will be 0 if the function failed, 1 if it did not

//* disable_check
// If this variable is 1, then when a few errors occur, the plugin will not render an error, it will handle it safely.

//* get_type usage
// To recieve information from these, pass into ... a variable for the value to be returned into, and its length.
// bool/int/float have 1 as a length, vector as 3, and strings have strlen.

//* set_type defines. 
// Any native containing "set_type" as a parameter uses these.
// To use those natives, enter the set_type you want to set, then pass the value into "..."
#define AP_NONE pawn_type_none
#define AP_BOOL pawn_type_bool
#define AP_INT pawn_type_int
#define AP_FLO pawn_type_flo
#define AP_STR pawn_type_str
#define AP_VEC pawn_type_vec


///* PUSH/POP/PEEK
// These powerful features allow a bintrie or array to emulate stacks, queues, and vectors.
// To emulate a queue/stack/vector, use the appropriate QUEUE_* / STACK_* / VECTOR_* defines.

//* STACK - First In, Last Out
//* QUEUE - First In, First Out
//* VECTOR - Random Access 

// The standard PUSH/POP/PEEK are used for VECTOR emulation.
// *_BACK does its business on the back end of the structure.
// *_FRONT does its business on the front end of the structure.

//* push_type defines
#define PUSH 1
#define PUSH_BACK 2
#define PUSH_FRONT 3
#define VECTOR_PUSH 1
#define QUEUE_PUSH 2
#define STACK_PUSH 2

//* pop_type defines
#define POP 1
#define POP_BACK 2
#define POP_FRONT 3
#define VECTOR_POP 1
#define QUEUE_POP 3
#define STACK_POP 2

//* peek_type defines
#define PEEK 1
#define PEEK_BACK 2
#define PEEK_FRONT 3
#define VECTOR_PEEK 1
#define QUEUE_PEEK 3
#define STACK_PEEK 2
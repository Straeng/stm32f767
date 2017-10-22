/* Cortex-M loads SP and PC from the first two words at address 0x0 */

.thumb

.section sp_pc
.align 2

.word _stack_start  /* SP */
.word 0             /* PC */


.section interrupt_handlers
.align 2

.word 0             /* */
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0
.word 0

.text
.align

/* 
todo:
 - copy data
 - zero bss
 - init hw
 - run main
*/

.thumb_func
reset_handler:
    bl reset_handler
    
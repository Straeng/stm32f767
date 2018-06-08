
/* Only thumb instructions are supported by Cortex-M */

.thumb
.cpu cortex-m7

/*
** Vector table specified in Generic user guide
*/
_isr_vector:
.word _stack_start
.word reset_handler /* 1.                       */
.word hang          /* 2.  NMI                  */
.word hang          /* 3.  Hard fault           */
.word hang          /* 4.  Memory mgmt fault    */
.word hang          /* 5.  Bus fault            */
.word hang          /* 6.  Usage fault          */
.word hang          /* 7.  Reserved             */
.word hang          /* 8.  Reserved             */
.word hang          /* 9.  Reserved             */
.word hang          /* 10. Reserved             */
.word hang          /* 11. SVCall               */
.word hang          /* 12. Debug                */
.word hang          /* 13. Reserved             */
.word hang          /* 14. PendSV               */
.word hang          /* 15. Systick              */

/*           16-255: IRQ0 - IRQ239              */

.text
.thumb_func
hang:   
    b .

.thumb_func
reset_handler:
    bl _start
    b hang

    
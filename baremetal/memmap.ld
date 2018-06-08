/*
https://www.math.utah.edu/docs/info/ld_3.html

TCM tightly coupled memory
DTCM-ram: high perf data
ITCM-ram: high perf code
*/

MEMORY
{
    flashaxim   : ORIGIN = 0x08000000, LENGTH = 2M
    flashitcm   : ORIGIN = 0x00200000, LENGTH = 2M
    sram1       : ORIGIN = 0x20020000, LENGTH = 368K
    sram2       : ORIGIN = 0x2007C000, LENGTH = 16K
    dtcm        : ORIGIN = 0x20000000, LENGTH = 128K
    itcm        : ORIGIN = 0x00000000, LENGTH = 16K
}


/* Stack is last 32K of DTCM */
stack_size      = 32K;

_stack_start    = ORIGIN(dtcm)+LENGTH(dtcm);
_stack_end      = _stack_start - stack_size;

/*
.text    > rom 
.bss     > ram
.data    > ram
.rodata  > rom
*/

SECTIONS
{
    .text : { 
        */init.o (.text);
        *(.text);
    } > flashaxim

    .rodata : { 
        *(.rodata*);
        _rodata_end = . ;
    } > flashaxim

    .bss_img : AT(_rodata_end) {
        _bss_start = . ;
        *(.bss*);
        _bss_end = . ;
    } > dtcm

    .data : {
        _data_rom_start = LOADADDR(.data);
        _data_ram_start = . ;
        *(.data)
        _data_ram_end = . ;
    } > dtcm
}


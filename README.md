# stm32f767

Cortex-M loads SP and PC from the first two words at address 0x0 
Address 0 is a shadow of another memory area, configured by BOOT_ADD0 / BOOT_ADD1
options bytes:

## BOOT_ADDx 
values defined in STM32F7x7 Reference Manual:

| Value | Result | Default |
|--------|--------|--------|
| 0x0000 | Boot from ITCM RAM (0x0000 0000) | |
| 0x0040 | Boot from system memory bootloader (0x0010 0000) | BOOT_ADD1 default |
| 0x0080 | Boot from Flash on ITCM interface (0x0020 0000) | BOOT_ADD0 default |
| 0x2000 | Boot from Flash on AXIM interface (0x0800 0000) | |
| 0x8000 | Boot from DTCM RAM (0x2000 0000) | |
| 0x8004 | Boot from SRAM1 (0x2002 0000) | |
| 0x8013 | Boot from SRAM2 (0x2004 C000) | |


Boot pin (?) chooses which BOOT_ADD to use:

| Boot pin | Boot from |
|-------|-------|
| 0 | BOOT_ADD0 |
| 1 | BOOT_ADD1 |


System memory bootloader (AN2606)

Flashed by ST during production. 
Supports loading over many interfaces (CAN, UART, USB, I2C and SPI).
Cant be overwritten (?)


extern char _data_rom_start;
extern char _data_ram_start;
extern char _data_ram_end;

extern char _bss_start;
extern char _bss_end;

extern void mainfunc();


static inline void copy_data() {
    char* rom = &_data_rom_start;
    char* ram = &_data_ram_start;

    while(ram < &_data_ram_end) {
        *ram++ = *rom++;
    }
}

static inline void zero_bss() {
    
    for(char* ptr = &_bss_start; ptr < &_bss_end ; ptr++) {
        *ptr = 0;
    }
}

void _start() {
    copy_data();
    zero_bss();

    mainfunc();
}

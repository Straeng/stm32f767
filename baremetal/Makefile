
# ---- Project configuration --------------------------------------------------

# Name & configuration
PROGNAME	= BareArmBlink
CONFIG_FILE = 
LDSCRIPT 	= memmap.ld
INIT_CODE   = init.s
CPU 		= cortex-m7

# ---- Paths & file setup -----------------------------------------------------

SRCDIR		= src
OBJDIR		= obj
DISTDIR		= dist


# ---- Toolchain --------------------------------------------------------------

CC 			= arm-none-eabi-gcc
AS          = arm-none-eabi-as
OBJCPY 		= arm-none-eabi-objcopy
SIZE		= arm-none-eabi-size

# https://gcc.gnu.org/onlinedocs/gcc/ARM-Options.html
COMP_OPT	= 
COMP_FLAGS	= -Wall -pedantic -funsigned-char -mcpu=$(CPU)
LINK_OPT	= 
LINK_FLAGS	= -nostdlib -nostartfiles
AS_FLAGS	= --warn --fatal-warnings -mcpu=$(CPU)



# Object files and include paths
SOURCE_DIRS := $(shell find src/ -type d)
SRCS		:= $(foreach DIR, $(SOURCE_DIRS), $(shell find $(DIR) -iname "*.c"))
OBJS 		:= $(patsubst %.c, $(OBJDIR)/%.o, $(notdir $(SRCS)))
INCS		:= $(foreach DIR, $(SOURCE_DIRS), -I$(DIR))

ifdef INIT_CODE
OBJS		+= $(patsubst %.s, $(OBJDIR)/%.o, $(INIT_CODE))
endif

# Source search paths
VPATH 		:= $(SOURCE_DIRS)

# Library paths
LDPATHS     := $(foreach L, $(LIB_DIRS), -L$(L)) $(foreach n, $(LIB_NAMES), -l$(n))



# ---- Compiler & linker flags ------------------------------------------------

CFLAGS 	:= $(COMP_OPT) $(COMP_FLAGS) $(INCS)
ifdef CONFIG_FILE
CFLAGS	+= -imacros $(CONFIG_FILE)
endif

LDFLAGS		:= $(LINK_OPT) $(LINK_FLAGS)
ifdef LDSCRIPT
LDFLAGS		+= -T $(LDSCRIPT)
endif



# ---- Targets & rules --------------------------------------------------------

.PHONY: all
all: makedirs $(DISTDIR)/$(PROGNAME).hex

.PHONY: clean
clean:
	@rm -rf $(DISTDIR)/*
	@rm -rf $(OBJDIR)/*

# Upload program using the serial STK500 (used by Arduino bootloaders)
.PHONY: stk500_upload
stk500_upload: $(DISTDIR)/$(PROGNAME).hex
	avrdude -carduino -p$(TARGET) -P$(PROG_PORT) -b$(PROG_RATE) -Uflash:w:$<

# Upload program using ISP (AVR Dragon)
.PHONY: isp_upload
isp_upload: $(DISTDIR)/$(PROGNAME).hex
	avrdude -cdragon_isp -p$(TARGET) -P$(ISP_IF) -Uflash:w:$<

# Set fuses iusing ISP (AVR Dragon)
.PHONY: isp_fuses
isp_fuses:
	avrdude -cdragon_isp -p$(TARGET) -P$(ISP_IF) -U lfuse:w:$(LFUSE):m -U hfuse:w:$(HFUSE):m -U efuse:w:$(EFUSE):m

# Transform to hex
$(DISTDIR)/$(PROGNAME).hex: $(DISTDIR)/$(PROGNAME).elf
	@echo "Generating hex..."
	@$(OBJCPY) -O ihex $< $@

# Link 
$(DISTDIR)/$(PROGNAME).elf: $(OBJS)
	@echo "Linking..."
	@$(CC) $(LDFLAGS) -o $@ $^ $(LDPATHS) -Wl,-Map=$(DISTDIR)/$(PROGNAME).map
	@$(SIZE) $@ 

#Assemble
$(OBJDIR)/%.o: %.s
	@$(AS) $< $(AS_FLAGS) -o $@

# Compile
$(OBJDIR)/%.o: %.c
	@$(CC) -c $< $(CFLAGS) -o $@


makedirs:
	@mkdir -p $(OBJDIR)
	@mkdir -p $(DISTDIR)



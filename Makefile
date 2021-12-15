#------------------------------------------------------------------------------
# <Put a Description Here>
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

TARGET = c1m2

LINKER_FILE = ../msp432p401r.lds

CPPFLAGs = -E
	   
# Platform Overrides

ifeq ($(PLATFORM),HOST)
     PLATFORM = HOST
     CC = gcc
     LDFLAGS = -Wl,-Map=$(TARGET).map
     CFLAGS = -std=c99 -Werror -Wall -g -O0 -D$(PLATFORM)
else
# Architectures Specific Flags
     PLATFORM = MSP432
     CPU = cortex-m4
     ARCH = thumb
     SPECS = nosys.specs
     MARCH = armv7e-m
     ABI = hard
     FBU = fpv4-sp-d16
# Compiler Flags and Defines
     CC = arm-none-eabi-gcc 
     LD = arm-none-eabi-lb
     LDFLAGS = -Wl,-Map=$(TARGET).map -T $(LINKER_FILE)
     CFLAGS = -Werror -mcpu=$(CPU) -m$(ARCH) --specs=$(SPECS) -march=$(MARCH) -mfloat-abi=$(ABI) -mfpu=$(FPU) -Wall -g -O0 -D$(PLATFORM)   

endif


ASM = $(SOURCES:.c=.asm)
I = $(SOURCES:.c=.i)
OBJS = $(SOURCES:.c=.o)

%.asm : %.c
	$(CC) -c $< $(INCLUDES) $(CFLAGS) $(CPPFLAGs) -S -o $@

%.i : %.c
	$(CC) -c $< $(CPPFLAGs) $(CFLAGS) $(INCLUDES) -o $@

%.o : %.c
	$(CC) -c $< $(INCLUDES) $(CFLAGS) -o $@

.PHONY: build
build: $(TARGET).out 
$(TARGET).out: $(OBJS)
	$(CC) $(OBJS) $(CFLAGS) $(INCLUDES) $(LDFLAGS) -o $@
	$(SIZE) -Atd $(TARGET).out
	$(SIZE) -Btd $(OBJS)

.PHONY: compile-all
compile-all:
	$(CC) $(CFLAGS) $(CPPFLAGs) $(INCLUDES) -D$(PLATFORM) -c $(OBJS:.o=.c) 
	$(SIZE) -Btd $(OBJS)	
.PHONY: clean
clean:
	rm -f $(OBJS) $(TARGET).out $(TARGET).map $(TARGET).i $(TARGET).asm $(I) $(ASM)
	
.PHONY: debug    
debug:
	@echo $(INCLUDES)


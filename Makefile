MCU = atmega328p
F_CPU = 16000000UL

TARGET = tinyRTOS

CC = avr-gcc
OBJCOPY = avr-objcopy
SIZE = avr-size

CFLAGS = -mmcu=$(MCU) \
         -DF_CPU=$(F_CPU) \
         -Os \
         -g \
         -Wall \
         -Iinclude

LDFLAGS = -mmcu=$(MCU)

SRC = \
    src/main.c \
    src/kernel.c \
    src/scheduler.c \
    src/task.c \
    src/timer.c \
    src/boot.S

OBJ = $(SRC:src/%.c=build/%.o)
OBJ := $(OBJ:src/%.S=build/%.o)

ELF = build/$(TARGET).elf
HEX = build/$(TARGET).hex

all: $(HEX)

build:
	mkdir -p build

build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -c $< -o $@

build/%.o: src/%.S | build
	$(CC) $(CFLAGS) -c $< -o $@

$(ELF): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) -o $@

$(HEX): $(ELF)
	$(OBJCOPY) -O ihex -R .eeprom $< $@
	$(SIZE) $<

clean:
	rm -rf build

sim: $(HEX)
	~/simavr/simavr/run_avr \
		-m $(MCU) \
		-f 16000000 \
		$(HEX)

.PHONY: all clean sim
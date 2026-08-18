CC=avr-gcc
CFLAGS=-mmcu=atmega328p -DF_CPU=16000000UL -Os
TARGET=main

all: $(TARGET).hex

$(TARGET).hex: $(TARGET).elf
	avr-objcopy -O ihex -R .eeprom $< $@

$(TARGET).elf: $(TARGET).c
	$(CC) $(CFLAGS) -o $@ $<

clean:
	rm -f $(TARGET).elf $(TARGET).hex
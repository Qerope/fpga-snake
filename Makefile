PROJ = snake
PCF = hx8k.pcf
SRC = top.v
SRC += spi_master.v max7219.v
SRC += frame.v
SRC += debounce.v
SRC += snake.v
SRC += lfsr.v

all: build/$(PROJ).bin

build/$(PROJ).json: $(SRC)
	mkdir -p build
	yosys -q -p "synth_ice40 -top top -json $@" $(SRC)

build/$(PROJ).asc: build/$(PROJ).json $(PCF)
	nextpnr-ice40 --hx8k --package ct256 --json $< --pcf $(PCF) --asc $@

build/$(PROJ).bin: build/$(PROJ).asc
	icepack $< $@

clean:
	rm -rf build

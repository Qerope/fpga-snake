# fpga-snake

Snake on an 8x8 LED matrix (MAX7219 module over SPI) running on the
Lattice iCE40-HX8K breakout board. Built with yosys, nextpnr and icestorm.

    make
    make prog

Pins are in `hx8k.pcf`: matrix DIN/CLK/CS on the PMOD header, four buttons on
the next header with the internal pull-ups enabled. 12 MHz board clock; the
game ticks at 4 Hz.

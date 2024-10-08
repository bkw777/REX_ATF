# NOT WORKING

If you just want a REX, buy a [REX#](https://bitchin100.com/wiki/index.php?title=REXsharp) or build a [REX Classic](https://github.com/bkw777/REX_Classic).

This is is an attempt to port REX Classic to a different CPLD chip.  
REX Classic is built around the Xilinx XCR3064XL, which is discontinued.  
ATF1504ASL is a similar part that is still available.  
Do not bother trying to build this yet unless you actually want to help GET it working.  
Because it DOES NOT WORK yet. But it seems to be close...  


## Current Status

Can't figure out a way to replicate the Xilinx internal pullup feature while using the Quartus -> EPM7064S -> POF2JED workflow, so at least for now we have external pullup resistors on the CSA & CSB pins (formerly TP1 & TP2). All other pins should be ok since they are connected to the bus.

Quartus 13.0 compiles the VHDL and creates `rexbrd.pof`.  
`pof2jed` creates `rexbrd.jed`.  
`atmisp` creates `rexbrd.svf`.  
`openocd` programs `rexbrd.svf` to the device.  

The machine still runs normally with the REX installed, so at least the REX is not waking up and interfering with the bus when not selected.

`rf149.co` runs without error.  
The "wiping blocks" stage goes way too fast.  
`CALL 63012` hangs.

TODO: observe the bus with https://github.com/bkw777/Molex_7880x_bus_tap

----
# REX_ATF

[REX Classic](http://tandy.wiki/REX) built on Microchip ATF1504 instead of Xilinx XCR3064

![](PCB/out/REX_ATF.1.jpg)  
![](PCB/out/REX_ATF.2.jpg)  
![](PCB/out/REX_ATF.top.jpg)  
![](PCB/out/REX_ATF.bottom.jpg)  
![](PCB/out/REX_ATF.svg)  

# What is it?

REX Classic is an on-board software-controlled rom library for TRS-80 Model 100, 102, or 200.

REX was originally designed around a Xilinx XCR3064XL CPLD, but Xilinx has stopped producing those.

This is a version of REX Classic using the same VHDL code, but compiled for a Microchip ATF1504ASL CPLD, which is still an active part.

# BOM

1 x ATF1504ASL TQFP44 - CPLD 64MC 5V  
https://www.digikey.com/en/products/detail/microchip-technology/ATF1504ASL-25AU44/1008353

1 x 29F800BB TSOP48 ex: AM29F800BB, M29F800FB, MX29F800CB - 8Mx8/4Mx16 FLASH parallel 5V bottom-boot  
https://www.digikey.com/en/products/detail/alliance-memory-inc/M29F800FB5AN6F2/12180108

2 x 1uF MLCC 0805 16V+  
https://www.digikey.com/en/products/detail/yageo/CC0805KKX7R7BB105/2103103

Gerbers & CPLD bitstream in [releases](../../releases/latest). (not working yet, so no release yet)

Carrier: http://shpws.me/SGGB  
(cad model source: https://github.com/bkw777/Molex78802_Module )

# Programming the CPLD
Install [openocd](https://openocd.org/) and a wrapper script [atfsvf](https://github.com/bkw777/ATF150x_uDEV/blob/main/bin/atfsvf):  
```
$ sudo apt install openocd
$ wget https://github.com/bkw777/ATF150x_uDEV/raw/main/bin/atfsvf
$ install -m 755 atfsvf ~/.local/bin/
```

Programmer hardware:  
 * [FT232R or FT232H usb-ttl module that can supply 5V VCC](https://github.com/bkw777/ATF150x_uDEV/blob/main/programming.md#hardware)
 * 6-pin length of generic 2.54mm single row square male pin header
 * 6 female dupont wires
 * [connection pinout table](https://github.com/bkw777/ATF150x_uDEV/blob/main/programming.md#hardware)

Example using an [FT232R usbc-ttl-serial module](https://amazon.com/dp/B0CQVB6JFV)  
![](HDL/prg1.jpg)
![](HDL/prg2.jpg)
![](HDL/prg3.jpg)

Get the SVF file from [Releases](../../releases/latest). (No releases yet since it doesn't work yet)

Use the atfsvf script to program the chip with the svf.  
If you have a FT232H module instead of FT232R, then change ft232r to ft232h below.  
`$ atfsvf ft232r ATF1504ASL rexbrd.svf`


# Usage
Use the normal [REX Classic](http://bitchin100.com/wiki/index.php?title=REXclassic) software and documentation.

Example on linux:

## install [dl2](https://github.com/bkw777/dl2)
```
$ git clone https://github.com/bkw777/dl2.git
$ cd dl2 && make clean all && sudo make install
```

## connect 100 to pc by serial
reference: http://tandy.wiki/Model_T_Serial_Cable  
https://www.pccables.com/products/00103.html  
https://www.amazon.com/gp/product/B074VN9ZG4/  

## load the REX firmware
```
$ wget https://www.bitchin100.com/wiki/images/3/38/R49_M100T102_260_rebuild.zip
$ unzip R49_M100T102_260_rebuild.zip
$ co2ba rf149.co call >rf149.do
$ dl -vb rf149.do && dl -vu
```
(follow the on-screen directions in the terminal and on the 100)  
Then SHIFT+BREAK+RESET on the 100  
Then Power-cycle the 100  

## Try to activate the REX
In BASIC: `CALL 63012`  
(currently hangs)

# Generating the SVF from the VHDL source
![HDL/Compile_HDL.md](HDL/Compile_HDL.md)


# Credits
Original REX design is by Steven Adolph  
http://bitchin100.com/wiki/index.php?title=REX  
http://www.club100.org/memfiles/index.php?direction=0&order=&directory=Steve%20Adolph

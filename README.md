# REX_ATF

**NOT WORKING  -  NOT WORKING  -  NOT WORKING**

Do not bother trying to build this yet unless you actually want to help GET it working.  
Because it DOES NOT WORK yet.

The code compiles and creates a .pof,  
and pof2jed creates a .jed,  
and atmisp creates a .svf,  
and openocd programs the svf to the device.

But if the REX is installed in the option rom socket then it prevents the machine from booting.  
It's interfering with the bus in some way.

The shematic and pcb are probably ok because they are a simple translation of the already working [REX Classic](https://github.com/bkw777/REX_Classic), and the VHDL is probably ok because it's not changed from Steve's original, which works on XCR3064.  
Possible problems to figure out:  
* Different compile options, default options, default behavior, between Xilinx ISE and Quartus?  
  Maybe there are some options that ISE and Quartus both have some equivalent feature,  
  but ISE defaults one way and Quartus defaults a different way, and so in Quartus we may need to  
  explicitly set some option that didn't have to be mentioned in the ISE project.  
* Porting error on my part, IE not handling the global clock pins correctly?  The `ale` signal is on a global clock pin, but I have not explicitly set any options in quartus about it. There are also a few options in pof2jed that might need to be used.
* Feature differences between xcr3064xl and max7064s?  
  Example, the Xilinx .ucf file specifies internal pullups on several pins,  
  but it's not clear if MAX7000S or ATF1504AS has that feature, and even if ATF1504 does,  
  if MAX7000S didn't, then quartus can't generate code for it. So maybe those pins need  
  external pullups on the PCB?  
* Timing differences. Maybe the logic is all correct and the behavior of the pins is all correct, but the same code on the ATF ends up not being fast enough due to different implimentation or maybe due to my re-arranged pin assignments.  
* Maybe POF2JED is not actually producing 100% correct translation from MAX7064 to ATF1504. Some people have claimed that some working Prochip projects don't work when built in quartus and converted with pof2jed.  

----

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

Gerbers & CPLD  in [releases](../../releases/latest). (not working yet, so no release yet)

Carrier: http://shpws.me/SGGB  
(cad model source: https://github.com/bkw777/Molex78802_Module )

# Programming the CPLD
Install openocd and a wrapper script:  
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


# Generating the SVF from the VHDL source
![HDL/Compile_HDL.md](HDL/Compile_HDL.md)


# Credits
Original REX design is by Steven Adolph  
http://bitchin100.com/wiki/index.php?title=REX  
http://www.club100.org/memfiles/index.php?direction=0&order=&directory=Steve%20Adolph

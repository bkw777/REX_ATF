# How to generate the .svf from the VHDL source

## Install Quartus 13.0  
You can omit ModelSim and all device families except MAX7000 if you want a smaller install.  
Directions for Ubuntu 23.10: https://gist.github.com/bkw777/a6a2888f482802f2e520165858268cd3

## Install ATMISP, 5vcomp, openocd, and some wrapper scripts
https://github.com/bkw777/ATF150x_uDEV/blob/main/programming.md  
Basically do the entire "Here is a start to finish install on Ubuntu 23.10"  
You don't need wincupl for this project, but you do need everything else.  

## Install POF2JED
You also need POF2JED which is not mentioned above because that document only covers the WINCUPL workflow, but you get pof2jed from the same place as atmisp and wincupl, and install the same way in the same wine environment:
```
$ wget http://ww1.microchip.com/downloads/archive/pof2jed.zip
$ unzip pof2jed.zip
$ wine_atmel WinPof2jed45.exe
$ cat >~/.local/bin/pof2jed <<%EOF
#!/bin/sh
# Wrapper to run POF2JED
# Install in ~/.local/bin along with wine_atmel

exec wine_atmel c:/pof2jed/bin/pof2jed.exe "\$@"
%EOF
$ chmod 755 ~/.local/bin/pof2jed
$ cat >~/.local/bin/winpof2jed <<%EOF 
#!/bin/sh
# Wrapper to run WinPOF2JED
# Install in ~/.local/bin along with wine_atmel

# "start" makes the help buttons work
exec wine_atmel start c:/pof2jed/bin/winpof2jed.exe "\$@"
%EOF
$ chmod 755 ~/.local/bin/winpof2jed
```

## Compile the VDHL to POF
```
$ cd .../HDL/rexbrd
$ q13 rexbrd
```

Press the play button to generate `output_files/rexbrd.pof`  

This produces a `*.pof` which could be used to program a EPM7064S right from within Quartus.

## Convert POF for EPM7064S to JED for ATF1504AS
[pof2jed.txt](pof2jed.txt)  
```
$ cd output_files
$ pof2jed rexbrd -verbose -device 1504as -JTAG on -TDI_PULLUP -TMS_PULLUP -pin_keep
```

This produces a `*.jed` which could be used by ATMISP to program a ATF1504ASL if you had an ATDH1150USB programmer.

## Convert JED to SVF
ATMISP can not program the JED to the chip with any other kind of programmer except exactly a $90 ATDH1150USB, but it can read the JED and write out a SVF file.  
https://github.com/bkw777/ATF150x_uDEV/blob/main/programming.md#convert-the-jed-to-svf

This produces a `*.svf` which any generic jtag software and hardware can use to program the chip.

## Setup JTAG programmer hardware
https://github.com/bkw777/ATF150x_uDEV/blob/main/programming.md#hardware)  
To make the physical JTAG connection, you only need 6 female-female dupont wires and a 6-pin length of common 2.54mm single-row square pin header.  
In these pics, the usbc module has a FT232R chip, so the pinout follows the FT232R table in the programming doc above.  
TX-TCK  
RX-TDI  
CTS-TMS  
RTS-TDO  
![](prg1.jpg)
![](prg2.jpg)
![](prg3.jpg)

## Program the SVF to the chip
https://github.com/bkw777/ATF150x_uDEV/blob/main/programming.md#program-the-device-with-the-svf

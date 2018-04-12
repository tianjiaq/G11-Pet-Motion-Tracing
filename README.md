# Pet Motion Tracing
About
The goal of our design is to provide information for pet’s motion and duration for staying at home. The design can do object detection on our pet at home by background subtraction method to get center points with a video camera and draw the path of object movement on a monitor.

# Usage
Note: Algorithm and wifi are working separatly well but the integration of two components has some issues.

To use this project, follow these steps:

Clone/Download the respository

Go to src/proj/ and open hdmi.xpr in Vivado 2017.2 (Other version of Vivado may work but may have some difference)

Ensure IP repositories 'src/repo' is linked in Tools > Project Settings > IP > Repository Manager

Generate bitstream 

Export hardware for use in SDK: File > Export > Export Hardware 

Launch SDK: File > Launch SDK

Right click on videodemo project and head to Properties > Project References

Check and confirm that right platform and BSP are used

Plug in Nexys Video Board via USB and turn on 

Edit the ip address in sdk according to the wifi used to connect client and server. Then built the program.

Flash imported hardware: Xilinx Tools > Flash FPGA > Program (Ensure platform being flashed is current platform)

PLug in UART USB for Nexys Video Board, plug HDMI display to connect the board with monitor.

Select Run > Run Configurations:

In Target Setup, ensure correct Hardware Platform
In STDIO Connection, ensure Port is highest COM port and BAUD rate is 115200
Press Run 


# Respository Structure
## Directory	Description

docs/	Documents including presentation slides and final report

src/src/bd	All files related to project implementation

src/proj	Vivado project 

src/sdk Contains SDK files of the project

src/repo/	Contains custom IPs and IPs from Digilient

# Authors
Wenyu Mao\
Jiaqi Tian\
Jiayi Xu

# Acknowledgements
The HDMI streaming part of the design is developed based on HDMI tutorial provided by Digilent which can be found here: https://reference.digilentinc.com/learn/programmable-logic/tutorials/nexys-video-hdmi-demo/start

The wifi pmod module is again based on example from Digilent which can be found here: https://github.com/Digilent/vivado-library/tree/master/ip/Pmods/PmodWIFI_v1_0\

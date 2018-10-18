This is a computer code (in MATLAB environment) to control hardwares such as arbitrary wavefrom generator.


Requirements

MATLAB 2017a or higher version.
Multiple drivers, which are given in the Usage session, need to be installed.
Operation system that code has been tested on: Windows 10


Usage

Part 1. MATLAB code for controlling of AWG, NI PXI-5412

1.	Setup the hardware of the arbitrary waveform generator. 
2.	Install NI-FGEN 18.1 or higher version Driver from National Instruments. For example, http://www.ni.com/download/ni-fgen-18.1/7587/en/  Durin this process, NI MAX (Measurement & Automation Explorer) will be installed as well. If not, one can download it from National Instruments. This may takes one hour to download and one hour to install.
3.	Install NI-FGEN support package for MATLAB. The package can be found in this link: https://www.mathworks.com/hardware-support/ni-fgen.html The package is also attached here. The name of the file is “nifgen.mlpkginstall”. Double click it to install it.
4.	Use NI MAX to find the resource ID of the AWG. In the example code, the AWG is named as NI PXI-5412 “PXI2Slot4”, under the category of NI PXIe-1073 “Chassis 2”.
5.	Use MATLAB to open the example code “PXI_5412_TTLsignalGeneration.m”. Change the resource ID, which is defined as 'PXI2Slot4' in the example code.
6.	Test the example code. 1) Connect the AWG output port to an oscilloscope. 2) Run the example code with revised resource ID. If the code works, AWG will generate a TTL output. This can be measured with the osciloscope. The code should take less than 1 ms. 3) Change the repetition rate by revising the sentence from “RepRate = 4;” to “RepRate = 2;” or other values. Run the code again and measure the output waveform using the oscilloscope.
7.	After testing the example code, one need to turn off the AWG code. Uncomment the code in the session of “Turn off the AWG”, and run the code again.
8.  For complicated modulation pattern, it is basically use a larger array with 1 (Pulse on) and -1(Pulse off).

Part 2. MATLAB code for controlling of the DAQ, ATS9371

The SDK and instruction guide for C/C++, C#, MATLAB, Python and LabVIEW have been provided by Alazar Tech. The MATLAB SDK has been attached as "AlazarDAQ.zip".

To be continued...
That are more under-developed device-controlling code. Feel free to push me to update the documentation of your favorite function! My email is: liboresearch@gmail.com

This is a computer code (in MATLAB environment) to control hardwares such as arbitrary wavefrom generator.
Part 1. MATLAB code for controlling of AWG 1.1 Preparation
1.	Setup the hardware of the arbitrary waveform generator. 
2.	Install NI-FGEN 18.1 or higher version Driver from National Instruments. For example, http://www.ni.com/download/ni-fgen-18.1/7587/en/ NI MAX (Measurement & Automation Explorer) will be installed as well.
3.	Install NI-FGEN support package for MATLAB. https://www.mathworks.com/hardware-support/ni-fgen.html The package is attached. The name of the file is “nifgen.mlpkginstall”. Double click it to install it.
4.	Use NI MAX to find the resource ID of the AWG. In the example code, the AWG is named as NI PXI-5412 “PXI2Slot4”, under the category of NI PXIe-1073 “Chassis 2”.
5.	Use MATLAB to open the example code “PXI_5412_TTLsignalGeneration.m”. Change the resource ID, which is defined as 'PXI2Slot4' in the example code.
6.	Test the example code. 1) Connect the AWG output port to an oscilloscope. 2) Run the example code with revised resource ID. If the code works, AWG will generate a TTL output. 3) Change the repetition rate by revising the sentence from “RepRate = 4;” to “RepRate = 2;”. Run the code again and measure the output waveform using the oscilloscope.
7.	After testing the example code, one need to turn off the AWG code. Uncomment the code in the session of “Turn off the AWG”, and run the code again.



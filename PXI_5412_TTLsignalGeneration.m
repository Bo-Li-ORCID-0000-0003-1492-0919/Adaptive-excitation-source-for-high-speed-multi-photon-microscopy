%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% About this code %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This example shows how to generate a TTL periodical waveform with  
% different repetition rate on a function generator using the NI-FGEN 
% driver and MATLAB software.

% Instrument Control Toolbox? supports communication with instruments 
% through interfaces and drivers.

% For more details on the toolbox, visit the Instrument Control Toolbox 
% product page.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Requirements %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this example, you will learn to generate a TTL periodical waveform
% using the NI-FGEN software package version 2.7.2 or higher and 
% a NI PXI-5412 function generator. You can also use any other function 
% generator supported by the NI-FGEN software package version 2.7.2 or
% higher.

% The package is free. It can be downloaded from the website: 
% https://www.mathworks.com/hardware-support/ni-fgen.html
% Find "get support package"

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;    % Clear the command window.
% clear;  % Erase all existing variables. Type it in command line before 
% run this code.
close all;  % Close all figures (except those of imtool.)
workspace;  % Make sure the workspace panel is showing.
fprintf('Start!\n'); % Message sent to command window.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Verify NI-FGEN driver installation %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use the instrhwinfo command to check if the NI-FGEN software package is 
% installed correctly.
driverInfo = instrhwinfo('vxipnp','niFgen');
disp(driverInfo);
% If output is the following sentences, it is then all wright.
% HardwareInfo with properties:
%      Manufacturer: 'National Instruments Corp.'
%             Model: 'National Instruments Function Generator'
%     DriverVersion: '1.0'
%     DriverDllName: 'C:\Program Files\IVI Foundation\VISA\Win64\bin\nifgen_...'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% AWG initialization %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To check if AWG exists, if so, one should disconnect and delete it.
ExistICdevice = exist('AWGdeviceObj');
if ExistICdevice == 1
    invoke(AWGdeviceObj.Utility,'disable');
    disconnect(AWGdeviceObj);
    delete(AWGdeviceObj);
    clear AWGdeviceObj;
    disp('AWG was on, and it was turned off.');
end

% Use the icdevice function to create an instrument object from the MDD, 
% and establish a connection to the function generator using that object.

% icdevice function takes two or more input arguments. The MDD file name,
% the resource name for the function generator and optionally, 
% setting specific parameters.

% You can get the resource name for the function generator from NI
% Measurement and Automation tool. For example: A resource name of
% PXI1Slot6 in NI MAX would be DAQ::PXI1Slot6 and Device 2 would be DAQ::2.
% You can remove the optionstring argument and the corresponding string
% parameter if you have the actual hardware.

resourceID = 'PXI2Slot4'; %Specify Resource ID, use "NI MAX" software to find the proper address
AWGdeviceObj = icdevice('niFgen',resourceID); % Create an instrument object from the niFgen driver
disp('Created an instrument object');
connect(AWGdeviceObj);                        % Connect driver instance
disp('AWG is initialized.');

% Attributes and Variables Definition
% For the purpose of this example, the function generator is configured to
% generate a periodical pulse train with a certain repetition rate, R. 
% When synchronized with the laser clock, 32 MHz, one can use the output 
% of the AWG to drive a modulator, and then the repetition rate of the
% laser will be R, i.g., R = 4 MHz, 2 MHz, 1.6 MHz, ...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Parameters define for AWG initialization %%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% These values are defined in the driver's header file 'niFgen.h'
NIFGEN_VAL_OUTPUT_ARB = 1;  % Arbitrary mode
ChannelName = '0'; % This value is described in the help file 'NI Signal Generators Help'
Enabled = 1;                    % Enable output waveform
NIFGEN_VAL_MARKER_EVENT = 1001; % Marker event, for Marker 0
NIFGEN_ATTR_ARB_GAIN = 1; % in volt, the range is (0,6)
NIFGEN_ATTR_ARB_OFFSET = 0.0; % in volt, the range is (-0.25,0.25)
AWGSamplingRate = 32e6;     % in Hz, sampling rate
SamplingSourceNum = 0; % 0 is to use the internal clock as the sampling 
% clock, 1 is to use the external TTL signal as sampling clock, i.g., the
% external TTL signal could be extracted from the laser source.
% External TTL signal can be sent into the "CLK IN" port of PXI 5412. The detail
% of the external clock can be found in the manual of PXI 5412.

% AWG waveform define
PulseOn = 1;                % Waveform value when pulse is on
PulseOff = -1;               % Waveform value when pulse is off
RepRate = 4;  % in MHz, available choices for this example code: 4, 2, 1.6, 1.33, 1, 0.8, 0.67, 0.5, more can be easily defined by simply defind an array with "PulseOn" and "PulseOff".
DTime = 1/AWGSamplingRate;      % in second.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%% AWG waveform define %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if RepRate == 4
    WAVEFORMDATAARRAYTT = linspace(1,1,8);
    WAVEFORMDATAARRAYTT(2:8)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT WAVEFORMDATAARRAYTT WAVEFORMDATAARRAYTT WAVEFORMDATAARRAYTT];
end
if RepRate == 2
    WAVEFORMDATAARRAYTT = linspace(1,1,16);
    WAVEFORMDATAARRAYTT(2:16)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT WAVEFORMDATAARRAYTT];
end
if RepRate == 1.6
    WAVEFORMDATAARRAYTT = linspace(1,1,20);
    WAVEFORMDATAARRAYTT(2:20)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT];
end
if RepRate == 1.33
    WAVEFORMDATAARRAYTT = linspace(1,1,24);
    WAVEFORMDATAARRAYTT(2:24)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT];
end
if RepRate == 1
    WAVEFORMDATAARRAYTT = linspace(1,1,32);
    WAVEFORMDATAARRAYTT(2:32)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT];
end
if RepRate == 0.8
    WAVEFORMDATAARRAYTT = linspace(1,1,40);
    WAVEFORMDATAARRAYTT(2:48)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT];
end
if RepRate == 0.67
    WAVEFORMDATAARRAYTT = linspace(1,1,48);
    WAVEFORMDATAARRAYTT(2:48)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT];
end
if RepRate == 0.5
    WAVEFORMDATAARRAYTT = linspace(1,1,64);
    WAVEFORMDATAARRAYTT(2:64)=-1;
    WAVEFORMDATAARRAY= [WAVEFORMDATAARRAYTT];
end
WAVEFORMSIZE = length(WAVEFORMDATAARRAY);               % Waveform size


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Enable AWG output %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Configure the sampling rate
if SamplingSourceNum==0 % if use internal source
    invoke(AWGdeviceObj.Configurationfunctionsarbitrarywaveformoutput,'configuresamplerate',AWGSamplingRate); 
end
if SamplingSourceNum==1 % if use external source
    invoke(AWGdeviceObj.Configurationfunctionsconfigureclock,'configuresampleclocksource',"ClkIn");
end

% Create arbitrary waveform
[NIFGEN_ATTR_ARB_WAVEFORM_HANDLE] = invoke(AWGdeviceObj.Configurationfunctionsarbitrarywaveformoutput,'createwaveformf64',ChannelName,WAVEFORMSIZE,WAVEFORMDATAARRAY);

% Query maximum capabilities, not neccessary for daily use
% [MAXIMUMNUMBEROFWAVEFORMS,WAVEFORMQUANTUM,MINIMUMWAVEFORMSIZE,MAXIMUMWAVEFORMSIZE] = invoke(AWGdeviceObj.Configurationfunctionsarbitrarywaveformoutput,'queryarbwfmcapabilities')

% Configure output mode
invoke(AWGdeviceObj.Configuration,'configureoutputmode',NIFGEN_VAL_OUTPUT_ARB);

% Configure arbitrary waveform
invoke(AWGdeviceObj.Configurationfunctionsarbitrarywaveformoutput,'configurearbwaveform',ChannelName,NIFGEN_ATTR_ARB_WAVEFORM_HANDLE,NIFGEN_ATTR_ARB_GAIN,NIFGEN_ATTR_ARB_OFFSET);

% export Marker 0 to PFI 1, i.e., the AWG will send a trigger output when
% it generate a new period of the wavefrom. 
set(AWGdeviceObj.Arbitrarywaveformarbitrarywaveformmode(1), 'Marker_Position', 0);
invoke(AWGdeviceObj.Configurationfunctionstriggeringandsynchronization,'exportsignal',NIFGEN_VAL_MARKER_EVENT,"Marker0","PFI1");

% Initiate the Waveform Generation
invoke(AWGdeviceObj.Waveformcontrol,'initiategeneration');

% Enable the Output
invoke(AWGdeviceObj.Configuration,'configureoutputenabled', ChannelName, Enabled);
disp('Output is enabled');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%% Turn off the AWG %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remember to turn off the AWG when work is finished.
ExistICdevice = exist('AWGdeviceObj');
if ExistICdevice == 1
    invoke(AWGdeviceObj.Utility,'disable');
    disconnect(AWGdeviceObj);
    delete(AWGdeviceObj);
    clear AWGdeviceObj;
    disp('AWG was on, and it was turned off.');
end





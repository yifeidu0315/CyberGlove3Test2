clear;
% productPath = "C:\Users\yifei\OneDrive\virtual hand files\rombokasCybergloveCode\rombokasCybergloveCode\CyberGlove3Test2\CyberGlove3Test2";
% cd(productPath);

%% Obtain names and directory for header files
% hFilesPath = "C:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\include\vhandtk";
% cd(hFilesPath);
% hFiles = dir('vhandtk');
% hFileSize = size(hFiles);
% hFiles(3).name
%% Obtain names and directory for import library files

% libPath = "C:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release";
% libFile1 = "CGS_VirtualHandCore.lib";
% libFile2 = "CGS_VirtualHandDevice.lib";
% libName1 = "vhtCoreLib";
% libName2 = "vhtDeviceLib";
%% specifying parameters for mex command
% ipath = ['-I' hFilesPath];
% mex "-IC:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\include\vhandtk"...
%     "-LC:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release" ...
%     -lCGS_VirtualHandCore -lCGS_VirtualHandDevice Source.cpp
mex -R2018a "-IC:\Program Files\CyberGlove Systems\VirtualHand SDK\include\vhandtk"...
    "-LC:\Program Files\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release" ...
    -lCGS_VirtualHandCore -lCGS_VirtualHandDevice Source_mxArray_3.cpp
mex -R2018a "-IC:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\include\vhandtk"...
    "-LC:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release" ...
    -lCGS_VirtualHandCore -lCGS_VirtualHandDevice Source_mxArray_4.cpp
%% generate library interface to C++
%% run the mex file

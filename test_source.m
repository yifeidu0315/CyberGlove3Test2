productPath = "C:\Users\yifei\OneDrive\virtual hand files\rombokasCybergloveCode\rombokasCybergloveCode\CyberGlove3Test2\CyberGlove3Test2";
cd(productPath);

%% Obtain names and directory for header files
hFilesPath = "C:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\include\vhandtk";
% cd(hFilesPath);
% hFiles = dir('vhandtk');
% hFileSize = size(hFiles);
% hFiles(3).name
%% Obtain names and directory for import library files

libPath = "C:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release";
libFile1 = "CGS_VirtualHandCore.lib";
libFile2 = "CGS_VirtualHandDevice.lib";
libName1 = "vhtCoreLib";
libName2 = "vhtDeviceLib";
%% specifying parameters for mex command
ipath = ['-I' hFilesPath];
mex "-IC:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\include\vhandtk"...
    "-LC:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release" ...
    -lCGS_VirtualHandCore -lCGS_VirtualHandDevice Source.cpp
%% generate library interface to C++
% turns out that we cannot simply generate all library definitions in a for loop
% have to perfrom lib-gen manually.
% clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vht.h"),"ReturnCArrays",false, ... % treat output as MATLAB arrays
%     "OverwriteExistingDefinitionFiles",true);
%% run the mex file
Source();

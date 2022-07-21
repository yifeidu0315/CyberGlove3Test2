productPath = "C:\Users\yifei\OneDrive\virtual hand files\rombokasCybergloveCode\rombokasCybergloveCode\CyberGlove3Test2\CyberGlove3Test2";
cd(productPath);

%% Obtain names and directory for header files
hFilesPath = "C:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\include";
cd(hFilesPath);
hFiles = dir('vhandtk');
hFileSize = size(hFiles);
% hFiles(3).name
%% Obtain names and directory for import library files

libPath = "C:\Users\yifei\OneDrive\virtual hand files\CyberGlove Systems VirtualHand Software\CyberGlove Systems\VirtualHand SDK\lib\winnt_x64\Release";
libFile1 = "CGS_VirtualHandCore.lib";
libFile2 = "CGS_VirtualHandDevice.lib";
libName1 = "vhtCoreLib";
libName2 = "vhtDeviceLib";
%% generate library interface to C++
% turns out that we cannot simply generate all library definitions in a for loop
% have to perfrom lib-gen manually.
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vht.h"),"ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtCyberGlove.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtCyberGloveEmulator.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtDevice.h"), "Libraries",fullfile(libPath,libFile2), ... 
    "PackageName",libName2, ...
    "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtGlove.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtGloveData.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtIOConn.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtQuaternion.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtTransform3D.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtUnimpl.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtVector3d.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
clibgen.generateLibraryDefinition(fullfile(hFilesPath, "vhtKey.h"), "ReturnCArrays",false, ... % treat output as MATLAB arrays
    "OverwriteExistingDefinitionFiles",true);
mex source.cpp;

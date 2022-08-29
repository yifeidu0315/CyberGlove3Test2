# CyberGlove3Test2
 Test code for retriving data from CyberGlove3

Paths:


mex files:
Source_mxArray_1.cpp: retrieve joint angle data, loop inside.
Source_mxArray_2.cpp: retrieve joint angle data for once. (Not finished)
Source_mxArray_3.cpp: retrieve joint angle data, with a loop in matlab.

matlab files:
test_source.m: for mexing Source_mxArray_3.cpp
test_source_1.m: for mexing Source_mxArray_2.cpp

test_glove_execute.m: for calling Source_mxArray_2.cpp. (Not finished)
test_glove_execute_2.m: for calling Source_mxArray_3.cpp. This matlab code will retrieve joint angle data multiple times with a while loop and format the data into an array stored in matlab workspace.

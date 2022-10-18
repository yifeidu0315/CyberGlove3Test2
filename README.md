# CyberGlove3Test2
 Test code for retriving data from CyberGlove3

Source_mxArray_1.cpp: retrieve finger joint angle data, loop inside
Source_mxArray_3.cpp: retrieve finger joint angle data (15 data points), no loop
Source_mxArray_4.cpp: retrieve finger joint angle data in radian (15 data points), no loop
Source_mxArray_5.cpp: retrieve finger joint angle data with palm-related joint angle data in radian (22 data points), no loop

test_source.m: mex command file

test_glove_execute.m: call Source_mxArray_3.cpp
test_glove_execute_1.m: call Source_mxArray_4.cpp
test_glove_execute_2.m: call Source_mxArray_5.cpp

test_analysis.m: analyze the joint angle data obtained from test_glove_execute.m
test_analysis_r.m: analyze the joint angle data (both in radian and in degree) obtained from test_glove_execute_2.m
test_analysis_full.m: analyze the abduction angle data obtained from test_glove_execute_2.m

Sensor Data mxArray Ordering:
c++ side:
[0][0] thumb metacarpal
[0][1] thumb proximal
[0][2] thumb distal
[0][3] thumb-index abduction
[1][0] index metacarpal
[1][1] index proximal
[1][2] index distal
[1][3] !!!not implemented!!!
[2][0] middle metacarpal
[2][1] middle proximal
[2][2] middle distal
[2][3] index-middle abduction
[3][0] ring metacarpal
[3][1] ring proximal
[3][2] ring distal
[3][3] middle-ring abduction
[4][0] pinky metacarpal
[4][1] pinky proximal
[4][2] pinky distal
[4][3] ring-pinky abduction
[5][0] palm arch
[5][1] wrist pitch/flextion
[5][2] wrist yaw/abduction
[5][3] !!!empty!!!

matlab side:
[1]  thumb metacarpal
[2]  thumb proximal
[3]  thumb distal
[4]  thumb-index abduction
[5]  index metacarpal
[6]  index proximal
[7]  index distal
[8]  !!!not implemented!!!
[9]  middle metacarpal
[10] middle proximal
[11] middle distal
[12] index-middle abduction
[13] ring metacarpal
[14] ring proximal
[15] ring distal
[16] middle-ring abduction
[17] pinky metacarpal
[18] pinky proximal
[19] pinky distal
[20] ring-pinky abduction
[21] palm arch
[22] wrist pitch/flextion
[23] wrist yaw/abduction
[24] !!!empty!!!
[25] matlab now timestamp

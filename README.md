# CyberGlove3Test2
 Test code for retriving data from CyberGlove3

Source_mxArray_1.cpp: retrieve joint angle data, loop inside
Source_mxArray_3.cpp: retrieve joint angle data, no loop
Source_mxArray_4.cpp: retrieve joint angle data in radian, no loop

test_source.m: mex command file

test_glove_execute.m: call Source_mxArray_3.cpp
test_glove_execute_2.m: call Source_mxArray_4.cpp

test_analysis.m: analyze the joint angle data obtained from test_glove_execute.m
test_analysis_r.m: analyze the joint angle data (both in radian and in degree) obtained from test_glove_execute_2.m
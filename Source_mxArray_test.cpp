/********************************************************************
test for mex file
2022.8.29
Jeff Du
********************************************************************/
#if defined( _WIN32 )
#include <windows.h>
#else
#include <stdlib.h>
#endif
#include <iostream>
#include <string>
#include <array>
#include "matrix.h"
using std::cout;
#include "mex.h"



/* The gateway function. */
/* This program outputs the joint angle data to Matlab workspace */
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {

	/* Check for proper number of arguments */
	// This program takes zero input arguments
	if (nrhs != 0) {
		mexErrMsgIdAndTxt("MATLAB:Source:maxrhs", "SOURCE requires zero input arguments.");
	}
	if (nlhs > 1) {
		mexErrMsgIdAndTxt("MATLAB:Source:nargout", "Too many output arguments.");
	}
	double data[] = { 1, 2, 3, 4, 5 };
	plhs[0] = mxCreateNumericMatrix((mwSize)5, (mwSize)1, mxDOUBLE_CLASS, mxREAL);
	mxSetDoubles(plhs[0], data);
     //free the allocated space
	return;
}

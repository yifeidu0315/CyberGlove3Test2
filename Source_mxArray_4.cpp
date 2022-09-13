/********************************************************************
Initialize a connection and update joint angle data in radius from CyberGlove
-Update data only one time
* mex in test_source.m
* call in test_glove_execute_2.m
2022.8.20
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
// matlab engine header files
//#include "MatlabDataArray.hpp"
//#include "MatlabEngine.hpp"
// matlab mex header files
#include "mex.h"
//#include "mexAdapter.hpp"
// vht related header files
//#include <vhtBase.h>

//#include <vht6DofDevice.h>
//#include <vhtBadData.h>
//#include <vhtBadLogic.h>
//#include <vhtBaseException.h>
//#include <vhtContactPatch.h>
//#include <vhtTracker.h>
//#include <vhtTrackerData.h>
//#include <vhtTrackerEmulator.h>
//#include <vhtCyberGrasp.h>
//#include <vhtCyberTouch.h>
//#include <vhtDeviceTypes.h>
//#include <vhtGenHandModel.h>
//#include <vhtHandMaster.h>
//#include <vhtHapticEffect.h>
//#include <vhtNegIndex.h>
//#include <vhtNullPtr.h>
//#include <vhtOutOfBound.h>

// The necessary header files

#include <vht.h>
#include <vhtCyberGlove.h>
#include <vhtCyberGloveEmulator.h>
#include <vhtDevice.h>
#include <vhtGlove.h>
#include <vhtGloveData.h>
#include <vhtIOConn.h>
#include <vhtQuaternion.h>
#include <vhtTransform3D.h>
#include <vhtUnimpl.h>
#include <vhtVector3d.h>
#include <vhtKey.h>

// Turn off the following to use a tracker emulator instead of
// a real tracker
#define USE_REAL_TRACKER
static int rows;
static int cols;
static vhtCyberGlove* glove = NULL; // an glove object for connection to the physical CyberGlove3 device


void cleanup(void) {


	glove = NULL;
}
/* Source function for the demo.*/
double* Source()
{
	// Specify the address of the glove if necessary
	//vhtIOConn gloveAddress("cyberglove1", "localhost", "12345", "com5", "115200");

	vhtIOConn* gloveDict = vhtIOConn::getDefault(vhtIOConn::glove); // Connect to the glove (with default address and parameters)

	//vhtCyberGlove* glove = new vhtCyberGlove(&gloveAddress);
	glove = new vhtCyberGlove(gloveDict);


	//
	// The demo loop: get the finger angles from the glove.
	//
	vhtTransform3D trackerXForm;
	vhtVector3d position;
	vhtQuaternion orientation;
	vhtVector3d axis;

	// update data from the physical device
	glove->update();
	// create an m x n double precision Array for Data Storage
	const int m = GHM::nbrFingers;
	const int n = GHM::nbrJoints;

	rows = (GHM::nbrFingers);
	cols = GHM::nbrJoints;
	static double GloveData[m][n];
	double* ptrGloveData = GloveData[0];
	// Get update time and other data -not implemented

	// Get joint angles
	cout << "Glove: \n";
	for (int finger = 0; finger < m; finger++)
	{
		cout << finger << " ";
		for (int joint = 0; joint < n; joint++)
		{
			// Store the data in an array
			GloveData[finger][joint] = glove->getAngle((GHM::Fingers)finger, (GHM::Joints)joint);
			cout << GloveData[finger][joint] << " ";
		}
		cout << "\n";
	}
	cout << "Data stored" << "\n";
	// wait for 100ms

	//Sleep(100);

	glove->~vhtCyberGlove();
	return ptrGloveData;
}

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

	double* ptrGloveData;
	ptrGloveData = Source();
	// clean up
	mexAtExit(cleanup);

	//initialize mxArray with GloveData
	mxDouble* dynamicGloveData;        // pointer to dynamic data
	mwSize index;
	int size = rows * cols;
	dynamicGloveData = (double*)mxMalloc(size * sizeof(double));
	for (index = 0; index < size; index++) {
		dynamicGloveData[index] = ptrGloveData[index];
	}
	// cout << "disp!";
	// for (int i = 0; i < 15; i++){

	// 		cout << dynamicGloveData[i] << " ";
	// }
	plhs[0] = mxCreateNumericMatrix((mwSize)size, (mwSize)1, mxDOUBLE_CLASS, mxREAL);
	mxSetDoubles(plhs[0], dynamicGloveData);
	//mxFree(dynamicGloveData);       //free the allocated space, cannot implement this way
	return;
}

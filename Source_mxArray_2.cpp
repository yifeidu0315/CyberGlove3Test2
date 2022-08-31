/********************************************************************
Update joint angle data from CyberGlove once after initialization using VirtualHand API
* call after calling Source_initialization.cpp
* mex in test_source_1.m
* call in test_glove_execute.m
2022.8.24
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
	if (glove != NULL)
		delete glove;

	glove = NULL;
}
/* Source function for the demo.*/
double* Source()
{
	// Find an existing connection to the IOConn
	vhtIOConn* gloveDict = vhtIOConn::getDefault(vhtIOConn::glove);
	cout << "default IOConn obtained";
	// create a glove object and make connection
	glove->connect();

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

	rows = (GHM::nbrFingers) + 1;
	cols = GHM::nbrJoints;
	static double GloveData[m + 1][n];
	double* ptrGloveData = GloveData[0];
	// Get update time and other data
	GloveData[m][0] = glove->getLastUpdateTime();
	GloveData[m][1] = 0;
	GloveData[m][2] = 0;
	//GloveData[m][1] = glove->getConnectStatus();
	//GloveData[m][2] = glove->getDimensionRange();
	cout << "last Update Time: " << GloveData[m][0] << "\n";
	// Get joint angles
	cout << "Glove: \n";
	for (int finger = 0; finger < m; finger++)
	{
		cout << finger << " ";
		for (int joint = 0; joint < n; joint++)
		{
			// Store the data in an array
			GloveData[finger][joint] = glove->getData((GHM::Fingers)finger, (GHM::Joints)joint);
			cout << GloveData[finger][joint] << " ";
		}
		cout << "\n";
	}
	cout << "Data stored" << "\n";
	// wait for 100ms
	Sleep(100);
#if defined(_WIN32)
	Sleep(100);
#else
	usleep(100000);
#endif

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

	plhs[0] = mxCreateNumericMatrix((mwSize)rows, (mwSize)cols, mxDOUBLE_CLASS, mxREAL);
	mxSetDoubles(plhs[0], dynamicGloveData);
	mxFree(dynamicGloveData);       //free the allocated space
	return;
}

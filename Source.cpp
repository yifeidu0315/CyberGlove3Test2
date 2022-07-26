/********************************************************************
FILE: $Id: glove.cpp,v 1.1 2000/05/30 01:15:49 ullrich Exp $
AUTHOR: Chris Ullrich.
DATE: 1999/05/12.
Description: Base demonstration.
Show how to connect to a glove and tracker, and then how to update and extract
sensor data from the devices.
History:
 1999/05/12 [CU]: Creation.
 1999/06/27 [HD]: Remodelling for a Irix/WinNT portable version.
 -- COPYRIGHT VIRTUAL TECHNOLOGIES, INC. 1999 --
********************************************************************/
#if defined( _WIN32 )
#include <windows.h>
#else
#include <stdlib.h>
#endif
#include <iostream>
#include <string>
using std::cout;
// matlab engine header files
//#include "MatlabDataArray.hpp"
//#include "MatlabEngine.hpp"
// matlab mex header files
#include "mex.h"
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

//class CyberGloveTest {
//	public:
//		CyberGloveTest(const std::string new_portName, int new_baudRate);
//	
//	private:
//		 const std::string portName;
//		 int baudRate;
//};
//
//CyberGloveTest::CyberGloveTest(const std::string new_portName, int new_baudRate)
//	: portName(new_portName), baudRate(new_baudRate) {
//	baudRate = new_baudRate;
//
//}


//
// Main function for the demo.
//
void Source()
{
	// Specify the address of the glove if necessary
	//vhtIOConn gloveAddress("cyberglove1", "localhost", "12345", "com5", "115200");
	// Connect to the glove (with default address and parameters)
	vhtIOConn* gloveDict = vhtIOConn::getDefault(vhtIOConn::glove);

	//vhtCyberGlove* glove = new vhtCyberGlove(&gloveAddress);
	vhtCyberGlove* glove = new vhtCyberGlove(gloveDict);


	//
	// The demo loop: get the finger angles from the glove.
	//
	vhtTransform3D trackerXForm;
	vhtVector3d position;
	vhtQuaternion orientation;
	vhtVector3d axis;
	double baseT = glove->getLastUpdateTime();
	//glove->update();
	//restrict the number of update for each loop to 50 for testing 
	int updateTimes = 0;
	while (true)
	{
		updateTimes++;
		// update data from the physical device
		glove->update();
		//tracker->update();
		// Get update time delta
		cout << "deltaT: " << glove->getLastUpdateTime() - baseT <<
			"\n";
		// Get joint angles
		cout << "Glove: \n";
		for (int finger = 0; finger < GHM::nbrFingers; finger++)
		{
			cout << finger << " ";
			for (int joint = 0; joint < GHM::nbrJoints; joint++)
			{
				cout << glove->getData((GHM::Fingers)finger, (GHM::Joints)joint) << " ";
			}
			cout << "\n";
		}
		// wait for 100ms
#if defined(_WIN32)
		Sleep(100);
#else
		usleep(100000);
#endif
		if (updateTimes >= 50) break;
	}
}

/* The gateway function. */
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, const mxArray* prhs[]) {

	/* Check for proper number of arguments */
	/*if (nrhs != 2) {
		mexErrMsgIdAndTxt("MATLAB:mexcpp:nargin", "MEXCPP requires two input arguments.");
	}
	if (nlhs != 0) {
		mexErrMsgIdAndTxt("MATLAB:mexcpp:nargout", "MEXCPP requires no output argument.");
	}*/

	/* Check if the input is of proper type */
	//if (!mxIsDouble(prhs[0]) || // not double
	//	mxIsComplex(prhs[0]) || // or complex
	//	!mxIsScalar(prhs[0])) { // or not scalar
	//	mexErrMsgIdAndTxt("MATLAB:mexcpp:typeargin", "First argument has to be double scalar.");
	//}
	//if (!mxIsDouble(prhs[1]) || // not double
	//	mxIsComplex(prhs[1]) || // or complex
	//	!mxIsScalar(prhs[1])) { // or not scalar
	//	mexErrMsgIdAndTxt("MATLAB:mexcpp:typeargin", "Second argument has to be double scalar.");
	//}

	Source();
}

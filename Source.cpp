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
using std::cout;
//#include <vhandtk/vhtBase.h>
#include <vht.h>
//#include <vht6DofDevice.h>
//#include <vhtBadData.h>
//#include <vhtBadLogic.h>
//#include <vhtBaseException.h>
//#include <vhtContactPatch.h>
#include <vhtCyberGlove.h>
#include <vhtCyberGloveEmulator.h>
//#include <vhtCyberGrasp.h>
//#include <vhtCyberTouch.h>
#include <vhtDevice.h>
//#include <vhtDeviceTypes.h>
//#include <vhtGenHandModel.h>
#include <vhtGlove.h>
#include <vhtGloveData.h>
//#include <vhtHandMaster.h>
//#include <vhtHapticEffect.h>
#include <vhtIOConn.h>
//#include <vhtNegIndex.h>
//#include <vhtNullPtr.h>
//#include <vhtOutOfBound.h>
#include <vhtQuaternion.h>
//#include <vhtTracker.h>
//#include <vhtTrackerData.h>
//#include <vhtTrackerEmulator.h>
#include <vhtTransform3D.h>
#include <vhtUnimpl.h>
#include <vhtVector3d.h>
#include <vhtKey.h>
// Turn off the following to use a tracker emulator instead of
// a real tracker
#define USE_REAL_TRACKER
//
// Main function for the demo.
//
int main(int argc, char* argv[])
{
	// Specifying the address of the glove
	//vhtIOConn gloveAddress("cyberglove1", "localhost", "12345", "com5", "115200");
	// Connect to the glove (with default address and parameters)
	vhtIOConn* gloveDict = vhtIOConn::getDefault(vhtIOConn::glove);

	// Expand the CyberGlove connection to the CyberTouch capabilities
	//vhtCyberGlove* glove = new vhtCyberGlove(&gloveAddress);
	vhtCyberGlove* glove = new vhtCyberGlove(gloveDict);

	
	// Connect to the tracker 
#if defined( USE_REAL_TRACKER )
	//vhtIOConn* trackerDict = vhtIOConn::getDefault(vhtIOConn::tracker);
	//vhtTracker* tracker = new vhtTracker(trackerDict);
#else
	vhtTrackerEmulator* tracker = new vhtTrackerEmulator();
#endif

	//
	// The demo loop: get the finger angles from the glove.
	//
	vhtTransform3D trackerXForm;
	vhtVector3d position;
	vhtQuaternion orientation;
	vhtVector3d axis;
	double baseT = glove->getLastUpdateTime();
	//glove->update();
	
	while (true)
	{
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
				cout << glove->getData((GHM::Fingers)finger, (GHM::Joints)joint
				) << " ";
			}
			cout << "\n";
		}
		// Get tracker data as a vhtTransform3D in world frame
		//tracker->getLogicalDevice(0)->getTransform(&trackerXForm);
		// print translation and orientaion
		//trackerXForm.getTranslation(position);
		//trackerXForm.getRotation(orientation);
		//orientation.getAxis(axis);
		//cout << "Tracker: \n";
		//cout << position.x << " " << position.y << " " << position.z << "\n";
		//cout << axis.x << " " << axis.y << " " << axis.z << " " <<
		//	orientation.getAngle() << "\n";
		// wait for 100ms
#if defined(_WIN32)
		Sleep(100);
#else
		usleep(100000);
#endif
	}
	return 0;
}

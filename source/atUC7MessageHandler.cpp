#include <vcl.h>
#pragma hdrstop
#include "atVCLUtils.h"
#include "TMainForm.h"
#include "mtkLogger.h"


using namespace mtk;

//---------------------------------------------------------------------------
bool TMainForm::handleUC7Message(const UC7Message& m)
{
	//Find out controller address from sender parameter
	switch(toInt(m.getSender()))
    {
        case 4:
        {
        	if(m.getCommand() == "20")
            {

            }
            else if(m.getCommand() == "21")
            {

            }
            else if(m.getCommand() == "23") //Feed
            {
            	if(m.getData().size() == 6)
                {
	                string feedIn_nm  = m.getData().substr(2);
                    mFeedRateE->setValue(hexToDec(feedIn_nm));
                }
            }
            else if(m.getCommand() == "30")
            {
            	if(m.getXX() == "FF") //This is info about position
                {
	                string absPos  = m.getData().substr(2);
                    mKnifeStageNSAbsPosE->setValue(hexToDec(absPos));
                }
            }
            else if(m.getCommand() == "31")
            {

            }
            else if(m.getCommand() == "40")	//Handwheel position
            {

            }
            else if(m.getCommand() == "41")
            {

            }
			else
            {

            }
        }
		case 5:
        {
        	if(m.getCommand() == "20")
            {
            	string d = m.getData().substr(2,2);
                if(d == "00")
                {
                	Log(lInfo) << "Cutting motor is off";
                    mStartStopBtn->Caption = "Start";
                }
                else if(d == "01")
                {
                	Log(lInfo) << "Cutting motor is on";
                    mStartStopBtn->Caption = "Stop";
                }
                else if(d == "E0")
                {
                	Log(lError) << "Invalid calibration";
                }

            }
        	else if(m.getCommand() == "30")
            {

            }
        	else if(m.getCommand() == "31")
            {

            }
        	else if(m.getCommand() == "40")
            {
            	string d = m.getData().substr(2,2);
                if(d == "00")  //Retract
                {
                	mCrankPositionPie->Angles->EndAngle = 180;
                	mCrankPositionPie->Angles->StartAngle = 90;
                }
                else if(d == "01")  //Before cutting
                {
                	mCrankPositionPie->Angles->EndAngle = 90;
                	mCrankPositionPie->Angles->StartAngle = 0;
                }
                else if(d == "03") //Cutting
                {
                	mCrankPositionPie->Angles->EndAngle = 0;
                	mCrankPositionPie->Angles->StartAngle = 270;
                    mUC7.getCounter().increase();
                    mCounterLabel->update();
                }
                else if(d == "02") //After cutting
                {
                	mCrankPositionPie->Angles->EndAngle = 270;
                	mCrankPositionPie->Angles->StartAngle = 180;
                }
                else if(d == "E0")
                {

                }
            }
            else
            {

            }
        }
        default: return UNKNOWN;
    }
}

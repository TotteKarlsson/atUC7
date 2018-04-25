#include <vcl.h>
#pragma hdrstop
#include "atVCLUtils.h"
#include "TMainForm.h"
#include "dslLogger.h"

using namespace dsl;

//---------------------------------------------------------------------------
bool TMainForm::handleUC7Message(const UC7Message& m)
{
	//Find out controller address from sender parameter
    int contr_address = toInt(m.getSender());
    bool message_handled(false);

	switch(contr_address)
    {
        case gStepperControllerAddress:
        {
        	if(m.getCommand() == "20")
            {
				if(m.getData().size() == 8)
                {
                	//This is the absolute, current position of feed controller (the arm)
                	Log(lDebug) << "Handling Feedrate Motor Control Message: "<<m.getData();
					message_handled = true;
                }
            }
            else if(m.getCommand() == "21")
            {
            	Log(lDebug) << "Autosend position at motion:" <<m.getData();
                message_handled = true;
            }
            else if(m.getCommand() == "23") //Feed rate
            {
            	if(m.getData().size() == 6)
                {
	                string feedIn_nm  = m.getData().substr(2);
                    int rate = hexToDec(feedIn_nm);

                    //Transfer hardware data to UC7 'soft' data
                    mUC7.setFeedRate(rate, false);
                    FeedRateE->setValue(rate);

                   	mRibbonStartBtn->Enabled = (rate != 0) ? false : true;
                    if(rate)
                    {
                    	mRibbonStartBtn->Caption = "Back off";
                        mRibbonStartBtn->Enabled = true;
                        mSetZeroCutBtn->Enabled = true;
                    }
                    else //Feed rate == zero
                    {
                    	mRibbonStartBtn->Caption = "Resume";
                        mSetZeroCutBtn->Enabled = false;
                    }
	                message_handled = true;
                }
            }
            else if(m.getCommand() == "30")
            {
            	if(m.getXX() == "FF") //This is info about absolute North_south stage position
                {
	               string absPos  = m.getData().substr(2);
                   mKnifeStageNSAbsPosE->setValue(hexToDec(absPos));
                   mUC7.setNorthSouthStageAbsolutePosition(mKnifeStageNSAbsPosE->getValue(), false);
                   message_handled = true;
                }
            }
            else if(m.getCommand() == "31")
            {
            	Log(lDebug) << "Send position at movement (North/South)" <<m.getData();
                message_handled = true;
            }
            else if(m.getCommand() == "40")
            {
            	Log(lDebug) << "East/West Motor control" <<m.getData();
                message_handled = true;
            }
            else if(m.getCommand() == "41")
            {
            	Log(lDebug) << "Autosend position at motion (East/West):" <<m.getData();
                message_handled = true;
            }
        }
        break;

		case gMotorControllerAddress:
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
                message_handled = true;
            }
        	else if(m.getCommand() == "30")
            {
              	Log(lInfo) << "Got Cutting Speed Message ("<<m.getXX()<<" "<<m.getData()<<")";

                if(m.getXX() == "FF")  //Getting cutting speed
                {
                	Log(lInfo) << "Reading Cutting Speed..";

                    //16 bit speed value
                	string yyyy = m.getData();
                   	Log(lInfo) << "Data: " << yyyy;
                   	CurrentCuttingSpeedL->setValue(hexToDec(yyyy));
                    mUC7.setCuttingSpeed(CurrentCuttingSpeedL->getValue(), false);
	                message_handled = true;
                }
            }
        	else if(m.getCommand() == "31")
            {

              	Log(lInfo) << "Got Return Speed Message ("<<m.getXX()<<" "<<m.getData()<<")";
                if(m.getXX() == "FF")  //Getting cutting speed
                {
                	Log(lInfo) << "Reading Return Speed..";

                    //16 bit speed value
                	string yyyy = m.getData();
                   	Log(lInfo) << "Data: " << yyyy;
                   	CurrentReturnSpeedL->setValue(hexToDec(yyyy));
                    mUC7.setReturnSpeed(CurrentReturnSpeedL->getValue(), false);
	                message_handled = true;
                }
            }
        	else if(m.getCommand() == "40")
            {
            	string d = m.getData().substr(2,2);
                if(d == "00")  //Retract
                {
                	Log(lDebug3) << "Retracting";
                	mUC7.setStrokeState(ssRetracting);
                	mCrankPositionPie->Angles->EndAngle = 180;
                	mCrankPositionPie->Angles->StartAngle = 90;
                    mHWPosShape->Left = mRetractLbl->Left;
                    mHWPosShape->Width = mRetractLbl->Width;
                }
                else if(d == "01")  //Before cutting
                {
                   	Log(lDebug3) << "Before Cutting";
                   	mUC7.setStrokeState(ssBeforeCutting);
                	mCrankPositionPie->Angles->EndAngle = 90;
                	mCrankPositionPie->Angles->StartAngle = 0;
                    mHWPosShape->Left = mBeforeCuttingLbl->Left;
                    mHWPosShape->Width = mBeforeCuttingLbl->Width;
                }
                else if(d == "03") //Cutting
                {
                   	Log(lDebug3) << "Cutting";
                   	mUC7.getSectionCounter().increase();
                   	mUC7.setStrokeState(ssCutting);
                	mCrankPositionPie->Angles->EndAngle = 0;
                	mCrankPositionPie->Angles->StartAngle = 270;
                    mHWPosShape->Left = mCuttingLbl->Left;
                    mHWPosShape->Width = mCuttingLbl->Width;
                }
                else if(d == "02") //After cutting
                {
                   	Log(lDebug3) << "After Cutting";
                   	mUC7.setStrokeState(ssAfterCutting);
                	mCrankPositionPie->Angles->EndAngle = 270;
                	mCrankPositionPie->Angles->StartAngle = 180;
                    mHWPosShape->Left = mAfterCuttingLbl->Left;
                    mHWPosShape->Width = mAfterCuttingLbl->Width;

                }
                else if(d == "E0")
                {
                   	mUC7.setStrokeState(ssUndefined);
                }
                message_handled = true;
            }
        }
        break;

        case gSystemCommands:
        {
        	string cmd = m.getCommand();
        	if(cmd == "F0")
            {
               	Log(lInfo) << "Software Reset!";
                message_handled = true;
            }
            else if(cmd == "F1")
            {
               	Log(lInfo) << "Getting part ID data: "<<m.getData();
                message_handled = true;
            }
            else if(cmd == "F2")
            {
               	Log(lInfo) << "Logging in";
                message_handled = true;
            }
            else if(cmd == "F3")
            {
            	Log(lError) << "There was a Command/Transmission Error. Data: "<<m.getData();
                message_handled = true;
            }
            else if(cmd == "F5")
            {
               	Log(lInfo) << "Getting version data: "<<m.getData();
                message_handled = true;
            }
        }
		break;

        default:
        	message_handled = false;
    }

    if(!message_handled)
    {
    	Log(lInfo) << "UC7 sent an unhandled message: " << m.getFullMessage();
    }
    mUC7Messages.push_back(pair<UC7Message, bool>(m, message_handled));
    return true;
}


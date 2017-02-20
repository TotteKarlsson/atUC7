#include <vcl.h>
#pragma hdrstop
#include "atVCLUtils.h"
#include "database/atDBUtils.h"
#include "mtkLogger.h"
#include "mtkMoleculixException.h"
#include "mtkSQLiteException.h"
#include "mtkSQLiteQuery.h"
#include "mtkSQLiteTable.h"
#include "mtkStringUtils.h"
#include "mtkUtils.h"
#include "mtkVCLUtils.h"
#include "Poco/DateTime.h"
#include "Poco/DateTimeFormat.h"
#include "Poco/DateTimeFormatter.h"
#include "Poco/Glob.h"
#include "Poco/Timezone.h"
#include "TMainForm.h"
#include "TMemoLogger.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "mtkIniFileC"
#pragma link "mtkIniFileC"
#pragma link "pies"
#pragma link "TFloatLabeledEdit"
#pragma link "TSTDStringEdit"
#pragma resource "*.dfm"

TMainForm *MainForm;
using namespace mtk;
using namespace ab;

extern string gLogFileName;
extern string gApplicationRegistryRoot;
extern string gDefaultAppTheme;
extern string gFullDateTimeFormat;
extern bool gIsDevelopmentRelease;

//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
    : TRegistryForm(gApplicationRegistryRoot, "MainForm", Owner),

    mBottomPanelHeight(190),
    mSplashProperties(gApplicationRegistryRoot, "Splash"),
    mShowSplashOnStartup(true),
    mLogLevel(lAny),
    mIsStyleMenuPopulated(false),
    gCanClose(true),
    mLogFileReader(joinPath(getSpecialFolder(CSIDL_LOCAL_APPDATA), "atUC7", gLogFileName), &logMsg),
    mCOMPort(0),
    mUC7Consumer(mUC7, Handle)
{
    //Close any dataconnection created by stupid TSQLConnection
    TMemoLogger::mMemoIsEnabled = false;
    setupIniFile();
    setupAndReadIniParameters();
    mUC7Consumer.start();
}

//This one is called from the reader thread
void __fastcall TMainForm::logMsg()
{
    infoMemo->Lines->Add(vclstr(mLogFileReader.getData()));
    mLogFileReader.purge();
}

//---------------------------------------------------------------------------
int	TMainForm::getCOMPortNumber()
{
	return mComportCB->ItemIndex + 1;
}

void __fastcall TMainForm::mSendBtn1Click(TObject *Sender)
{
	TButton* btn = dynamic_cast<TButton*>(Sender);

	string msg;
	bool sendRaw(false);
    if(btn == mGetCurrentFeedRateBtn)
    {
    	mUC7.getCurrentFeedRate();
    }
    else if (btn == mStartStopBtn)
    {
    	if(mStartStopBtn->Caption == "Start")
        {
            Log(lInfo) << "Starting cutter";
            mUC7.startCutter();

        }
        else
        {
            Log(lInfo) << "Stopping cutter";
            mUC7.stopCutter();
        }
    }
    else if (btn == mSendBtn1)
    {
		sendRaw = true;
    }

 	if(!sendRaw)
    {
    	mRawCMDE->setValue(mUC7.getLastSentMessage().getMessage());
	    mCheckSumEdit->setValue(mUC7.getLastSentMessage().getCheckSum());
    }

	msg = mRawCMDE->getValue();
    UC7Message uc7Msg(msg, false);
    uc7Msg.calculateCheckSum();
    Log(lInfo) << "Checksum is: " <<uc7Msg.getCheckSum();


    if(sendRaw)
    {
	    Log(lInfo) << "Sending message: " << uc7Msg.getFullMessage();
		mUC7.sendRawMessage(uc7Msg.getFullMessage());
    }
}

void __fastcall TMainForm::onConnectedToUC7()
{
	enableDisableUI(true);
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::onDisConnectedToUC7()
{
	enableDisableUI(false);
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::enableDisableUI(bool enableDisable)
{
    mConnectUC7Btn->Caption                 = enableDisable ? "Close" : "Open";
	mSendBtn1->Enabled 		                = enableDisable;

	enableDisableGroupBox(CuttingMotorGB, enableDisable);
    enableDisableGroupBox(HandwheelGB, enableDisable);
    enableDisableGroupBox(NorthSouthGB,enableDisable);

    mCrankPositionPie->Brush->Color 		= enableDisable ? clRed : this->Color;
}

//---------------------------------------------------------------------------
bool TMainForm::handleUC7Message(const UC7Message& m)
{
	//Find out controller address from sender parameter
	switch(toInt(m.getSender()))
    {
    	case 1: 		return UNKNOWN;
        case 2:			return UNKNOWN;
        case 3:			return UNKNOWN;
        case 4:
        {
        	if(m.getCommand() == "20")
            {

            }
            else if(m.getCommand() == "21")
            {

            }
            else if(m.getCommand() == "23")
            {

            }
            else if(m.getCommand() == "30")
            {

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

void __fastcall TMainForm::mRawCMDEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
    UC7Message msg(mRawCMDE->getValue(), false);
    msg.calculateCheckSum();
    Log(lInfo) << "Checksum is: " << msg.getCheckSum();
    mCheckSumEdit->setValue(msg.getCheckSum());
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mRawCMDEChange(TObject *Sender)
{
	mRawCMDE->OnChange(Sender);
}



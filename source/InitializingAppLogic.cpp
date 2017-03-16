#pragma hdrstop
#include "TMainForm.h"
#include "TMemoLogger.h"
#include "mtkVCLUtils.h"
#include "mtkLogger.h"
#include "mtkIniSection.h"

extern bool             gAppIsStartingUp;
extern string           gLogFileLocation;
extern string           gLogFileName;
using namespace mtk;

//---------------------------------------------------------------------------
void __fastcall TMainForm::FormCreate(TObject *Sender)
{
    TMemoLogger::mMemoIsEnabled = false;

	setupWindowTitle();
	LogLevelCB->ItemIndex = mLogLevel;
	if(mLogLevel == lInfo)
	{
		StringList logs = getLinesInFile(joinPath(gLogFileLocation, gLogFileName));

		StringList msgs;
		msgs.append("WARNING");
		msgs.append("ERROR");
		msgs.append("INFO");

		//Only add lines to logwindow with lInfo and "higher"
		for(uint i = 0; i < logs.size(); i++)
		{
			if(contains(msgs, logs[i]))
			{
				infoMemo->Lines->Add(vclstr(logs[i]));
			}
		}
	}
	else if(mLogLevel == lAny)
	{
		StringList logs = getLinesInFile(joinPath(gLogFileLocation, gLogFileName));

		//Only add lines to log window with lInfo and "igher"
		for(uint i = 0; i < logs.size(); i++)
		{
			infoMemo->Lines->Add(vclstr(logs[i]));
		}
	}

	mLogFileReader.start(true);
    mStartupTimer->Enabled = true;
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::FormShow(TObject *Sender)
{
	gAppIsStartingUp = false;

	//transfer INI values
	BottomPanel->Height     = mBottomPanelHeight + 1;
	SB->Top = MainForm->Top + MainForm->Height + 10;
	SB->SizeGrip = true;

    enableDisableUI(false);
}

void TMainForm::setupIniFile()
{
	string fldr = getSpecialFolder(CSIDL_LOCAL_APPDATA);
	fldr =  joinPath(fldr, "atUC7");

	if(!folderExists(fldr))
	{
		CreateDir(fldr.c_str());
	}

	mIniFileC->init(fldr);
}

bool TMainForm::setupAndReadIniParameters()
{
	mIniFileC->load();
	mGeneralProperties.setIniFile(mIniFileC->getIniFile());

	//Setup parameters
	mGeneralProperties.setSection("GENERAL");
	mGeneralProperties.add((BaseProperty*)  &mBottomPanelHeight.setup( 	            "HEIGHT_OF_BOTTOM_PANEL",    	    205));

	mGeneralProperties.add((BaseProperty*)  &mLogLevel.setup( 	                    "LOG_LEVEL",    	                lAny));
	mGeneralProperties.add((BaseProperty*)  &mCOMPort.setup( 	                    "COM_PORT",    	                	0));
	mGeneralProperties.add((BaseProperty*)  &mRawCMDE->getProperty()->setup(        "RAW_CMD",    	                	""));
	mGeneralProperties.add((BaseProperty*)  &mCountToE->getProperty()->setup(       "COUNT_TO",                     	5));
	mGeneralProperties.add((BaseProperty*)  &mZeroCutsE->getProperty()->setup(      "NUMBER_OF_ZERO_CUTS",           	2));

	mGeneralProperties.add((BaseProperty*)  &mStageMoveDelayE->getProperty()->setup("KNIFE_STAGE_MOVE_DELAY",          	10));
	mGeneralProperties.add((BaseProperty*)  &mPresetFeedRateE->getProperty()->setup("PRESET_FEED_RATE",               	100));
	mGeneralProperties.add((BaseProperty*)  &mKnifeStageJogStep->getProperty()->setup("KNIFE_STAGE_JOG_SIZE",          	100));


	//Read from file. Create if file do not exist
	mGeneralProperties.read();

	//Setup UI elements
	mRawCMDE->update();
	mCountToE->update();
    mPresetFeedRateE->update();
    mKnifeStageJogStep->update();
    mStageMoveDelayE->update();
	mZeroCutsE->update();
	mComportCB->ItemIndex = mCOMPort - 1;

    gLogger.setLogLevel(mLogLevel);
	return true;
}


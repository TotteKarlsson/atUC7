#include <vcl.h>
#pragma hdrstop
#include "atVCLUtils.h"
#include "mtkLogger.h"
#include "mtkStringUtils.h"
#include "mtkUtils.h"
#include "mtkVCLUtils.h"
#include "TMainForm.h"
#include "TMemoLogger.h"
#include "sound/atSounds.h"
#include <mmsystem.h>
#include "atCore.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma link "mtkIniFileC"
#pragma link "pies"
#pragma link "TFloatLabeledEdit"
#pragma link "TSTDStringEdit"
#pragma link "TIntegerLabeledEdit"
#pragma link "TIntLabel"
#pragma link "mtkIntEdit"
#pragma link "TPropertyCheckBox"
#pragma link "TArrayBotBtn"
#pragma resource "*.dfm"

TMainForm *MainForm;
using namespace mtk;
using namespace at;

extern string gLogFileName;
extern string gApplicationRegistryRoot;
extern string gDefaultAppTheme;
extern string gFullDateTimeFormat;
extern bool gIsDevelopmentRelease;

//---------------------------------------------------------------------------
__fastcall TMainForm::TMainForm(TComponent* Owner)
    : TRegistryForm(gApplicationRegistryRoot, "MainForm", Owner),

    mBottomPanelHeight(190),
    mLogLevel(lAny),
    gCanClose(true),
    mLogFileReader(joinPath(getSpecialFolder(CSIDL_LOCAL_APPDATA), "atUC7", gLogFileName), &logMsg),
    mCOMPort(0),
	mUC7(Handle),
    mCountTo(0)
{
    TMemoLogger::mMemoIsEnabled = (false);

    //Init the DLL -> give intra messages their ID's
	initABCoreLib();

	//Setup references
  	//The following causes the editbox, and its property to reference the counters CountTo value
   	mCountToE->setReference(mUC7.getSectionCounter().getCountToReference());
   	mCounterLabel->setReference(mUC7.getSectionCounter().getCountReference());
    mZeroCutsE->setReference(mUC7.getNumberOfZeroStrokesReference());

    mCountToE->update();
    mCounterLabel->update();
    mZeroCutsE->update();

	mRibbonCreatorActiveCB->setReference(mUC7.getRibbonCreatorActiveReference());

    setupIniFile();
    setupAndReadIniParameters();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::createUC7Message(TObject *Sender)
{
	TArrayBotButton* btn = dynamic_cast<TArrayBotButton*>(Sender);

    if(!btn)
    {
    	Log(lError) << "Sender object was NULl!";
    	return;
    }

	bool sendRaw(false);
	if (btn == mStartStopBtn)
    {
    	if(mStartStopBtn->Caption == "Start")
        {
            mUC7.startCutter();
        }
        else
        {
            mUC7.stopCutter();
        }
    }
    else if(btn == mSetZeroCutBtn)
    {
		mUC7.setFeedRate(0);
    }
    else if(btn == mRibbonStartBtn)
    {
    	if(btn->Caption == "Back off")
        {
			mUC7.prepareToCutRibbon(true);
            btn->Caption = "Preparing for IDLE";
        }
        else
        {
            mUC7.prepareForNewRibbon(true);
            btn->Caption = "Preparing start of Ribbon";
            btn->Enabled = false;
        }
    }
    else if(btn == mMoveSouthBtn)
    {
    	mUC7.jogKnifeStageSouth(mKnifeStageJogStep->getValue());
		mUC7.jogKnifeStageSouth(mKnifeStageJogStep->getValue());
    }
    else if(btn == mMoveNorthBtn)
    {
    	mUC7.jogKnifeStageNorth(mKnifeStageJogStep->getValue());
    }

    else if(btn == mSendBtn1)
    {
		sendRaw = true;
    }

 	if(!sendRaw)
    {
    	string msg = mUC7.getLastSentMessage().getMessage();
    	mRawCMDE->setValue(msg);
	    mCheckSumEdit->setValue(mUC7.getLastSentMessage().getCheckSum());
    }
    else
    {
        string msg = mRawCMDE->getValue();
        UC7Message uc7Msg(msg, false);
        uc7Msg.calculateCheckSum();

    	Log(lInfo) << "Sending UC7 message:\""<<msg << "\"\t"<<uc7Msg.getMessageNameAsString();
		mUC7.sendRawMessage(uc7Msg.getFullMessage());
    }
}

//---------------------------------------------------------------------------
void TMainForm::onUC7Count()
{
	mCounterLabel->update();
    if(mRibbonCreatorActiveCB->Checked)
    {
    	//Check if we are close to ribbon separation
        if(mCounterLabel->getValue() >= (mCountToE->getValue() - 3))
        {
//			playABSound(absBeforeBackOff, SND_ASYNC);
        }
    }
}

//---------------------------------------------------------------------------
void TMainForm::onUC7CountedTo()
{
	if(mUC7.isActive())
    {
	    mUC7.getSectionCounter().reset();
		Log(lInfo) << "Creating new ribbon";
	    mUC7.prepareToCutRibbon(true);
        mRibbonStartBtn->Enabled = false;
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mRawCMDEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
    UC7Message msg(mRawCMDE->getValue(), false);
    msg.calculateCheckSum();
    mCheckSumEdit->setValue(msg.getCheckSum());
    if(Key = VK_RETURN)
    {
    	Log(lInfo) << "Message: "<<msg.getMessageNameAsString();
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mRawCMDEChange(TObject *Sender)
{
	mRawCMDE->OnChange(Sender);
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mFeedRateEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
	TIntegerLabeledEdit* e = dynamic_cast<TIntegerLabeledEdit*>(Sender);

	if(Key == VK_RETURN)
    {
    	if(e == mFeedRateE)
        {
        	//Set feedrate
	        mUC7.setFeedRate(e->getValue());
        }
        else if(e == mKnifeStageJogStep)
        {
	        mUC7.setKnifeStageJogStepPreset(e->getValue());
        }
        else if(e == mNorthLimitPosE)
        {
        	mUC7.setNorthLimitPosition(e->getValue());
        }
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mSynchUIBtnClick(TObject *Sender)
{
    mUC7.getStatus();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::miscBtnClicks(TObject *Sender)
{
	TArrayBotButton* btn = dynamic_cast<TArrayBotButton*>(Sender);
    if(btn == mResetCounterBtn)
    {
    	mUC7.getSectionCounter().reset();
        mCounterLabel->update();
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mPresetFeedRateEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{
	TIntegerLabeledEdit* e = dynamic_cast<TIntegerLabeledEdit*>(Sender);

    if(e == mPresetFeedRateE)
    {
        if(Key == VK_RETURN)
        {
            mUC7.setFeedRatePreset(e->getValue());
        }
    }
    else if(e == mStageMoveDelayE)
    {
 		mUC7.setStageMoveDelay(e->getValue());
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mRepeatTimerTimer(TObject *Sender)
{
	mSendBtn1->Click();
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mRepeatEveryBtnClick(TObject *Sender)
{
	mRepeatTimer->Enabled = !mRepeatTimer->Enabled;
    if(mRepeatTimer->Enabled)
    {
	    mRepeatTimer->Interval = mRepeatTimeE->getValue();
		mRepeatEveryBtn->Caption = "Stop";
    }
    else
    {
		mRepeatEveryBtn->Caption = "Repeat Every";
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mRibbonCreatorActiveCBClick(TObject *Sender)
{
	mRibbonCreatorActiveCB->OnClick(Sender);
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mConnectUC7BtnClick(TObject *Sender)
{
	if(mConnectUC7Btn->Caption == "Open")
    {
        if(mUC7.connect(getCOMPortNumber()))
        {
            Log(lInfo) << "Connected to a UC7 device";
        }
        else
        {
            Log(lInfo) << "Connection failed";
        }
    }
    else
    {
        if(!mUC7.disConnect())
        {
			Log(lError) << "Failed to close serial port";
        }
    }

    //Give it some time to close down..
    //These should be UC7 callbacks..
    Sleep(100);
    if(mUC7.isConnected())
    {
	    onConnectedToUC7();
    }
    else
    {
		onDisConnectedToUC7();
    }
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mStartupTimerTimer(TObject *Sender)
{
	mStartupTimer->Enabled = false;
	mConnectUC7BtnClick(NULL);
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mCloseBottomPanelBtnClick(TObject *Sender)
{
	BottomPanel->Visible = false;
    mShowBottomPanelBtn->Visible = true;
}

//---------------------------------------------------------------------------
void __fastcall TMainForm::mShowBottomPanelBtnClick(TObject *Sender)
{
	BottomPanel->Visible = true;
    mShowBottomPanelBtn->Visible = false;
    Splitter1->Top = BottomPanel->Top - 1;
}

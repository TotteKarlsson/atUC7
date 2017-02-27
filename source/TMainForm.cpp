#include <vcl.h>
#pragma hdrstop
#include "atVCLUtils.h"
#include "mtkLogger.h"
#include "mtkStringUtils.h"
#include "mtkUtils.h"
#include "mtkVCLUtils.h"
#include "TMainForm.h"
#include "TMemoLogger.h"
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
    mLogLevel(lAny),
    gCanClose(true),
    mLogFileReader(joinPath(getSpecialFolder(CSIDL_LOCAL_APPDATA), "atUC7", gLogFileName), &logMsg),
    mCOMPort(0),
	mUC7(Handle),
    mCountTo(0)
{
    TMemoLogger::mMemoIsEnabled = (false);

	//Setup references
  	//The following causes the editbox, and its property to reference the counters CountTo value
   	mCountToE->setReference(mUC7.getCounter().getCountToReference());

   	mCounterLabel->setReference(mUC7.getCounter().getCountReference());
    mCounterLabel->update();

	mRibbonCreatorActiveCB->setReference(mUC7.getRibbonCreatorActiveReference());

	mNumberOfZeroStrokesAfter->setReference(mUC7.getSetNumberOfZeroStrokesReference());
    
    setupIniFile();
    setupAndReadIniParameters();
}

//---------------------------------------------------------------------------
int	TMainForm::getCOMPortNumber()
{
	return mComportCB->ItemIndex + 1;
}

void __fastcall TMainForm::createUC7Message(TObject *Sender)
{
	TButton* btn = dynamic_cast<TButton*>(Sender);

    if(!btn)
    {
    	Log(lError) << "Sender object was NULl!";
    	return;
    }

	bool sendRaw(false);
    if(btn == mGetFeedRateBtn)
    {
    	mUC7.getCurrentFeedRate();
    }
    else if (btn == mGetKnifeStagePosBtn)
    {
     	mUC7.getKnifeStagePosition();
    }
    else if (btn == mStartStopBtn)
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
    else if(btn == mRibbonStartBtn)
    {
        mUC7.prepareForNewRibbon(true);
        btn->Caption = "Resume";
    }
    else if(btn == mMoveSouthBtn)
    {
    	mUC7.moveKnifeStageSouth(mKnifeStageJogStep->getValue());
    }
    else if(btn == mMoveNorthBtn)
    {
    	mUC7.moveKnifeStageNorth(mKnifeStageJogStep->getValue());
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

void __fastcall TMainForm::onConnectedToUC7()
{
	//Setup callbacks
    mUC7.getCounter().assignOnCountCallBack(onUC7Count);
    mUC7.getCounter().assignOnCountedToCallBack(onUC7CountedTo);
	enableDisableUI(true);
}

void TMainForm::onUC7Count()
{
	mCounterLabel->update();
}

void TMainForm::onUC7CountedTo()
{
	if(mUC7.isActive())
    {
	    mUC7.getCounter().reset();
		Log(lInfo) << "Creating new ribbon";
	    mUC7.prepareToCutRibbon(true);
        mRibbonStartBtn->Enabled = false;
    }
}

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
	if(Key == VK_RETURN)
    {
    	//Set feedrate
        mUC7.setFeedRate(mFeedRateE->getValue());
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
	TButton* btn = dynamic_cast<TButton*>(Sender);
    if(btn == mResetCounterBtn)
    {
    	mUC7.getCounter().reset();
        mCounterLabel->update();
    }
}

void __fastcall TMainForm::mPresetFeedRateEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift)
{

	TIntegerLabeledEdit* e = dynamic_cast<TIntegerLabeledEdit*>(Sender);

    if(e == mPresetFeedRateE)
    {
        if(Key == VK_RETURN)
        {
            mUC7.setPresetFeedRate(e->getValue());
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



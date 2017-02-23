#ifndef TMainFormH
#define TMainFormH
#include <System.Classes.hpp>
#include <Vcl.Controls.hpp>
#include <Vcl.StdCtrls.hpp>
#include <Vcl.Forms.hpp>
#include <Vcl.ComCtrls.hpp>
#include <Vcl.ExtCtrls.hpp>
#include <Vcl.Grids.hpp>
#include <System.Actions.hpp>
#include <Vcl.ActnList.hpp>
#include <Vcl.Menus.hpp>
#include <Vcl.StdActns.hpp>
//---------------------------------------------------------------------------
#include "source/atUC7ApplicationMessages.h"
#include "source/atUC7DataStructures.h"
#include "mtkIniFileC.h"
#include "mtkIniFileProperties.h"
#include "mtkLogFileReader.h"
#include "mtkLogLevel.h"
#include "mtkMessageContainer.h"
#include "mtkProperty.h"
#include "mtkSQLite.h"
#include "TApplicationProperties.h"
#include "TRegistryForm.h"
#include "TRegistryProperties.h"
#include "TSTDStringLabeledEdit.h"
#include "TSTDStringEdit.h"
#include "mtkIniFileC.h"
#include "atUC7Component.h"
#include "pies.h"
#include "TFloatLabeledEdit.h"
#include "atUC7MessageConsumer.h"
#include "TSTDStringEdit.h"
#include "TIntegerLabeledEdit.h"
#include "TIntLabel.h"
using mtk::Property;
using mtk::MessageContainer;
using mtk::IniFileProperties;
using mtk::TRegistryProperties;

extern string gApplicationRegistryRoot;

class TMainForm : public TRegistryForm
{
    __published:	// IDE-managed Components
    TStatusBar *SB;
        TActionList *ActionList1;
        TPopupMenu *PopupMenu1;
        TAction *ClearMemoA;
        TMenuItem *ClearMemoA1;
    TSplitter *Splitter1;
	TPanel *mMiddlePanel;
    mtkIniFileC *mIniFileC;
    TMainMenu *MainMenu1;
    TMenuItem *File1;
    TMenuItem *Help1;
    TFileExit *FileExit1;
    TMenuItem *Exit1;
    TAction *OpenAboutFormA;
    TMenuItem *About1;
    TTimer *ShutDownTimer;
	TMemo *infoMemo;
	TPanel *BottomPanel;
	TPanel *Panel1;
	TButton *Button1;
	TComboBox *LogLevelCB;
	TComboBox *mComportCB;
	TButton *mConnectUC7Btn;
	TButton *mSendBtn1;
	TButton *mStartStopBtn;
	TGroupBox *CuttingMotorGB;
	TPanel *mTopPanel;
	TButton *mSynchUIBtn;
	TGroupBox *HandwheelGB;
	TPie *mCrankPositionPie;
	TLabel *mRetractLbl;
	TLabel *mBe;
	TLabel *Label3;
	TLabel *Label4;
	TPanel *mMiddleLeftPanel;
	TGroupBox *GroupBox2;
	TFloatLabeledEdit *FloatLabeledEdit1;
	TFloatLabeledEdit *FloatLabeledEdit2;
	TSTDStringEdit *mCheckSumEdit;
	TSTDStringEdit *mRawCMDE;
	TSTDStringEdit *STDStringEdit1;
	TGroupBox *NorthSouthGB;
	TButton *mGetFeedRateBtn;
	TIntegerLabeledEdit *mFeedRateE;
	TIntegerLabeledEdit *mKnifeStageNSAbsPosE;
	TButton *mGetKnifeStagePosBtn;
	TGroupBox *CounterGB;
	TIntegerLabeledEdit *mCountToE;
	TButton *mResetCounterBtn;
	TIntLabel *mCounterLabel;
	TButton *mRibbonStartBtn;
	TButton *mMoveSouthBtn;
	TButton *mMoveNorthBtn;
	TIntegerLabeledEdit *mKnifeStageJogStep;
	TIntegerLabeledEdit *mPresetFeedRateE;
    void __fastcall FormKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
    void __fastcall FormCreate(TObject *Sender);

    void __fastcall ClearMemoAExecute(TObject *Sender);
    void __fastcall FormCloseQuery(TObject *Sender, bool &CanClose);
    void __fastcall FormShow(TObject *Sender);
    void __fastcall ThemesMenuClick(TObject *Sender);
    void __fastcall ShutDownTimerTimer(TObject *Sender);
	void __fastcall FormClose(TObject *Sender, TCloseAction &Action);
    void __fastcall LogLevelCBChange(TObject *Sender);
	void __fastcall mConnectUC7BtnClick(TObject *Sender);
	void __fastcall createUC7Message(TObject *Sender);
	void __fastcall OpenAboutFormAExecute(TObject *Sender);
	void __fastcall mRawCMDEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
	void __fastcall mRawCMDEChange(TObject *Sender);
	void __fastcall mFeedRateEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);
	void __fastcall mSynchUIBtnClick(TObject *Sender);
	void __fastcall miscBtnClicks(TObject *Sender);
	void __fastcall mPresetFeedRateEKeyDown(TObject *Sender, WORD &Key, TShiftState Shift);


    private:
        bool                                            gCanClose;

		UC7												mUC7;

        												//!Consume UC7 messages
        UC7MessageConsumer		  						mUC7Consumer;

        int												getCOMPortNumber();
        void __fastcall                                 logMsg();
		LogFileReader                                   mLogFileReader;
		bool                                            mIsStyleMenuPopulated;
		void                                            setupWindowTitle();
		void                                            updateWindowTitle();


                                                        //INI Parameters...
        IniFileProperties	      	                    mGeneralProperties;
        mtk::Property<int>	                            mBottomPanelHeight;
		mtk::Property<mtk::LogLevel>	                mLogLevel;
		mtk::Property<int>	                			mCOMPort;
        mtk::Property<int>                             	mCountTo;

        void __fastcall                          		PopulateStyleMenu();
        bool                                            setupAndReadIniParameters();
        void                                            setupIniFile();

		void __fastcall 								onConnectedToUC7();
        void __fastcall 								onDisConnectedToUC7();
		void __fastcall                                 AppInBox(ATWindowStructMessage& Msg);
        bool											handleUC7Message(const UC7Message& m);
		void __fastcall 								enableDisableUI(bool enableDisable);
        void 											onUC7Count();
        void 											onUC7CountedTo();

    public:
                    __fastcall                          TMainForm(TComponent* Owner);
                    __fastcall                          ~TMainForm();

        BEGIN_MESSAGE_MAP
                  MESSAGE_HANDLER(UWM_MESSAGE,        ATWindowStructMessage,         AppInBox);
        END_MESSAGE_MAP(TForm)
};

extern PACKAGE TMainForm *MainForm;
#endif

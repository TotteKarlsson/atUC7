object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'UC7 Controller'
  ClientHeight = 582
  ClientWidth = 856
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDefault
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 370
    Width = 856
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Constraints.MaxHeight = 10
    ExplicitLeft = 88
    ExplicitTop = 430
    ExplicitWidth = 990
  end
  object mMiddlePanel: TPanel
    Left = 0
    Top = 41
    Width = 856
    Height = 329
    Align = alClient
    TabOrder = 0
    object mMiddleLeftPanel: TPanel
      Left = 1
      Top = 1
      Width = 234
      Height = 327
      Align = alLeft
      TabOrder = 0
      object CuttingMotorGB: TGroupBox
        Left = 1
        Top = 89
        Width = 232
        Height = 237
        Align = alClient
        Caption = 'Cutting Parameters'
        TabOrder = 0
        object mStartStopBtn: TButton
          Left = 21
          Top = 138
          Width = 192
          Height = 90
          Caption = 'Start'
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = createUC7Message
        end
        object mPresetFeedRateE: TIntegerLabeledEdit
          Left = 22
          Top = 44
          Width = 73
          Height = 27
          EditLabel.Width = 128
          EditLabel.Height = 13
          EditLabel.Caption = 'Preset Feed Rate (nm/cut)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = '50'
          OnKeyDown = mPresetFeedRateEKeyDown
          Value = 50
        end
        object FloatLabeledEdit1: TFloatLabeledEdit
          Left = 24
          Top = 98
          Width = 89
          Height = 21
          EditLabel.Width = 68
          EditLabel.Height = 13
          EditLabel.Caption = 'Cutting Speed'
          TabOrder = 2
          Text = '-1.00'
          Value = -1.000000000000000000
        end
        object FloatLabeledEdit2: TFloatLabeledEdit
          Left = 124
          Top = 98
          Width = 89
          Height = 21
          EditLabel.Width = 66
          EditLabel.Height = 13
          EditLabel.Caption = 'Return Speed'
          TabOrder = 3
          Text = '-1.00'
          Value = -1.000000000000000000
        end
      end
      object GroupBox2: TGroupBox
        Left = 1
        Top = 1
        Width = 232
        Height = 88
        Align = alTop
        Caption = 'Misc parameters'
        TabOrder = 1
        object mStageMoveDelayE: TIntegerLabeledEdit
          Left = 22
          Top = 34
          Width = 73
          Height = 27
          EditLabel.Width = 107
          EditLabel.Height = 13
          EditLabel.Caption = 'StageMove delay (ms)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          Text = '50'
          OnKeyDown = mPresetFeedRateEKeyDown
          Value = 50
        end
      end
    end
    object NorthSouthGB: TGroupBox
      Left = 235
      Top = 1
      Width = 233
      Height = 327
      Align = alLeft
      Caption = 'North-South'
      TabOrder = 1
      object mGetFeedRateBtn: TButton
        Left = 127
        Top = 40
        Width = 74
        Height = 25
        Caption = 'fetch'
        Enabled = False
        TabOrder = 1
        OnClick = createUC7Message
      end
      object mFeedRateE: TIntegerLabeledEdit
        Left = 24
        Top = 37
        Width = 73
        Height = 27
        EditLabel.Width = 94
        EditLabel.Height = 13
        EditLabel.Caption = 'Feed Rate (nm/cut)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0'
        OnKeyDown = mFeedRateEKeyDown
      end
      object mKnifeStageNSAbsPosE: TIntegerLabeledEdit
        Left = 24
        Top = 97
        Width = 73
        Height = 27
        EditLabel.Width = 144
        EditLabel.Height = 13
        EditLabel.Caption = 'Knife Stage Position (0-10mm)'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 2
        Text = '0'
        OnKeyDown = mFeedRateEKeyDown
      end
      object mGetKnifeStagePosBtn: TButton
        Left = 127
        Top = 100
        Width = 74
        Height = 25
        Caption = 'fetch'
        Enabled = False
        TabOrder = 3
        OnClick = createUC7Message
      end
      object mMoveSouthBtn: TButton
        Left = 23
        Top = 227
        Width = 90
        Height = 90
        Caption = 'Move South'
        Enabled = False
        TabOrder = 4
        OnClick = createUC7Message
      end
      object mMoveNorthBtn: TButton
        Left = 127
        Top = 227
        Width = 90
        Height = 90
        Caption = 'Move North'
        Enabled = False
        TabOrder = 5
        OnClick = createUC7Message
      end
      object mKnifeStageJogStep: TIntegerLabeledEdit
        Left = 24
        Top = 194
        Width = 73
        Height = 27
        EditLabel.Width = 125
        EditLabel.Height = 13
        EditLabel.Caption = 'Knife Stage Jog Step (nm)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '1'
        OnKeyDown = mFeedRateEKeyDown
        Value = 1
      end
      object mNorthLimitPosE: TIntegerLabeledEdit
        Left = 24
        Top = 149
        Width = 73
        Height = 27
        EditLabel.Width = 140
        EditLabel.Height = 13
        EditLabel.Caption = 'North Limit Position (0-10mm)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        Text = '0'
        OnKeyDown = mFeedRateEKeyDown
      end
    end
    object CounterGB: TGroupBox
      Left = 468
      Top = 1
      Width = 287
      Height = 327
      Align = alLeft
      Caption = 'Ribbon Creation'
      TabOrder = 2
      object mCounterLabel: TIntLabel
        Left = 32
        Top = 33
        Width = 11
        Height = 25
        Caption = '1'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Value = 1
        TheFont.Charset = DEFAULT_CHARSET
        TheFont.Color = clWindowText
        TheFont.Height = -21
        TheFont.Name = 'Tahoma'
        TheFont.Style = []
      end
      object mCountToE: TIntegerLabeledEdit
        Left = 120
        Top = 32
        Width = 65
        Height = 31
        EditLabel.Width = 44
        EditLabel.Height = 13
        EditLabel.Caption = 'Count To'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = '0'
      end
      object mResetCounterBtn: TButton
        Left = 31
        Top = 64
        Width = 50
        Height = 25
        Caption = 'Reset'
        Enabled = False
        TabOrder = 1
        OnClick = miscBtnClicks
      end
      object mRibbonCreatorActiveCB: TPropertyCheckBox
        Left = 24
        Top = 185
        Width = 241
        Height = 17
        Caption = 'Ribbon Creator on/off'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = mRibbonCreatorActiveCBClick
      end
      object mRibbonStartBtn: TButton
        Left = 22
        Top = 227
        Width = 245
        Height = 90
        Caption = 'Resume Cutting'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = createUC7Message
      end
      object mZeroCutsE: TIntegerLabeledEdit
        Left = 32
        Top = 130
        Width = 81
        Height = 31
        EditLabel.Width = 210
        EditLabel.Height = 19
        EditLabel.Caption = 'Zero cuts before knife backoff'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -16
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '0'
      end
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 563
    Width = 856
    Height = 19
    Panels = <>
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 373
    Width = 856
    Height = 190
    Align = alBottom
    TabOrder = 2
    object infoMemo: TMemo
      Left = 1
      Top = 49
      Width = 536
      Height = 140
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 854
      Height = 48
      Align = alTop
      TabOrder = 1
      object Button1: TButton
        Left = 8
        Top = 12
        Width = 75
        Height = 25
        Caption = 'Clear'
        TabOrder = 0
        OnClick = ClearMemoAExecute
      end
      object LogLevelCB: TComboBox
        Left = 89
        Top = 12
        Width = 145
        Height = 21
        TabOrder = 1
        Text = 'INFO'
        OnChange = LogLevelCBChange
        Items.Strings = (
          'ERRORS'
          'WARNINGS'
          'INFO'
          'DEBUG'
          'DEBUG1'
          'DEBUG2'
          'DEBUG3'
          'DEBUG4'
          'DEBUG5'
          'EVERYTHING')
      end
    end
    object HandwheelGB: TGroupBox
      Left = 537
      Top = 49
      Width = 318
      Height = 140
      Align = alRight
      Caption = 'Handwheel Position'
      TabOrder = 2
      object mCrankPositionPie: TPie
        Left = 95
        Top = 36
        Width = 90
        Height = 90
        Angles.StartAngle = 90
        Angles.EndAngle = 180
        Brush.Color = clCream
      end
      object mRetractLbl: TLabel
        Left = 40
        Top = 36
        Width = 36
        Height = 13
        Caption = 'Retract'
      end
      object mBe: TLabel
        Left = 191
        Top = 36
        Width = 70
        Height = 13
        Caption = 'Before Cutting'
      end
      object Label3: TLabel
        Left = 191
        Top = 116
        Width = 35
        Height = 13
        Caption = 'Cutting'
      end
      object Label4: TLabel
        Left = 40
        Top = 116
        Width = 63
        Height = 13
        Caption = 'After Cutting'
      end
    end
  end
  object mTopPanel: TPanel
    Left = 0
    Top = 0
    Width = 856
    Height = 41
    Align = alTop
    TabOrder = 3
    object Label1: TLabel
      Left = 679
      Top = 19
      Width = 13
      Height = 13
      Caption = 'ms'
    end
    object mComportCB: TComboBox
      Left = 8
      Top = 12
      Width = 145
      Height = 21
      ItemIndex = 0
      TabOrder = 0
      Text = 'COM1'
      Items.Strings = (
        'COM1'
        'COM2'
        'COM3'
        'COM4'
        'COM5'
        'COM6'
        'COM7'
        'COM8'
        'COM9'
        'COM10'
        'COM11'
        'COM12'
        'COM13'
        'COM14'
        'COM15'
        'COM16'
        'COM17'
        'COM18'
        'COM19'
        'COM20')
    end
    object mConnectUC7Btn: TButton
      Left = 165
      Top = 10
      Width = 50
      Height = 25
      Caption = 'Open'
      TabOrder = 1
      OnClick = mConnectUC7BtnClick
    end
    object mSendBtn1: TButton
      Left = 431
      Top = 10
      Width = 50
      Height = 25
      Caption = 'Send'
      Enabled = False
      TabOrder = 2
      OnClick = createUC7Message
    end
    object mSynchUIBtn: TButton
      Left = 770
      Top = 1
      Width = 85
      Height = 39
      Align = alRight
      Caption = 'Get All Status'
      TabOrder = 4
      OnClick = mSynchUIBtnClick
    end
    object mCheckSumEdit: TSTDStringEdit
      Left = 396
      Top = 14
      Width = 29
      Height = 21
      Enabled = False
      TabOrder = 5
      Text = 'CC'
      Value = 'CC'
    end
    object mRawCMDE: TSTDStringEdit
      Left = 282
      Top = 14
      Width = 108
      Height = 21
      TabOrder = 3
      Text = '81F0F8'
      OnChange = mRawCMDEChange
      OnKeyDown = mRawCMDEKeyDown
      Value = '81F0F8'
    end
    object STDStringEdit1: TSTDStringEdit
      Left = 254
      Top = 14
      Width = 22
      Height = 21
      Alignment = taCenter
      Enabled = False
      TabOrder = 6
      Text = '!'
      Value = '!'
    end
    object mRepeatEveryBtn: TButton
      Left = 519
      Top = 10
      Width = 89
      Height = 25
      Caption = 'Repeat Every'
      Enabled = False
      TabOrder = 7
      OnClick = mRepeatEveryBtnClick
    end
    object mRepeatTimeE: mtkIntEdit
      Left = 630
      Top = 14
      Width = 43
      Height = 21
      TabOrder = 8
      Text = '10'
    end
  end
  object ActionList1: TActionList
    Left = 824
    Top = 312
    object ClearMemoA: TAction
      Category = 'Memo'
      Caption = 'Clear Messages'
      OnExecute = ClearMemoAExecute
    end
    object FileExit1: TFileExit
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 43
    end
    object OpenAboutFormA: TAction
      Caption = 'About'
      OnExecute = OpenAboutFormAExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 848
    Top = 200
    object ClearMemoA1: TMenuItem
      Action = ClearMemoA
    end
  end
  object mIniFileC: mtkIniFileC
    IniFileName = 'atUC7.ini'
    RootFolder = '.'
    Left = 842
    Top = 64
  end
  object MainMenu1: TMainMenu
    Left = 845
    Top = 144
    object File1: TMenuItem
      Caption = 'File'
      object Exit1: TMenuItem
        Action = FileExit1
      end
    end
    object Help1: TMenuItem
      Caption = 'Help'
      object About1: TMenuItem
        Action = OpenAboutFormA
      end
    end
  end
  object ShutDownTimer: TTimer
    Enabled = False
    Interval = 50
    OnTimer = ShutDownTimerTimer
    Left = 802
    Top = 88
  end
  object mRepeatTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = mRepeatTimerTimer
    Left = 744
    Top = 8
  end
end

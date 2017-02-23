object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'UC7 Controller'
  ClientHeight = 571
  ClientWidth = 862
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
    Top = 359
    Width = 862
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitLeft = 88
    ExplicitTop = 430
    ExplicitWidth = 990
  end
  object mMiddlePanel: TPanel
    Left = 0
    Top = 41
    Width = 862
    Height = 318
    Align = alClient
    TabOrder = 0
    object mMiddleLeftPanel: TPanel
      Left = 1
      Top = 1
      Width = 264
      Height = 316
      Align = alLeft
      TabOrder = 0
      object CuttingMotorGB: TGroupBox
        Left = 1
        Top = 1
        Width = 262
        Height = 314
        Align = alClient
        Caption = 'Cutting Motor Controls'
        TabOrder = 0
        ExplicitWidth = 318
        object mStartStopBtn: TButton
          Left = 2
          Top = 231
          Width = 258
          Height = 81
          Align = alBottom
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
          ExplicitWidth = 314
        end
        object GroupBox2: TGroupBox
          Left = 2
          Top = 159
          Width = 258
          Height = 72
          Align = alBottom
          Caption = 'Motor Speeds (um/s)'
          TabOrder = 1
          ExplicitWidth = 314
          object FloatLabeledEdit1: TFloatLabeledEdit
            Left = 20
            Top = 35
            Width = 89
            Height = 21
            EditLabel.Width = 68
            EditLabel.Height = 13
            EditLabel.Caption = 'Cutting Speed'
            TabOrder = 0
            Text = '-1.00'
            Value = -1.000000000000000000
          end
          object FloatLabeledEdit2: TFloatLabeledEdit
            Left = 135
            Top = 35
            Width = 89
            Height = 21
            EditLabel.Width = 66
            EditLabel.Height = 13
            EditLabel.Caption = 'Return Speed'
            TabOrder = 1
            Text = '-1.00'
            Value = -1.000000000000000000
          end
        end
        object mPresetFeedRateE: TIntegerLabeledEdit
          Left = 24
          Top = 45
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
          TabOrder = 2
          Text = '50'
          OnKeyDown = mPresetFeedRateEKeyDown
          Value = 50
        end
      end
    end
    object NorthSouthGB: TGroupBox
      Left = 282
      Top = 14
      Width = 233
      Height = 283
      Caption = 'North-South'
      TabOrder = 1
      object mGetFeedRateBtn: TButton
        Left = 119
        Top = 40
        Width = 74
        Height = 25
        Caption = 'Get Current'
        Enabled = False
        TabOrder = 1
        OnClick = createUC7Message
      end
      object mFeedRateE: TIntegerLabeledEdit
        Left = 16
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
        Left = 16
        Top = 101
        Width = 73
        Height = 27
        EditLabel.Width = 95
        EditLabel.Height = 13
        EditLabel.Caption = 'Knife Stage Position'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = '0'
        OnKeyDown = mFeedRateEKeyDown
      end
      object mGetKnifeStagePosBtn: TButton
        Left = 119
        Top = 104
        Width = 74
        Height = 25
        Caption = 'Get Current'
        Enabled = False
        TabOrder = 3
        OnClick = createUC7Message
      end
      object mMoveSouthBtn: TButton
        Left = 23
        Top = 163
        Width = 74
        Height = 51
        Caption = 'Move South'
        Enabled = False
        TabOrder = 4
        OnClick = createUC7Message
      end
      object mMoveNorthBtn: TButton
        Left = 127
        Top = 163
        Width = 74
        Height = 51
        Caption = 'Move North'
        Enabled = False
        TabOrder = 5
        OnClick = createUC7Message
      end
      object mKnifeStageJogStep: TIntegerLabeledEdit
        Left = 72
        Top = 245
        Width = 73
        Height = 27
        EditLabel.Width = 100
        EditLabel.Height = 13
        EditLabel.Caption = 'Knife Stage Jog Step'
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
    end
    object CounterGB: TGroupBox
      Left = 543
      Top = 19
      Width = 249
      Height = 209
      Caption = 'Ribbon Creation'
      TabOrder = 2
      object mCounterLabel: TIntLabel
        Left = 32
        Top = 35
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
        Left = 128
        Top = 34
        Width = 49
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
        Left = 15
        Top = 66
        Width = 50
        Height = 25
        Caption = 'Reset'
        Enabled = False
        TabOrder = 1
        OnClick = miscBtnClicks
      end
      object mRibbonStartBtn: TButton
        Left = 2
        Top = 136
        Width = 245
        Height = 71
        Align = alBottom
        Caption = 'Start Ribbon'
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
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 552
    Width = 862
    Height = 19
    Panels = <>
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 362
    Width = 862
    Height = 190
    Align = alBottom
    Constraints.MinHeight = 190
    TabOrder = 2
    object infoMemo: TMemo
      Left = 1
      Top = 49
      Width = 542
      Height = 140
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 860
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
      Left = 543
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
    Width = 862
    Height = 41
    Align = alTop
    TabOrder = 3
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
      Left = 776
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
  end
  object ActionList1: TActionList
    Left = 784
    Top = 296
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
    Left = 688
    Top = 296
    object ClearMemoA1: TMenuItem
      Action = ClearMemoA
    end
  end
  object mIniFileC: mtkIniFileC
    IniFileName = 'atUC7.ini'
    RootFolder = '.'
    Left = 810
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 589
    Top = 296
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
    Left = 770
    Top = 136
  end
end

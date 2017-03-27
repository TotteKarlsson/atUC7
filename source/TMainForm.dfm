object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'UC7 Controller'
  ClientHeight = 806
  ClientWidth = 999
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
    Top = 575
    Width = 999
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Constraints.MaxHeight = 10
    ExplicitLeft = 88
    ExplicitTop = 430
    ExplicitWidth = 990
  end
  object SB: TStatusBar
    Left = 0
    Top = 768
    Width = 999
    Height = 19
    Panels = <>
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 578
    Width = 999
    Height = 190
    Align = alBottom
    TabOrder = 1
    object infoMemo: TMemo
      Left = 1
      Top = 49
      Width = 997
      Height = 140
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 997
      Height = 48
      Align = alTop
      TabOrder = 1
      object Button1: TButton
        Left = 8
        Top = 3
        Width = 75
        Height = 39
        Caption = 'Clear'
        TabOrder = 0
        OnClick = ClearMemoAExecute
      end
      object LogLevelCB: TComboBox
        Left = 89
        Top = 12
        Width = 80
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
      object mCloseBottomPanelBtn: TButton
        Left = 928
        Top = 1
        Width = 68
        Height = 46
        Align = alRight
        Caption = 'x'
        TabOrder = 2
        OnClick = mCloseBottomPanelBtnClick
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 65
    Width = 999
    Height = 510
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Main'
      object mMiddlePanel: TPanel
        Left = 0
        Top = 0
        Width = 991
        Height = 482
        Align = alClient
        TabOrder = 0
        object NorthSouthGB: TGroupBox
          Left = 401
          Top = 1
          Width = 233
          Height = 480
          Align = alLeft
          Caption = 'North-South Knife Stage Position (0-100 000)'
          TabOrder = 0
          object mKnifeStageNSAbsPosE: TIntegerLabeledEdit
            Left = 14
            Top = 42
            Width = 73
            Height = 27
            EditLabel.Width = 97
            EditLabel.Height = 13
            EditLabel.Caption = 'Current N/S Position'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            Text = '0'
            OnKeyDown = mFeedRateEKeyDown
          end
          object mNorthLimitPosE: TIntegerLabeledEdit
            Left = 126
            Top = 42
            Width = 83
            Height = 27
            EditLabel.Width = 91
            EditLabel.Height = 13
            EditLabel.Caption = 'North MAX Position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            Text = '0'
            OnKeyDown = mFeedRateEKeyDown
          end
          object mKnifeStageJogStep: TIntegerLabeledEdit
            Left = 14
            Top = 272
            Width = 195
            Height = 27
            EditLabel.Width = 103
            EditLabel.Height = 13
            EditLabel.Caption = 'Knife Stage Jog Step '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 4
            Text = '1'
            OnKeyDown = mFeedRateEKeyDown
            Value = 1
          end
          object mMoveSouthBtn: TArrayBotButton
            Left = 14
            Top = 112
            Width = 90
            Height = 90
            Caption = 'Move South'
            Enabled = False
            ParentDoubleBuffered = True
            TabOrder = 1
            OnClick = createUC7Message
            SoundID = 'BUTTON_CLICK_4'
          end
          object mMoveNorthBtn: TArrayBotButton
            Left = 119
            Top = 112
            Width = 90
            Height = 90
            Caption = 'Move North'
            Enabled = False
            ParentDoubleBuffered = True
            TabOrder = 2
            OnClick = createUC7Message
            SoundID = 'BUTTON_CLICK_4'
          end
        end
        object CounterGB: TGroupBox
          Left = 634
          Top = 1
          Width = 287
          Height = 480
          Align = alLeft
          Caption = 'Ribbon Creation'
          TabOrder = 1
          object mCounterLabel: TIntLabel
            Left = 224
            Top = 34
            Width = 16
            Height = 35
            Caption = '1'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -29
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            Value = 1
            TheFont.Charset = DEFAULT_CHARSET
            TheFont.Color = clWindowText
            TheFont.Height = -29
            TheFont.Name = 'Tahoma'
            TheFont.Style = []
          end
          object mCountToE: TIntegerLabeledEdit
            Left = 22
            Top = 38
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
          object mResetCounterBtn: TArrayBotButton
            Left = 100
            Top = 29
            Width = 106
            Height = 42
            Caption = 'Reset Counter'
            Enabled = False
            ParentDoubleBuffered = True
            TabOrder = 1
            OnClick = miscBtnClicks
            SoundID = 'BUTTON_CLICK_4'
          end
          object mRibbonStartBtn: TArrayBotButton
            Left = 21
            Top = 112
            Width = 245
            Height = 187
            Caption = 'Resume Cutting'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentDoubleBuffered = True
            ParentFont = False
            TabOrder = 2
            OnClick = createUC7Message
            SoundID = 'BUTTON_CLICK_4'
          end
        end
        object CuttingMotorGB: TGroupBox
          Left = 1
          Top = 1
          Width = 400
          Height = 480
          Align = alLeft
          Caption = 'Cutting Parameters'
          TabOrder = 2
          object mPresetFeedRateE: TIntegerLabeledEdit
            Left = 15
            Top = 44
            Width = 73
            Height = 27
            EditLabel.Width = 102
            EditLabel.Height = 13
            EditLabel.Caption = 'Preset Feed (nm/cut)'
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
          object mFeedRateE: TIntegerLabeledEdit
            Left = 145
            Top = 44
            Width = 73
            Height = 27
            EditLabel.Width = 108
            EditLabel.Height = 13
            EditLabel.Caption = 'Current Feed (nm/cut)'
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
          object mSetZeroCutBtn: TArrayBotButton
            Left = 281
            Top = 16
            Width = 104
            Height = 81
            Caption = 'Set zero-cut'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = createUC7Message
            SoundID = 'BUTTON_CLICK_4'
          end
          object mStartStopBtn: TArrayBotButton
            Left = 15
            Top = 112
            Width = 370
            Height = 187
            Caption = 'Start'
            Enabled = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -21
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentDoubleBuffered = True
            ParentFont = False
            TabOrder = 0
            OnClick = createUC7Message
            SoundID = 'BUTTON_CLICK_4'
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tests'
      ImageIndex = 1
      DesignSize = (
        991
        482)
      object mCrankPositionPie: TPie
        Left = 459
        Top = 14
        Width = 152
        Height = 147
        Anchors = [akTop, akRight]
        Angles.StartAngle = 90
        Angles.EndAngle = 180
        Brush.Color = clCream
        ExplicitLeft = 329
      end
      object GroupBox2: TGroupBox
        Left = 14
        Top = 16
        Width = 217
        Height = 257
        Caption = 'Command Creation'
        TabOrder = 0
        object Label1: TLabel
          Left = 170
          Top = 201
          Width = 13
          Height = 13
          Caption = 'ms'
        end
        object mCheckSumEdit: TSTDStringEdit
          Left = 164
          Top = 38
          Width = 29
          Height = 21
          Enabled = False
          TabOrder = 0
          Text = 'CC'
          Value = 'CC'
        end
        object STDStringEdit1: TSTDStringEdit
          Left = 22
          Top = 38
          Width = 22
          Height = 21
          Alignment = taCenter
          Enabled = False
          TabOrder = 1
          Text = '!'
          Value = '!'
        end
        object mRawCMDE: TSTDStringEdit
          Left = 50
          Top = 38
          Width = 108
          Height = 21
          TabOrder = 2
          Text = '81F0F8'
          OnChange = mRawCMDEChange
          OnKeyDown = mRawCMDEKeyDown
          Value = '81F0F8'
        end
        object mRepeatTimeE: mtkIntEdit
          Left = 117
          Top = 197
          Width = 43
          Height = 21
          TabOrder = 4
          Text = '10'
        end
        object mRepeatEveryBtn: TButton
          Left = 22
          Top = 195
          Width = 89
          Height = 25
          Caption = 'Repeat Every'
          Enabled = False
          TabOrder = 5
          OnClick = mRepeatEveryBtnClick
        end
        object mSendBtn1: TArrayBotButton
          Left = 22
          Top = 82
          Width = 171
          Height = 47
          Caption = 'Send'
          Enabled = False
          ParentDoubleBuffered = True
          TabOrder = 3
          OnClick = createUC7Message
          SoundID = 'BUTTON_CLICK_4'
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 3
        Top = 47
        Width = 310
        Height = 273
        Caption = 'Misc parameters'
        TabOrder = 0
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
        object mZeroCutsE: TIntegerLabeledEdit
          Left = 22
          Top = 118
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
          TabOrder = 1
          Text = '0'
        end
      end
      object mTopPanel: TPanel
        Left = 0
        Top = 0
        Width = 991
        Height = 41
        Align = alTop
        TabOrder = 1
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
      end
    end
  end
  object HandwheelGB: TGroupBox
    Left = 0
    Top = 0
    Width = 999
    Height = 65
    Align = alTop
    TabOrder = 3
    object mHWPosShape: TShape
      Left = 19
      Top = 50
      Width = 65
      Height = 8
      Brush.Color = clBlue
      Pen.Style = psClear
    end
    object mRetractLbl: TLabel
      Left = 21
      Top = 20
      Width = 89
      Height = 25
      Caption = 'Retracting'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object mCuttingLbl: TLabel
      Left = 287
      Top = 20
      Width = 64
      Height = 25
      Caption = 'Cutting'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object mAfterCuttingLbl: TLabel
      Left = 391
      Top = 20
      Width = 113
      Height = 25
      Caption = 'After Cutting'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object mBeforeCuttingLbl: TLabel
      Left = 135
      Top = 20
      Width = 125
      Height = 25
      Caption = 'Before Cutting'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Segoe UI Semibold'
      Font.Style = []
      ParentFont = False
    end
    object mRibbonCreatorActiveCB: TPropertyCheckBox
      Left = 536
      Top = 24
      Width = 241
      Height = 17
      Caption = 'Ribbon Creator on/off'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = mRibbonCreatorActiveCBClick
    end
  end
  object mShowBottomPanelBtn: TButton
    Left = 0
    Top = 787
    Width = 999
    Height = 19
    Align = alBottom
    Caption = '^'
    TabOrder = 4
    Visible = False
    OnClick = mShowBottomPanelBtnClick
  end
  object mSynchUIBtn: TArrayBotButton
    Left = 776
    Top = 8
    Width = 85
    Height = 39
    Caption = 'Refresh Status'
    ParentDoubleBuffered = True
    TabOrder = 5
    OnClick = mSynchUIBtnClick
    SoundID = 'BUTTON_CLICK_4'
  end
  object ActionList1: TActionList
    Left = 608
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
    Left = 608
    Top = 240
    object ClearMemoA1: TMenuItem
      Action = ClearMemoA
    end
  end
  object mIniFileC: mtkIniFileC
    IniFileName = 'atUC7.ini'
    RootFolder = '.'
    Left = 546
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 677
    Top = 80
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
    Top = 72
  end
  object mRepeatTimer: TTimer
    Enabled = False
    Interval = 10
    OnTimer = mRepeatTimerTimer
    Left = 24
    Top = 312
  end
  object mStartupTimer: TTimer
    Enabled = False
    Interval = 150
    OnTimer = mStartupTimerTimer
    Left = 128
    Top = 472
  end
end

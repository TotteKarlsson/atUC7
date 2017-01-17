object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'UC7 Controller'
  ClientHeight = 643
  ClientWidth = 983
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
    Top = 431
    Width = 983
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
    Width = 983
    Height = 390
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 304
    ExplicitHeight = 290
    object mMiddleLeftPanel: TPanel
      Left = 1
      Top = 1
      Width = 320
      Height = 388
      Align = alLeft
      TabOrder = 0
      object HandwheelGB: TGroupBox
        Left = 1
        Top = 193
        Width = 318
        Height = 194
        Align = alBottom
        Caption = 'Handwheel Position'
        TabOrder = 0
        ExplicitTop = 195
        ExplicitWidth = 981
        object Pie1: TPie
          Left = 95
          Top = 64
          Width = 90
          Height = 90
          Angles.StartAngle = 90
          Angles.EndAngle = 180
        end
        object Label1: TLabel
          Left = 40
          Top = 64
          Width = 36
          Height = 13
          Caption = 'Retract'
        end
        object Label2: TLabel
          Left = 216
          Top = 64
          Width = 70
          Height = 13
          Caption = 'Before Cutting'
        end
        object Label3: TLabel
          Left = 216
          Top = 144
          Width = 35
          Height = 13
          Caption = 'Cutting'
        end
        object Label4: TLabel
          Left = 40
          Top = 144
          Width = 63
          Height = 13
          Caption = 'After Cutting'
        end
      end
      object GroupBox3: TGroupBox
        Left = 1
        Top = 1
        Width = 392
        Height = 192
        Align = alLeft
        Caption = 'Cutting Motor Controls'
        TabOrder = 1
        ExplicitLeft = -207
        object mStartStopBtn: TButton
          Left = 16
          Top = 24
          Width = 121
          Height = 89
          Caption = 'Start'
          Enabled = False
          TabOrder = 0
          OnClick = mStartStopBtnClick
        end
      end
    end
  end
  object SB: TStatusBar
    Left = 0
    Top = 624
    Width = 983
    Height = 19
    Panels = <>
    ExplicitTop = 163
    ExplicitWidth = 304
  end
  object BottomPanel: TPanel
    Left = 0
    Top = 434
    Width = 983
    Height = 190
    Align = alBottom
    TabOrder = 2
    ExplicitTop = -27
    ExplicitWidth = 304
    object infoMemo: TMemo
      Left = 1
      Top = 49
      Width = 981
      Height = 140
      Align = alClient
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
      ExplicitWidth = 302
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 981
      Height = 48
      Align = alTop
      TabOrder = 1
      ExplicitWidth = 302
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
  end
  object mTopPanel: TPanel
    Left = 0
    Top = 0
    Width = 983
    Height = 41
    Align = alTop
    TabOrder = 3
    ExplicitWidth = 304
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
      Left = 396
      Top = 10
      Width = 50
      Height = 25
      Caption = '->'
      Enabled = False
      TabOrder = 2
      OnClick = mSendBtn1Click
    end
    object mSendRAW1: TSTDStringLabeledEdit
      Left = 245
      Top = 12
      Width = 145
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = 'mSendRAW1'
      Enabled = False
      TabOrder = 3
      Text = 's10'
      Value = 's10'
    end
    object mResetBtn: TButton
      Left = 897
      Top = 1
      Width = 85
      Height = 39
      Align = alRight
      Caption = 'Reset UC7'
      Enabled = False
      TabOrder = 4
      ExplicitLeft = 788
      ExplicitTop = 5
      ExplicitHeight = 30
    end
  end
  object ActionList1: TActionList
    Left = 584
    Top = 192
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
    Left = 512
    Top = 232
    object ClearMemoA1: TMenuItem
      Action = ClearMemoA
    end
  end
  object mIniFileC: mtkIniFileC
    IniFileName = 'atUC7.ini'
    RootFolder = '.'
    Left = 482
    Top = 88
  end
  object MainMenu1: TMainMenu
    Left = 533
    Top = 136
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
    Left = 578
    Top = 72
  end
end

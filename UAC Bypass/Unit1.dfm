object Form1: TForm1
  Left = 1916
  Top = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 521
  ClientWidth = 664
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 460
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 22
    Top = 479
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 502
    Width = 664
    Height = 19
    Panels = <
      item
        Width = 120
      end
      item
        Text = 'Priviliegs:'
        Width = 65
      end
      item
        Width = 200
      end
      item
        Text = 'Status :'
        Width = 50
      end
      item
        Text = 'ready.'
        Width = 50
      end>
    ExplicitTop = 501
    ExplicitWidth = 661
  end
  object CheckBox1: TCheckBox
    Left = 533
    Top = 424
    Width = 97
    Height = 17
    TabStop = False
    Caption = 'Admin Privilegs'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Left = 533
    Top = 401
    Width = 65
    Height = 17
    TabStop = False
    Caption = 'Stay Top'
    Checked = True
    State = cbChecked
    TabOrder = 2
    OnClick = CheckBox2Click
  end
  object Button1: TButton
    Left = 501
    Top = 461
    Width = 75
    Height = 25
    Caption = 'Reboot'
    TabOrder = 3
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 420
    Top = 461
    Width = 75
    Height = 25
    Hint = 'Jump to Registry Key "EnableLUA"'
    Caption = 'Jump Reg'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    TabStop = False
    OnClick = Button2Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 664
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    Caption = 'UAC Bypass'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Impact'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    ExplicitWidth = 661
    object Bevel1: TBevel
      Left = 604
      Top = 16
      Width = 56
      Height = 56
      Shape = bsFrame
    end
    object Image1: TImage
      Left = 605
      Top = 20
      Width = 52
      Height = 52
      Stretch = True
    end
    object Label3: TLabel
      Left = 153
      Top = 76
      Width = 32
      Height = 13
      Caption = 'Label3'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Shape11: TShape
      Left = 22
      Top = 16
      Width = 10
      Height = 10
      Brush.Color = clLime
    end
    object Shape12: TShape
      Left = 22
      Top = 32
      Width = 10
      Height = 10
      Brush.Color = clRed
    end
    object Shape13: TShape
      Left = 22
      Top = 48
      Width = 10
      Height = 10
      Brush.Color = clGray
    end
    object Shape14: TShape
      Left = 22
      Top = 64
      Width = 10
      Height = 10
    end
    object Label4: TLabel
      Left = 38
      Top = 16
      Width = 28
      Height = 11
      Caption = 'Enable'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 38
      Top = 31
      Width = 31
      Height = 11
      Caption = 'Disable'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 38
      Top = 47
      Width = 37
      Height = 11
      Caption = 'Standard'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
    object Label7: TLabel
      Left = 38
      Top = 64
      Width = 42
      Height = 11
      Caption = 'Not found'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -9
      Font.Name = 'Small Fonts'
      Font.Style = []
      ParentFont = False
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 104
    Width = 177
    Height = 177
    Caption = ' User Account Control (UAC) '
    TabOrder = 6
    object Shape3: TShape
      Left = 157
      Top = 24
      Width = 10
      Height = 10
    end
    object RadioButton1: TRadioButton
      Left = 14
      Top = 40
      Width = 135
      Height = 17
      Caption = 'Turn UAC Complete off'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 14
      Top = 87
      Width = 145
      Height = 17
      Caption = 'Turn UAC Quiet Mode on'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton2Click
    end
    object RadioButton3: TRadioButton
      Left = 14
      Top = 136
      Width = 133
      Height = 17
      Caption = 'Turn UAC Complete on'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = RadioButton3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 191
    Top = 104
    Width = 322
    Height = 177
    Caption = ' Admninistrators (Behavior) '
    TabOrder = 7
    object Shape5: TShape
      Left = 293
      Top = 24
      Width = 10
      Height = 10
    end
    object RadioButton4: TRadioButton
      Left = 16
      Top = 32
      Width = 245
      Height = 17
      Caption = 'No Prompt (Quiet Mode -Elevate Automatically)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton4Click
    end
    object RadioButton5: TRadioButton
      Left = 16
      Top = 55
      Width = 129
      Height = 17
      Caption = 'Prompt for Credentials'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton5Click
    end
    object RadioButton6: TRadioButton
      Left = 16
      Top = 78
      Width = 113
      Height = 17
      Caption = 'Prompt for Consent'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = RadioButton6Click
    end
    object RadioButton7: TRadioButton
      Left = 16
      Top = 101
      Width = 212
      Height = 17
      Caption = 'Prompt for Credentials (Secure Desktop)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = RadioButton7Click
    end
    object RadioButton8: TRadioButton
      Left = 16
      Top = 124
      Width = 201
      Height = 17
      Caption = 'Prompt for Consent (Secure Desktop)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = RadioButton8Click
    end
    object RadioButton9: TRadioButton
      Left = 16
      Top = 147
      Width = 285
      Height = 17
      Caption = 'Prompt for Consent (Secure Desktop, Standard Default)'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = RadioButton9Click
    end
  end
  object Button3: TButton
    Left = 582
    Top = 461
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 8
    TabStop = False
    OnClick = Button3Click
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 287
    Width = 177
    Height = 74
    Caption = ' Filter Administrator Token '
    TabOrder = 9
    object Shape1: TShape
      Left = 157
      Top = 16
      Width = 10
      Height = 10
    end
    object RadioButton10: TRadioButton
      Left = 14
      Top = 24
      Width = 58
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton10Click
    end
    object RadioButton11: TRadioButton
      Left = 14
      Top = 47
      Width = 57
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton11Click
    end
  end
  object GroupBox4: TGroupBox
    Left = 519
    Top = 104
    Width = 138
    Height = 177
    Caption = ' User (Behavior)  '
    TabOrder = 10
    object Shape4: TShape
      Left = 112
      Top = 24
      Width = 10
      Height = 10
    end
    object RadioButton12: TRadioButton
      Left = 14
      Top = 40
      Width = 113
      Height = 17
      Caption = 'Elevated privileges'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton12Click
    end
    object RadioButton13: TRadioButton
      Left = 14
      Top = 87
      Width = 113
      Height = 17
      Caption = 'Standard privileges'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton13Click
    end
    object RadioButton26: TRadioButton
      Left = 14
      Top = 136
      Width = 105
      Height = 17
      Caption = 'Disable privileges'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = RadioButton26Click
    end
  end
  object GroupBox5: TGroupBox
    Left = 191
    Top = 287
    Width = 159
    Height = 74
    Caption = ' Installer Detection '
    TabOrder = 11
    object Shape2: TShape
      Left = 132
      Top = 16
      Width = 10
      Height = 10
    end
    object RadioButton14: TRadioButton
      Left = 14
      Top = 24
      Width = 61
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton14Click
    end
    object RadioButton15: TRadioButton
      Left = 14
      Top = 47
      Width = 56
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton15Click
    end
  end
  object GroupBox6: TGroupBox
    Left = 356
    Top = 287
    Width = 157
    Height = 74
    Caption = ' User Execution Block '
    TabOrder = 12
    object Shape6: TShape
      Left = 128
      Top = 16
      Width = 10
      Height = 10
    end
    object RadioButton16: TRadioButton
      Left = 14
      Top = 24
      Width = 59
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton16Click
    end
    object RadioButton17: TRadioButton
      Left = 14
      Top = 47
      Width = 55
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton17Click
    end
  end
  object GroupBox7: TGroupBox
    Left = 8
    Top = 367
    Width = 177
    Height = 74
    Caption = ' User UIAccess '
    TabOrder = 13
    object Shape8: TShape
      Left = 157
      Top = 24
      Width = 10
      Height = 10
    end
    object RadioButton18: TRadioButton
      Left = 14
      Top = 24
      Width = 58
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton18Click
    end
    object RadioButton19: TRadioButton
      Left = 14
      Top = 47
      Width = 55
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton19Click
    end
  end
  object GroupBox8: TGroupBox
    Left = 191
    Top = 367
    Width = 159
    Height = 74
    Caption = ' UIA Desktop Toggle '
    TabOrder = 14
    object Shape9: TShape
      Left = 132
      Top = 24
      Width = 10
      Height = 10
    end
    object RadioButton20: TRadioButton
      Left = 14
      Top = 24
      Width = 57
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton20Click
    end
    object RadioButton21: TRadioButton
      Left = 14
      Top = 47
      Width = 56
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton21Click
    end
  end
  object GroupBox9: TGroupBox
    Left = 356
    Top = 367
    Width = 157
    Height = 74
    Caption = ' User Secure Desktop '
    TabOrder = 15
    object Shape10: TShape
      Left = 128
      Top = 24
      Width = 10
      Height = 10
    end
    object RadioButton22: TRadioButton
      Left = 14
      Top = 24
      Width = 59
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton22Click
    end
    object RadioButton23: TRadioButton
      Left = 14
      Top = 47
      Width = 56
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton23Click
    end
  end
  object GroupBox10: TGroupBox
    Left = 519
    Top = 287
    Width = 138
    Height = 74
    Caption = ' User Virtualization '
    TabOrder = 16
    object Shape7: TShape
      Left = 112
      Top = 16
      Width = 10
      Height = 10
    end
    object RadioButton24: TRadioButton
      Left = 14
      Top = 24
      Width = 58
      Height = 17
      Caption = 'Disable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = RadioButton24Click
    end
    object RadioButton25: TRadioButton
      Left = 14
      Top = 47
      Width = 55
      Height = 17
      Caption = 'Enable'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = RadioButton25Click
    end
  end
  object CheckBox3: TCheckBox
    Left = 533
    Top = 378
    Width = 47
    Height = 17
    TabStop = False
    Caption = 'Hints'
    Checked = True
    State = cbChecked
    TabOrder = 17
    OnClick = CheckBox3Click
  end
  object Button4: TButton
    Left = 339
    Top = 461
    Width = 75
    Height = 25
    Caption = 'Default'
    TabOrder = 18
    OnClick = Button4Click
  end
end

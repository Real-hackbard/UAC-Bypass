object Form1: TForm1
  Left = 1916
  Top = 227
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  ClientHeight = 429
  ClientWidth = 524
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 22
    Top = 355
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 22
    Top = 374
    Width = 32
    Height = 13
    Caption = 'Label2'
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 410
    Width = 524
    Height = 19
    Panels = <
      item
        Width = 120
      end
      item
        Text = 'Priviliegs:'
        Width = 70
      end
      item
        Width = 50
      end>
    ExplicitTop = 409
    ExplicitWidth = 520
  end
  object CheckBox1: TCheckBox
    Left = 22
    Top = 322
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
    Left = 22
    Top = 299
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
    Left = 413
    Top = 345
    Width = 97
    Height = 25
    Caption = 'Reboot'
    TabOrder = 3
    TabStop = False
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 413
    Top = 314
    Width = 97
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
    Width = 524
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
    ExplicitWidth = 520
    object Bevel1: TBevel
      Left = 457
      Top = 8
      Width = 56
      Height = 56
      Shape = bsFrame
    end
    object Image1: TImage
      Left = 458
      Top = 12
      Width = 52
      Height = 52
      Stretch = True
    end
    object Label3: TLabel
      Left = 81
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
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 104
    Width = 177
    Height = 177
    Caption = ' User Account Control (UAC) '
    TabOrder = 6
    object RadioButton1: TRadioButton
      Left = 14
      Top = 40
      Width = 135
      Height = 17
      Caption = 'Turn UAC Complete off'
      TabOrder = 0
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 14
      Top = 87
      Width = 145
      Height = 17
      Caption = 'Turn UAC Quiet Mode on'
      TabOrder = 1
      OnClick = RadioButton2Click
    end
    object RadioButton3: TRadioButton
      Left = 14
      Top = 136
      Width = 133
      Height = 17
      Caption = 'Turn UAC Complete on'
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
    object RadioButton4: TRadioButton
      Left = 16
      Top = 32
      Width = 187
      Height = 17
      Caption = 'No Prompt (Elevate Automatically)'
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
    end
  end
  object Button3: TButton
    Left = 413
    Top = 376
    Width = 97
    Height = 25
    Caption = 'Close'
    TabOrder = 8
    TabStop = False
    OnClick = Button3Click
  end
end

object frmMain: TfrmMain
  Left = 445
  Top = 279
  Width = 515
  Height = 258
  Caption = 'Main'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl2: TLabel
    Left = 32
    Top = 88
    Width = 325
    Height = 13
    Caption = 
      'The thread will then pass this integer value to a container of l' +
      'isteners.'
  end
  object lbl3: TLabel
    Left = 32
    Top = 24
    Width = 430
    Height = 13
    Caption = 
      'There is a thread working in the background. It will increase an' +
      ' integer value every second.'
  end
  object lbl1: TLabel
    Left = 32
    Top = 120
    Width = 145
    Height = 13
    Caption = 'You can register listeners here.'
  end
  object btnStart: TButton
    Left = 144
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 0
    OnClick = btnStartClick
  end
  object btnStop: TButton
    Left = 272
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Stop'
    TabOrder = 1
    OnClick = btnStopClick
  end
  object cbListener1: TCheckBox
    Left = 56
    Top = 144
    Width = 143
    Height = 17
    Caption = 'cbListener1 - unregistered'
    TabOrder = 2
    OnClick = cbListenerClick
  end
  object cbListener2: TCheckBox
    Left = 56
    Top = 160
    Width = 143
    Height = 17
    Caption = 'cbListener2 - unregistered'
    TabOrder = 3
    OnClick = cbListenerClick
  end
  object cbListener3: TCheckBox
    Left = 56
    Top = 176
    Width = 143
    Height = 17
    Caption = 'cbListener3 - unregistered'
    Checked = True
    State = cbChecked
    TabOrder = 4
    OnClick = cbListenerClick
  end
end

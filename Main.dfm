object MainForm: TMainForm
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'RSA E\D'
  ClientHeight = 378
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 5
  Padding.Top = 5
  Padding.Right = 5
  Padding.Bottom = 5
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object EditP: TEdit
    Left = 5
    Top = 5
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 0
    TextHint = 'Input P'
    OnChange = EditPChange
  end
  object EditQ: TEdit
    Left = 5
    Top = 32
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 1
    TextHint = 'Input Q'
    OnChange = EditQChange
  end
  object EncButton: TButton
    Left = 141
    Top = 5
    Width = 75
    Height = 25
    Caption = 'Encrypt'
    Enabled = False
    TabOrder = 2
    OnClick = EncButtonClick
  end
  object DecButton: TButton
    Left = 141
    Top = 115
    Width = 75
    Height = 25
    Caption = 'Decrypt'
    Enabled = False
    TabOrder = 3
    OnClick = DecButtonClick
  end
  object InfoMemo: TMemo
    Left = 237
    Top = 7
    Width = 249
    Height = 158
    Lines.Strings = (
      'InfoMemo')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
  end
  object EditD: TEdit
    Left = 5
    Top = 117
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 5
    TextHint = 'Input D'
    OnChange = EditDChange
  end
  object EditR: TEdit
    Left = 5
    Top = 144
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 6
    TextHint = 'Input R'
    OnChange = EditRChange
  end
  object ResultMemo: TMemo
    Left = 5
    Top = 182
    Width = 481
    Height = 191
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Consolas'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 7
  end
end

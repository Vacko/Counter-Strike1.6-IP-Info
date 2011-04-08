object AddServer: TAddServer
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'AddServer'
  ClientHeight = 163
  ClientWidth = 284
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object LB_Name: TLabel
    Left = 16
    Top = 24
    Width = 69
    Height = 13
    Caption = 'Server Name :'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Lb_IP: TLabel
    Left = 16
    Top = 51
    Width = 52
    Height = 13
    Caption = 'Server IP :'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object LB_Port: TLabel
    Left = 16
    Top = 78
    Width = 62
    Height = 13
    Caption = 'Server Port :'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object ED_Name: TEdit
    Left = 105
    Top = 21
    Width = 160
    Height = 21
    TabOrder = 0
  end
  object Ed_IP: TEdit
    Left = 105
    Top = 48
    Width = 160
    Height = 21
    TabOrder = 1
  end
  object Ed_Port: TEdit
    Left = 105
    Top = 75
    Width = 75
    Height = 21
    TabOrder = 2
  end
  object OkBT: TButton
    Left = 73
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 3
    OnClick = OkBTClick
  end
  object CancelBT: TButton
    Left = 154
    Top = 117
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = CancelBTClick
  end
end

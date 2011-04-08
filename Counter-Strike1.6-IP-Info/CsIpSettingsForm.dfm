object SettingsForm: TSettingsForm
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 't'
  ClientHeight = 214
  ClientWidth = 517
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
  object LB_HlExe: TLabel
    Left = 32
    Top = 27
    Width = 100
    Height = 13
    Caption = 'Hl.exe File Location :'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object LB_HLTVExe: TLabel
    Left = 32
    Top = 83
    Width = 110
    Height = 13
    Caption = 'Hltv.exe File Location :'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object BT_Cancel: TButton
    Left = 265
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 0
    OnClick = BT_CancelClick
  end
  object BT_OK: TButton
    Left = 176
    Top = 160
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = BT_OKClick
  end
  object ED_HLExe: TEdit
    Left = 32
    Top = 46
    Width = 377
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object ED_HltvExe: TEdit
    Left = 32
    Top = 102
    Width = 377
    Height = 21
    ReadOnly = True
    TabOrder = 3
  end
  object Bt_SetHlExe: TButton
    Left = 415
    Top = 44
    Width = 75
    Height = 25
    Caption = 'Locate'
    TabOrder = 4
    OnClick = Bt_SetHlExeClick
  end
  object BtSetHltvExe: TButton
    Left = 415
    Top = 102
    Width = 75
    Height = 23
    Caption = 'Locate'
    TabOrder = 5
    OnClick = BtSetHltvExeClick
  end
  object OpenDialog: TOpenDialog
    Filter = 'Exe File|Hl.exe'
    Left = 424
    Top = 168
  end
end

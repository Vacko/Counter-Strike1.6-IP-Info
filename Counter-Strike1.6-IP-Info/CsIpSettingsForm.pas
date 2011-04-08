unit CsIpSettingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TSettingsForm = class(TForm)
    BT_Cancel: TButton;
    BT_OK: TButton;
    ED_HLExe: TEdit;
    ED_HltvExe: TEdit;
    LB_HlExe: TLabel;
    LB_HLTVExe: TLabel;
    Bt_SetHlExe: TButton;
    BtSetHltvExe: TButton;
    OpenDialog: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure BT_OKClick(Sender: TObject);
    procedure BT_CancelClick(Sender: TObject);
    procedure Bt_SetHlExeClick(Sender: TObject);
    procedure BtSetHltvExeClick(Sender: TObject);
  private
    procedure FormMove(var M: TWMNChitTest); message WM_NCHitTest;
    { Private declarations }
  public
    { Public declarations }
    procedure LoadForm(FileName:String);
    procedure SaveForm(FileName:String);
  end;

var
  SettingsForm: TSettingsForm;

implementation

{$R *.dfm}


procedure TSettingsForm.LoadForm(FileName:String);
var
 ini:TInifile;
begin
   Ini:=TIniFile.Create(FileName);
    ED_HlExe.Text:=Ini.ReadString('Data','Hl','');
    ED_HltvExe.Text:=Ini.ReadString('Data','Hltv','');
   Ini.free;
end;

procedure TSettingsForm.SaveForm(FileName:String);
var
 ini:TInifile;
begin
   Ini:=TIniFile.Create(FileName);
    Ini.WriteString('Data','Hl',ED_HlExe.Text);
    Ini.WriteString('Data','Hltv',ED_HltvExe.Text);
  Ini.free;
end;

procedure TSettingsForm.FormMove(var M: TWMNChitTest);
begin
    Inherited;
    if M.Result = htClient then M.Result := htCaption;
end;

procedure TSettingsForm.BtSetHltvExeClick(Sender: TObject);
begin
 OpenDialog.Filter:='Hltv.exe File|Hltv.exe';
 if OpenDialog.Execute then
  begin
     ED_HLTvExe.Text:=OpenDialog.FileName;
  end;
end;

procedure TSettingsForm.BT_CancelClick(Sender: TObject);
begin
ModalResult:=MrCancel;
end;

procedure TSettingsForm.BT_OKClick(Sender: TObject);
begin
ModalResult:=MrOK;
end;

procedure TSettingsForm.Bt_SetHlExeClick(Sender: TObject);
begin
 OpenDialog.Filter:='Hl.exe File|Hl.exe';
 if OpenDialog.Execute then
  begin
     ED_HLExe.Text:=OpenDialog.FileName;
  end;
end;

procedure TSettingsForm.FormCreate(Sender: TObject);
var Window: HRGN;
begin
  //Window Shape
  Window := CreateRoundRectRgn(0,0,ClientWidth,ClientHeight,20,20);
  SetWindowRgn(Handle, Window, True);
end;

procedure TSettingsForm.FormPaint(Sender: TObject);
begin
  //draw main windows white border
  Canvas.Pen.Color :=ClWhite;
  Canvas.RoundRect(1,1,ClientWidth-2,ClientHeight-2,20,20);;
end;

end.

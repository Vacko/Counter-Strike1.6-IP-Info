unit CsIpAddServerForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CsIpServerListTypes;

type
  TAddServer = class(TForm)
    ED_Name: TEdit;
    Ed_IP: TEdit;
    Ed_Port: TEdit;
    OkBT: TButton;
    CancelBT: TButton;
    LB_Name: TLabel;
    Lb_IP: TLabel;
    LB_Port: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure OkBTClick(Sender: TObject);
    procedure CancelBTClick(Sender: TObject);
  private
      procedure FormMove(var M: TWMNChitTest); message WM_NCHitTest;
      procedure Clear;
    { Private declarations }
  public
      function GetServer:TServerInfo;
      procedure SetServer(Server:TServerInfo);
    { Public declarations }
  end;

var
  AddServer: TAddServer;
  NewServer:TServerInfo;

implementation

{$R *.dfm}

procedure TAddServer.Clear;
begin
   ED_Name.Clear;
   ED_IP.Clear;
   Ed_Port.Clear;
end;

function TAddServer.GetServer;
begin
  Result:=NewServer;
end;

procedure TAddServer.SetServer(Server: TServerInfo);
begin
   ED_Name.Text := Server.Name;
   ED_IP.Text   := Server.ServerIP;
   Ed_Port.Text := IntToStr(Server.Port);
end;

procedure TAddServer.CancelBTClick(Sender: TObject);
begin
Clear;
Modalresult:=mrCancel;
end;

procedure TAddServer.FormCreate(Sender: TObject);
var Window: HRGN;
begin
  //Window Shape
  Window := CreateRoundRectRgn(0,0,ClientWidth,ClientHeight,20,20);
  SetWindowRgn(Handle, Window, True);
end;

procedure TAddServer.FormMove(var M: TWMNChitTest);
begin
    Inherited;
    if M.Result = htClient then M.Result := htCaption;
end;

procedure TAddServer.FormPaint(Sender: TObject);
begin
  //draw main windows white border
  Canvas.Pen.Color :=ClWhite;
  Canvas.RoundRect(1,1,ClientWidth-2,ClientHeight-2,20,20);;
end;

procedure TAddServer.OkBTClick(Sender: TObject);
var
 error:boolean;
begin
 error:=False;
 try
  NewServer.Name     := ED_Name.Text;
  NewServer.ServerIP := ED_IP.Text;
  NewServer.Port     := StrToInt(Ed_Port.Text);
 except
   on exception do Error:=True;
 end;

 Clear;

 if Error then ModalResult:=MrCancel
          else Modalresult:=mrOK;
end;

end.

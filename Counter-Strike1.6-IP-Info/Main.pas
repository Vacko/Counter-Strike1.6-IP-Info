unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Functions, CsIpServerList, CsIpServerListTypes,CsIpThread, CsIpThreadTypes,
  ExtCtrls, jpeg, Buttons, XPMan, ImgList, Menus,Inifiles;

type
  TMainForm = class(TForm)
    LB_Servers: TListBox;
    BT_Add: TButton;
    Bt_Delete: TButton;
    M_ServerInfo: TMemo;
    TrayIcon1: TTrayIcon;
    I_CsLogo: TImage;
    TrayPopup: TPopupMenu;
    Close1: TMenuItem;
    Hide1: TMenuItem;
    N1: TMenuItem;
    SystemPanel: TPanel;
    Im_Close: TImage;
    Im_Tray: TImage;
    ConnectBT: TButton;
    Image1: TImage;
    Bt_Edit: TButton;
    XPManifest1: TXPManifest;
    BT_Settings: TButton;
    procedure BT_AddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Bt_DeleteClick(Sender: TObject);
    procedure LB_ServersClick(Sender: TObject);
    procedure LB_ServersKeyPress(Sender: TObject; var Key: Char);
    procedure Close1Click(Sender: TObject);
    procedure Hide1Click(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure Im_CloseClick(Sender: TObject);
    procedure Im_TrayClick(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure Bt_EditClick(Sender: TObject);
    procedure BT_SettingsClick(Sender: TObject);
    procedure ConnectBTClick(Sender: TObject);
  private
    procedure RefreshList;
    procedure GetThreadInfo;
    procedure OnServerInfo(var M:TMessage); message ServerMsg;
    procedure FormMove(var M: TWMNChitTest); message WM_NCHitTest;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;
  ServerList:TCsListClass;
  //for decide game type  - connect disabled - ask server for info - recive adn server
  //selected - amalyze - enable conect - and use data form last serverinfo ...
  LastServerInfo:TServerThInfo;

implementation

uses CsIpAddServerForm, CsIpSettingsForm;

{$R *.dfm}

//****************************Message*******************************************

procedure TMainForm.OnServerInfo(var M:TMessage);    //cancel;
var
  MsgServer  : PServerThInfo;
  ServerInfo : TServerThInfo;
begin
  MsgServer  := ptr(M.wparam);
  ServerInfo := MsgServer^;
  Dispose(MsgServer);

  if LB_Servers.ItemIndex>-1 then
  begin

    if (ServerList.GetServer(LB_Servers.ItemIndex).ServerIP=ServerInfo.IP) and
       (ServerList.GetServer(LB_Servers.ItemIndex).Port=ServerInfo.Port)
       then
       begin

        M_ServerInfo.Clear;
        //Show Info
        if  ServerInfo.Error=False then
          begin
          M_ServerInfo.Lines.add(ServerInfo.Description);
          M_ServerInfo.Lines.add(ServerInfo.HostName);
          M_ServerInfo.Lines.add(ServerInfo.IP+':'+IntToStr(Serverinfo.Port));
          M_ServerInfo.Lines.add(' ');
          M_ServerInfo.Lines.add('Map : '+ServerInfo.Map);
          M_ServerInfo.Lines.add('Players : '+IntToStr(ServerInfo.Players)+'/'+IntToStr(ServerInfo.Maxplayers));
          M_ServerInfo.Lines.add('Bots : '+IntToStr(ServerInfo.Bots));
          M_ServerInfo.Lines.add(' ');
          M_ServerInfo.Lines.add('Server Type : '+ServerInfo.ServerType+' - '+ServerInfo.Os);
          if ServerInfo.Password then M_ServerInfo.Lines.add('Password : True')
                                 else M_ServerInfo.lines.add('Password : False');
          if ServerInfo.Secure   then M_ServerInfo.lines.add('Secure : True')
                                 else M_ServerInfo.lines.add('Secure : False');
          {
          M_ServerInfo.Lines.add('Packet Version : '+IntToStr(ServerInfo.PacketVersion));
          M_ServerInfo.Lines.add('Host Name : '+ServerInfo.HostName);

          M_ServerInfo.Lines.add('Game : '+ServerInfo.Game);
          M_ServerInfo.Lines.add('Players : '+IntToStr(ServerInfo.Players));
          M_ServerInfo.Lines.add('Max Players : '+IntToStr(ServerInfo.Maxplayers));
          M_ServerInfo.Lines.add('Net Version : '+IntToStr(ServerInfo.NetVersion));

         if ServerInfo.IsMod    then M_ServerInfo.lines.add('Mod : True')
                                 else M_ServerInfo.lines.add('Mod : False');
          }

          //connection decision
          LastServerInfo:=ServerInfo;
          ConnectBT.Enabled:=True;

        end
        else begin
               ConnectBT.Enabled:=False;
               M_ServerInfo.Lines.add(ServerInfo.IP+':'+IntToStr(Serverinfo.Port));
               M_ServerInfo.Lines.Add('Connection Error...')
             end;
       end
  end;
end;

procedure TMainForm.Panel1Click(Sender: TObject);
begin
close
end;

//********************Form move*************************************************

procedure TMainForm.FormMove(var M: TWMNChitTest);
begin
    Inherited;
    if M.Result = htClient then M.Result := htCaption;
end;



procedure TMainForm.FormPaint(Sender: TObject);
begin
  //draw main windows white border
  Canvas.Pen.Color :=ClSilver;
  Canvas.RoundRect(1,1,ClientWidth-2,ClientHeight-2,20,20);;
end;

//****************************SERVER LIST***************************************

procedure TMainForm.RefreshList;
var
 i:integer;
begin
 //until focus return do LB_SERVERS done
 ConnectBT.Enabled:=False;

 LB_Servers.Clear;
 for i := 0 to ServerList.ItemsCount - 1 do LB_Servers.Items.Add(ServerList.GetServer(i).Name);

end;

procedure TMainForm.GetThreadInfo;
var
 Thread:TCsIpThread;
begin

  ConnectBT.Enabled:=False;

  if LB_Servers.ItemIndex>-1 then
  begin
    M_ServerInfo.Clear;
    M_ServerInfo.Lines.Add('Connecting...');

    Thread:=TCsIpThread.Create(MainForm.Handle,ServerList.GetServer(LB_Servers.Itemindex).ServerIP,ServerList.GetServer(LB_Servers.Itemindex).Port);
  end;
end;

//*************************Create/Destroy***************************************

procedure TMainForm.FormCreate(Sender: TObject);
var Window: HRGN;
begin
  //Window Shape
  Window := CreateRoundRectRgn(0,0,ClientWidth,ClientHeight,20,20);
  SetWindowRgn(Handle, Window, True);

  //List and Server Init
  ServerList := TCsListCLass.Create(GetExeDir+ServerFile);
  RefreshList;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ServerList.Free;
end;

//******************************************************************************

procedure TMainForm.Hide1Click(Sender: TObject);
begin
 if Visible then Hide
            else Show;
end;

procedure TMainForm.Image1Click(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.Im_CloseClick(Sender: TObject);
begin
 Close;
end;

procedure TMainForm.Im_TrayClick(Sender: TObject);
begin
 Hide;
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
begin
 if Visible then Hide
            else Show;
end;

procedure TMainForm.LB_ServersClick(Sender: TObject);
begin
 GetThreadInfo;
end;

procedure TMainForm.LB_ServersKeyPress(Sender: TObject; var Key: Char);
begin
 GetThreadInfo;
end;

procedure TMainForm.Bt_DeleteClick(Sender: TObject);
begin
 if LB_Servers.ItemIndex>-1 then ServerList.DeleteServer(LB_Servers.ItemIndex);
 RefreshList;
end;


procedure TMainForm.Bt_EditClick(Sender: TObject);
begin
 if LB_Servers.ItemIndex>-1 then
 begin
    AddServer.SetServer(ServerList.GetServer(Lb_Servers.ItemIndex));
    AddServer.ShowModal;

    if AddServer.ModalResult=MrOK then
    begin
      ServerList.DeleteServer(Lb_Servers.ItemIndex);
      ServerList.AddServer(AddServer.GetServer);
    end;
 end;
 RefreshList;
end;

procedure TMainForm.BT_SettingsClick(Sender: TObject);
begin
  SettingsForm.LoadForm(GetExeDir+ServerFile);
  SettingsForm.showmodal;

  if SettingsForm.ModalResult=MrOk
     then SettingsForm.SaveForm(GetExeDir+ServerFile);

end;

procedure TMainForm.Close1Click(Sender: TObject);
begin
Close;
end;


procedure TMainForm.ConnectBTClick(Sender: TObject);
var
 Connecthl,ConnectHlTv:String;
 ini:TInifIle;
begin

 if LB_Servers.ItemIndex>-1 then
 begin
   ini:=TiniFile.Create(GetExeDir+ServerFile);
     ConnectHl   := Ini.ReadString('Data','Hl','');
     ConnectHltv := Ini.ReadString('Data','Hltv','');
   ini.Free;

   ConnectHl   := ConnectHl+' -game '+LastServerInfo.Game+' -console +connect '+ServerList.GetServer(LB_Servers.itemindex).ServerIP;
   ConnectHltv := ConnectHltv+' +connect '+ServerList.GetServer(LB_Servers.itemindex).ServerIP+#13+'+name '+'ENTER NAME'+#13+'+record '+'ENTER REC NAME';
   ShowMessage(ConnectHl);
   ShowMessage(ConnectHltv);

//    WinExec(PChar(hl_exe.Text+' -game cstrike -console +connect '+IPADD.Items[IPADD.itemindex]),SW_SHOW);
//    if  Cb_hltv.checked then
//        WinExec(PChar(hltv_exe.Text+' +connect '+IPADD.Items[IPADD.itemindex]+#13+'+name '+HLTV_name.Text+#13+'+record '+Record_name.Text),SW_SHOW);
    //  Hide;     //schova okno

 end;
end;

procedure TMainForm.BT_AddClick(Sender: TObject);
begin
   AddServer.ShowModal;
   if AddServer.ModalResult=MrOk then Serverlist.AddServer(AddServer.GetServer);
   RefreshList;
end;


end.

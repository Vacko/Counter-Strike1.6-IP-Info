unit CsIpThread;

interface

uses
  Classes,CsIpThreadTypes,Windows,SysUtils,IdUDPClient;

type
  TCsIpThread = class(TThread)
  private
    { Private declarations }
    Ip:String;
    Port:Integer;
    MFHandle:HWND;
    procedure PostMainMessage(Msg:TServerThInfo);
  protected
    procedure Execute; override;
  public
    constructor Create(Handle:HWND;Cs_Ip:String;Cs_Port:Integer);
  end;

implementation

constructor TCsIpThread.Create(Handle:HWND;Cs_Ip:String;Cs_Port:Integer);
begin
  Ip       := Cs_ip;
  Port     := Cs_Port;
  MFHandle := Handle;

  FreeOnTerminate:=True;

  inherited Create(False);
end;

procedure TCsIpThread.PostMainMessage(Msg:TServerThInfo);
var
   MsgInfo:PServerThInfo;
begin
   New(MsgInfo);
   MsgInfo^:=msg;
   Postmessage(MFHandle,ServerMsg,integer(MsgInfo),0);  //pointer to MsgInfo
end;


procedure TCsIpThread.Execute;
var
 IdUDP: TIdUDPClient;
 Recive : String;
 SInfo:TServerThInfo;
 Error:Boolean;
begin

 Error:=False;
//**********************************UDP CLIENT**********************************
 try
  // Create instance of Id UDP
  IdUdp:=TIdUDPClient.Create(nil);

  // Set Port and Host 
  IdUdp.Host:=Ip;
  IdUDP.Port:=Port;

  // Recive Delay - How long client waits
  IdUdp.ReceiveTimeout:=3000;

  // Send Quaey to server .
  IdUDP.Send(A2S_INFO);

  //Recive Query
  Recive:=IdUDP.ReceiveString();

  // Free instance of Id UDP client
  IdUDP.Free;

 except
  //on TimeOut do Error:=True;
  on Exception do begin
                    Error:=True;
                  end;
 end;

//****************************Parse Segver Info*********************************

if not(Error) and (Length(Recive)>0) then
 begin
 try
  //Delete header
  Delete(Recive,1,4);
  //Packet version
  Sinfo.PacketVersion:=ord(Recive[1]);
  Delete(Recive,1,1);
  //IP
  SInfo.ServerIP:=Copy(Recive,1,Pos(Chr(0),Recive)-1);
  Delete(Recive,1,Pos(Chr(0),Recive));
  //HostName
  SInfo.HostName:=Copy(Recive,1,Pos(Chr(0),Recive)-1);
  Delete(Recive,1,Pos(Chr(0),Recive));
  //Map
  SInfo.Map:=Copy(Recive,1,Pos(Chr(0),Recive)-1);
  Delete(Recive,1,Pos(Chr(0),Recive));
  //Game
  SInfo.Game:=Copy(Recive,1,Pos(Chr(0),Recive)-1);
  Delete(Recive,1,Pos(Chr(0),Recive));
  //Game Info
  SInfo.Description:=Copy(Recive,1,Pos(Chr(0),Recive)-1);
  Delete(Recive,1,Pos(Chr(0),Recive));
  //Players
  Sinfo.Players:=ord(Recive[1]);
  Delete(Recive,1,1);
  //Players Max
  Sinfo.MaxPlayers:=ord(Recive[1]);
  Delete(Recive,1,1);
  //Net Version
  Sinfo.NetVersion:=ord(Recive[1]);
  Delete(Recive,1,1);
  //Dedicated
    case Recive[1] of
      'l' : Sinfo.ServerType:='Listen';
      'd' : Sinfo.ServerType:='Dedicated';
      'p' : Sinfo.ServerType:='HLTV';
    end;
  Delete(Recive,1,1);
  //OS
      case Recive[1] of
      'w' : Sinfo.Os:='Windows';
      'l' : Sinfo.Os:='Linux';
    end;
  Delete(Recive,1,1);
  //Password
  if Recive[1]=chr(1) then SInfo.Password:=True
                      else SInfo.Password:=False;
  Delete(Recive,1,1);
  //IsMod
  if Recive[1]=chr(1) then SINFo.IsMod:=True
                      else SINFo.IsMod:=False;
  Delete(Recive,1,1);
          //Delete Mod Info
          if SINFo.IsMod then          
          begin
           Delete(Recive,1,Pos(Chr(0),Recive));    //mod info - string
           Delete(Recive,1,Pos(Chr(0),Recive));    //mod url  - string
           Delete(Recive,1,Pos(Chr(0),Recive));    //0x00
           Delete(Recive,1,10);                    //  Version (long - 32bit (4)) + Down Size (long) + ServerSideOnly (byte - bool) + Modified SWDll (byte - bool)
          end;
  //Secure
  if Recive[1]=chr(1) then SINFo.Secure:=True
                      else SINFo.Secure:=False;
  Delete(Recive,1,1);
  //Bots
   Sinfo.Bots:=ord(Recive[1]);
   Delete(Recive,1,1);

 except
  on exception do Error:=True;
 end;
 end;

 //Not just it but works
 if Sinfo.PacketVersion<>109 then Error:=True;

 //Input values (for assign to ListBox)
 SInfo.Error:=Error;
 SInfo.IP   := Ip;
 SInfo.Port := Port;

 PostMainMessage(SInfo);  //post message to main application

end;

end.

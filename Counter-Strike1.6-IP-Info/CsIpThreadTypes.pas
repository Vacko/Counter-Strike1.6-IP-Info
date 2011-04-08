unit CsIpThreadTypes;

interface

uses Messages;

const ServerMsg = WM_USER + 10;
const A2S_INFO = #255+#255+#255+#255+'TSource Engine Query'+#0;


type

  PServerThInfo = ^TServerThInfo;

  TServerThInfo = record
    Error         : boolean;
    IP            : String;
    Port          : integer;

    //dle specifikace
    PacketVersion : byte;   //0x6D    (CS1)
    ServerIP,
    HostName,
    Map,
    Game,
    Description: String;
    Players,
    Maxplayers,
    NetVersion  : integer;
    ServerType  : String;
    Os          : String;
    Password    : boolean;
    IsMod       : boolean;
    Secure      : boolean;
    Bots        : integer;
  end;

implementation

end.

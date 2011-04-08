unit CsIpServerListTypes;

interface

type

  PServerInfo = ^TServerInfo;

  TServerInfo = record
    Name,
    ServerIP :String;
    Port     :Integer;
  end;


implementation

end.

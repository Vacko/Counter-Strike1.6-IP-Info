unit Functions;

interface

uses SysUtils;

const ServerFile='csip.ini';

function GetExeDir:String;

implementation

function GetExeDir:String;
var
 x,y:String;
begin
       x := ParamStr(0);
       y := ExtractFileName(ParamStr(0));
    result:= copy(x,0,length(x) - length(y));
end;
end.

unit CsIpServerList;

interface

uses Classes,SysUtils,CsIpServerListTypes,Inifiles;

type
  TCsListClass = class
    private
      FileName:String;
      List:TList;

      procedure SaveIni;
      procedure LoadIni;
    protected
    public
      constructor Create(SaveFile:String);
      destructor Free;

      procedure AddServer(Server:TServerInfo);
      function  GetServer(Index:integer):TServerInfo;
      procedure DeleteServer(Index:Integer);
      function  ItemsCount:Integer;

      procedure Clear;
  end;

implementation

//*************List Functions***************************************************

Constructor TCsListClass.Create(SaveFile:String);
begin
 FileName:=SaveFile;
 List:=TList.Create;
 LoadIni;
end;

Destructor TCsListClass.Free;
begin
 SaveIni;
 List.Free;  //uvolni i vsechny v seznamu
end;

procedure TCsListClass.AddServer(Server:TServerInfo);
var
 JobPointer:PServerInfo;
begin
   New(JobPointer);
   JobPointer^:=Server;
   List.Add(JobPointer);
   SaveIni;
end;

procedure TCsListClass.DeleteServer(index:Integer);
begin
  List.Delete(index);
  SaveIni;
end;

function TCsListClass.GetServer(index:integer):TServerInfo;
var
  JobPointer:PServerInfo;
begin
   JobPointer:= List.items[index];
   Result:=JobPointer^;
end;

function TCsListClass.ItemsCount:Integer;
begin
 result:= List.Count
end;

procedure TCsListClass.Clear;
begin
  List.Clear;
  if FileExists(FileName) then DeleteFile(FileName);
end;

//****************INI***********************************************************

procedure TCsListClass.SaveIni;
var
 ini:TIniFile;
 i:integer;
begin
  Ini:=TIniFile.Create(FileName);

    Ini.WriteInteger('Data','Count',ItemsCount);

    for i := 0 to List.Count - 1 do
      begin
       Ini.WriteString('Server'+IntToStr(i),'Name',GetServer(i).Name);
       Ini.WriteString('Server'+IntToStr(i),'IP',GetServer(i).ServerIP);
       Ini.WriteInteger('Server'+IntToStr(i),'Port',GetServer(i).Port);
      end;
    
  Ini.free;
end;

procedure TCsListClass.LoadIni;
var
 ini:TIniFile;
 ItemsCount,i:integer;
 NewServer:TServerInfo;
begin
  Ini:=TIniFile.Create(FileName);

    ItemsCount := Ini.ReadInteger('Data','Count',0);

     for i := 0 to ItemsCount - 1 do
       begin
         NewServer.Name     := Ini.ReadString('Server'+IntToStr(i),'Name','None');
         NewServer.ServerIP := Ini.ReadString('Server'+IntToStr(i),'IP','None');
         NewServer.Port     := Ini.ReadInteger('Server'+IntToStr(i),'Port',0);

         AddServer(NewServer);
       end;

  Ini.Free;
end;


end.

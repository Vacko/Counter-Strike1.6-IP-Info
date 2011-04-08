program CsIp7;

{%File 'CsIp.txt'}

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  CsIpThread in 'CsIpThread.pas',
  CsIpThreadTypes in 'CsIpThreadTypes.pas',
  CsIpServerList in 'CsIpServerList.pas',
  CsIpServerListTypes in 'CsIpServerListTypes.pas',
  Functions in 'Functions.pas',
  CsIpAddServerForm in 'CsIpAddServerForm.pas' {AddServer},
  CsIpSettingsForm in 'CsIpSettingsForm.pas' {SettingsForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Cs-Ip';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAddServer, AddServer);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.Run;
end.

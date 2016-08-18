program EventHandling;

uses
  Forms,
  FormMain in 'FormMain.pas' {frmMain},
  uBackgroundThread in 'units\uBackgroundThread.pas',
  uEventHandler in 'units\uEventHandler.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

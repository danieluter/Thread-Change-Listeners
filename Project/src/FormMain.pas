unit FormMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uBackgroundThread, SyncObjs, uEventHandler;

type

  TfrmMain = class(TForm)
    btnStart: TButton;
    btnStop: TButton;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbListener1: TCheckBox;
    cbListener2: TCheckBox;
    cbListener3: TCheckBox;
    procedure btnStartClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbListenerClick(Sender: TObject);
  private
    { Private declarations }
    EventHandler: TEventHandler;
    BackgroundThread: TBackgroundThread;

    procedure UpdateThreadValue(Sender: TObject; aValue: Integer);

    procedure StartThread;
    procedure TerminateThread;

    procedure RefreshListener(Sender: TObject; aValue: Integer);
    procedure AfterUnregister(Sender: TObject);

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  EventHandler := TEventHandler.Create;
  StartThread;

  cbListenerClick(cbListener3);
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TerminateThread;
  EventHandler.Free;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  StartThread;
end;

procedure TfrmMain.btnStopClick(Sender: TObject);
begin
  TerminateThread;
end;

procedure TfrmMain.StartThread;
begin
  if not Assigned(BackgroundThread) then
  begin
    BackgroundThread := TBackgroundThread.Create(True);
    BackgroundThread.OnUpdateThreadValue := UpdateThreadValue;
    BackgroundThread.Resume;
  end;

  btnStart.Enabled := False;
  btnStop.Enabled := True;
end;

procedure TfrmMain.TerminateThread;
begin
  if Assigned(BackgroundThread) then
  begin
    BackgroundThread.Terminate;
    BackgroundThread.WaitFor;
    FreeAndNil(BackgroundThread);
  end;

  btnStart.Enabled := True;
  btnStop.Enabled := False;
end;

procedure TfrmMain.UpdateThreadValue(Sender: TObject; aValue: Integer);
begin
  EventHandler.CurrentValue := aValue;
end;

procedure TfrmMain.RefreshListener(Sender: TObject; aValue: Integer);
begin
  if Sender is TCheckBox then
    (Sender as TCheckBox).Caption := IntToStr(aValue);
end;

procedure TfrmMain.AfterUnregister(Sender: TObject);
begin
  if Sender is TCheckBox then
    (Sender as TCheckBox).Caption := (Sender as TCheckBox).Name + ' - unregistered';
end;

procedure TfrmMain.cbListenerClick(Sender: TObject);
begin
  if not (Sender is TCheckBox) then
    Exit;

  if (Sender as TCheckBox).Checked then
    EventHandler.RegisterListener(Sender, RefreshListener)
  else
    EventHandler.UnregisterListener(Sender, AfterUnregister);
end;

end.

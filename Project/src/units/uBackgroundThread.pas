unit uBackgroundThread;

interface

uses
  Classes, uEventHandler;

type
  TOnUpdateThreadValue = procedure(Sender: TObject; aValue: Integer) of object;

  TBackgroundThread = class(TThread)
  private
    i: Integer;
    fOnUpdateThreadValue: TOnUpdateThreadValue;
    procedure UpdateThreadValue;
  protected
    procedure Execute; override;
  public
    constructor Create(aCreateSuspended: Boolean);
  published
    property OnUpdateThreadValue: TOnUpdateThreadValue read fOnUpdateThreadValue write fOnUpdateThreadValue;
  end;

implementation

uses
  Forms, SysUtils;

{ TBackgroundThread }

constructor TBackgroundThread.Create(aCreateSuspended: Boolean);
begin
  inherited Create(aCreateSuspended);

  FreeOnTerminate := false;
  i := 0;
end;

procedure TBackgroundThread.UpdateThreadValue;
begin
  if Assigned(fOnUpdateThreadValue) then
    fOnUpdateThreadValue(Self, i);
end;

procedure TBackgroundThread.Execute;
var
  c: Integer;
begin
  c := 0;

  while not Terminated do
  begin
    Inc(c);
    Sleep(1);
    if c mod 200 = 0 then
    begin
      c := 0;
      Inc(i);
      Synchronize(UpdateThreadValue);
    end;
  end;
end;

end.

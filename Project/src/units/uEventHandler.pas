unit uEventHandler;

interface

uses
  Classes, SyncObjs;

type
  TRefreshProc = procedure(Sender: TObject; aValue: Integer) of object;

  TListener = record
    Sender: TObject;
    RefreshProc: TRefreshProc;
  end;

  TEventHandler = class
  private
    ListSection: TCriticalSection;
    fCurrentValue: Integer;

    Listeners: array of TListener;
    procedure SetCurrentValue(const Value: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    procedure RegisterListener(Sender: TObject; aRefreshProc: TRefreshProc);
    procedure UnregisterListener(Sender: TObject; aAfterUnregister: TNotifyEvent = nil);

    property CurrentValue: Integer read fCurrentValue write SetCurrentValue;
  end;

implementation

{ TEventHandler }

constructor TEventHandler.Create;
begin
  inherited;

  ListSection := TCriticalSection.Create;
end;

destructor TEventHandler.Destroy;
begin
  ListSection.Free;

  inherited;
end;

procedure TEventHandler.RegisterListener(Sender: TObject; aRefreshProc: TRefreshProc);
var
  i: Integer;
  lListener: TListener;
  lFound: Boolean;
begin
  lFound := False;

  ListSection.Acquire;
  try
    for i := High(Listeners) downto Low(Listeners) do
    begin
      lListener := Listeners[i];

      if (lListener.Sender = Sender)
        and (TMethod(lListener.RefreshProc).Data = TMethod(aRefreshProc).Data)
        and (TMethod(lListener.RefreshProc).Code = TMethod(aRefreshProc).Code) then
      begin
        lFound := True;
        Break;
      end;
    end;

    if not lFound then
    begin
      SetLength(Listeners, Length(Listeners) + 1);

      Listeners[Length(Listeners) - 1].Sender := Sender;
      Listeners[Length(Listeners) - 1].RefreshProc := aRefreshProc;
    end;
  finally
    ListSection.Release
  end;
end;

procedure TEventHandler.SetCurrentValue(const Value: Integer);
var
  i: Integer;
begin
  fCurrentValue := Value;

  ListSection.Acquire;
  try
    for i := High(Listeners) downto Low(Listeners) do
      Listeners[i].RefreshProc(Listeners[i].Sender, Value);
  finally
    ListSection.Release;
  end;
end;

procedure TEventHandler.UnregisterListener(Sender: TObject; aAfterUnregister: TNotifyEvent);
var
  i, j: Integer;
  lListener: TListener;
begin
  ListSection.Acquire;
  try
    for i := High(Listeners) downto Low(Listeners) do
    begin
      lListener := Listeners[i];

      if lListener.Sender = Sender then
      begin
        for j := i to High(Listeners) - 1 do
          Listeners[j] := Listeners[j + 1];
        SetLength(Listeners, Length(Listeners) - 1);

        if Assigned(aAfterUnregister) then
          aAfterUnregister(Sender);

        Break;
      end;
    end;

  finally
    ListSection.Release;
  end;
end;

end.

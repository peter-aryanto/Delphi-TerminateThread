unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMyThreadUpdate = reference to procedure (const AUpdateText: string);

  TMyThread = class(TThread)
  strict private
    FOnUpdate: TMyThreadUpdate;
    procedure DoUpdate;
  strict protected
    procedure Execute; override;
  public
    constructor Create(const AOnUpdate: TMyThreadUpdate); reintroduce;
    destructor Destroy; override;
  end;

  TForm2 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  strict private
    FThread: TMyThread;
    FOnThreadFinished: TNotifyEvent;
    procedure HandleThreadUpdate(const AUpdateText: string);
    procedure HandleThreadFinished(Sender: TObject);
  public
    property OnThreadFinished: TNotifyEvent write FOnThreadFinished;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
begin
  {}FThread := TMyThread.Create({}HandleThreadUpdate);
  FThread.OnTerminate := HandleThreadFinished;
  FThread.FreeOnTerminate := True;
  {}FThread.Start;
///////  while not FThread.Started do begin end; FThread.Free;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
//  FThread.Free;
end;

procedure TForm2.HandleThreadUpdate(const AUpdateText: string);
begin
  Edit1.Text := AUpdateText;
end;

procedure TForm2.HandleThreadFinished(Sender: TObject);
begin
  if Assigned(FOnThreadFinished) then FOnThreadFinished(nil);
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
//  if Assigned(FThread) then
    {}FThread.Terminate;
//  begin
//    if TerminateThread(FThread.Handle, 0) then
//      MessageDlg('Thread terminated successfully.', mtInformation, [mbOK], 0)
//    else
//      raise Exception.Create('Failed to terminate thread.');
//  end;
end;

{ TMyThread }

constructor TMyThread.Create(const AOnUpdate: TMyThreadUpdate);
begin
  {}inherited Create(True);
  {}FOnUpdate := AOnUpdate;
end;

destructor TMyThread.Destroy;
begin
//  OnTerminate := nil;
//  FOnUpdate := nil;
  inherited Destroy;
end;

procedure TMyThread.Execute;
begin
///////  inherited Execute;

  while {}not {}Terminated do
//  while True do
  begin
    Sleep(1000);
    {}Synchronize({}DoUpdate);
  end;
end;

procedure TMyThread.DoUpdate;
begin
  if Assigned(FOnUpdate) then FOnUpdate(FormatDateTime('ddmmyyyy hh:nn:ss', Now));
end;

end.


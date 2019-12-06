unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    procedure HandleThreadFinished(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  Unit2;

procedure TForm1.Button1Click(Sender: TObject);
var
  LForm2: TForm2;
begin
  Edit1.Text := 'Started';

  LForm2 := TForm2.Create(nil);
  try
    LForm2.OnThreadFinished := HandleThreadFinished;
    LForm2.ShowModal;
  finally
    LForm2.Free;
  end;
end;

procedure TForm1.HandleThreadFinished(Sender: TObject);
begin
  Edit1.Text := 'Finished';
end;

end.

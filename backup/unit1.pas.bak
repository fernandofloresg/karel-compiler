unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  f : TextFile;
  c : string;
  i : integer;
begin
  AssignFile(f, 'fuente.txt'); //Asigna apuntador del archivo de texto a la variable f
  reset(f); //Abrimos el archivo como solo lectura
  readln(f,c);
  i := 0;
  while not eof(f) do
  begin
    Memo1.Lines[i]:=c;
    inc(i);
    readln(f,c);
  end;
  closefile(f);
end; //Fin

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

end.


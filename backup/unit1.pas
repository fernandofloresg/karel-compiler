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
//Funciones del analizador léxico
type
  stringArray = array of string;

function noEsSeparador(c : char) : boolean;
begin
  result := ((c <> ' ') and (c <> chr(9)) and (c <> chr(13)) and (c <> chr(10)))
end;

function esIdentificador(token : string) : integer;
begin

end;

function esNumero(token : string) : integer;
begin

end;

function analizaToken(token : string) : integer;
var
reservadoArray : stringArray;
i, iValue, iCode: integer;

begin
reservadoArray := stringArray.create('include','main','int','float');
for i := Low(identificadorArray) to High(identificadorArray) do
  if token = identificadorArray[i] then
    Exit(1);


end;

procedure TForm1.Button1Click(Sender: TObject);
var
  f : TextFile;
  c : char;
  i : integer;
  token, tokenAux, tipo : string;
begin
  AssignFile(f, 'fuente.txt'); //Asigna apuntador del archivo de texto a la variable f
  reset(f); //Abrimos el archivo como solo lectura
  i := 0;
  repeat
    read(f,c);
    //Análisis léxico
    token := '';
    tipo := '';
    while noEsSeparador(c) do begin
          token:= token + c;
          read(f,c);
    end;
    tokenaux := c;

    case analizaToken(token) of
         1 : tipo := 'palabra reservada';
    end;
    Memo1.Lines[i]:=token + ',' + tokenaux + tipo;
    inc(i);
  until eof(f);
  closefile(f);
end; //Fin



procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

end.


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

function esPalabraReservada(token : string) : boolean;
var
  reservadoArray : stringArray;
  i : integer;
begin
  //busca palabras reservadas
reservadoArray := stringArray.create('include','main','int','float');
result := false;
for i := low(reservadoArray) to high(reservadoArray) do
  if token = reservadoArray[i] then
    begin
      result := true;
    end;
end;

function esNumero(token : string) : boolean;
var
  num : Double;
begin
  //busca numeros
  result := false;
  if(TryStrToFloat(token, num)) then
    begin
      result := true;
    end;
end;

function esIdentificador(token : string) : integer;
const
  alfabeto = ['a'..'z', 'A'..'Z'];
  digitos = ['0' .. '9'];
var
  j : integer;
  letra : char;
begin
  //busca identificadores
  j := 1;
  result := 0;
  if j < length(token) then
    begin
      //si el primer caracter es letra, lo demás no puede ser simbolo
      if token[j] in alfabeto then
        begin
          for letra in token do
            begin
              if ( not (token[j] in digitos)) and (not (token[j] in alfabeto)) then
                exit(5);
              inc(j);
            end;
          result := 3;
        end;
      //si el primer numero lo demás no puede ser caracter o simbolo
      if token[j] in digitos then
        begin
           for letra in token do
            begin
              inc(j);
              if not (token[j] in digitos) then
                exit(4);
            end;
          result := 3;
        end;
    end;
  end;

function analizaToken(token : string) : integer;
var
j : integer;
letra : char;

begin
if esPalabraReservada(token) then
  exit(1);

if esNumero(token) then
  exit(2);

exit(esIdentificador(token));

result := 0;
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
         2 : tipo := 'numero';
         3 : tipo := 'identificador';
         4 : tipo := 'error, un identificador no puede iniciar con un numero';
         5 : tipo := 'error, simbolo no especificado dentro de identificador';
    end;
    Memo1.Lines[i]:= token + ',' + tokenaux + tipo;
    inc(i);
  until eof(f);
  closefile(f);
end; //Fin



procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

end.


unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, JvComponentBase,
  JvTrayIcon, Vcl.Menus, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    jvtrycn1: TJvTrayIcon;
    tmr1: TTimer;
    pm1: TPopupMenu;
    miClose: TMenuItem;
    lbl1: TLabel;
    procedure tmr1Timer(Sender: TObject);
    procedure miCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation


{$R *.dfm}

var
  i:Integer;
procedure TForm1.miCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.tmr1Timer(Sender: TObject);
var
p:TPoint;
begin
  if i>0 then i:=-1 else i:=1;
  P:=Mouse.CursorPos;
  p.X:=p.X+i;
  Mouse.CursorPos:=p;
end;

initialization
i:=0;

end.

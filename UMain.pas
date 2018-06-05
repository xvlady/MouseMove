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
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function SetThreadExecutionState(esFlags: UINT): UINT; stdcall; external kernel32 name 'SetThreadExecutionState';

var
  Form1: TForm1;

implementation


{$R *.dfm}
const
  ES_AWAYMODE_REQUIRED = $00000040;//Enables away mode. This value must be specified with ES_CONTINUOUS. Away mode should be used only by media-recording and media-distribution applications that must perform critical background processing on desktop computers while the computer appears to be sleeping. See Remarks.
  ES_CONTINUOUS = $80000000; //Informs the system that the state being set should remain in effect until the next call that uses ES_CONTINUOUS and one of the other state flags is cleared.
  ES_DISPLAY_REQUIRED =$00000002;//Forces the display to be on by resetting the display idle timer.
  ES_SYSTEM_REQUIRED=$00000001;//Forces the system to be in the working state by resetting the system idle timer.

procedure TForm1.FormCreate(Sender: TObject);
begin
//https://msdn.microsoft.com/en-us/library/windows/desktop/aa373208(v=vs.85).aspx
 if SetThreadExecutionState($00000001 + $80000000) = 0 then
   ShowMessage('Не получилось, придётся спать.');
 if SetThreadExecutionState(ES_DISPLAY_REQUIRED) = 0 then
   ShowMessage('Не получилось, придётся спать.');

   // else
//   ShowMessage("Нескафе голд - не замерзай ночью!");
end;

procedure TForm1.miCloseClick(Sender: TObject);
begin
  Close;
end;

var
  i:Integer;

procedure TForm1.tmr1Timer(Sender: TObject);
var
p:TPoint;
begin
  if i>0 then i:=-1 else i:=1;
  P:=Mouse.CursorPos;
  p.X:=p.X+i;
  Mouse.CursorPos:=p;
  SetThreadExecutionState(ES_DISPLAY_REQUIRED);
  SetThreadExecutionState(ES_SYSTEM_REQUIRED);
end;

initialization
i:=0;

end.

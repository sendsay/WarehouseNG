unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  JvTimer;

type
  TfrmLogin = class(TForm)
    dbcbbUserName: TDBComboBox;
    pnlButtons: TPanel;
    btnCancel: TButton;
    lblLogin: TLabel;
    lblPassword: TLabel;
    edtPassword: TEdit;
    jvtmrCloseSplash: TJvTimer;
    btnLogin: TButton;
    procedure FormShow(Sender: TObject);
    procedure jvtmrCloseSplashTimer(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  Splash;

{$R *.dfm}

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  frmLogin.Close;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  {$IFNDEF DEBUG}
  frmMain.jvtmrCloseSplash.Enabled := True;
  btnTest.Visible := False;
  {$ELSE}
  frmSplash.Hide;
  frmSplash.Free;
  {$ENDIF}
end;

procedure TfrmLogin.jvtmrCloseSplashTimer(Sender: TObject);
begin
  frmSplash.Hide;
  frmSplash.Free;
  jvtmrCloseSplash.Enabled := False;
end;

end.

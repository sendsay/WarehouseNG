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
    btnLogin: TButton;
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
  Splash, WareHouseNG;

{$R *.dfm}

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  frmLogin.Close;
  Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
begin
  frmMain.show;

end;

end.

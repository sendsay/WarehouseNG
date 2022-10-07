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
    class function Execute: Boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

class function TfrmLogin.Execute: boolean;
begin
  with TfrmLogin.Create(nil) do
  try
    Result := ShowModal = mrOk;
  finally
    Free;
  end;
end;

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject) ;
begin
  if edtPassword.Text = 'delphi' then

    ModalResult := mrOK
  else
    ModalResult := mrAbort;
end;

end.

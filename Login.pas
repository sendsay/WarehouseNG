unit Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls,
  JvTimer, JvExStdCtrls, JvCombobox, Registry;

type
  TfrmLogin = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    lblLogin: TLabel;
    lblPassword: TLabel;
    edtPassword: TEdit;
    btnLogin: TButton;
    cbbUsers: TJvComboBox;
    procedure btnCancelClick(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Execute: Boolean;
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  DataModule, WareHouseNG;

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

procedure TfrmLogin.FormShow(Sender: TObject);
var
  slUsers: TStringList;
  I: Integer;
  RegRead: TRegistry;

begin
  slUsers := TStringList.Create;
  try
    RegRead := TRegistry.Create(KEY_READ);

    try
      RegRead.RootKey := HKEY_CURRENT_USER;
      RegRead.OpenKeyReadOnly('SOFTWARE\Sendsay\WareHouseNG\frmParams') ;
      sBasePath := RegRead.ReadString('edtDir_Text');
    finally
      RegRead.Free;
    end;


    DataModule1.conMain.Params.Database := sBasePath + '\' + 'WareHouse.accdb';
    DataModule1.conMain.Connected := True;
    DataModule1.fdqryItems.Active := True;
    DataModule1.fdqryUsers.Active := True;
  
    with DataModule1 do
    begin
      fdqryUsers.First;
      for I := 0 to fdqryUsers.RecordCount - 1 do
      begin
        cbbUsers.Items.Add(fdqryUsersUserName.Asstring);  
        fdqryUsers.Next; 
      end;  
    end;
    
  finally
    slUsers.Free;
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
  begin
    ModalResult := mrAbort;
  end;
end;

end.

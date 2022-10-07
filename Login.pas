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
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
      iTryCount : SmallInt;
  public
    { Public declarations }
    class function Execute: Boolean;
  end;

var
  frmLogin: TfrmLogin;


  procedure SDM(Str : Variant); stdcall external 'MyDLL.dll' {$IFNDEF DEBUG} delayed {$ENDIF};

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
  I: Integer;
  RegRead: TRegistry;
begin
  //read regystry
  RegRead := TRegistry.Create(KEY_READ);
  try
    RegRead.RootKey := HKEY_CURRENT_USER;
    RegRead.OpenKeyReadOnly('SOFTWARE\Sendsay\WareHouseNG\frmParams') ;
    sBasePath := RegRead.ReadString('edtDir_Text');
  finally
    RegRead.Free;
  end;

  //connect to base
  DataModule1.conMain.Params.Database := sBasePath + '\' + 'WareHouse.accdb';
  DataModule1.conMain.Connected := True;
  DataModule1.fdqryItems.Active := True;
  DataModule1.fdqryUsers.Active := True;

   //fill comdobox
  with DataModule1 do
  begin
    fdqryUsers.First;
    for I := 0 to fdqryUsers.RecordCount - 1 do
    begin
      cbbUsers.Items.Add(fdqryUsersUserName.Asstring);
      fdqryUsers.Next;
    end;
  end;
end;

procedure TfrmLogin.btnCancelClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmLogin.btnLoginClick(Sender: TObject);
var
  sUserName, sUserPass: string;
begin
  with DataModule1 do
  begin
    //check name in base
    if fdqryUsers.Locate('UserName', cbbUsers.Text, []) then
    begin
      //get pass
      sUserPass := fdqryUsers.FieldByName('UserPass').AsString;

      //check
      if sUserPass = edtPassword.Text then
      begin
        //get level pass
        sMachine := fdqryUsers.FieldByName('Machine').AsString;
        //exit with OK
        ModalResult := mrOK
      end
      else
      begin
        //inc try count
        Inc(iTryCount);

        MessageDlg('Wrong login or password!',  mtConfirmation, [mbOK], 0);

        if iTryCount = 3 then
        begin
          //exit with error
          Application.Terminate;
        end;
      end;
    end
    else
    begin
      //msg
      MessageDlg('Enter valid name!',  mtConfirmation, [mbOK], 0);
    end;
  end;
end;

procedure TfrmLogin.edtPasswordKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btnLogin.Click;
end;

end.

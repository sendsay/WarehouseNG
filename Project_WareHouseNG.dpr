program Project_WareHouseNG;

uses
  Vcl.Forms,
  WareHouseNG in 'WareHouseNG.pas' {frmMain},
  Login in 'Login.pas' {frmLogin},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  AddEdit in 'AddEdit.pas' {frmAddEdit},
  Params in 'Params.pas' {frmParams},
  Vcl.Themes,
  Vcl.Styles,
  ShowFoto in 'ShowFoto.pas' {frmShowFoto},
  Splash in 'Splash.pas' {frmSplash},
  About in 'About.pas' {frmAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');

  Application.CreateForm(TDataModule1, DataModule1);

  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;

  Application.ProcessMessages;

  if TfrmLogin.Execute then
  begin
    Application.CreateForm(TfrmMain, frmMain);
    Application.CreateForm(TfrmAddEdit, frmAddEdit);
    Application.CreateForm(TfrmParams, frmParams);
    Application.CreateForm(TfrmShowFoto, frmShowFoto);
    Application.CreateForm(TfrmAbout, frmAbout);
    Application.Run;
  end
  else
  begin
    Application.MessageBox('You are not authorized!', 'Warehouse NG') ;
    Application.Terminate;
  end;


end.

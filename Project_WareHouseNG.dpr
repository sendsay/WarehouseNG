program Project_WareHouseNG;

uses
  Vcl.Forms,
  WareHouseNG in 'WareHouseNG.pas' {frmMain},
  DataModule in 'DataModule.pas' {DataModule1: TDataModule},
  AddEdit in 'AddEdit.pas' {frmAddEdit},
  Params in 'Params.pas' {frmParams},
  Vcl.Themes,
  Vcl.Styles,
  ShowFoto in 'ShowFoto.pas' {frmShowFoto},
  Splash in 'Splash.pas' {frmSplash},
  About in 'About.pas' {frmAbout},
  Login in 'Login.pas' {frmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sky');

  frmSplash := TfrmSplash.Create(nil);
  frmSplash.Show;

  Application.ProcessMessages;

  Application.CreateForm(TfrmLogin, frmLogin);

//  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TfrmAddEdit, frmAddEdit);
  Application.CreateForm(TfrmParams, frmParams);
  Application.CreateForm(TfrmShowFoto, frmShowFoto);
  Application.CreateForm(TfrmAbout, frmAbout);

  Application.Run;
end.

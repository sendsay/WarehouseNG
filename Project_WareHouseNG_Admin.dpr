program Project_WareHouseNG_Admin;

uses
  Vcl.Forms,
  WareHouseNG_Admin in 'WareHouseNG_Admin.pas' {frmMain},
  DataModuleAdmin in 'DataModuleAdmin.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.Run;
end.

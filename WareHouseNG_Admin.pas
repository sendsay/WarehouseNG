unit WareHouseNG_Admin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid;

type
  TfrmMain = class(TForm)
    jvdbgrdUsers: TJvDBGrid;
    jvdbgrdMachine: TJvDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  DataModuleAdmin;

{$R *.dfm}

end.

unit DataModuleAdmin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDataModule2 = class(TDataModule)
    dsUsers: TDataSource;
    conMain: TFDConnection;
    fdqryUsers: TFDQuery;
    fdqryMachine: TFDQuery;
    dsMachine: TDataSource;
    fdtncfldUsersID: TFDAutoIncField;
    wdstrngfldUsersUserName: TWideStringField;
    wdstrngfldUsersUserPass: TWideStringField;
    intgrfldUsersMachine: TIntegerField;
    fdtncfldMachineID: TFDAutoIncField;
    wdstrngfldMachineMachineName: TWideStringField;
    procedure dsUsersDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule2.dsUsersDataChange(Sender: TObject; Field: TField);
begin

end;

end.

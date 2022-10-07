unit DataModule;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.MSAcc, FireDAC.Phys.MSAccDef, FireDAC.Phys.SQLiteWrapper.Stat;

type
  TDataModule1 = class(TDataModule)
    conMain: TFDConnection;
    fdqryItems: TFDQuery;
    dsItems: TDataSource;
    fdgxwtcrsrMain: TFDGUIxWaitCursor;
    fdphysqltdrvrlnkMain: TFDPhysSQLiteDriverLink;
    fdtncfldItemsID: TFDAutoIncField;
    wdstrngfldItemsID_Item: TWideStringField;
    wdstrngfldItemsName_Item: TWideStringField;
    intgrfldItemsQuantity: TIntegerField;
    wdstrngfldItemsMachine: TWideStringField;
    wdstrngfldItemsNotes: TWideStringField;
    blbfldItemsPhoto: TBlobField;
    procedure conMainAfterConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.conMainAfterConnect(Sender: TObject);
begin
  fdqryItems.Active := True;
end;

end.

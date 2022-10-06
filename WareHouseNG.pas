unit WareHouseNG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, JvExComCtrls, JvStatusBar, Vcl.ExtCtrls, JvFormPlacement,
  JvComponentBase, JvAppStorage, JvAppRegistryStorage, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.DBCtrls, JvExDBGrids, JvDBGrid, System.Actions,
  Vcl.ActnList, JvLogFile, JvLogClasses, ShlObj, Vcl.Imaging.pngimage, System.UITypes,
  JvTimer, frxClass, frxCross;

type
  TfrmMain = class(TForm)
    jvprgstrystrgMain: TJvAppRegistryStorage;
    jvfrmstrgMain: TJvFormStorage;
    pnlButtonsUp: TPanel;
    pnlData: TPanel;
    jvstsbrMain: TJvStatusBar;
    btnAdd: TButton;
    btnNewEdit: TButton;
    btnDelete: TButton;
    btnParams: TButton;
    btnAbout: TButton;
    srchbxMain: TSearchBox;
    lblIDItem: TLabel;
    dbtxtIDItem: TDBText;
    lblItem: TLabel;
    dbtxtItem: TDBText;
    lblQuantity: TLabel;
    dbtxtQuantity: TDBText;
    lblNotes: TLabel;
    dbtxtNotes: TDBText;
    lblFoto: TLabel;
    dbimgFoto: TDBImage;
    jvdbgrdMain: TJvDBGrid;
    actlstMain: TActionList;
    actAdd: TAction;
    actEdit: TAction;
    actDelete: TAction;
    jvlgflMain: TJvLogFile;
    actShowFoto: TAction;
    frxcrsbjctPrint: TfrxCrossObject;
    frxrprtPrint: TfrxReport;
    btnPrint: TButton;
    actPrint: TAction;
    btnTest: TButton;

    procedure FormShow(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actParamsExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure srchbxMainInvokeSearch(Sender: TObject);
    procedure jvdbgrdMainDblClick(Sender: TObject);
    procedure dbimgFotoDblClick(Sender: TObject);
    procedure jvdbgrdMainTitleBtnClick(Sender: TObject; ACol: Integer;
      Field: TField);
    procedure actPrintExecute(Sender: TObject);
    procedure frxrprtPrintBeforePrint(Sender: TfrxReportComponent);
    procedure jvdbgrdMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure actAboutExecute(Sender: TObject);
    procedure jvdbgrdMainKeyPress(Sender: TObject; var Key: Char);
    procedure btnTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    sBasePath: string;
  end;

type
  TPrint = record
    id: string;
    name: string;
    quantity: string;
    machine: string;
  end;

var
  prnArr: array of TPrint;

  frmMain: TfrmMain;
  bHasStart: Boolean = True;

  procedure SDM(Str : Variant); stdcall external 'MyDLL.dll' {$IFNDEF DEBUG} delayed {$ENDIF};

  procedure Log(sTitle: string); overload;
  procedure Log(lcSeverity: TJvLogEventSeverity; sTitle, sDesc: string);  overload;
  procedure Log(lcSeverity: TJvLogEventSeverity; sTitle: string); overload;

const
  INFO = lesInformation;
  ERROR = lesError;
  WARN = lesWarning;
  CSIDL_COMMON_APPDATA = $23;

function GetSpecialPath(CSIDL: word): string;

implementation

uses
  DataModule, AddEdit, Params, ShowFoto, Splash, About;

{$R *.dfm}

function GetSpecialPath(CSIDL: word): string;
var s: string;
begin
  SetLength(s, MAX_PATH);
  if not SHGetSpecialFolderPath(0, PChar(s), CSIDL, true) then
    s := GetSpecialPath(CSIDL_APPDATA);

  Result := PChar(s);
end;

procedure Log(sTitle: string);
begin
  frmMain.jvlgflMain.Severity := INFO;
  frmMain.jvlgflMain.Add(' '+ sTitle);
end;

procedure Log(lcSeverity: TJvLogEventSeverity; sTitle, sDesc: string);
begin
  frmMain.jvlgflMain.Severity := lcSeverity;
  frmMain.jvlgflMain.Add(' ' + sTitle, ' ' +sDesc);
end;

procedure Log(lcSeverity: TJvLogEventSeverity; sTitle: string);
begin
  frmMain.jvlgflMain.Severity := lcSeverity;
  frmMain.jvlgflMain.Add(' '+ sTitle);
end;

procedure TfrmMain.actAboutExecute(Sender: TObject);
begin
  frmAbout.ShowModal;
end;

procedure TfrmMain.actAddExecute(Sender: TObject);
begin
  try
    Log(WARN, 'Add record');
    frmAddEdit.Caption := 'Add';
    DataModule1.fdqryItems.Append;
    frmAddEdit.ShowModal;
  except on E: Exception do
    begin
      Log(ERROR, 'Add record', (E.ClassName + ' > ' + E.Message));
      ShowMessage(E.ClassName + #10#13 + E.Message);
    end;
  end;
end;

procedure TfrmMain.actDeleteExecute(Sender: TObject);
begin
  if MessageDlg('You want to delete ' + DataModule1.wdstrngfldItemsName_Item.AsString +
                #10#13 + 'Are you sure?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    if MessageDlg('Are you seriously?',  mtConfirmation, [mbYes, mbNo], 0) =
      mrYes then
    begin
      try
        Log(WARN, 'Delete record', DataModule1.wdstrngfldItemsName_Item.AsString);

        DataModule1.fdqryItems.Delete;
      except on E: Exception do
        begin
          Log(ERROR, 'Delete record', (E.ClassName + ' > ' + E.Message));
          ShowMessage(E.ClassName + #10#13 + E.Message);
        end;
      end;
    end;
  end;
end;

procedure TfrmMain.actEditExecute(Sender: TObject);
begin
  try
    frmAddEdit.Caption := 'Edit';
    DataModule1.fdqryItems.Edit;
    frmAddEdit.ShowModal;
  except on E: Exception do
    begin
      Log(ERROR, 'Edit record', (E.ClassName + ' > ' + E.Message));
      ShowMessage(E.ClassName + #10#13 + E.Message);
    end;
  end;
end;

procedure TfrmMain.actParamsExecute(Sender: TObject);
begin
  frmParams.ShowModal;
end;

procedure TfrmMain.actPrintExecute(Sender: TObject);
var
  iCountRow : Integer;
begin
  SetLength(prnArr, 1);
  prnArr[0].id := 'ID';
  prnArr[0].name := 'NAME';
  prnArr[0].quantity := 'QUANTITY';
  prnArr[0].machine := 'MACHINE';

  with jvdbgrdMain do
  begin
    for iCountRow := 1 to SelectedRows.Count do
    begin
      SetLength(prnArr, Length(prnArr) + 1);

      DataSource.DataSet.GotoBookmark(SelectedRows.Items[iCountRow - 1]) ;

      prnArr[iCountRow].id := DataModule1.wdstrngfldItemsID_Item.AsString;
      prnArr[iCountRow].name  := DataModule1.wdstrngfldItemsName_Item.AsString;
      prnArr[iCountRow].quantity  := DataModule1.intgrfldItemsQuantity.AsString;
      prnArr[iCountRow].machine := DataModule1.wdstrngfldItemsMachine.AsString;
    end;
  end;

  frxrprtPrint.LoadFromFile('PrintReport.fr3');
  frxrprtPrint.PrepareReport(True);
  frxrprtPrint.ShowReport;
end;

procedure TfrmMain.frxrprtPrintBeforePrint(Sender: TfrxReportComponent);
var
  Cross: TfrxCrossView;
  i, j: Integer;
begin
  if Sender is TfrxCrossView then
  begin
    Cross := TfrxCrossView(Sender);

    Cross.AddValue([0], [0], ['##']);
    Cross.AddValue([0], [1], ['ID']);
    Cross.AddValue([0], [2], ['NAME']);
    Cross.AddValue([0], [3], ['QUANTITY']);
    Cross.AddValue([0], [4], ['MACHINE']);

    for i := 1 to Length(prnArr) - 1 do
    begin
    Cross.AddValue([i], [0], [i]);

      for j := 1 to 4 do
      begin
        case j of
          0: Cross. AddValue([i], [j], [prnArr[i].id]);
          1: Cross. AddValue([i], [j], [prnArr[i].name]);
          2: Cross. AddValue([i], [j], [prnArr[i].quantity]);
          3: Cross. AddValue([i], [j], [prnArr[i].machine]);
        end;
      end;

    end;
  end;
end;

procedure TfrmMain.btnTestClick(Sender: TObject);
type
  TCust = record
    name: string;
    age: Integer;
  end;
var
  test : ^TCust;
begin
  New(test);

  FreeMem(test);
end;

procedure TfrmMain.dbimgFotoDblClick(Sender: TObject);
begin
  frmShowFoto.Show;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Log(INFO, 'Close', 'Application');
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if bHasStart then
  begin
    try
      Log(INFO, 'Start', 'Application');

      sBasePath := jvprgstrystrgMain.ReadString('\frmParams\edtDir_Text', '');
      DataModule1.conMain.Params.Database := sBasePath + '\' + 'WareHouse.accdb';

      DataModule1.conMain.Connected := True;
      DataModule1.fdqryItems.Active := True;

    except
      on E: Exception do
      begin
        if E.ClassName = 'EMSAccessNativeException' then
        begin
          Log(ERROR, 'Can`t find database', (E.ClassName + ' > ' + E.Message));
         ShowMessage('Can`t find the database!' + #10#13 + E.ClassName + #10#13 + E.Message);
        end
        else
        begin
          Log(ERROR, 'Connect to base', (E.ClassName + ' > ' + E.Message));
          ShowMessage(E.ClassName + #10#13 + E.Message);
        end;
      end;
    end;
  end;

  jvdbgrdMain.SetFocus;
  frmMain.jvstsbrMain.Panels[1].Text := IntToStr(DataModule1.fdqryItems.RecordCount);
end;

procedure TfrmMain.jvdbgrdMainDblClick(Sender: TObject);
begin
  actEdit.Execute;
end;

procedure TfrmMain.jvdbgrdMainKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    frmShowFoto.Show;
  end;
end;

procedure TfrmMain.jvdbgrdMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if jvdbgrdMain.SelectedRows.Count > 0 then
    actPrint.Enabled := True;
end;

procedure TfrmMain.jvdbgrdMainTitleBtnClick(Sender: TObject; ACol: Integer;
  Field: TField);
var
  sSortMarker, sFindStr : string;
begin
  with DataModule1.fdqryItems do
  begin
    Close;
    SQL.Clear;

    if jvdbgrdMain.SortMarker = smDown then
      sSortMarker := ' DESC'
    else
      sSortMarker := ' ASC';

    if frmMain.srchbxMain.Text = '' then
    begin
      SQL.Add('SELECT * FROM Items ORDER BY ' + Field.FieldName + sSortMarker)
    end
    else
    begin
       sFindStr := QuotedStr('%' +srchbxMain.Text+ '%');
       SQL.Add('SELECT * FROM Items WHERE ID_Item LIKE ' +sFindStr+ ' or Name_Item LIKE ' +sFindStr+ ' or Notes LIKE ' +sFindStr+ ' or Machine LIKE ' +sFindStr+ 'ORDER BY ' + Field.FieldName + sSortMarker);
    end;

    Open;
  end;
end;

procedure TfrmMain.srchbxMainInvokeSearch(Sender: TObject);
var
  sFindStr : string;
begin
  sFindStr := QuotedStr('%' +srchbxMain.Text+ '%');

  with DataModule1.fdqryItems do
  begin
    Close;
    SQL.Clear;

    if srchbxMain.Text <> '' then
      SQL.Add('SELECT * FROM Items WHERE ID_Item LIKE ' +sFindStr+ ' or Name_Item LIKE ' +sFindStr+ ' or Notes LIKE ' +sFindStr+ ' or Machine LIKE ' +sFindStr )
    else
      SQL.Add('SELECT * FROM Items');

    Open;
  end;
end;

end.

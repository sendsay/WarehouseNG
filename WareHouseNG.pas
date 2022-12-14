unit WareHouseNG;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, JvExComCtrls, JvStatusBar, Vcl.ExtCtrls, JvFormPlacement,
  JvComponentBase, JvAppStorage, JvAppRegistryStorage, Vcl.StdCtrls,
  Vcl.WinXCtrls, Vcl.DBCtrls, JvExDBGrids, JvDBGrid, System.Actions,
  Vcl.ActnList, JvLogFile, JvLogClasses, ShlObj, Vcl.Imaging.pngimage, System.UITypes,
  JvTimer, frxClass, frxCross, System.ImageList, Vcl.ImgList;

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
    jvtmrCloseSplash: TJvTimer;
    frxDSPrint: TfrxUserDataSet;
    ilMain: TImageList;

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
    procedure jvtmrCloseSplashTimer(Sender: TObject);
    procedure frxDSPrintGetValue(const VarName: string; var Value: Variant);
  private
    { Private declarations }
  public

  end;

type
  TPrint = record
    id: string;
    name: string;
    quantity: string;
  end;

var
  prnArr: array of TPrint;

  frmMain: TfrmMain;
  bHasStart: Boolean = True;
  sBasePath: string;
  sMachine: string;
  sUserName: string;

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
  iCountRow : SmallInt;
begin
  SetLength(prnArr, 0);

  with jvdbgrdMain do
  begin
    for iCountRow := 0 to SelectedRows.Count - 1 do
    begin
      SetLength(prnArr, Length(prnArr) + 1);

      DataSource.DataSet.GotoBookmark(SelectedRows.Items[iCountRow]) ;

      prnArr[iCountRow].id := DataModule1.wdstrngfldItemsID_Item.AsString;
      prnArr[iCountRow].name  := DataModule1.wdstrngfldItemsName_Item.AsString;
      prnArr[iCountRow].quantity  := DataModule1.intgrfldItemsQuantity.AsString;
    end;
  end;

  frxrprtPrint.LoadFromFile('PrintReport.fr3');
  frxrprtPrint.PrepareReport(True);
  frxrprtPrint.ShowReport;
end;

procedure TfrmMain.frxDSPrintGetValue(const VarName: string;
  var Value: Variant);
begin
  if VarName = 'Machine' then
    Value := sMachine;
  if VarName = 'UserName' then
    Value := sUserName;
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

    for i := 1 to Length(prnArr) do
    begin
    Cross.AddValue([i], [0], [i]);    //counter row

      for j := 1 to 3 do
      begin
        case j of
          1: Cross. AddValue([i], [j], [prnArr[i - 1].id]);
          2: Cross. AddValue([i], [j], [prnArr[i - 1].name]);
          3: Cross. AddValue([i], [j], [prnArr[i - 1].quantity]);
        end;
      end;

    end;
  end;
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

      with frmMain do
      begin
        Caption := Caption + ' [' + sMachine + ' - ' + sUserName  +']';
      end;

      with DataModule1.fdqryItems do
      begin
        SQL.Clear;
        SQL.Add('SELECT * FROM Items WHERE Machine LIKE ' + QuotedStr('%' +sMachine+ '%'));
        Open;
      end;

      {$IFNDEF DEBUG}
      frmMain.jvtmrCloseSplash.Enabled := True;
      btnTest.Visible := False;
      {$ELSE}
      frmSplash.Hide;
      frmSplash.Free;
      {$ENDIF}

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
          Log(ERROR, 'Connect to base error', (E.ClassName + ' > ' + E.Message));
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
      SQL.Add('SELECT * FROM Items WHERE Machine=' +QuotedStr(sMachine)+ ' ORDER BY ' + Field.FieldName + sSortMarker);
    end
    else
    begin
      sFindStr := QuotedStr('%' +srchbxMain.Text+ '%');
      SQL.Add('SELECT * FROM Items WHERE Machine='+ QuotedStr(sMachine) +' AND (ID_Item LIKE ' +sFindStr+ ' OR Quantity LIKE '+sFindStr+ ' OR Name_Item LIKE ' +sFindStr+ ' OR Notes LIKE ' +sFindStr + ') ORDER BY ' + Field.FieldName + sSortMarker ) ;
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
       SQL.Add('SELECT * FROM Items WHERE Machine='+QuotedStr(sMachine) +' AND (ID_Item LIKE ' +sFindStr+ ' OR Quantity LIKE '+sFindStr+ ' OR Name_Item LIKE ' +sFindStr+ ' OR Notes LIKE ' +sFindStr + ')')
    else
      SQL.Add('SELECT * FROM Items WHERE Machine='+QuotedStr(sMachine));
    Open;
  end;
end;

procedure TfrmMain.jvtmrCloseSplashTimer(Sender: TObject);
begin
  frmSplash.Hide;
  frmSplash.Free;
  jvtmrCloseSplash.Enabled := False;
end;

end.

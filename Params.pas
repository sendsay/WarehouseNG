unit Params;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, JvExMask,
  JvToolEdit, System.Actions, Vcl.ActnList, Vcl.ExtCtrls, JvBaseDlg,
  JvSelectDirectory, JvComponentBase, JvFormPlacement;

type
  TfrmParams = class(TForm)
    pnlButtons: TPanel;
    btnApplay: TButton;
    btnCancel: TButton;
    actlstParams: TActionList;
    actApply: TAction;
    actCancel: TAction;
    lblSSelectDir: TLabel;
    jvslctdrctryParams: TJvSelectDirectory;
    edtDir: TEdit;
    btnSelDir: TButton;
    actBrowse: TAction;
    jvfrmstrgParams: TJvFormStorage;
    procedure actCancelExecute(Sender: TObject);
    procedure jvslctdrctryParamsShow(Sender: TObject);
    procedure jvslctdrctryParamsClose(Sender: TObject);
    procedure btnSelDirClick(Sender: TObject);
    procedure edtDirChange(Sender: TObject);
    procedure actBrowseExecute(Sender: TObject);
  private
    { Private declarations }
    bChanges : Boolean;
    sPath : string;
  public
    { Public declarations }
  end;

var
  frmParams: TfrmParams;

implementation

uses
  WareHouseNG;

{$R *.dfm}

{TODO -oVlad -cVlad : Добавить контроль изменений в настйроках, и вывод предупреждения}

procedure TfrmParams.actBrowseExecute(Sender: TObject);
begin
  jvslctdrctryParams.Execute;
end;

procedure TfrmParams.actCancelExecute(Sender: TObject);
begin
  Close;
//  if bChanges then
//  begin
//    if MessageDlg('There are changes, are you sure?',  mtConfirmation, [mbYes,
//      mbNo], 0) = mrYes then
//    begin
//      bChanges := False;
//      sPath := '';
//      Close;
//    end;
//  end
//  else
//  begin
//    bChanges := False;
//    Close;
//  end;
end;

procedure TfrmParams.btnSelDirClick(Sender: TObject);
begin
//  if jvslctdrctryParams.Execute then
//    if sPath <> jvslctdrctryParams.Directory then
//      bChanges := True
//  else
//   edtDir.Text := sPath;
end;

procedure TfrmParams.edtDirChange(Sender: TObject);
begin
//  sPath := edtDir.Text;
end;

procedure TfrmParams.jvslctdrctryParamsClose(Sender: TObject);
begin
  edtDir.Text := jvslctdrctryParams.Directory;
end;

procedure TfrmParams.jvslctdrctryParamsShow(Sender: TObject);
begin
//  sPath := edtDir.Text;
end;

end.

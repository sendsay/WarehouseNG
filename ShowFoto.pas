unit ShowFoto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.ExtDlgs,GraphUtil,
  JvComponentBase, JvFormPlacement;

type
  TfrmShowFoto = class(TForm)
    pnlButtons: TPanel;
    btnClose: TButton;
    actlstShowFoto: TActionList;
    actClose: TAction;
    dbimgFoto: TDBImage;
    btnUpload: TButton;
    actUpload: TAction;
    dlgUploadFoto: TSavePictureDialog;
    jvfrmstrgShowPhoto: TJvFormStorage;
    procedure actCloseExecute(Sender: TObject);
    procedure actUploadExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmShowFoto: TfrmShowFoto;

implementation

uses
  DataModule, WareHouseNG;

{$R *.dfm}

procedure TfrmShowFoto.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmShowFoto.actUploadExecute(Sender: TObject);
begin
  if dlgUploadFoto.Execute then
  begin
    dbimgFoto.Picture.SaveToFile(dlgUploadFoto.FileName);
  end;
end;

end.

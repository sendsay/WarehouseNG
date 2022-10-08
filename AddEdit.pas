unit AddEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  JvExMask, JvSpin, JvDBSpinEdit, Vcl.Mask, System.Actions, Vcl.ActnList,  GDIPAPI, GDIPOBJ, GDIPUTIL,
  JvDialogs, System.UITypes;

type
  TfrmAddEdit = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    lblIDItem: TLabel;
    dbedtIDItem: TDBEdit;
    lblItem: TLabel;
    dbedtItem: TDBEdit;
    lblQuantity: TLabel;
    jvdbspndtQuantity: TJvDBSpinEdit;
    lblMachine: TLabel;
    dbcbbMachine: TDBComboBox;
    lblNotes: TLabel;
    dbmmoNotes: TDBMemo;
    dbimgFoto: TDBImage;
    lblFoto: TLabel;
    actlstAddEdit: TActionList;
    actSave: TAction;
    actClose: TAction;
    btnBrowse: TButton;
    btnClear: TButton;
    btnCamera: TButton;
    actBrowse: TAction;
    actClear: TAction;
    actCamera: TAction;
    jvpndlgFoto: TJvOpenDialog;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure actSaveExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actBrowseExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAddEdit: TfrmAddEdit;

procedure CompressFoto(FName: string);//compress foto

implementation

uses
  DataModule, Params, WareHouseNG;

{$R *.dfm}

procedure CompressFoto(FName: string);
var
  rPercents : Real;
  iNewWidth, iNewHeight : integer;
  Input: TGPImage;
  Output: TGPBitmap;
  Encoder: TGUID;
  Graphics: TGPGraphics;
begin
    Input := TGPImage.Create(FName);

    if (Input.GetWidth > Input.GetHeight) then
      rPercents := 2048 / Input.GetWidth()
    else
      rPercents := 1536 / Input.GetHeight();

    iNewWidth := Trunc(Input.GetWidth() * rPercents);
    iNewHeight := Trunc(Input.GetHeight() * rPercents);

  try
    // create the output bitmap in desired size
    Output := TGPBitmap.Create(iNewWidth, iNewHeight, PixelFormat24bppRGB);
    try
      // create graphics object for output image
      Graphics := TGPGraphics.Create(Output);
      try
        // set the composition mode to copy
        Graphics.SetCompositingMode(CompositingModeSourceCopy);
        // set high quality rendering modes
        Graphics.SetInterpolationMode(InterpolationModeHighQualityBicubic);
        Graphics.SetPixelOffsetMode(PixelOffsetModeHighQuality);
        Graphics.SetSmoothingMode(SmoothingModeAntiAlias8x8);
        // draw the input image on the output in modified size
        Graphics.DrawImage(Input, 0, 0, Output.GetWidth, Output.GetHeight);
      finally
        Graphics.Free;
        Log(ERROR, 'Graphics', 'TGPGraphics error');
      end;

      // get encoder and encode the output image
      if GetEncoderClsid('image/jpeg', Encoder) <> -1 then
      begin
        Output.Save(FName + '.tmp.jpg', Encoder);
      end
      else
      begin
//        DataModule1.fdqryItems.Cancel;
        raise Exception.Create('Failed to get encoder.');
      end;
    finally
//      DataModule1.fdqryItems.Cancel;
      Output.Free;
      Log(ERROR, 'Graphics', 'Output error');
    end;
  finally
    Input.Free;
  end;
end;

procedure TfrmAddEdit.actBrowseExecute(Sender: TObject);
begin
  if jvpndlgFoto.Execute then
  begin
    CompressFoto(jvpndlgFoto.FileName);
    DataModule1.blbfldItemsPhoto.LoadFromFile(jvpndlgFoto.FileName  + '.tmp.jpg');
    {$IFNDEF DEBUG}
    DeleteFile(jvpndlgFoto.FileName + '.tmp.jpg');
    {$ENDIF}
  end;
end;

procedure TfrmAddEdit.actClearExecute(Sender: TObject);
begin
  if MessageDlg('Are you sure?',  mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    Log(WARN, 'Clear foto', DataModule1.wdstrngfldItemsName_Item.AsString);
    DataModule1.blbfldItemsPhoto.Clear;
  end;
end;

procedure TfrmAddEdit.actCloseExecute(Sender: TObject);
begin
  try
    DataModule1.fdqryItems.Cancel;
  except on E: Exception do
    begin
      Log(ERROR, 'Cancel make record', (E.ClassName + ' > ' + E.Message));
      ShowMessage(E.ClassName + #10#13 + E.Message);
    end;
  end;
  Close;  
end;

procedure TfrmAddEdit.actSaveExecute(Sender: TObject);
begin
  try
    DataModule1.fdqryItems.Post;
    Log(INFO, 'Add record', DataModule1.wdstrngfldItemsName_Item.AsString);

  except on E: Exception do
    begin
      Log(ERROR, 'Post record', (E.ClassName + ' > ' + E.Message));
      ShowMessage(E.ClassName + #10#13 + E.Message);
    end;
  end;
  Close;
end;

procedure TfrmAddEdit.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  actClose.Execute;    
end;

procedure TfrmAddEdit.FormShow(Sender: TObject);
begin
  DataModule1.wdstrngfldItemsMachine.Value := sMachine;
  dbedtItem.SetFocus;
end;

end.

unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TfrmAbout = class(TForm)
    imgLogo: TImage;
    lblVersion: TLabel;
    lblName: TLabel;
    lblProgName: TLabel;
    lblYear: TLabel;
    pnlButtons: TPanel;
    btnClose: TButton;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.dfm}

procedure TfrmAbout.btnCloseClick(Sender: TObject);
begin
  Close;
end;

end.

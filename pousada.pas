unit pousada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects, FireDAC.Phys.MySQLDef, FireDAC.Stan.Intf, FireDAC.Phys,
  FireDAC.Phys.MySQL,global, FireDAC.UI.Intf, FireDAC.FMXUI.Wait,
  FireDAC.Comp.UI, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TFormTelaPrincipal = class(TForm)
    Rectangle1: TRectangle;
    LytInicio: TLayout;
    StyleBook1: TStyleBook;
    MySQLDriver: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FormTelaPrincipal: TFormTelaPrincipal;

implementation

uses
  framelgin;

{$R *.fmx}

procedure TFormTelaPrincipal.FormCreate(Sender: TObject);
begin
  frameLogin:= TFrameLogin.Create(LytInicio);
   Configuracoes.Create(ExtractFilePath(ParamStr(0)));
  Configuracoes.ReadConfigIni;

end;

end.

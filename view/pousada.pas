unit pousada;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Objects;

type
  TFormTelaPrincipal = class(TForm)
    Rectangle1: TRectangle;
    LytInicio: TLayout;
    StyleBook1: TStyleBook;
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
end;

end.

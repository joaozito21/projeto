unit frameCadCategoria;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TFrameCategoriaCad = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout4: TLayout;
    Label3: TLabel;
    EdtNome: TEdit;
    Layout7: TLayout;
    CornerButton1: TCornerButton;
    procedure CornerButton2Click(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     modif:boolean;
     id_cat:integer;
     constructor Create(_AOwner: TComponent;modi:boolean=true;desc:string=' ';id:integer=0);overload;
     procedure  Release;override;
   function pegarDescricao(id:integer):string;
  end;

var
  frameCat:TFrameCategoriaCad;

implementation

uses
  frameCatpes, pousada,global,bancoCategoria, FireDAC.Comp.Client;

{$R *.fmx}

procedure TFrameCategoriaCad.CornerButton1Click(Sender: TObject);
begin

  if not(edtNome.Text.Trim.IsEmpty) then
  begin
    with Tcategoria.Create(self) do
      begin
        if modif then
             MudarCategoria(EdtNome.text,id_cat)
        else
            InserirCategoria(EdtNome.Text);
      end;
       Release;
       frameCatPro:=TFrameCat.Create(FormTelaPrincipal);
  end;

end;

procedure TFrameCategoriaCad.CornerButton2Click(Sender: TObject);
begin
 Release;
  frameCatPro:=TFrameCat.Create(FormTelaPrincipal);
end;

function TFrameCategoriaCad.pegarDescricao(id:integer):string;
var
  qry:TFDQuery;

begin
    Result := ' ';
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('SELECT idCategoria,descricao FROM pousada.categorias where id = :id;');
        ParamByName('id').AsInteger := id;
      end;
      open;
      if RecordCount > 0 then
           Result := FieldByName('descricao').AsString;

      qry.Close;
    end;
    FDConnection.Close;
end;




constructor TFrameCategoriaCad.Create(_AOwner: TComponent ;modi:boolean;desc:string;id:integer);
begin
  inherited Create(Owner);
  Parent := TFmxObject(_AOwner);

  if modi then
  begin
    modif := modi;
    EdtNome.Text := desc;
    id_cat := id;
  end;


end;

procedure TFrameCategoriaCad.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCat := nil;
end;

end.

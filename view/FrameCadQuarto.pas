unit FrameCadQuarto;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TFrameCadQua = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout4: TLayout;
    Label3: TLabel;
    EdNumero: TEdit;
    Layout3: TLayout;
    EdtTipo: TEdit;
    LbValor: TLabel;
    Layout7: TLayout;
    CornerButton1: TCornerButton;
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure EdNumeroKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
     modi : boolean;
      pro_id:integer;
     constructor create(_AOwner:TComponent;id_pro:integer = 0;modif:boolean = false); overload;
    procedure Release;override;
    procedure  pegarInfoQuarto(id:integer);
  end;

  var
      frameCadQuartos:TFrameCadQua;

implementation

uses
  FrameQuarto, pousada,bancoQuarto, FrameInicial, FireDAC.Comp.Client,global;

{$R *.fmx}

procedure TFrameCadQua.CornerButton1Click(Sender: TObject);
begin
      if(not(Ednumero.Text.IsEmpty) and not (Edttipo.Text.IsEmpty)) then
    begin
      with Tquarto.Create(self) do
      begin
        if modi then
            alterar_quarto(EdNumero.Text,Edttipo.Text,
                        pro_id)
        else
          inserir_quarto(EdNumero.Text,Edttipo.Text);
      end;
    end;

    Release;
    frameQuar:=TFrameQuart.Create(FormTelaPrincipal);
end;

procedure TFrameCadQua.CornerButton2Click(Sender: TObject);
begin
  frameQuar:=TFrameQuart.Create(FormTelaPrincipal);
  release;
end;

constructor TFrameCadQua.Create(_AOwner: TComponent;id_pro:integer;modif:boolean);
begin
  inherited Create(Owner);
  Parent := TFmxObject(_AOwner);
    if modif then
  begin
    pegarInfoQuarto(id_pro);
    modi := modif;
    pro_id := id_pro;
  end;
end;


procedure TFrameCadQua.EdNumeroKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  verificarInteger(sender,keychar);
end;

procedure  TFrameCadQua.pegarInfoQuarto(id:integer);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);

   try
      with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('select * from quarto where idquarto = :id');
        ParamByName('id').Asinteger := id;

      end;
      open;

      while not EOF do
      begin
        Ednumero.Text := FieldByName('numero').AsString;
        Edttipo.Text := FieldByName('tipo').Asstring;

        next;
      end;

      qry.Close;
    end;

   finally
     FDConnection.Close;
   end;
end;

procedure TFrameCadQua.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCadQuartos := nil;
end;

end.

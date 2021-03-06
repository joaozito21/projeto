unit frameCadCli;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  TFrameCadastroCli = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout4: TLayout;
    EdtNome: TEdit;
    Layout3: TLayout;
    edtData: TEdit;
    LbValor: TLabel;
    Layout7: TLayout;
    CornerButton1: TCornerButton;
    Layout5: TLayout;
    Layout6: TLayout;
    Label2: TLabel;
    EdtEnd: TEdit;
    Layout8: TLayout;
    Layout9: TLayout;
    Label4: TLabel;
    EdtTel: TEdit;
    Layout11: TLayout;
    Label5: TLabel;
    Edtest: TEdit;
    Layout12: TLayout;
    Layout13: TLayout;
    Label6: TLabel;
    Edtcid: TEdit;
    Layout16: TLayout;
    Label8: TLabel;
    EdtEmail: TEdit;
    LytBr: TLayout;
    lytRb: TLayout;
    RbInaSim: TRadioButton;
    RbinaNao: TRadioButton;
    Label7: TLabel;
    Label3: TLabel;
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure edtDataExit(Sender: TObject);
    procedure EdtTelKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }

     modi : boolean;
     cli_id:integer;
    constructor create(_AOwner:TComponent;id_pro:integer = 0;modif:boolean = false); overload;
    procedure Release;override;
    procedure  pegarInfoCli(id:integer);
  end;
var
  frameCadCliente:TFrameCadastroCli;

implementation

uses
  FrameInicial, pousada,bancocliente, FireDAC.Comp.Client,global, FrameCliente;

{$R *.fmx}


procedure  TFrameCadastroCli.pegarInfoCli(id:integer);
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
        add('select * from cliente where idcliente = :id');
        ParamByName('id').Asinteger := id;

      end;
      open;

      while not EOF do
      begin
        EdtNome.Text := FieldByName('nome').AsString;
        edtData.Text := datetostr(FieldByName('data_nascimento').AsDateTime);
        EdtEnd.Text :=FieldByName('endereco').AsString;
        EdtTel.Text := FieldByName('telefone').AsString;
        Edtest.Text := FieldByName('estado').AsString;
        Edtcid.Text := FieldByName('cidade').AsString;
        EdtEmail.Text := FieldByName('email').AsString;
        if FieldByName('inativarcliente').AsBoolean.ToInteger = 0 then
          RbInaSim.IsChecked := false
        else
          RbinaNao.IsChecked := true;
        next;
      end;

      qry.Close;
    end;

   finally
     FDConnection.Close;
   end;
end;

procedure TFrameCadastroCli.CornerButton2Click(Sender: TObject);
begin
    Release;
    frameClientes:=TFrameCli.create(FormTelaPrincipal);
end;

constructor TFrameCadastroCli.Create(_AOwner: TComponent;id_pro:integer;modif:boolean);
begin
  inherited Create(Owner);
  Parent := TFmxObject(_AOwner);
  rbinanao.ischecked := true;
  if modif = false then
    LytBr.Visible := false;
    if modif then
  begin
    pegarInfoCli(id_pro);
    modi := modif;
    cli_id := id_pro;
  end;
end;

function tbStrIsDate(const S: string): boolean;
begin
  try
    StrToDate(S);
    Result := true;
  except
    Result := false;
  end;
end;

procedure TFrameCadastroCli.edtDataExit(Sender: TObject);
begin
  if(tbStrIsDate(EdTdata.Text)=false) or (EdTdata.Text.IsEmpty)  then
    EdTdata.Text := '__/__/____';
end;

procedure TFrameCadastroCli.EdtTelKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  verificarInteger(sender,keychar);
end;

procedure TFrameCadastroCli.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCadCliente := nil;
end;

procedure TFrameCadastroCli.CornerButton1Click(Sender: TObject);
var
  inat:boolean;
begin
  if(not(EdtNome.Text.IsEmpty) and not (edtData.Text.IsEmpty) and not (EdtEnd.Text.IsEmpty)
    and not (EdtTel.Text.IsEmpty)and not (Edtest.Text.IsEmpty) and not (Edtcid.Text.IsEmpty)
     and not (EdtEmail.Text.IsEmpty)) then
   begin

      if Rbinasim.ischecked then
        inat:=false;
       if Rbinanao.ischecked then
        inat:=true;
      with Tcliente.Create(self) do
      begin
        if modi then
            alterar_cliente(EdtNome.Text,edtData.Text,EdtEnd.Text,EdtTel.Text,
                            Edtcid.Text,Edtest.Text,EdtEmail.Text,
                        cli_id,inat)
        else
          inserir_cliente(EdtNome.Text,edtData.Text,EdtEnd.Text,EdtTel.Text,
                            Edtcid.Text,Edtest.Text,EdtEmail.Text,inat);
      end;
    end;

    Release;
    frameClientes:=TFrameCli.create(FormTelaPrincipal);
end;

end.

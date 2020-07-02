unit frameProd;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.DB, Datasnap.DBClient, FMX.ListView, FMX.Layouts,
  FMX.Controls.Presentation, FMX.Objects, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, FMX.Edit;

type
  TFrameProdutos = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Lvprod: TListView;
    cdProd: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    CornerButton1: TCornerButton;
    Edit1: TEdit;
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure LvprodDblClick(Sender: TObject);
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
       constructor create(_AOwner:TComponent); override;
    procedure Release;
    procedure dados(texto : string = ' ');
  end;
var
  frameProds :TFrameProdutos;
implementation

uses
  FireDAC.Comp.Client,global,frameCadastro, FrameCadProduto, pousada;

{$R *.fmx}

procedure TFrameProdutos.CornerButton1Click(Sender: TObject);
begin
  release;
  FramePro:= TFrameCadastroProduto.Create(FormTelaPrincipal);
end;

procedure TFrameProdutos.CornerButton2Click(Sender: TObject);
begin
  release;

  FrameCad := TFrameCadastros.Create(FormTelaPrincipal);
end;

constructor TFrameProdutos.Create(_AOwner: TComponent);
begin
  inherited;
  Parent := TFmxObject(_AOwner);
  dados;
end;

procedure TFrameProdutos.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameProds := nil;
end;

procedure TFrameProdutos.dados(texto : string = ' ');
var
  qry:TFDQuery;
begin


    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        if texto = ' ' then
            add('select id_produto,descricao from produto')
        else
           add('select id_produto,descricao from produto where descricao like ''%'+ texto+'%''')

      end;
      Open;
      cdprod.EmptyDataSet;
      while not EOF do
      begin
        cdProd.Insert;
        cdProd.FieldByName('desc').AsString := FieldByName('descricao').AsString;
        cdProd.FieldByName('id').AsInteger := FieldByName('id_produto').AsInteger;
        cdProd.Post;
        next;
      end;
      cdProd.Close;
      cdProd.Open;
      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);
end;

procedure TFrameProdutos.Edit1KeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  dados(Edit1.Text);
end;

procedure TFrameProdutos.LvprodDblClick(Sender: TObject);
begin
   if Assigned(Lvprod.Selected) then
   begin

    cdProd.RecNo:=Lvprod.Selected.Index+ 1;
    framePro:=TFrameCadastroProduto.create(parent,cdProd.FieldByName('id').AsInteger,true);
    Release;
   end;
end;

end.

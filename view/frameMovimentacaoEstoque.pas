unit frameMovimentacaoEstoque;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  Data.DB, Datasnap.DBClient, FMX.Edit, FMX.ListView, FMX.Layouts,
  FMX.Controls.Presentation, FMX.Objects, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFrameEsto = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    btnVolta: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    LvEstoque: TListView;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Label5: TLabel;
    Layout3: TLayout;
    Layout4: TLayout;
    Label6: TLabel;
    cdMovimentacao: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    Label7: TLabel;
    CornerButton1: TCornerButton;
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure CornerButton1Click(Sender: TObject);
    procedure LvEstoqueDblClick(Sender: TObject);
    procedure btnVoltaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     constructor Create(_AOwner: TComponent);
     procedure  Release;
     procedure  cancelarMovimentacao;
     procedure pegardados(texto : string = ' ');
  end;

var
   frameMovi: TFrameEsto;

implementation

uses
  FrameEstoquePro, pousada, FireDAC.Comp.Client,global, FrameMensagem,
  FrameInicial;

{$R *.fmx}

procedure TFrameEsto.pegardados(texto : string = ' ');
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
           begin
             add('  select movimentacao_estoque.id_estoque,produto.id_produto,produto.descricao,motivo,data_movimentacao,quantidade  from movimentacao_estoque  ');
	        add( ' inner join produto on movimentacao_estoque.id_produto = produto.id_produto ');
          add( '  where movimentacao_estoque.cancelado = 0')
           end
        else
        begin
         add('  select movimentacao_estoque.id_estoque,produto.id_produto,produto.descricao,motivo,data_movimentacao,quantidade  from movimentacao_estoque  ');
	        add( ' inner join produto on movimentacao_estoque.id_produto = produto.id_produto ');
         add('  where movimentacao_estoque.cancelado = 0 and  produto.descricao  like ''%'+ texto+'%''');


        end;
      end;
      Open;
      cdMovimentacao.EmptyDataSet;
      while not EOF do
      begin
        cdMovimentacao.Insert;
        cdMovimentacao.FieldByName('quantidade').AsString := FieldByName('quantidade').AsFloat.ToString;
        cdMovimentacao.FieldByName('data').AsString := datetostr(FieldByName('data_movimentacao').AsDateTime);
        cdMovimentacao.FieldByName('nome').AsString := FieldByName('descricao').AsString;
        cdMovimentacao.FieldByName('motivo').AsString := FieldByName('motivo').AsString;
        cdMovimentacao.FieldByName('id').AsInteger := FieldByName('id_produto').AsInteger;
        cdMovimentacao.FieldByName('id_estoque').AsInteger := FieldByName('id_estoque').AsInteger;
        cdMovimentacao.Post;
        next;
      end;
      cdMovimentacao.Close;
      cdMovimentacao.Open;
      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);
end;



procedure TFrameEsto.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameMovi := nil;
end;

procedure TFrameEsto.btnVoltaClick(Sender: TObject);
begin
  release;
  FramePri := TFramePrincipal.Create(FormTelaPrincipal) ;
end;

procedure  TFrameEsto.cancelarMovimentacao;
var
  qry:TFDQuery;
begin
    cdMovimentacao.RecNo := LvEstoque.Selected.Index +1;
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update movimentacao_estoque set cancelado = 1 where id_estoque = :id');
        ParamByName('id').AsInteger := cdMovimentacao.FieldByName('id_estoque').AsInteger;
        ExecSQL;
        Clear;
        add('   update produto set estoque = estoque + :quant where id_produto = :id');
          ParamByName('id').AsInteger := cdMovimentacao.FieldByName('id').AsInteger;
          ParamByName('quant').AsFloat :=  StrToFloat(cdMovimentacao.FieldByName('quantidade').AsString);
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;
    pegardados;
end;


procedure TFrameEsto.CornerButton1Click(Sender: TObject);
begin
   Release;
   frameEstPro:=TFrameEstoque.Create(FormTelaPrincipal);
end;

constructor TFrameEsto.Create(_AOwner: TComponent);
begin
  inherited;
  Parent := TFmxObject(_AOwner);
  pegardados;
end;

procedure TFrameEsto.Edit1KeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  pegardados(Edit1.Text);
end;

procedure TFrameEsto.LvEstoqueDblClick(Sender: TObject);
begin
  if assigned(lvestoque.selected) then
  begin
     cdMovimentacao.RecNo := LvEstoque.Selected.Index + 1;
     frameAviso:=TFrameMen.create(FormTelaPrincipal,'Aviso','quer cancelar a baixa de esoque do ' + cdMovimentacao.FieldByName('nome').AsString +
                                                     ' com ' + cdMovimentacao.FieldByName('quantidade').AsString,true);
     frameAviso.onconfirma := cancelarMovimentacao;
  end;
end;

end.

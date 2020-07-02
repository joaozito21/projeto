unit bancoMovimentacaoEstoque;

interface

uses
  System.Classes;
    type
    tmovimentacao=class(tcomponent)
       procedure inserir_movimentacao(id_produto,quantidade,motivo:string);

    end;

implementation

uses
  FireDAC.Comp.Client,global, System.SysUtils;

procedure tmovimentacao.inserir_movimentacao(id_produto,quantidade,motivo:string);
var
  qry:TFDQuery;
  usuario:tusuario;
begin
    qry := TFDQuery.Create(self);
    usuario := TUsuario.GetInstance;
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('insert into movimentacao_estoque(motivo,quantidade,data_movimentacao,id_fun,id_produto) ');
        add('values(:motivo,:quant,date(now()),:id_fun,:id_pro)');
        ParamByName('motivo').AsString := motivo;
        ParamByName('quant').AsFloat :=strtofloat(quantidade);
        ParamByName('id_fun').AsInteger := usuario.id;
        ParamByName('id_pro').AsInteger :=strtoint(id_produto);
        ExecSQL;
        Clear;
        add('update produto set estoque = estoque - :quant where id_produto = :id_pro');
        ParamByName('quant').AsFloat :=strtofloat(quantidade);
        ParamByName('id_pro').AsInteger :=strtoint(id_produto);
        ExecSQL;
      Close;
      end;
    end;
    FDConnection.Close;
end;


end.

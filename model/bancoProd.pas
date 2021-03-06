unit bancoProd;

interface

uses
  System.Classes;

    type

     Tprod =class(TComponent)

       procedure inserir_produto(nome,valor,dat,est:string;cat:Integer);
       procedure alterar_produto(nome,valor,dat,est:string;id,cat:integer);

     end;

implementation

uses
  FireDAC.Comp.Client,global, System.SysUtils;

procedure Tprod.inserir_produto(nome,valor,dat,est:string;cat:Integer);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('insert into produto(descricao,valor,data_val,estoque,idCategoria)values(:desc,:val,:dat,:esto,:cat)');
        ParamByName('desc').AsString := nome;
        ParamByName('val').AsFloat :=strtofloat(valor);
        ParamByName('dat').AsDate := StrToDate(dat);
         ParamByName('esto').AsFloat := est.ToDouble;
         ParamByName('cat').AsInteger := cat;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);

end;

procedure Tprod.alterar_produto(nome,valor,dat,est:string;id,cat:integer);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update produto set descricao = :desc,valor=:val,data_val =:dat,estoque =:esto,idCategoria = :cat    where id_produto = :id');
          ParamByName('id').AsInteger :=id;
        ParamByName('desc').AsString := nome;
        ParamByName('val').AsFloat :=strtofloat(valor);
        ParamByName('dat').AsDate := StrToDate(dat);
         ParamByName('esto').AsFloat := est.ToDouble;
         ParamByName('cat').AsInteger := cat;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);

end;

end.

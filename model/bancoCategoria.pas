unit bancoCategoria;

interface

uses
  System.Generics.Collections, System.Classes,global;
  type
       Tcategoria = class (tcomponent)
            public
            procedure InserirCategoria(desc:string);
            procedure MudarCategoria(desc:string;id:integer);
            function pegarCategoria:TObjectList<tcategoriaPro>;

       end;

implementation

uses
  FireDAC.Comp.Client;

procedure Tcategoria.InserirCategoria(desc:string);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('insert into categorias(descricao) values(:desc)');
        ParamByName('desc').AsString:=desc;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;

end;

procedure Tcategoria.MudarCategoria(desc:string;id:integer);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update categorias set descricao=:desc where idCategoria = :id');
        ParamByName('desc').AsString:=desc;
        ParamByName('id').AsInteger := id;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;

end;




function Tcategoria.pegarCategoria:TObjectList<tcategoriaPro>;
var
  qry:TFDQuery;
  listaCategoria:TObjectList<tcategoriaPro>;
  Categoria:tcategoriaPro;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('SELECT idCategoria,descricao FROM pousada.categorias;');
      end;
      listaCategoria:= TObjectList<tcategoriaPro>.create;
      open;

      while not EOF do
      begin
        Categoria:= tcategoriaPro.create;
         Categoria.descricao := FieldByName('descricao').AsString;
       Categoria.idCategoria :=FieldByName('idCategoria').AsInteger;
        listaCategoria.Add(Categoria);
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
    Result := listaCategoria;
end;

end.

unit bancoCliente;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,global;
  type
  tcliente =class(tcomponent)
      public
         function pegarClienteporId(id:integer):string;
       function pegarClienteporNome(nome:string):integer;
       function pegarClientes :TObjectList<Tclientes>;
       procedure inserir_cliente(nome,dat,ende,tel,
                                cidade,estado,email:string;inativar:boolean);
        procedure alterar_cliente(nome,dat,ende,tel,
                                cidade,estado,email:string;id:integer;inativar:boolean);

  end;

implementation

uses
  FireDAC.Comp.Client;

 function Tcliente.pegarClienteporNome(nome:string):integer;
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('select idCliente from cliente where nome = :nome');
        ParamByName('nome').AsString := nome;
      end;
      open;

      while not EOF do
      begin
         result := FieldByName('idCliente').AsInteger;
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
end;

 function Tcliente.pegarClienteporId(id:integer):string;
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('select nome from cliente where idCliente = :id');
        ParamByName('id').Asinteger := id;
      end;
      open;

      while not EOF do
      begin
         result := FieldByName('nome').AsString;
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
end;


function Tcliente.pegarClientes:TObjectList<Tclientes>;
var
  qry:TFDQuery;
  listaClientes:TObjectList<tclientes>;
  cliente:tclientes;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('select idCliente,nome from cliente');
      end;
      listaClientes:= TObjectList<tclientes>.create;
      open;

      while not EOF do
      begin
        cliente:= tclientes.create;
        cliente.idCliente := FieldByName('idCliente').AsInteger;
        cliente.Nome:=FieldByName('nome').AsString;
        listaClientes.Add(cliente);
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
    Result := listaClientes;
end;

procedure tcliente.inserir_cliente(nome,dat,ende,tel,
                                cidade,estado,email:string;inativar:boolean);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('insert into cliente(nome,data_nascimento,endereco,telefone,cidade,estado,email,inativarCliente)');
        add('values(:nome,:data,:end,:tel,:cid,:est,:email,:ina)');
        ParamByName('nome').AsString := nome;
        ParamByName('data').AsDate := StrToDate(dat);
        ParamByName('end').AsString :=ende;
        ParamByName('tel').AsString := tel;
        ParamByName('cid').AsString := cidade;
        ParamByName('est').AsString := estado;
        ParamByName('email').AsString := email;
        if inativar then
        begin
              ParamByName('ina').AsInteger :=0;
        end
        else
             ParamByName('ina').AsInteger :=1;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;
end;

procedure tcliente.alterar_cliente(nome,dat,ende,tel,
                                cidade,estado,email:string;id:integer;inativar:boolean);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update cliente set nome =:nome,data_nascimento = :data,endereco = :end,telefone = :tel,cidade=:cid,estado =:est,email = :email,inativarCliente=:ina');
        add('  where  idcliente = :id');
          ParamByName('id').Asinteger := id;
        ParamByName('nome').AsString := nome;
        ParamByName('data').AsDate :=StrToDate(dat);
        ParamByName('end').AsString :=ende;
        ParamByName('cid').AsString := cidade;
        ParamByName('tel').AsString := tel;
        ParamByName('est').AsString := estado;
        ParamByName('email').AsString := email;
         if inativar then
              ParamByName('ina').AsInteger :=0
        else
             ParamByName('ina').AsInteger :=1;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;
end;



end.

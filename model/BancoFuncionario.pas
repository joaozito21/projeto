unit BancoFuncionario;

interface

uses
  System.Classes, System.Generics.Collections,global;
type
  Tfuncionario=class(tcomponent)
      public
      function pegarFunc:TObjectList<TFun>;
      procedure inserir_fun(nome,funcao,telefone,data,endereco,
                                    email,cidade,estado:string;inativar:boolean);
      procedure alterarFun(nome,funcao,telefone,data,endereco,
                                    email,cidade,estado:string;inativar:boolean;id:integer);

  end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils;


function Tfuncionario.pegarFunc:TObjectList<TFun>;
var
  qry:TFDQuery;
  listafun:TObjectList<TFun>;
  funcionario:tfun;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('select idFuncionario,nome,funcao from funcionario');
      end;
      listafun:=TObjectList<TFun>.create;
      open;

      while not EOF do
      begin
        funcionario:= Tfun.create;
        funcionario.idFun := FieldByName('idFuncionario').AsInteger;
        funcionario.NomeFun:=FieldByName('nome').AsString;
        funcionario.Funcao := FieldByName('funcao').AsString;
        listafun.Add(funcionario);
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
    Result := listafun;
end;

procedure Tfuncionario.inserir_fun(nome,funcao,telefone,data,endereco,
                                    email,cidade,estado:string;inativar:boolean);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
  with qry.SQL do
      begin
        qry.Connection := FDConnection;
        add('insert into funcionario(nome,dataAdmissao,funcao,telefone,inativarFun,'
                                        + ' data_nascimento,endereco_fun,email_fun,'
                                        + 'cidade_fun,estado_fun)');
        add('values(:nome,now(),:fun,:tel,:ina,:dat,:end,:email,:cid,:est)');
        qry.ParamByName('nome').AsString := nome;
        qry.ParamByName('fun').AsString := funcao;
        qry.ParamByName('tel').AsString :=telefone;
        qry.ParamByName('dat').AsDate   := strtodate(data);
        qry.ParamByName('end').AsString := endereco;
        qry.ParamByName('email').AsString := email;
        qry.ParamByName('cid').AsString := cidade;
        qry.ParamByName('est').AsString := estado;

       if inativar then
        begin
              qry.ParamByName('ina').AsInteger :=0;
        end
        else
             qry.ParamByName('ina').AsInteger :=1;
      end;
      qry.ExecSQL;

      qry.Close;

    FDConnection.Close;
end;

procedure Tfuncionario.alterarFun(nome,funcao,telefone,data,endereco,
                                    email,cidade,estado:string;inativar:boolean;id:integer);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
  with qry.SQL do
      begin
        qry.Connection := FDConnection;
        add('update funcionario set nome = :nome,funcao = :fun,telefone =:tel '+
            ',inativarFun = :ina,data_nascimento = :dat,endereco_fun = :end, ' +
             'email_fun = :email,cidade_fun = :cid,estado_fun= :est');
        add('   where idFuncionario = :id');
        qry.ParamByName('nome').AsString := nome;
        qry.ParamByName('fun').AsString := funcao;
        qry.ParamByName('tel').AsString :=telefone;
        qry.ParamByName('dat').AsDate   := strtodate(data);
        qry.ParamByName('end').AsString := endereco;
        qry.ParamByName('email').AsString := email;
        qry.ParamByName('cid').AsString := cidade;
        qry.ParamByName('est').AsString := estado;
        qry.ParamByName('id').AsInteger :=id;

       if inativar then
        begin
             qry.ParamByName('ina').AsInteger :=0;
        end
        else
             qry.ParamByName('ina').AsInteger :=1;
      end;
      qry.ExecSQL;

      qry.Close;
      FDConnection.Close;
    end;




end.

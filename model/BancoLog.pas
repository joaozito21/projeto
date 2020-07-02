unit BancoLog;

interface

uses
  System.Classes;
type
      tusua=class(tcomponent)
         procedure inserir_login(nickName,senha:string;idFun:integer);
      end;

implementation

uses
  FireDAC.Comp.Client,global;


procedure tusua.inserir_login(nickName,senha:string;idFun:integer);
var
  qry:TFDQuery;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('insert into login(nickname,senha,idFun)values(:ni,:sen,:id)  ');
        ParamByName('ni').AsString := nickName;
        ParamByName('sen').Asstring :=senha;
        ParamByName('id').AsInteger := idFun;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;
end;


end.

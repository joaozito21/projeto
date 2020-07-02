unit BancoReserva;

interface

uses
  System.Classes,System.Generics.Collections,global;
  type
    Treseva = class(tcomponent)
         procedure checkin(id:integer);
         procedure cancelarReserva(id:integer);
         function  pegarReserva(id:integer;dat:string):TObjectList<Treservas>;
         procedure mudanca_Reserva(daa_entrada,data_saida,quantPessoa,numCri,valor:string;idCli,idQuarto,id:integer);
         function pegarReservaTotal(id:integer;dat:string):TObjectList<Treservas>;
         procedure inserir_Reserva(daa_entrada,data_saida,quantPessoa,numCri,valor:string;idCli,idQuarto:integer);
         function PegarQuartosDisponivel(datas:string):TObjectList<Treservas>;
    end;

implementation

uses
  FireDAC.Comp.Client, System.SysUtils;



function Treseva.pegarReservaTotal(id:integer;dat:string):TObjectList<Treservas>;
var
  qry:TFDQuery;
  listaReserva:TObjectList<Treservas>;
  Reserva:Treservas;
  formato:string;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
            formato := '%d  %m  %Y';
         add('select   cliente.nome     as nome_do_cliente,   ' );
         add(' cliente.telefone as telefone_do_cliente ,     ');
         add(' funcionario.nome as  nome_de_funcionario,     ');
         add(' reservas.data_entrada as data_de_entrada ,reservas.idReserva as ids,   ');
         add(' reservas.data_saida   as data_para_saida,reservas.idReserva,reservas.numero_adul,reservas.numero_cri, ');
         add(' (( reservas.numero_adul  * (reservas.valor_diaria    *  datediff( reservas.data_saida,reservas.data_entrada)) )  +     ');
         add( ' ( reservas.numero_cri  * (reservas.valor_diaria    *  datediff( reservas.data_saida,reservas.data_entrada)) ))  as ''valor_da_diaria '' ');
         add('   from reservas     ');
         add(' inner join cliente on reservas.idCliente =cliente.idcliente  ');
         add(' inner join  login on reservas.idFuncionario = login.idlogin    ');
         add(' inner join funcionario on funcionario.idFuncionario = login.idFun  ');

        add(' where (IdQuarto = :id) and   ');
        Add('(:dat between date_format(data_entrada,:for) and    date_format(data_saida,:for))');
        ParamByName('dat').AsString := dat;
        ParamByName('for').AsString := formato;
        ParamByName('id').AsInteger := id;
      end;
      listaReserva:= TObjectList<Treservas>.create;
      open;

      while not EOF do
      begin
        Reserva:= Treservas.create;

        Reserva.IdReserva     := FieldByName('ids').AsInteger;
        Reserva.DataEntrada    :=datetostr( fieldbyname('data_de_entrada').AsDateTime);
        Reserva.DataSaida      := datetostr(fieldbyname('data_para_saida').AsDateTime);
        Reserva.numeroAdult    := fieldbyname('numero_adul').AsInteger;
        Reserva.NumeroCri      := fieldbyname('numero_cri').AsInteger;
        Reserva.nomeFunc  := FieldByName('nome_de_funcionario').AsString;
        Reserva.nomeCli      := FieldByName('nome_do_cliente').AsString;
        Reserva.valorDiaria    := FieldByName('valor_da_diaria ').AsFloat.ToString();
        Reserva.tel         := FieldByName('telefone_do_cliente').AsString;
        listaReserva.Add( Reserva);
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
    Result := listaReserva;
end;


function Treseva.pegarReserva(id:integer;dat:string):TObjectList<Treservas>;
var
  qry:TFDQuery;
  listaReserva:TObjectList<Treservas>;
  Reserva:Treservas;
  formato:string;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin

            formato := '%d  %m  %Y';
        add('select * from reservas where (IdQuarto = :id) and   ');
        Add('(:dat between date_format(data_entrada,:for) and    date_format(data_saida,:for))');
        ParamByName('dat').AsString := dat;
        ParamByName('for').AsString := formato;
        ParamByName('id').AsInteger := id;
      end;
      listaReserva:= TObjectList<Treservas>.create;
      open;

      while not EOF do
      begin
        Reserva:= Treservas.create;
        Reserva.IdReserva      := fieldbyname('idReserva').AsInteger;
        Reserva.status         := FieldByName('status').AsInteger;
        Reserva.DataEntrada    :=datetostr( fieldbyname('data_entrada').AsDateTime);
        Reserva.DataSaida      := datetostr(fieldbyname('data_saida').AsDateTime);
        Reserva.numeroAdult    := fieldbyname('numero_adul').AsInteger;
        Reserva.NumeroCri      := fieldbyname('numero_cri').AsInteger;
        Reserva.Idfuncionario  := FieldByName('idFuncionario').AsInteger;
        Reserva.Idcliente      := FieldByName('idCliente').AsInteger;
        Reserva.valorDiaria    := FieldByName('valor_diaria').AsFloat.ToString();

        listaReserva.Add( Reserva);
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
    Result := listaReserva;
end;


procedure Treseva.mudanca_Reserva(daa_entrada,data_saida,quantPessoa,numCri,valor:string;idCli,idQuarto,id:integer);
var
  qry:TFDQuery;
  usuario:TUsuario;
begin
    qry := TFDQuery.Create(self);
    usuario:=TUsuario.GetInstance;
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update  reservas set data_entrada=:dat_ent,data_saida=:data_sai ');
        add(' ,numero_adul=:numPess,numero_cri=:numCri,idFuncionario=:idFun,idCliente=:idCli,idQuarto =:idQuar,valor_diaria =:di where idReserva - :id ');

        ParamByName('dat_ent').AsDate := StrToDate(daa_entrada);
        ParamByName('data_sai').AsDate :=StrToDate(data_saida);;
        ParamByName('numPess').AsInteger := strtoint(quantPessoa);
        ParamByName('idFun').AsInteger :=usuario.id;
        ParamByName('idCli').AsInteger := idCli;
        ParamByName('idQuar').AsInteger :=idQuarto;
        ParamByName('numCri').AsInteger := strtoint(numCri);
        ParamByName('di').AsFloat := StrToFloat(valor.Replace(',','.')) ;
        ParamByName('id').AsInteger  := id;
      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;

end;

procedure Treseva.checkin(id:integer);
var
  qry:TFDQuery;
  usuario:TUsuario;
begin
    qry := TFDQuery.Create(self);
    usuario:=TUsuario.GetInstance;
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update reservas set status = 2 where idReserva = :id ');
        ParamByName('id').AsInteger := id;



      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;

end;


procedure Treseva.cancelarReserva(id:integer);
var
  qry:TFDQuery;
  usuario:TUsuario;
begin
    qry := TFDQuery.Create(self);
    usuario:=TUsuario.GetInstance;
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('update reservas set cancelar_reserva = 1 where idReserva = :id ');
        ParamByName('id').AsInteger := id;



      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;

end;

procedure Treseva.inserir_Reserva(daa_entrada,data_saida,quantPessoa,numCri,valor:string;idCli,idQuarto:integer);
var
  qry:TFDQuery;
  usuario:TUsuario;
begin
    qry := TFDQuery.Create(self);
    usuario:=TUsuario.GetInstance;
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('insert into reservas(data_entrada,data_saida,numero_adul,numero_cri,idFuncionario,idCliente,idQuarto,status,valor_diaria) ');
        add('values(:dat_ent,:data_sai,:numPess,:numCri,:idFun,:idCli,:idQuar,1,:di)');
        ParamByName('dat_ent').AsDate := StrToDate(daa_entrada);
        ParamByName('data_sai').AsDate :=StrToDate(data_saida);;
        ParamByName('numPess').AsInteger := strtoint(quantPessoa);
        ParamByName('idFun').AsInteger :=usuario.id;
        ParamByName('idCli').AsInteger := idCli;
        ParamByName('idQuar').AsInteger :=idQuarto;
        ParamByName('numCri').AsInteger := strtoint(numCri);
        ParamByName('di').AsFloat := StrToFloat(valor.Replace(',','.')) ;

      end;
      ExecSQL;

      qry.Close;
    end;
    FDConnection.Close;

end;


function Treseva.PegarQuartosDisponivel(datas:string):TObjectList<Treservas>;
var
  qry:TFDQuery;
  reserva:treservas;
  listReserva:TObjectList<Treservas>;
  formato:string;
begin
    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        formato := '%d-%m-%Y';
        add('   select  quarto.numero  from reservas '+
         '   inner join quarto on reservas.IdQuarto = quarto.idquarto '   +
         '   where :dat between date(data_entrada) and   '+
         '   date(data_saida) and   cancelar_reserva = 0');
        ParamByName('dat').AsDate := strtodate(datas);

      end;
      listReserva:= TObjectList<TReservas>.create;
      open;

      while not EOF do
      begin
        reserva := TReservas.Create;
        reserva.NumeroQuarto := FieldByName('numero').AsInteger;
        listReserva.Add(reserva);
        next;
      end;

      qry.Close;
    end;
    FDConnection.Close;
    Result := listReserva;
end;

end.

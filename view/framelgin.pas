unit framelgin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.Layouts, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,fireDAC.DApt;

type
  TFrameLogin = class(TFrame)
    RectPrinc: TRectangle;
    LytLogin: TLayout;
    Layout2: TLayout;
    Layout3: TLayout;
    Label1: TLabel;
    Edit1: TEdit;
    Layout4: TLayout;
    Layout5: TLayout;
    Label2: TLabel;
    Edit2: TEdit;
    RecTop: TRectangle;
    Label3: TLabel;
    BtnCorfirma: TCornerButton;
    Layout1: TLayout;
    MySQLDriver: TFDPhysMySQLDriverLink;
    FDConnection1: TFDConnection;
    CornerButton1: TCornerButton;
    CornerButton2: TCornerButton;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCorfirmaClick(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(_AOwner:TComponent); override;
    function CorfirmaLogin(NickName,senha:string):boolean;
    procedure Release;
    function SenhaNumero:boolean;
  end;
var
  frameLogin:TFrameLogin;
implementation

uses
  FrameInicial, pousada,global, frameConfiguracao, FrameCadLo, FrameMensagem;

{$R *.fmx}


function TFrameLogin.SenhaNumero:boolean;
var
  qry:TFDQuery;
  text:string;
  usuario:tusuario;
  qtd:integer;
begin
    result := false;


    if  FDConnection.Connected then
      text:='sim';

    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('SELECT count(idlogin) FROM  login');
        Open;
        qtd := RecordCount;
        if (qtd-1) >0 then
        begin
          result := true;
        end;


      end;
      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);
end;

function TFrameLogin.CorfirmaLogin(NickName,senha:string):boolean;
var
  qry:TFDQuery;
  text:string;
  usuario:tusuario;
begin
    result := false;


    if  FDConnection.Connected then
      text:='sim';

    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('SELECT idlogin,Nickname,senha,funcao  FROM login inner join funcionario on login.idFun = funcionario.idFuncionario where Nickname = :nick and senha = :sen');
        ParamByName('nick').AsString := NickName;
        ParamByName('sen').AsString := senha;
      end;
      Open;
      if RecordCount > 0 then
      begin
        Usuario        := TUsuario.GetInstance;
        Usuario.id     := FieldByName('idlogin').AsInteger;
        Usuario.nome   := FieldByName('Nickname').AsString;
        Usuario.funcao :=  FieldByName('funcao').AsString;
        Result := true;
      end;
      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);
end;

procedure TFrameLogin.CornerButton1Click(Sender: TObject);
begin
    frameconfig := TFrameconf.create(frameLogin);
end;

procedure TFrameLogin.CornerButton2Click(Sender: TObject);
begin
 Configuracoes.servidor(true);
  Release;
  frameCadLogin:= TFrameCadLog.Create(FormTelaPrincipal)
end;

procedure TFrameLogin.BtnCorfirmaClick(Sender: TObject);
var
  verificar:boolean;
  Usuario:TUsuario;
begin
  Configuracoes.servidor(true);
  if(CorfirmaLogin(Edit1.Text,Edit2.Text))or ((Edit1.Text.ToUpper ='ADMIN')and (Edit2.Text.ToUpper='ADMIN')) then
  begin
     Usuario := TUsuario.GetInstance;


    if((Edit1.Text.ToUpper ='ADMIN')and (Edit2.Text.ToUpper='ADMIN'))then
    begin
    if senhanumero then
    begin
      frameAviso:=TFrameMen.create(self,'Aviso','N�o pode usar o usuario e senha');
      exit;
    end;
     release;
     Usuario        := TUsuario.GetInstance;
        Usuario.id     := 99;
        Usuario.nome   := 'ADMIN';
        Usuario.funcao := 'administrador';
    end;
    FramePri := TFramePrincipal.create(FormTelaPrincipal);
  end
  else
    begin
      frameAviso:=TFrameMen.create(FormTelaPrincipal,'Aviso','o usuario e senha errados');
      exit;
    end;



end;

procedure TFrameLogin.BtnFecharClick(Sender: TObject);
begin
  self.Release;
end;

constructor TFrameLogin.Create(_AOwner: TComponent);
begin
  inherited;
  Parent := TFmxObject(_AOwner);
end;

procedure TFrameLogin.Label4Click(Sender: TObject);
begin;
end;

procedure TFrameLogin.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameLogin := nil;
end;




end.

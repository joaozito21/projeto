unit FrameCadLo;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FMX.ListBox, System.Generics.Collections,global;

type
  TFrameCadLog = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    Layout4: TLayout;
    Label3: TLabel;
    EdtNick: TEdit;
    Layout3: TLayout;
    EdtSen: TEdit;
    LbValor: TLabel;
    Layout5: TLayout;
    Lbestoque: TLabel;
    Layout7: TLayout;
    CornerButton1: TCornerButton;
    cmbFun: TComboBox;
    procedure CornerButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    list:TObjectList<Tfun>;
    constructor Create(_AOwner: TComponent);
    procedure Release;
  end;

  var
    frameCadLogin: TFrameCadLog;

implementation

uses
  bancoCliente, BancoFuncionario, BancoLog, framelgin, pousada, FrameMensagem;

{$R *.fmx}

procedure TFrameCadLog.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCadLogin := nil;
end;

procedure TFrameCadLog.CornerButton1Click(Sender: TObject);
var
  fun:tfun;
  nome:string;
  id :integer;
begin
    nome:= cmbFun.Items[cmbFun.ItemIndex];
    if (not(EdtNick.Text.Trim.IsEmpty) and(not(EdtSen.Text.Trim.IsEmpty)) and (nome <> 'SELECIONE UM FUNCIONARIO')) then
    begin

     for fun in list do
     begin
       if nome = fun.NomeFun then
              id:=fun.idFun;
     end;
     with tusua.create(self) do
      inserir_login(EdtNick.Text,EdtSen.Text,id);
      Release;
       frameLogin:= TFrameLogin.Create(FormTelaPrincipal.LytInicio);

    end
    else
        frameAviso:=TFrameMen.create(frameCadLogin,'Aviso','CAMPOS PRECISA SER PREENCHIDOS');
end;

constructor TFrameCadLog.Create(_AOwner: TComponent);
var
  lista:tobjectlist<tfun>;
  CLI:Tfun;
begin
  inherited;
  Parent := TFmxObject(_AOwner);

  cmbFun.Items.Add('SELECIONE UM FUNCIONARIO');

  with tfuncionario.Create(self) do
  begin
       lista := pegarFunc;
  end;

  for CLI in lista do
  begin
      cmbFun.Items.Add(CLI.NomeFun);
  end;
  list:=lista;
  cmbFun.ItemIndex:=0;

end;

end.

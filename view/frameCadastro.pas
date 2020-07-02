unit frameCadastro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FrameCadProduto;

type
  TFrameCadastros = class(TFrame)
    RecTotal: TRectangle;
    Rectop: TRectangle;
    Label1: TLabel;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Layout2: TLayout;
    btnPro: TCornerButton;
    CornerButton2: TCornerButton;
    btnQuarto: TCornerButton;
    btnCli: TCornerButton;
    btnFun: TCornerButton;
    CornerButton1: TCornerButton;
    procedure btnProClick(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure btnCliClick(Sender: TObject);
    procedure btnQuartoClick(Sender: TObject);
    procedure btnFunClick(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor create(_AOwner:TComponent); override;
    procedure Release;

  end;

var
  frameCad:TFrameCadastros;

implementation

uses
  pousada, frameProd, FrameInicial, FrameQuarto,global,FrameCliente,
  FrameMensagem, frameFuncio, frameCatpes;

{$R *.fmx}

procedure TFrameCadastros.btnCliClick(Sender: TObject);
begin
  frameClientes := TFrameCli.Create(FormTelaPrincipal);
  Release;
end;

procedure TFrameCadastros.btnProClick(Sender: TObject);
var
  usu:tusuario;
begin
  usu := tusuario.GetInstance;
  if (usu.funcao.ToUpper = 'ADMINISTRADOR') OR (usu.funcao.ToUpper = 'GERENTE') then
  BEGIN
    Release;
    frameprods := TFrameProdutos.Create(FormTelaPrincipal);
  END
  else
  begin
    frameAviso := TFrameMen.Create(frameCad,'Aviso','esse login não tem acesso para criar produto');
    exit;
  end;
end;

procedure TFrameCadastros.btnQuartoClick(Sender: TObject);
begin
   FrameQuar := TFrameQuart.Create(FormTelaPrincipal);
  Release;
end;

procedure TFrameCadastros.btnFunClick(Sender: TObject);
begin
  framefun := TFrameFuncionario.Create(FormTelaPrincipal);
  Release;
end;

procedure TFrameCadastros.CornerButton1Click(Sender: TObject);
begin
  frameCatPro := TFrameCat.Create(FormTelaPrincipal);
  Release;
end;

procedure TFrameCadastros.CornerButton2Click(Sender: TObject);
begin
  Release;
  framePri := TFramePrincipal.Create(FormTelaPrincipal);
end;

constructor TFrameCadastros.Create(_AOwner: TComponent);
var
  usuario:tusuario;
begin
  inherited;
  Parent := TFmxObject(_AOwner);
  usuario := TUsuario.GetInstance;
  if (usuario.funcao.ToUpper = 'GERENTE') or (usuario.funcao.ToUpper = 'ADMINISTRADOR') then
    btnFun.Visible:= true;

end;

procedure TFrameCadastros.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCad := nil;
end;


end.

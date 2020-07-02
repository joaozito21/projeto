program pousada_recanto;

uses
  System.StartUpCopy,
  FMX.Forms,
  pousada in 'pousada.pas' {FormTelaPrincipal},
  FrameInicial in 'view\FrameInicial.pas' {FramePrincipal: TFrame},
  framelgin in 'view\framelgin.pas' {FrameLogin: TFrame},
  global in 'controll\global.pas',
  frameCadastro in 'view\frameCadastro.pas' {FrameCadastros: TFrame},
  FrameCadProduto in 'view\FrameCadProduto.pas' {FrameCadastroProduto: TFrame},
  bancoProd in 'model\bancoProd.pas',
  frameProd in 'view\frameProd.pas' {FrameProdutos: TFrame},
  FrameQuarto in 'view\FrameQuarto.pas' {FrameQuart: TFrame},
  FrameCadQuarto in 'view\FrameCadQuarto.pas' {FrameCadQua: TFrame},
  bancoQuarto in 'model\bancoQuarto.pas',
  FrameCliente in 'view\FrameCliente.pas' {FrameCli: TFrame},
  frameCadCli in 'view\frameCadCli.pas' {FrameCadastroCli: TFrame},
  bancoCliente in 'model\bancoCliente.pas',
  FrameMensagem in 'view\FrameMensagem.pas' {FrameMen: TFrame},
  FrameEstoquePro in 'view\FrameEstoquePro.pas' {FrameEstoque: TFrame},
  frameMovimentacaoEstoque in 'view\frameMovimentacaoEstoque.pas' {FrameEsto: TFrame},
  frameMoviCadastro in 'view\frameMoviCadastro.pas' {FrameCadMoviEstoque: TFrame},
  bancoMovimentacaoEstoque in 'model\bancoMovimentacaoEstoque.pas',
  frameConfiguracao in 'view\frameConfiguracao.pas' {Frameconf: TFrame},
  frameFuncio in 'view\frameFuncio.pas' {FrameFuncionario: TFrame},
  FrameCadastroFun in 'view\FrameCadastroFun.pas' {FrameCadFunc: TFrame},
  BancoFuncionario in 'model\BancoFuncionario.pas',
  FrameQuartoControle in 'view\FrameQuartoControle.pas' {FrameControleQuarto: TFrame},
  BancoReserva in 'model\BancoReserva.pas',
  FrameReservaCad in 'view\FrameReservaCad.pas' {FrameCadReserva: TFrame},
  FrameCadLo in 'view\FrameCadLo.pas' {FrameCadLog: TFrame},
  BancoLog in 'model\BancoLog.pas',
  frameCatpes in 'view\frameCatpes.pas' {FrameCat: TFrame},
  FrameMeni in 'view\FrameMeni.pas' {FrameMenuRes: TFrame},
  frameCheckin in 'view\frameCheckin.pas' {FramedeCheckin: TFrame},
  bancoCategoria in 'model\bancoCategoria.pas',
  frameCadCategoria in 'view\frameCadCategoria.pas' {FrameCategoriaCad: TFrame},
  frameCheckConf in 'view\frameCheckConf.pas' {FrameCheck: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormTelaPrincipal, FormTelaPrincipal);
  Application.Run;
end.

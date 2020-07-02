unit FrameMeni;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Controls.Presentation, FMX.Ani, FMX.Layouts;

type
  TFrameMenuRes = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    Layout2: TLayout;
    CornerButton1: TCornerButton;
    CornerButton2: TCornerButton;
    Rectangle3: TRectangle;
    Label1: TLabel;
    Layout3: TLayout;
    CornerButton3: TCornerButton;
    Layout4: TLayout;
    CornerButton4: TCornerButton;
    procedure CornerButton3Click(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure CornerButton1Click(Sender: TObject);
    procedure CornerButton4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     ids :integer;
     id_res:integer;
     tex:string;
     numero:integer;
     stat :integer;
     procedure verificar;
     procedure canc;
      constructor create(_AOwner:TComponent;id:integer;dat:string='');overload;
    procedure Release;override;
  end;

  var
    frameMenu:TFrameMenuRes;

implementation

uses
  FrameReservaCad,global ,FrameQuartoControle, pousada, frameCheckConf,
  BancoReserva, System.Generics.Collections, FrameMensagem;

{$R *.fmx}

procedure TFrameMenuRes.CornerButton1Click(Sender: TObject);
begin
  if stat = 1 then
     formCheckConf :=TFrameCheck.create(frameMenu,id_res,true,tex)
  else
    ShowMessage('a fazer');
end;

procedure TFrameMenuRes.CornerButton2Click(Sender: TObject);
begin
  FrameCadReser:=TFrameCadReserva.create(FormTelaPrincipal,id_res,true,tex);
end;

procedure TFrameMenuRes.CornerButton3Click(Sender: TObject);
begin
  self.Release;
end;

procedure TFrameMenuRes.canc;
begin
    with Treseva.Create(self) do
       cancelarReserva(ids);

    self.Release;
end;

procedure TFrameMenuRes.CornerButton4Click(Sender: TObject);
begin
    frameAviso:=TFrameMen.create(self,'AVISO ','Tem certeza que gostaria de cancelar',true);
    frameAviso.onconfirma := canc;
 end;

procedure TFrameMenuRes.verificar;
var
   lista:tobjectlist<treservas>;

begin
      with Treseva.create(self) do
       lista := pegarReserva(id_res,tex);
   if lista.Count > 0 then
   begin
      ids := lista.Items[0].IdReserva;
      stat:=  lista.Items[0].status;
      numero := lista.Items[0].NumeroQuarto;
   end
   else
   begin
     ids :=1;
     stat:=1;
   end;
   if stat  = 2 then
      CornerButton1.Text := 'checkout';

end;

constructor TFrameMenuRes.Create(_AOwner: TComponent;id:integer;dat:string='');
var
   lista:tobjectlist<treservas>;
begin
  inherited create(Owner);
  Parent := TFmxObject(_AOwner);
  id_res := id;
   tex:=dat;
   verificar;
end;

procedure TFrameMenuRes.Release;
begin
  Name := '';


  inherited;

  frameMenu := nil;
end;

end.

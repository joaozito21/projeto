unit FrameMensagem;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Controls.Presentation, FMX.Objects;

type
  Tconfirma = procedure of object;
  TFrameMen = class(TFrame)
    RecTop: TRectangle;
    lbTop: TLabel;
    RectPrinc: TRectangle;
    LytLogin: TLayout;
    Layout4: TLayout;
    Layout1: TLayout;
    LbMensagem: TLabel;
    CornerButton1: TCornerButton;
    btnCon: TCornerButton;
    procedure CornerButton1Click(Sender: TObject);
    procedure btnConClick(Sender: TObject);
  private
    { Private declarations }
    Fconfirma   :Tconfirma;

  public
    { Public declarations }
     property onconfirma: Tconfirma read Fconfirma write Fconfirma;
    constructor create(_AOwner:TComponent;mentop,mensagem:string;but:boolean = false);overload;
     procedure Release;override;
  end;

var
  frameAviso:TFrameMen;

implementation


{$R *.fmx}

procedure TFrameMen.CornerButton1Click(Sender: TObject);
begin
  self.Release;
end;

procedure TFrameMen.btnConClick(Sender: TObject);
begin
  onconfirma;
  release;
end;

constructor TFrameMen.Create(_AOwner: TComponent;mentop,mensagem:string;but:boolean);
begin
  if not assigned(frameAviso) then
  begin
    inherited create(_AOwner);
    Parent := TFmxObject(_AOwner);
    lbTop.Text := mentop;
    LbMensagem.Text := mensagem;
    if but then
       btnCon.Visible := true;
  end;
end;

procedure TFrameMen.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameAviso := nil;
end;


end.

unit FrameQuartoControle;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Layouts, FMX.Edit, FMX.Controls.Presentation, FMX.Objects, System.Classes,
  FMX.DateTimeCtrls;

type
  TFrameControleQuarto = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label2: TLabel;
    flwQuartos: TFlowLayout;
    DateEdt: TDateEdit;
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure CornerButton2Click(Sender: TObject);
    procedure DateEdtKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure DateEdtChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure CadReser(sender:tobject);
    constructor create(_AOwner:TComponent); override;
    procedure Release;
  end;

var
  FrameControl: TFrameControleQuarto;

implementation

uses
  bancoQuarto, System.Generics.Collections, global, BancoReserva, FrameInicial,
  pousada, FrameReservaCad, FrameMensagem, FrameMeni;

{$R *.fmx}


procedure TFrameControleQuarto.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  FrameControl := nil;
end;


procedure TFrameControleQuarto.CornerButton2Click(Sender: TObject);
begin
  Release;
  framePri := TFramePrincipal.Create(FormTelaPrincipal);
end;

constructor TFrameControleQuarto.Create(_AOwner: TComponent);

begin
  inherited;
  Parent := TFmxObject(_AOwner);
  DateEdt.Date := Now();
end;

procedure TFrameControleQuarto.DateEdtChange(Sender: TObject);
var
  listaQuarto,quartodis:TObjectList<Tquartos>;
  listaReservasQuarto:TObjectList<Treservas>;
  I,J:integer;
  quarto:TButton;
  texto :TLabel;
begin
     quartodis:= TObjectList<tquartos>.create;
       listaQuarto:= TObjectList<tquartos>.create;
       with tquarto.Create(self) do
         listaQuarto :=pegarQuartos;
       with Treseva.Create(self) do
           listaReservasQuarto:= PegarQuartosDisponivel(DateEdt.Text);
       if listaReservasQuarto.Count > 0 then
       BEGIN
       for I := 0 to listaReservasQuarto.Count -1 do
         begin
           for J := 0 to listaQuarto.Count-1 do
             begin
                 if listaQuarto[J].numero = listaReservasQuarto[I].NumeroQuarto then
                    listaQuarto[J].status := 'OCUPADO';

             end;
         end;
       END;
      flwQuartos.Controls.Clear;
      flwQuartos.DestroyComponents;

       for I := 0 to listaQuarto.Count -1 do
       begin


            quarto:= TButton.Create(Owner);
            quarto.Parent :=flwQuartos;
            quarto.Tag :=listaQuarto[I].idQuarto;

            quarto.Width := 100;
            quarto.Height := 120;
            quarto.onclick := cadreser;
            quarto.Margins.Left := 10;
            if listaQuarto[I].status = 'OCUPADO' then
            begin
              quarto.TagString :=  'OCUPADO';
              quarto.StyleLookup := 'btnAberta';

              quarto.TextSettings.HorzAlign:= TTextAlign.Leading;
            end
            else
            begin
                quarto.StyleLookup := 'btnPorta';
                quarto.TagString :=  'DISPONIVEL';
            end;
            quarto.Text := listaQuarto[I].numero.ToString;
       end;


end;



procedure TFrameControleQuarto.DateEdtKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  listaQuarto,quartodis:TObjectList<Tquartos>;
  listaReservasQuarto:TObjectList<Treservas>;
  I,J:integer;
  quarto:TButton;
  texto :TLabel;
begin


       quartodis:= TObjectList<tquartos>.create;
       listaQuarto:= TObjectList<tquartos>.create;
       with tquarto.Create(self) do
         listaQuarto :=pegarQuartos;
       with Treseva.Create(self) do
           listaReservasQuarto:= PegarQuartosDisponivel(DateEdt.Text);
       if listaReservasQuarto.Count > 0 then
       BEGIN
       for I := 0 to listaReservasQuarto.Count -1 do
         begin
           for J := 0 to listaQuarto.Count-1 do
             begin
                 if listaQuarto[J].numero = listaReservasQuarto[I].NumeroQuarto then
                    listaQuarto[J].status := 'OCUPADO';

             end;
         end;
       END;
      flwQuartos.Controls.Clear;
      flwQuartos.DestroyComponents;

       for I := 0 to listaQuarto.Count -1 do
       begin


            quarto:= TButton.Create(Owner);
            quarto.Parent :=flwQuartos;
            quarto.Tag :=listaQuarto[I].idQuarto;
            quarto.Width := 100;
            quarto.Height := 60;
            quarto.onclick := cadreser;
            quarto.Margins.Left := 10;
            if listaQuarto[I].status = 'OCUPADO' then
            begin
              quarto.TagString :=  'OCUPADO';
              quarto.StyleLookup := 'btnAberta';
              quarto.TextSettings.HorzAlign:= TTextAlign.Leading;
            end
            else
            begin
                quarto.StyleLookup := 'btnPorta';
                quarto.TagString :=  'DISPONIVEL';
            end;
            quarto.Text := listaQuarto[I].numero.ToString;
       end;

end;


procedure TFrameControleQuarto.CadReser(sender:tobject);
var
  id:integer;
begin
  if (sender as TButton).TagString = 'DISPONIVEL' then
  begin
    id := (sender as TButton).Tag;
    release;
    FrameCadReser:=TFrameCadReserva.create(FormTelaPrincipal,id,false,DateEdt.Text);

  end
  else
  begin
    id := (sender as TButton).Tag;

    frameMenu :=   TFrameMenuRes.create(FormTelaPrincipal,id,DateEdt.Text);

  end;
end;

procedure TFrameControleQuarto.Edit1KeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
var
  listaQuarto,quartodis:TObjectList<Tquartos>;
  listaReservasQuarto:TObjectList<Treservas>;
  I,J:integer;
  quarto:TButton;
  texto :TLabel;
begin
    if Key = vkReturn then
    begin

       quartodis:= TObjectList<tquartos>.create;
       listaQuarto:= TObjectList<tquartos>.create;
       with tquarto.Create(self) do
         listaQuarto :=pegarQuartos;
       with Treseva.Create(self) do
           listaReservasQuarto:= PegarQuartosDisponivel(DateEdt.Text);
       if listaReservasQuarto.Count > 0 then
       BEGIN
       for I := 0 to listaReservasQuarto.Count -1 do
         begin
           for J := 0 to listaQuarto.Count-1 do
             begin
                 if listaQuarto[J].numero = listaReservasQuarto[I].NumeroQuarto then
                    listaQuarto[J].status := 'OCUPADO';

             end;
         end;
       END;
      flwQuartos.Controls.Clear;
      flwQuartos.DestroyComponents;

       for I := 0 to listaQuarto.Count -1 do
       begin


            quarto:= TButton.Create(Owner);
            quarto.Parent :=flwQuartos;
            quarto.Tag :=listaQuarto[I].idQuarto;
            quarto.Width := 100;
            quarto.Height := 60;
            quarto.onclick := cadreser;
            quarto.Margins.Left := 10;
            if listaQuarto[I].status = 'OCUPADO' then
            begin
              quarto.TagString :=  'OCUPADO';
              quarto.StyleLookup := 'btnAberta';
              quarto.TextSettings.HorzAlign:= TTextAlign.Leading;
            end
            else
            begin
                quarto.StyleLookup := 'btnPorta';
                quarto.TagString :=  'DISPONIVEL';
            end;
            quarto.Text := listaQuarto[I].numero.ToString;
       end;

    end;
end;

end.

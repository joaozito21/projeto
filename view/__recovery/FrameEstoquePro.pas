unit FrameEstoquePro;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.Edit, FMX.ListView, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects,
  Data.DB, Datasnap.DBClient, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.EngExt, Fmx.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope;

type
  TFrameEstoque = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    btnVolta: TCornerButton;
    RecTotal: TRectangle;
    Layout1: TLayout;
    Rectangle1: TRectangle;
    LvEstoque: TListView;
    Layout2: TLayout;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    cdEstoquePro: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    Layout3: TLayout;
    Layout4: TLayout;
    Label5: TLabel;
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure btnVoltaClick(Sender: TObject);
    procedure LvEstoqueDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(_AOwner: TComponent);
     procedure  Release;


 procedure dadosEstoque(texto : string = ' ');
  end;

var
  frameEstPro:TFrameEstoque;

implementation

uses
  FireDAC.Comp.Client,global, FrameInicial, pousada, frameMovimentacaoEstoque,
  frameMoviCadastro;

{$R *.fmx}


procedure TFrameEstoque.btnVoltaClick(Sender: TObject);
begin
 Release;
 frameMovi := TFrameEsto.Create(FormTelaPrincipal);
end;




constructor TFrameEstoque.Create(_AOwner: TComponent);
begin
  inherited;
  Parent := TFmxObject(_AOwner);
  dadosEstoque;
end;


 procedure TFrameEstoque.dadosEstoque(texto : string = ' ');
var
  qry:TFDQuery;
begin


    qry := TFDQuery.Create(self);
    with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        if texto = ' ' then
            add('select id_produto,descricao,estoque from produto')
        else
           add('select id_produto,descricao,estoque from produto where descricao like ''%'+ texto+'%''')

      end;
      Open;
      cdEstoquePro.EmptyDataSet;
      while not EOF do
      begin
        cdEstoquePro.Insert;
        cdEstoquePro.FieldByName('estoque').AsString := FieldByName('estoque').AsFloat.ToString;
        cdEstoquePro.FieldByName('nome').AsString := FieldByName('descricao').AsString;
        cdEstoquePro.FieldByName('id').AsInteger := FieldByName('id_produto').AsInteger;
        cdEstoquePro.Post;
        next;
      end;
      cdEstoquePro.Close;
      cdEstoquePro.Open;
      qry.Close;
    end;
    FDConnection.Close;
end;


procedure TFrameEstoque.Edit1KeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
    dadosEstoque(Edit1.Text);
end;

procedure TFrameEstoque.LvEstoqueDblClick(Sender: TObject);
begin
   if Assigned(LvEstoque.Selected) then
   begin
    cdEstoquePro.RecNo:=LvEstoque.Selected.Index+ 1;
    frameMoviCad :=TFrameCadMoviEstoque.create(FormTelaPrincipal,cdEstoquePro.FieldByName('id').AsInteger,cdEstoquePro.FieldByName('estoque').AsString.ToInteger);
    Release;
   end;
end;

procedure TFrameEstoque.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameEstPro := nil;
end;

end.

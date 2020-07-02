unit frameCatpes;

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
  TFrameCat = class(TFrame)
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
    Layout3: TLayout;
    Edit1: TEdit;
    Layout4: TLayout;
    Label6: TLabel;
    Cdscategoria: TClientDataSet;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    CornerButton1: TCornerButton;
    procedure Edit1KeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure CornerButton1Click(Sender: TObject);
    procedure btnVoltaClick(Sender: TObject);
    procedure LvEstoqueDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     constructor Create(_AOwner: TComponent);
     procedure  Release;
     procedure pegardados(texto : string = ' ');
  end;

  var
    frameCatPro:TFrameCat;

implementation

uses
  FireDAC.Comp.Client,global, frameCadCategoria, pousada, frameCadastro;


{$R *.fmx}

procedure TFrameCat.Edit1KeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  pegardados(Edit1.Text);
end;

procedure TFrameCat.LvEstoqueDblClick(Sender: TObject);
begin
      if Assigned(LvESTOQUE.Selected) then
   begin

   Cdscategoria.RecNo:=Lvestoque.Selected.Index+ 1;
  frameCat:=TFrameCategoriaCad.Create(parent,true,Cdscategoria.FieldByName('descricao').AsString,Cdscategoria.FieldByName('id').Asinteger);
    Release;
   end;
end;

procedure TFrameCat.pegardados(texto : string = ' ');
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
           begin
             add('  select *  from categorias  ');

           end
        else
        begin
           add('select * from categorias where descricao like ''%'+ texto+'%''');

        end;
      end;
      Open;
      Cdscategoria.EmptyDataSet;
      while not EOF do
      begin
        Cdscategoria.Insert;
        Cdscategoria.FieldByName('id').AsInteger := FieldByName('idCategoria').AsInteger;
        Cdscategoria.FieldByName('descricao').AsString := FieldByName('descricao').AsString;
           Cdscategoria.Post;
        next;
      end;
      Cdscategoria.Close;
      Cdscategoria.Open;
      qry.Close;
    end;
    FDConnection.Close;
    FreeAndNil(qry);
end;



procedure TFrameCat.btnVoltaClick(Sender: TObject);
begin
 self.Release;
  frameCad:=TFrameCadastros.Create(FormTelaPrincipal);
end;

procedure TFrameCat.CornerButton1Click(Sender: TObject);
begin
   self.Release;
 frameCat:=TFrameCategoriaCad.Create(FormTelaPrincipal);

end;

constructor TFrameCat.Create(_AOwner: TComponent);
begin
  inherited;
  Parent := TFmxObject(_AOwner);
  pegardados;
end;

procedure TFrameCat.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCatPro := nil;
end;


end.

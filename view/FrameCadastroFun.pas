unit FrameCadastroFun;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Layouts, FMX.Controls.Presentation, FMX.Objects, FMX.ListBox;

type
  TFrameCadFunc = class(TFrame)
    Rectop: TRectangle;
    Label1: TLabel;
    CornerButton2: TCornerButton;
    RecTotal: TRectangle;
    LytTotal: TLayout;
    RtPrincipal: TRectangle;
    Layout2: TLayout;
    Layout4: TLayout;
    Label3: TLabel;
    EdtNome: TEdit;
    Layout3: TLayout;
    LbValor: TLabel;
    Layout7: TLayout;
    CornerButton1: TCornerButton;
    Layout8: TLayout;
    Layout9: TLayout;
    Label4: TLabel;
    EdtTel: TEdit;
    LytBr: TLayout;
    lytRb: TLayout;
    Label7: TLabel;
    RbInaSim: TRadioButton;
    RbinaNao: TRadioButton;
    CmbFun: TComboBox;
    Layout1: TLayout;
    Label2: TLabel;
    EdtEnd: TEdit;
    Layout5: TLayout;
    Label5: TLabel;
    EdtEmail: TEdit;
    Layout6: TLayout;
    Label6: TLabel;
    EdTdata: TEdit;
    Layout10: TLayout;
    Label8: TLabel;
    EdtCid: TEdit;
    Label9: TLabel;
    CmbEstado: TComboBox;
    procedure CornerButton1Click(Sender: TObject);
    procedure EdTdataExit(Sender: TObject);
    procedure CornerButton2Click(Sender: TObject);
    procedure EdtTelKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
     modi : boolean;
     fun_id:integer;
    constructor create(_AOwner:TComponent;id_pro:integer = 0;modif:boolean = false); overload;
    procedure Release;override;
    procedure  pegarInfofun(id:integer);

  end;

  var
      frameCadFuncio:TFrameCadFunc;

implementation

uses
  frameFuncio, pousada, BancoFuncionario, FireDAC.Comp.Client,global;

{$R *.fmx}

procedure TFrameCadFunc.Release;
begin
  Name := '';

  FreeOnRelease;
  inherited;

  frameCadFuncio := nil;
end;


procedure  TFrameCadFunc.pegarInfofun(id:integer);
var
  qry:TFDQuery;
  texto:string;
begin
    qry := TFDQuery.Create(self);


      with qry do
    begin
      qry.Connection := FDConnection;
      with qry.SQL do
      begin
        add('select nome,telefone,funcao,inativarFun,data_nascimento,email_fun,cidade_fun,endereco_fun,estado_fun from funcionario where idFuncionario = :id');
        ParamByName('id').Asinteger := id;

      end;
      open;

      while not EOF do
      begin
        EdtNome.Text := FieldByName('nome').AsString;
        EdtTel.Text   :=  FieldByName('telefone').AsString;
        iF FieldByName('funcao').AsString.ToUpper =   'GERENTE' THEN
               CmbFun.ItemIndex := 1;
        iF FieldByName('funcao').AsString.ToUpper =   'ADMINISTRADOR' THEN
               CmbFun.ItemIndex := 2;
        iF FieldByName('funcao').AsString.ToUpper =   'FUNCIONARIO' THEN
               CmbFun.ItemIndex := 3;


        if FieldByName('inativarFun').AsBoolean.ToInteger = 0 then
          RbInaSim.IsChecked := false
        else
          RbinaNao.IsChecked := true;
        EdTdata.Text :=datetostr(FieldByName('data_nascimento').AsDateTime);
        EdtEmail.Text :=FieldByName('email_fun').AsString;
        EdtCid.Text := FieldByName('cidade_fun').AsString;
        EdtEnd.Text := FieldByName('endereco_fun').AsString;
        texto:= FieldByName('estado_fun').AsString;
           if texto = 'AC' then
                CmbEstado.ItemIndex := 1;
           if texto = 'AL'  then
            CmbEstado.ItemIndex :=2;
           if texto = 'AP'  then
            CmbEstado.ItemIndex := 3;
            if texto = 'AM'  then
               CmbEstado.ItemIndex := 4;
             if texto = 'BA'  then
                   CmbEstado.ItemIndex := 5;
            if texto = 'CE'  then
                CmbEstado.ItemIndex := 6;
             if texto = 'DF'  then
                   CmbEstado.ItemIndex := 7;
              if texto = 'ES'  then
                   CmbEstado.ItemIndex := 8;
               if texto = 'GO'  then
                   CmbEstado.ItemIndex := 9;
              if texto = 'MA'  then
                   CmbEstado.ItemIndex := 10;
              if texto = 'MT'  then
                   CmbEstado.ItemIndex := 11;
              if texto = 'MS'  then
                   CmbEstado.ItemIndex := 12;
              if texto = 'MG'  then
                   CmbEstado.ItemIndex := 13;
              if texto = 'PA'  then
                   CmbEstado.ItemIndex := 14;
              if texto = 'PB'  then
                   CmbEstado.ItemIndex := 15;
              if texto = 'PR'  then
                   CmbEstado.ItemIndex := 16;
              if texto = 'PE'  then
                   CmbEstado.ItemIndex :=17;
              if texto = 'PI'  then
                   CmbEstado.ItemIndex := 18;
              if texto = 'RJ'  then
                   CmbEstado.ItemIndex := 19;
              if texto = 'RN'  then
                   CmbEstado.ItemIndex := 20;
              if texto = 'RS'  then
                   CmbEstado.ItemIndex := 21;
              if texto = 'RO'  then
                   CmbEstado.ItemIndex := 22;
              if texto = 'PR'  then
                   CmbEstado.ItemIndex := 23;
              if texto = 'SC'  then
                   CmbEstado.ItemIndex := 24;
              if texto = 'SP'  then
                   CmbEstado.ItemIndex := 25;
              if texto = 'SE'  then
                   CmbEstado.ItemIndex := 26;
              if texto = 'TO'  then
                   CmbEstado.ItemIndex := 27;
              next;
      end;
      end;

      qry.Close;
end;

procedure TFrameCadFunc.CornerButton2Click(Sender: TObject);
begin
  Release;
  frameFun := TFrameFuncionario.Create(FormTelaPrincipal);
end;

constructor TFrameCadFunc.Create(_AOwner: TComponent;id_pro:integer;modif:boolean);
begin
  inherited Create(Owner);
  Parent := TFmxObject(_AOwner);
  rbinanao.ischecked := true;
  if modif = false then
    LytBr.Visible := false;
   if modif then
  begin
    pegarInfofun(id_pro);
    modi := modif;
    fun_id := id_pro;
  end;
end;

function tbStrIsDate(const S: string): boolean;
begin
  try
    StrToDate(S);
    Result := true;
  except
    Result := false;
  end;
end;

procedure TFrameCadFunc.EdTdataExit(Sender: TObject);
begin
  if(tbStrIsDate(EdTdata.Text)=false) or (EdTdata.Text.IsEmpty)  then
    EdTdata.Text := '__/__/____';
end;

procedure TFrameCadFunc.EdtTelKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  verificarInteger(sender,keychar);
end;

procedure TFrameCadFunc.CornerButton1Click(Sender: TObject);
var
  inat:boolean;
  index:integer;
begin
  if(not(EdtNome.Text.IsEmpty)and not (EdtTel.Text.IsEmpty)) then
   begin

      if Rbinasim.ischecked then
        inat:=false;
       if Rbinanao.ischecked then
        inat:=true;
      with Tfuncionario.Create(self) do
      begin
        if modi then
            alterarFun(EdtNome.Text,CmbFun.Items[CmbFun.ItemIndex],EdtTel.Text,EdTdata.Text,
                      EdtEnd.Text,EdtEmail.Text,EdtCid.Text,CmbEstado.Items[CmbEstado.ItemIndex],inat,fun_id)

        else
          inserir_fun(EdtNome.Text,CmbFun.Items[CmbFun.ItemIndex],EdtTel.Text,EdTdata.Text,
                      EdtEnd.Text,EdtEmail.Text,EdtCid.Text,CmbEstado.Items[CmbEstado.ItemIndex],inat);
      end;
    end;

    Release;
    frameFun:=TFrameFuncionario.create(FormTelaPrincipal);
end;


end.

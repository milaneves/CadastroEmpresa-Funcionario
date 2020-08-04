unit uFuncionario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uTelaHeranca, ExtCtrls, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, DBCtrls, Grids, DBGrids, StdCtrls, Buttons, ComCtrls,cFuncionario,
  uEnum, uDTMConexao, Mask;

type
  TfrmFuncionario = class(TfrmTelaHeranca)
    edtIdFuncionario: TLabeledEdit;
    edtNome: TLabeledEdit;
    edtCPF: TLabeledEdit;
    edtEndereco: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtCEP: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtSalario: TLabeledEdit;
    combEmpresa: TComboBox;
    lbEmpresa: TLabel;
    QryListagemIdFuncionario: TIntegerField;
    QryListagemIdEmpresa: TIntegerField;
    QryListagemNome: TWideStringField;
    QryListagemCPF: TWideStringField;
    edtTelefone: TMaskEdit;
    lblTelefone: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure PreencherComboEmpresa;
    procedure ExportarDados;




  private
    { Private declarations }
    oFuncionario :TFuncionario;
     function Apagar: Boolean; Override;
    function Inserir(EstaDoCadastro: TEstadoDoCadastro): Boolean; Override;
  public
       { Public declarations }
  end;

var
  frmFuncionario: TfrmFuncionario;

implementation

{$R *.dfm}


function TfrmFuncionario.Inserir(EstaDoCadastro: TEstadoDoCadastro): Boolean;
begin

  //preenchendo o Objeto
 if  edtIdFuncionario.Text<>EmptyStr then
    oFuncionario.IdFuncionario:= StrToInt(edtIdFuncionario.text)
 else
     oFuncionario.IdFuncionario:=0;

  oFuncionario.CPF := edtCPF.Text;
  oFuncionario.IdEmpresa:= combEmpresa.Text;
  oFuncionario.Nome:= edtNome.Text;
  oFuncionario.CEP:= edtCEP.Text;
  oFuncionario.Endereco:=edtEndereco.Text;
  oFuncionario.Bairro:= edtBairro.Text;
  oFuncionario.Cidade:= edtCidade.Text;
  oFuncionario.Numero:= edtNumero.Text;
  oFuncionario.Complemento:=edtComplemento.Text;
  oFuncionario.Telefone:=edtTelefone.Text;
  oFuncionario.Email:=edtEmail.Text;
  oFuncionario.Salario:=StrToInt(edtSalario.Text);



 if (EstaDoCadastro = ecInserir) then
   Result:= oFuncionario.Inserir
 else if (EstaDoCadastro = ecAlterar) then
   Result:= oFuncionario.Atualizar;

end;


function TfrmFuncionario.Apagar: Boolean;
begin
  Result := oFuncionario.Apagar(QryListagem.FieldByName('IdFuncionario').AsInteger);
end;

procedure TfrmFuncionario.btnAlterarClick(Sender: TObject);
var VLoValorCombo:integer;
begin
  if oFuncionario.Selecionar(QryListagem.FieldByName('CPF').Value) then
    begin
     edtIdFuncionario.text:= IntToStr(oFuncionario.IdFuncionario);
     edtCPF.Text:= oFuncionario.CPF;
     edtNome.Text:= oFuncionario.Nome;
     edtCEP.Text:= oFuncionario.CEP;
     edtEndereco.Text:= oFuncionario.Endereco;
     edtBairro.Text:= oFuncionario.Bairro;
     edtCidade.Text:= oFuncionario.Cidade;;
     edtNumero.Text := oFuncionario.Numero;
     edtComplemento.Text:= oFuncionario.Complemento;
     edtTelefone.Text:= oFuncionario.Telefone;
     edtEmail.Text:= oFuncionario.Email;


     For VLoValorCombo := 0 to (combEmpresa).Items.Count - 1 do
       If (combEmpresa).Items[VLoValorCombo] = Trim
      (QryListagem.FieldByName('Nome_Fantasia').AsString) then
       (combEmpresa).ItemIndex := VLoValorCombo;

     edtSalario.Text:= FloatToSTr(oFuncionario.Salario);
    end
    else
    begin
      btnCancelar.Click;
      Abort;
    end;
 inherited;
end;

procedure TfrmFuncionario.btnExportarClick(Sender: TObject);
begin
  inherited;
  ExportarDados;
end;

procedure TfrmFuncionario.ExportarDados;
 var
   txt : TextFile;
    i:integer;
begin
  Assignfile (txt,'Arquivo.Txt');
  ReWrite (txt);
  QryListagem.First;
while not QryListagem.Eof do
begin
   for i := 0 to QryListagem.Fields.Count - 1 do
   write(txt, QryListagem.Fields[i].AsString + '|');
   writeln(txt, ''); // quebra a linha
   QryListagem.Next;
end;
  CloseFile(txt);
end;

procedure TfrmFuncionario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

    // limpa o objeto, se estiver estanciado
  if Assigned(oFuncionario) then
    FreeAndNil(oFuncionario);

end;

procedure TfrmFuncionario.FormCreate(Sender: TObject);
begin
  inherited;
  oFuncionario:=TFuncionario.Create(dtmPrincipal.ConexaoDB);
  PreencherComboEmpresa;
end;

procedure TfrmFuncionario.PreencherComboEmpresa;
var  Qry:TzQuery;
begin
 Qry:=TZQuery.Create(Nil);
 Qry.Connection:=dtmPrincipal.ConexaoDB;
 Qry.SQL.Clear;
 Qry.SQL.Clear;
 Qry.SQL.Add('select Nome_Fantasia from empresa');
 Qry.Open;

  combEmpresa.Items.clear;
  while not Qry.eof do
  begin
    combEmpresa.Items.Add(Qry.FieldByName ('Nome_Fantasia').AsString);
    Qry.Next;
  end;
  combEmpresa.ItemIndex:= -1;

end;

end.

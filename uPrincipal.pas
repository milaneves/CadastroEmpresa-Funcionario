unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, UDTMConexao, uEmpresa, uFuncionario, uLocalizarFuncionario,
  StdCtrls, jpeg, ExtCtrls;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    menuCadastro: TMenuItem;
    menuEmpresa: TMenuItem;
    menuLocalizar: TMenuItem;
    menuFuncionario: TMenuItem;
    menuLocFuncionarios: TMenuItem;
    N3: TMenuItem;
    menuFechar: TMenuItem;
    procedure menuEmpresaClick(Sender: TObject);
    procedure menuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure menuFuncionarioClick(Sender: TObject);
    procedure menuLocFuncionariosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation


{$R *.dfm}

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  //criando a variavel conex�o sobre o formulario principal e conectando ao banco de dados
   dtmPrincipal:=TdtmPrincipal.Create(Self);
  with dtmPrincipal.ConexaoDB do
  begin
    SQLHourGlass:= false;
    Protocol:= 'mssql';
    LibraryLocation:= 'C:\Users\milaneves\Documents\PROJETOS\Delphi\ExtraDigital\ntwdblib';
    HostName:= '.\SQLEXPRESS';
    Port:= 1433;
    User:= 'mila';
    Password:= '246810Mila';
    Database:= 'ExtraDigital';
    Connected:= True;

  end;
end;

procedure TfrmPrincipal.menuEmpresaClick(Sender: TObject);
begin
  //Chamando a tela de Empresa ap�s o evento Onclick
  frmEmpresa:=TfrmEmpresa.Create(Self);
  frmEmpresa.ShowModal;
  frmEmpresa.Release;

end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
 Close;
end;

procedure TfrmPrincipal.menuFuncionarioClick(Sender: TObject);
begin
  //Chamando a tela de Funcionario ap�s o evento Onclick
  frmFuncionario:=TfrmFuncionario.Create(Self);
  frmFuncionario.ShowModal;
  frmFuncionario.Release;

end;

procedure TfrmPrincipal.menuLocFuncionariosClick(Sender: TObject);
begin
  //Chamando a tela de localizar ap�s o evento Onclick
  frmLocalizarFuncionario:=TfrmLocalizarFuncionario.Create(Self);
  frmLocalizarFuncionario.ShowModal;
  frmLocalizarFuncionario.Release;

end;

end.

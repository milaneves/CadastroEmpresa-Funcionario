program ExtraDigital;

uses
  Forms,
  uDTMConexao in 'DataModule\uDTMConexao.pas' {dtmPrincipal: TDataModule},
  uTelaHeranca in 'Heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uEnum in 'Heranca\uEnum.pas',
  uEmpresa in 'Cadastro\uEmpresa.pas' {frmEmpresa},
  cEmpresa in 'Classes\cEmpresa.pas',
  uFuncionario in 'Cadastro\uFuncionario.pas' {frmFuncionario},
  cFuncionario in 'Classes\cFuncionario.pas',
  uLocalizarFuncionario in 'Localizar\uLocalizarFuncionario.pas' {frmLocalizarFuncionario},
  uPrincipal in 'uPrincipal.pas' {frmPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.

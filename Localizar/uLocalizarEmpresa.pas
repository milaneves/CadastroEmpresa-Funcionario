unit uLocalizarEmpresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ZAbstractRODataset, ZAbstractDataset, ZDataset, Grids, DBGrids,
  StdCtrls, Buttons, ExtCtrls, ComCtrls;

type
  TfrmLocalizarFuncionario = class(TForm)
    pgPrincipal: TPageControl;
    tabListagem: TTabSheet;
    pnListagem: TPanel;
    lblIndice: TLabel;
    edtPesquisa: TEdit;
    btnPesquisar: TBitBtn;
    BitBtn1: TBitBtn;
    grdListagem: TDBGrid;
    QryListagem: TZQuery;
    QryListagemCNPJ: TWideStringField;
    QryListagemNome_Fantasia: TWideStringField;
    QryListagemIdEmpresa: TIntegerField;
    dsListagem: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLocalizarFuncionario: TfrmLocalizarFuncionario;

implementation

{$R *.dfm}

end.

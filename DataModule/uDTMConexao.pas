unit uDTMConexao;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, DB, ZAbstractRODataset,
  ZAbstractDataset, ZStoredProcedure;

type
  TdtmPrincipal = class(TDataModule)
    ConexaoDB: TZConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{$R *.dfm}

end.

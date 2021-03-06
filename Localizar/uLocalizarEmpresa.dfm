object frmLocalizarFuncionario: TfrmLocalizarFuncionario
  Left = 0
  Top = 0
  Caption = 'Localizar Empresa'
  ClientHeight = 676
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pgPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 949
    Height = 676
    ActivePage = tabListagem
    Align = alClient
    TabOrder = 0
    object tabListagem: TTabSheet
      Caption = 'Listagem'
      ExplicitWidth = 1028
      ExplicitHeight = 680
      object pnListagem: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 82
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 1028
        object lblIndice: TLabel
          Left = 3
          Top = 30
          Width = 78
          Height = 13
          Caption = 'Campo Pesquisa'
        end
        object edtPesquisa: TEdit
          Left = 3
          Top = 51
          Width = 214
          Height = 21
          TabOrder = 0
          TextHint = 'Digite sua Pesquisa'
        end
        object btnPesquisar: TBitBtn
          Left = 223
          Top = 48
          Width = 75
          Height = 25
          Caption = 'PESQUISAR'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
        end
        object BitBtn1: TBitBtn
          Left = 640
          Top = 48
          Width = 291
          Height = 25
          Caption = 'EXPORTAR ARQUIVO'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 2
        end
      end
      object grdListagem: TDBGrid
        Left = 3
        Top = 88
        Width = 1022
        Height = 614
        DataSource = dsListagem
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
  end
  object QryListagem: TZQuery
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT *'
      'FROM EMPRESA')
    Params = <>
    Left = 768
    Top = 88
    object QryListagemCNPJ: TWideStringField
      FieldName = 'CNPJ'
      Required = True
      Size = 16
    end
    object QryListagemNome_Fantasia: TWideStringField
      DisplayLabel = 'Nome Fantasia'
      FieldName = 'Nome_Fantasia'
      Size = 80
    end
    object QryListagemIdEmpresa: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdEmpresa'
      ReadOnly = True
    end
  end
  object dsListagem: TDataSource
    DataSet = QryListagem
    Left = 832
    Top = 88
  end
end

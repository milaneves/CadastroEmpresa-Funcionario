inherited frmEmpresa: TfrmEmpresa
  Caption = 'Cadastro de Empresa'
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgPrincipal: TPageControl
    ActivePage = tabListagem
    inherited tabListagem: TTabSheet
      inherited grdListagem: TDBGrid
        Height = 614
      end
    end
    inherited tabManutencao: TTabSheet
      Caption = 'Cadastrar'
      ExplicitLeft = 4
      ExplicitTop = 24
      object lblTelefone: TLabel
        Left = 12
        Top = 329
        Width = 42
        Height = 13
        Caption = 'Telefone'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lblCEP: TLabel
        Left = 11
        Top = 226
        Width = 19
        Height = 13
        Caption = 'CEP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtIdEmpresa: TLabeledEdit
        Tag = 2
        Left = 11
        Top = 53
        Width = 102
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 10
        NumbersOnly = True
        ParentFont = False
        TabOrder = 11
      end
      object edtRazaoSocial: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 147
        Width = 682
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 60
        EditLabel.Height = 13
        EditLabel.Caption = 'Raz'#227'o Social'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object edtNomeFantasia: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 195
        Width = 682
        Height = 21
        EditLabel.Width = 71
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome Fantasia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object edtCNPJ: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 101
        Width = 121
        Height = 21
        EditLabel.Width = 25
        EditLabel.Height = 13
        EditLabel.Caption = 'CNPJ'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 14
        NumbersOnly = True
        ParentFont = False
        TabOrder = 0
        OnExit = edtCNPJExit
      end
      object edtEndereco: TLabeledEdit
        Tag = 1
        Left = 119
        Top = 241
        Width = 310
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
      end
      object edtBairro: TLabeledEdit
        Tag = 1
        Left = 435
        Top = 241
        Width = 258
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edtCidade: TLabeledEdit
        Tag = 1
        Left = 11
        Top = 293
        Width = 182
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object edtNumero: TLabeledEdit
        Tag = 1
        Left = 199
        Top = 293
        Width = 58
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Numero'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object edtComplemento: TLabeledEdit
        Tag = 1
        Left = 263
        Top = 293
        Width = 430
        Height = 21
        EditLabel.Width = 65
        EditLabel.Height = 13
        EditLabel.Caption = 'Complemento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
      end
      object edtEmail: TLabeledEdit
        Tag = 1
        Left = 119
        Top = 345
        Width = 574
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
      end
      object edtTelefone: TMaskEdit
        Tag = 1
        Left = 11
        Top = 345
        Width = 102
        Height = 21
        EditMask = '(99)99999-9999;1;_'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 14
        ParentFont = False
        TabOrder = 9
        Text = '(  )     -    '
      end
      object edtCEP: TMaskEdit
        Tag = 1
        Left = 11
        Top = 241
        Width = 99
        Height = 21
        HelpContext = 8
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxLength = 8
        ParentFont = False
        TabOrder = 3
      end
    end
  end
  inherited pnRodape: TPanel
    inherited btnCancelar: TBitBtn
      Height = 26
      ExplicitHeight = 26
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'SELECT *'
      'FROM EMPRESA AS A '
      '        JOIN  ENDERECO AS B ON (A.IdEndereco = B.IdEndereco)')
    object QryListagemIdEmpresa: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IdEmpresa'
      ReadOnly = True
    end
  end
end

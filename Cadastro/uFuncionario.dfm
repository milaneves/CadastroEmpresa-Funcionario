inherited frmFuncionario: TfrmFuncionario
  Caption = 'Cadastro de Funcion'#225'rios'
  OnClose = FormClose
  OnCreate = FormCreate
  ExplicitWidth = 1052
  ExplicitHeight = 788
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgPrincipal: TPageControl
    ActivePage = tabListagem
    inherited tabListagem: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 1028
      ExplicitHeight = 680
      inherited pnListagem: TPanel
        inherited edtPesquisa: TEdit
          Top = 52
          ExplicitTop = 52
        end
      end
      inherited grdListagem: TDBGrid
        Left = 3
        Height = 565
      end
    end
    inherited tabManutencao: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 24
      ExplicitWidth = 1028
      ExplicitHeight = 680
      object lbEmpresa: TLabel
        Left = 12
        Top = 128
        Width = 41
        Height = 13
        Caption = 'Empresa'
      end
      object lblTelefone: TLabel
        Left = 13
        Top = 327
        Width = 42
        Height = 13
        Caption = 'Telefone'
      end
      object edtIdFuncionario: TLabeledEdit
        Tag = 2
        Left = 12
        Top = 53
        Width = 102
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'digo'
        MaxLength = 10
        NumbersOnly = True
        TabOrder = 0
      end
      object edtNome: TLabeledEdit
        Tag = 1
        Left = 12
        Top = 187
        Width = 682
        Height = 21
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome'
        TabOrder = 3
      end
      object edtCPF: TLabeledEdit
        Tag = 1
        Left = 12
        Top = 101
        Width = 147
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'CPF'
        MaxLength = 11
        TabOrder = 1
      end
      object edtEndereco: TLabeledEdit
        Tag = 1
        Left = 120
        Top = 239
        Width = 310
        Height = 21
        EditLabel.Width = 45
        EditLabel.Height = 13
        EditLabel.Caption = 'Endere'#231'o'
        TabOrder = 5
      end
      object edtBairro: TLabeledEdit
        Tag = 1
        Left = 436
        Top = 239
        Width = 258
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Bairro'
        TabOrder = 6
      end
      object edtCidade: TLabeledEdit
        Tag = 1
        Left = 12
        Top = 291
        Width = 182
        Height = 21
        EditLabel.Width = 33
        EditLabel.Height = 13
        EditLabel.Caption = 'Cidade'
        TabOrder = 7
      end
      object edtCEP: TLabeledEdit
        Tag = 1
        Left = 12
        Top = 239
        Width = 102
        Height = 21
        EditLabel.Width = 19
        EditLabel.Height = 13
        EditLabel.Caption = 'CEP'
        MaxLength = 8
        TabOrder = 4
      end
      object edtNumero: TLabeledEdit
        Tag = 1
        Left = 200
        Top = 291
        Width = 58
        Height = 21
        EditLabel.Width = 37
        EditLabel.Height = 13
        EditLabel.Caption = 'Numero'
        TabOrder = 8
      end
      object edtComplemento: TLabeledEdit
        Tag = 1
        Left = 264
        Top = 291
        Width = 430
        Height = 21
        EditLabel.Width = 65
        EditLabel.Height = 13
        EditLabel.Caption = 'Complemento'
        TabOrder = 9
      end
      object edtEmail: TLabeledEdit
        Tag = 1
        Left = 120
        Top = 348
        Width = 574
        Height = 21
        EditLabel.Width = 24
        EditLabel.Height = 13
        EditLabel.Caption = 'Email'
        TabOrder = 11
      end
      object edtSalario: TLabeledEdit
        Tag = 1
        Left = 13
        Top = 394
        Width = 101
        Height = 21
        EditLabel.Width = 32
        EditLabel.Height = 13
        EditLabel.Caption = 'Sal'#225'rio'
        TabOrder = 12
      end
      object combEmpresa: TComboBox
        Left = 13
        Top = 147
        Width = 323
        Height = 21
        Style = csDropDownList
        TabOrder = 2
      end
      object edtTelefone: TMaskEdit
        Tag = 1
        Left = 12
        Top = 346
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
        TabOrder = 10
        Text = '(  )     -    '
      end
    end
  end
  inherited QryListagem: TZQuery
    SQL.Strings = (
      'select       IdFuncionario,'
      '                 a.IdEmpresa,'
      #9'   Nome ,'
      #9'   CPF,'
      '                  CNPJ,'
      '                 Nome_fantasia'
      
        'from funcionario as a join empresa as b on (a.IdEmpresa = b.IdEm' +
        'presa)'
      '')
    object QryListagemCPF: TWideStringField [0]
      FieldName = 'CPF'
      Required = True
      Size = 11
    end
    object QryListagemNome: TWideStringField [1]
      FieldName = 'Nome'
      Required = True
      Size = 80
    end
    object QryListagemIdFuncionario: TIntegerField
      FieldName = 'IdFuncionario'
      ReadOnly = True
    end
    object QryListagemIdEmpresa: TIntegerField
      FieldName = 'IdEmpresa'
      Required = True
    end
  end
end

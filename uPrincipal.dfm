object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Menu Principal'
  ClientHeight = 471
  ClientWidth = 876
  Color = clBtnHighlight
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mainPrincipal
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mainPrincipal: TMainMenu
    Left = 664
    Top = 48
    object menuCadastro: TMenuItem
      Caption = 'CADASTRO'
      object menuEmpresa: TMenuItem
        Caption = 'EMPRESA'
        OnClick = menuEmpresaClick
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object menuFuncionario: TMenuItem
        Caption = 'FUNCION'#193'RIO'
        OnClick = menuFuncionarioClick
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object menuFechar: TMenuItem
        Caption = 'FECHAR'
        OnClick = menuFecharClick
      end
    end
    object menuLocalizar: TMenuItem
      Caption = 'LOCALIZAR'
      object menuLocFuncionarios: TMenuItem
        Caption = 'FUNCION'#193'RIOS'
        OnClick = menuLocFuncionariosClick
      end
    end
  end
end

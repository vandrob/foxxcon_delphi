object DataModule1: TDataModule1
  OldCreateOrder = False
  Left = 221
  Top = 275
  Height = 448
  Width = 641
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\fooxfood\foxxfoo' +
      'd.mdb;Persist Security Info=False;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 56
    Top = 24
  end
  object ADOCommand1: TADOCommand
    Connection = ADOConnection1
    Parameters = <>
    Left = 144
    Top = 32
  end
  object qryIngredientes: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM ingredientes ORDER BY nome;')
    Left = 56
    Top = 88
    object qryIngredientesidingrediente: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 12
      FieldName = 'idingrediente'
      ReadOnly = True
    end
    object qryIngredientesnome: TWideStringField
      DisplayLabel = 'Nome do Ingrediente'
      DisplayWidth = 100
      FieldName = 'nome'
      Size = 255
    end
    object qryIngredientesvalor: TFloatField
      DisplayLabel = 'Valor'
      DisplayWidth = 15
      FieldName = 'valor'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object dsIngredientes: TDataSource
    DataSet = qryIngredientes
    Left = 136
    Top = 88
  end
  object qryLanches: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM lanches ORDER BY nome;')
    Left = 56
    Top = 152
    object qryLanchesidlanche: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'idlanche'
      ReadOnly = True
    end
    object qryLanchesnome: TWideStringField
      DisplayLabel = 'Nome do Lanche'
      DisplayWidth = 36
      FieldName = 'nome'
      Size = 255
    end
    object qryLanchesdescricao: TWideStringField
      DisplayLabel = 'Descri'#231#227'o para o Card'#225'pio'
      DisplayWidth = 94
      FieldName = 'descricao'
      Size = 255
    end
    object qryLanchesvalor: TFloatField
      DisplayLabel = 'Valor'
      DisplayWidth = 12
      FieldName = 'valor'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object dsLanches: TDataSource
    DataSet = qryLanches
    Left = 120
    Top = 152
  end
  object qryGenerica: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select max(idlanche)+1 as vlr_retornado from lanches')
    Left = 280
    Top = 16
  end
  object qryLanches_Ingredientes: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    DataSource = dsLanches
    Parameters = <>
    Left = 56
    Top = 232
    object qryLanches_Ingredientesingrediente_nome: TWideStringField
      DisplayLabel = 'Nome do Ingrediente'
      DisplayWidth = 90
      FieldName = 'ingrediente_nome'
      Size = 255
    end
    object qryLanches_Ingredientesid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object qryLanches_Ingredientesidlanche: TIntegerField
      FieldName = 'idlanche'
      Visible = False
    end
    object qryLanches_Ingredientesidingrediente: TIntegerField
      FieldName = 'idingrediente'
      Visible = False
    end
    object qryLanches_Ingredientesquantidade: TFloatField
      DisplayLabel = 'Qtd.'
      DisplayWidth = 7
      FieldName = 'quantidade'
    end
    object qryLanches_Ingredientesvalorunitario: TFloatField
      DisplayLabel = 'Vlr.Unit'#225'rio'
      FieldName = 'valorunitario'
      DisplayFormat = '###,###,##0.00'
    end
    object qryLanches_Ingredientesvalortotal: TFloatField
      DisplayLabel = 'Vlr.Total'
      DisplayWidth = 18
      FieldName = 'valortotal'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object dsLanches_Ingredientes: TDataSource
    DataSet = qryLanches_Ingredientes
    Left = 152
    Top = 240
  end
  object qryPesquisar: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      '  idingrediente as id,'
      '  nome,'
      '  valor'
      'FROM'
      '  ingredientes'
      'ORDER BY '
      '  nome')
    Left = 56
    Top = 296
    object qryPesquisarid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object qryPesquisarnome: TWideStringField
      DisplayWidth = 60
      FieldName = 'nome'
      Size = 255
    end
    object qryPesquisarvalor: TFloatField
      FieldName = 'valor'
    end
  end
  object dsPesquisar: TDataSource
    DataSet = qryPesquisar
    Left = 160
    Top = 296
  end
  object qryPedidos: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM pedidos ORDER BY idpedido;')
    Left = 280
    Top = 88
    object qryPedidosidpedido: TIntegerField
      DisplayLabel = 'Nro.Pedido'
      FieldName = 'idpedido'
    end
    object qryPedidoscliente: TWideStringField
      DisplayLabel = 'Nome do Cliente'
      DisplayWidth = 20
      FieldName = 'cliente'
      Size = 100
    end
    object qryPedidosvalor_lanches: TFloatField
      DisplayLabel = 'Valor dos Lanches'
      DisplayWidth = 8
      FieldName = 'valor_lanches'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidosvalor_adicionais: TFloatField
      DisplayLabel = 'Valor dos Adicionais'
      DisplayWidth = 8
      FieldName = 'valor_adicionais'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidosvalor_pedido: TFloatField
      DisplayLabel = 'Valor do Pedido'
      DisplayWidth = 8
      FieldName = 'valor_pedido'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidosqtd_lanches: TFloatField
      DisplayLabel = 'Qtd.de Lanches'
      DisplayWidth = 8
      FieldName = 'qtd_lanches'
      DisplayFormat = '###,###,##0'
    end
    object qryPedidospercentual_desconto: TFloatField
      DisplayLabel = 'Perc.de Desconto'
      DisplayWidth = 8
      FieldName = 'percentual_desconto'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidosvalor_desconto: TFloatField
      DisplayLabel = 'Valor do Desconto'
      DisplayWidth = 8
      FieldName = 'valor_desconto'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidosvalor_total: TFloatField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 8
      FieldName = 'valor_total'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidosmesa: TWideStringField
      DisplayLabel = 'Nro.da Mesa'
      DisplayWidth = 10
      FieldName = 'mesa'
      Size = 50
    end
    object qryPedidosendereco: TWideStringField
      DisplayLabel = 'Endere'#231'o de Entrega'
      DisplayWidth = 100
      FieldName = 'endereco'
      Size = 255
    end
  end
  object dsPedidos: TDataSource
    DataSet = qryPedidos
    Left = 352
    Top = 88
  end
  object qryPedidos_Lanches: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    DataSource = dsPedidos
    Parameters = <>
    Left = 256
    Top = 152
    object qryPedidos_Lanchesid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object qryPedidos_Lanchesidpedido: TIntegerField
      FieldName = 'idpedido'
      Visible = False
    end
    object qryPedidos_Lanchesidlanche: TIntegerField
      FieldName = 'idlanche'
      Visible = False
    end
    object qryPedidos_Lanchesqtd: TFloatField
      DisplayLabel = 'Qtd.Pedida'
      DisplayWidth = 6
      FieldName = 'qtd'
      DisplayFormat = '###,###,##0'
    end
    object qryPedidos_Lanchesnome_lanche: TWideStringField
      DisplayLabel = 'Nome do Lanche'
      DisplayWidth = 30
      FieldName = 'nome_lanche'
      Size = 255
    end
    object qryPedidos_Lanchesvalorunitario: TFloatField
      DisplayLabel = 'Vlr.Unit'#225'rio'
      DisplayWidth = 9
      FieldName = 'valorunitario'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidos_Lanchesvalortotal: TFloatField
      DisplayLabel = 'Vlr.Total'
      DisplayWidth = 9
      FieldName = 'valortotal'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object dsPedidos_Lanches: TDataSource
    DataSet = qryPedidos_Lanches
    Left = 352
    Top = 152
  end
  object dsPedidos_Adiciionais: TDataSource
    DataSet = qryPedidos_Adicionais
    Left = 384
    Top = 216
  end
  object qryPedidos_Adicionais: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    DataSource = dsPedidos
    Parameters = <>
    Left = 288
    Top = 216
    object qryPedidos_Adicionaisid: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object qryPedidos_Adicionaisidpedido: TIntegerField
      FieldName = 'idpedido'
      Visible = False
    end
    object qryPedidos_Adicionaisidingrediente: TIntegerField
      FieldName = 'idingrediente'
      Visible = False
    end
    object qryPedidos_Adicionaisnome_ingrediente: TWideStringField
      DisplayLabel = 'Ingrediente Adicional'
      DisplayWidth = 35
      FieldName = 'nome_ingrediente'
      Size = 255
    end
    object qryPedidos_Adicionaisqtd: TFloatField
      DisplayLabel = 'Qtd.Adicionada'
      FieldName = 'qtd'
      DisplayFormat = '###,###,##0'
    end
    object qryPedidos_Adicionaisvalorunitario: TFloatField
      DisplayLabel = 'Vlr.Unit'#225'rio'
      FieldName = 'valorunitario'
      DisplayFormat = '###,###,##0.00'
    end
    object qryPedidos_Adicionaisvalortotal: TFloatField
      DisplayLabel = 'Vlr.Total'
      FieldName = 'valortotal'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object qryComanda: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'idpedido'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT * FROM pedidos WHERE idpedido=:idpedido ORDER BY idpedido' +
        ';')
    Left = 296
    Top = 288
    object IntegerField1: TIntegerField
      DisplayLabel = 'Nro.Pedido'
      FieldName = 'idpedido'
    end
    object WideStringField1: TWideStringField
      DisplayLabel = 'Nome do Cliente'
      DisplayWidth = 20
      FieldName = 'cliente'
      Size = 100
    end
    object FloatField1: TFloatField
      DisplayLabel = 'Valor dos Lanches'
      DisplayWidth = 8
      FieldName = 'valor_lanches'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField2: TFloatField
      DisplayLabel = 'Valor dos Adicionais'
      DisplayWidth = 8
      FieldName = 'valor_adicionais'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField3: TFloatField
      DisplayLabel = 'Valor do Pedido'
      DisplayWidth = 8
      FieldName = 'valor_pedido'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField4: TFloatField
      DisplayLabel = 'Qtd.de Lanches'
      DisplayWidth = 8
      FieldName = 'qtd_lanches'
      DisplayFormat = '###,###,##0'
    end
    object FloatField5: TFloatField
      DisplayLabel = 'Perc.de Desconto'
      DisplayWidth = 8
      FieldName = 'percentual_desconto'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField6: TFloatField
      DisplayLabel = 'Valor do Desconto'
      DisplayWidth = 8
      FieldName = 'valor_desconto'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField7: TFloatField
      DisplayLabel = 'Valor Total'
      DisplayWidth = 8
      FieldName = 'valor_total'
      DisplayFormat = '###,###,##0.00'
    end
    object WideStringField2: TWideStringField
      DisplayLabel = 'Nro.da Mesa'
      DisplayWidth = 10
      FieldName = 'mesa'
      Size = 50
    end
    object WideStringField3: TWideStringField
      DisplayLabel = 'Endere'#231'o de Entrega'
      DisplayWidth = 100
      FieldName = 'endereco'
      Size = 255
    end
  end
  object dsComanda: TDataSource
    DataSet = qryComanda
    Left = 376
    Top = 288
  end
  object qryComanda_Itens: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'idpedido1'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '2'
      end
      item
        Name = 'idpedido2'
        Attributes = [paNullable]
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 510
        Value = '2'
      end>
    SQL.Strings = (
      ''
      'SELECT'
      ' PL.*,'
      ' L.nome as nome_do_item'
      'FROM'
      ' pedidos_lanches PL'
      ' INNER JOIN lanches L ON ( L.idlanche=PL.idlanche )'
      'WHERE'
      ' PL.idpedido=:idpedido1'
      ''
      'UNION ALL'
      ''
      'SELECT'
      ' PL.*,'
      ' I.nome as  nome_do_item'
      ''
      'FROM'
      ' pedidos_adicionais PL'
      
        ' INNER JOIN ingredientes I ON ( I.idingrediente=PL.idingrediente' +
        ' )'
      'WHERE'
      ' PL.idpedido=:idpedido2'
      ''
      'ORDER BY nome_do_item')
    Left = 296
    Top = 344
    object AutoIncField1: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object IntegerField2: TIntegerField
      FieldName = 'idpedido'
      Visible = False
    end
    object IntegerField3: TIntegerField
      FieldName = 'idlanche'
      Visible = False
    end
    object FloatField8: TFloatField
      DisplayLabel = 'Qtd.Pedida'
      DisplayWidth = 6
      FieldName = 'qtd'
      DisplayFormat = '###,###,##0'
    end
    object FloatField9: TFloatField
      DisplayLabel = 'Vlr.Unit'#225'rio'
      DisplayWidth = 9
      FieldName = 'valorunitario'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField10: TFloatField
      DisplayLabel = 'Vlr.Total'
      DisplayWidth = 9
      FieldName = 'valortotal'
      DisplayFormat = '###,###,##0.00'
    end
    object qryComanda_Itensnome_do_item: TWideStringField
      FieldName = 'nome_do_item'
      ReadOnly = True
      Size = 255
    end
  end
  object dsComanda_Itens: TDataSource
    DataSet = qryComanda_Itens
    Left = 392
    Top = 344
  end
  object qryCardapio: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT * FROM lanches ORDER BY nome;')
    Left = 448
    Top = 64
    object AutoIncField2: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 10
      FieldName = 'idlanche'
      ReadOnly = True
    end
    object WideStringField4: TWideStringField
      DisplayLabel = 'Nome do Lanche'
      DisplayWidth = 36
      FieldName = 'nome'
      Size = 255
    end
    object WideStringField5: TWideStringField
      DisplayLabel = 'Descri'#231#227'o para o Card'#225'pio'
      DisplayWidth = 94
      FieldName = 'descricao'
      Size = 255
    end
    object FloatField11: TFloatField
      DisplayLabel = 'Valor'
      DisplayWidth = 12
      FieldName = 'valor'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object qryCardapio_itens: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    DataSource = dsCardapio
    Parameters = <
      item
        Name = 'idlanche'
        Attributes = [paNullable]
        DataType = ftInteger
        NumericScale = 255
        Precision = 255
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' I.nome as ingrediente_nome,'
      ' LI.*'
      'FROM'
      ' lanches_ingredientes LI'
      ' INNER JOIN ingredientes I ON (I.idingrediente=LI.idingrediente)'
      'WHERE'
      '  LI.idlanche=:idlanche'
      'ORDER BY'
      '  I.nome,LI.idlanche;')
    Left = 520
    Top = 72
    object WideStringField6: TWideStringField
      DisplayLabel = 'Nome do Ingrediente'
      DisplayWidth = 90
      FieldName = 'ingrediente_nome'
      Size = 255
    end
    object AutoIncField3: TAutoIncField
      FieldName = 'id'
      ReadOnly = True
      Visible = False
    end
    object IntegerField4: TIntegerField
      FieldName = 'idlanche'
      Visible = False
    end
    object IntegerField5: TIntegerField
      FieldName = 'idingrediente'
      Visible = False
    end
    object FloatField12: TFloatField
      DisplayLabel = 'Qtd.'
      DisplayWidth = 7
      FieldName = 'quantidade'
    end
    object FloatField13: TFloatField
      DisplayLabel = 'Vlr.Unit'#225'rio'
      FieldName = 'valorunitario'
      DisplayFormat = '###,###,##0.00'
    end
    object FloatField14: TFloatField
      DisplayLabel = 'Vlr.Total'
      DisplayWidth = 18
      FieldName = 'valortotal'
      DisplayFormat = '###,###,##0.00'
    end
  end
  object dsCardapio: TDataSource
    DataSet = qryCardapio
    Left = 464
    Top = 144
  end
  object dsCardapio_Itens: TDataSource
    DataSet = qryCardapio_itens
    Left = 536
    Top = 144
  end
end

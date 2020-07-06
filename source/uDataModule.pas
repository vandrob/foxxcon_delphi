unit uDataModule;

interface

uses
  SysUtils, Classes, DB, ADODB,Dialogs;

type
  TDataModule1 = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOCommand1: TADOCommand;
    qryIngredientes: TADOQuery;
    qryIngredientesidingrediente: TAutoIncField;
    qryIngredientesnome: TWideStringField;
    qryIngredientesvalor: TFloatField;
    dsIngredientes: TDataSource;
    qryLanches: TADOQuery;
    dsLanches: TDataSource;
    qryLanchesidlanche: TAutoIncField;
    qryLanchesnome: TWideStringField;
    qryLanchesdescricao: TWideStringField;
    qryLanchesvalor: TFloatField;
    qryGenerica: TADOQuery;
    qryLanches_Ingredientes: TADOQuery;
    dsLanches_Ingredientes: TDataSource;
    qryLanches_Ingredientesid: TAutoIncField;
    qryLanches_Ingredientesidlanche: TIntegerField;
    qryLanches_Ingredientesidingrediente: TIntegerField;
    qryLanches_Ingredientesquantidade: TFloatField;
    qryLanches_Ingredientesvalorunitario: TFloatField;
    qryLanches_Ingredientesvalortotal: TFloatField;
    qryLanches_Ingredientesingrediente_nome: TWideStringField;
    qryPesquisar: TADOQuery;
    dsPesquisar: TDataSource;
    qryPesquisarid: TAutoIncField;
    qryPesquisarnome: TWideStringField;
    qryPesquisarvalor: TFloatField;
    qryPedidos: TADOQuery;
    qryPedidosidpedido: TIntegerField;
    qryPedidoscliente: TWideStringField;
    qryPedidosendereco: TWideStringField;
    qryPedidosmesa: TWideStringField;
    qryPedidosvalor_lanches: TFloatField;
    qryPedidosvalor_adicionais: TFloatField;
    qryPedidosvalor_pedido: TFloatField;
    qryPedidosqtd_lanches: TFloatField;
    qryPedidospercentual_desconto: TFloatField;
    qryPedidosvalor_desconto: TFloatField;
    qryPedidosvalor_total: TFloatField;
    dsPedidos: TDataSource;
    qryPedidos_Lanches: TADOQuery;
    dsPedidos_Lanches: TDataSource;
    qryPedidos_Lanchesid: TAutoIncField;
    qryPedidos_Lanchesidpedido: TIntegerField;
    qryPedidos_Lanchesidlanche: TIntegerField;
    qryPedidos_Lanchesqtd: TFloatField;
    qryPedidos_Lanchesvalorunitario: TFloatField;
    qryPedidos_Lanchesvalortotal: TFloatField;
    qryPedidos_Lanchesnome_lanche: TWideStringField;
    dsPedidos_Adiciionais: TDataSource;
    qryPedidos_Adicionais: TADOQuery;
    qryPedidos_Adicionaisid: TAutoIncField;
    qryPedidos_Adicionaisidpedido: TIntegerField;
    qryPedidos_Adicionaisidingrediente: TIntegerField;
    qryPedidos_Adicionaisqtd: TFloatField;
    qryPedidos_Adicionaisvalorunitario: TFloatField;
    qryPedidos_Adicionaisvalortotal: TFloatField;
    qryPedidos_Adicionaisnome_ingrediente: TWideStringField;
    qryComanda: TADOQuery;
    IntegerField1: TIntegerField;
    WideStringField1: TWideStringField;
    FloatField1: TFloatField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    FloatField4: TFloatField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    FloatField7: TFloatField;
    WideStringField2: TWideStringField;
    WideStringField3: TWideStringField;
    dsComanda: TDataSource;
    qryComanda_Itens: TADOQuery;
    AutoIncField1: TAutoIncField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    FloatField8: TFloatField;
    FloatField9: TFloatField;
    FloatField10: TFloatField;
    qryComanda_Itensnome_do_item: TWideStringField;
    dsComanda_Itens: TDataSource;
    qryCardapio: TADOQuery;
    AutoIncField2: TAutoIncField;
    WideStringField4: TWideStringField;
    WideStringField5: TWideStringField;
    FloatField11: TFloatField;
    qryCardapio_itens: TADOQuery;
    WideStringField6: TWideStringField;
    AutoIncField3: TAutoIncField;
    IntegerField4: TIntegerField;
    IntegerField5: TIntegerField;
    FloatField12: TFloatField;
    FloatField13: TFloatField;
    FloatField14: TFloatField;
    dsCardapio: TDataSource;
    dsCardapio_Itens: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

{ TDataModule1 }


end.

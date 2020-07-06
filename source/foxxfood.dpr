program foxxfood;

uses
  Forms,
  uFrmAbertura in 'uFrmAbertura.pas' {FrmAbertura},
  uDataModule in 'uDataModule.pas' {DataModule1: TDataModule},
  uFrmMenu in 'uFrmMenu.pas' {FrmMenu},
  uFrmIngredientes in 'uFrmIngredientes.pas' {FrmIngredientes},
  uFrmLanchesIngredientesRegistro in 'uFrmLanchesIngredientesRegistro.pas' {FrmLanchesIngredientesRegistro},
  uFuncoes in 'uFuncoes.pas',
  uFrmLanches in 'uFrmLanches.pas' {FrmLanches},
  uFrmLanchesRegistro in 'uFrmLanchesRegistro.pas' {FrmLanchesRegistro},
  uFrmCardapio in 'uFrmCardapio.pas' {FrmCardapio},
  uFrmIngredientesRegistro in 'uFrmIngredientesRegistro.pas' {FrmIngredientesRegistro},
  uFrmPesquisar in 'uFrmPesquisar.pas' {FrmPesquisar},
  uFrmPedidos in 'uFrmPedidos.pas' {FrmPedidos},
  uFrmPedidosRegistro in 'uFrmPedidosRegistro.pas' {FrmPedidosRegistro},
  uFrmPedidosRegistroAdicionais in 'uFrmPedidosRegistroAdicionais.pas' {FrmPedidosRegistroAdicionais},
  uFrmPedidosRegistroLanches in 'uFrmPedidosRegistroLanches.pas' {FrmPedidosRegistroLanches},
  uFrmIngredientesListagem in 'uFrmIngredientesListagem.pas' {FrmIngredientesListagem},
  uFrmComanda in 'uFrmComanda.pas' {FrmComanda},
  uFrmPedidosListagem in 'uFrmPedidosListagem.pas' {FrmPedidosListagem};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmAbertura, FrmAbertura);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TFrmComanda, FrmComanda);
  Application.CreateForm(TFrmPedidosListagem, FrmPedidosListagem);
  Application.Run;
end.

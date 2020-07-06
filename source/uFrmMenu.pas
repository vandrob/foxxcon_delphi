unit uFrmMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, Buttons, ExtCtrls,     ActnList;

type
  TFrmMenu = class(TForm)
    Image1: TImage;
    btnSair: TLabel;
    btnIngredientes: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    lblVersao: TLabel;
    ActionList1: TActionList;
    ActionIngredientes: TAction;
    ActionLanches: TAction;
    ActionCardapio: TAction;
    ActionPedidos: TAction;
    ActionSair: TAction;
    procedure btnSairClick(Sender: TObject);
    function CapturarVersaoExe: string;
    procedure FormCreate(Sender: TObject);
    procedure ActionSairExecute(Sender: TObject);
    procedure SairSistema();
    procedure ActionIngredientesExecute(Sender: TObject);
    procedure ActionLanchesExecute(Sender: TObject);
    procedure ActionCardapioExecute(Sender: TObject);
    procedure ActionPedidosExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

uses uDataModule, uFrmIngredientes, uFrmLanches,  uFrmCardapio,
  uFrmPedidos;
{$R *.dfm}

procedure TFrmMenu.btnSairClick(Sender: TObject);
begin
 SairSistema;
end;

function TFrmMenu.CapturarVersaoExe: string;
var
  Rec: LongRec;
begin
  Rec := LongRec(GetFileVersion(ParamStr(0)));
  Result := Format('%d.%d', [Rec.Hi, Rec.Lo])

end;

procedure TFrmMenu.FormCreate(Sender: TObject);
begin
 lblVersao.Caption:='Versão:'+CapturarVersaoExe();
end;

procedure TFrmMenu.ActionSairExecute(Sender: TObject);
begin
 SairSistema;
end;

procedure TFrmMenu.SairSistema;
begin
 DataModule1.ADOConnection1.Connected:=false;
 Application.Terminate;
end;

procedure TFrmMenu.ActionIngredientesExecute(Sender: TObject);
begin
 if not assigned(FrmIngredientes) then
                 FrmIngredientes:=TFrmIngredientes.Create(Application);
                 FrmIngredientes.ShowModal;
                 FreeAndNil(FrmIngredientes);
end;

procedure TFrmMenu.ActionLanchesExecute(Sender: TObject);
begin
 if not assigned(FrmLanches) then
                 FrmLanches:=TFrmLanches.Create(Application);
                 FrmLanches.ShowModal;
                 FreeAndNil(FrmLanches);
end;

procedure TFrmMenu.ActionCardapioExecute(Sender: TObject);
begin
 uDataModule.DataModule1.qryCardapio.Open;
 uDataModule.DataModule1.qryCardapio_Itens.Open;
 if not assigned(FrmCardapio) then FrmCardapio:=TFrmCardapio.Create(Application);
                 FrmCardapio.QuickRep1.Preview;
                 FreeAndNil(FrmCardapio);
 uDataModule.DataModule1.qryCardapio.close;
 uDataModule.DataModule1.qryCardapio_Itens.close;
end;

procedure TFrmMenu.ActionPedidosExecute(Sender: TObject);
begin
if not assigned(FrmPedidos) then
                 FrmPedidos:=TFrmPedidos.Create(Application);
                 FrmPedidos.ShowModal;
                 FreeAndNil(FrmPedidos);
end;

end.

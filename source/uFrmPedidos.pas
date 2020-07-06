unit uFrmPedidos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids;

type
  TFrmPedidos = class(TForm)
    grpGrid: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnExcluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnIncluir: TBitBtn;
    DBNavigator1: TDBNavigator;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    btnprinter: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnprinterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPedidos: TFrmPedidos;

implementation

uses uDatamodule,uFuncoes, uFrmPedidosRegistro, uFrmLanchesRegistro,
  uFrmComanda, uFrmPedidosListagem;
{$R *.dfm}

procedure TFrmPedidos.FormCreate(Sender: TObject);
begin
  uDataModule.DataModule1.qryPedidos.Open;
  uDataModule.DataModule1.qryPedidos.Open;

end;

procedure TFrmPedidos.DBGrid1TitleClick(Column: TColumn);
var
   i: Integer;
   strSQL:String;
begin

      with DBGrid1 do
      for i := 0 to Columns.Count - 1 do
         Columns[i].Title.Font.Style := Columns[i].Title.Font.Style - [fsBold];
         Column.Title.Font.Style := Column.Title.Font.Style + [fsBold]
      ;
      strSQL:='SELECT * FROM pedidos ORDER BY '+Column.FieldName;

      with uDataModule.DataModule1.qryPedidos do begin
         DisableControls;
         Close;
         SQL.Clear;
         SQL.Add(strSQL);
         Open;
         EnableControls;
     end;


end;

procedure TFrmPedidos.btnIncluirClick(Sender: TObject);
begin
  //Chama a tela de registro
  if not assigned(FrmPedidosRegistro) then
                 FrmPedidosRegistro:=TFrmPedidosRegistro.Create(Application);
                 FrmPedidosRegistro.Caption          :='[ INCLUIR ]' ;
                 FrmPedidosRegistro.txtCodigo.text:='[ NOVO ]';
                 FrmPedidosRegistro.txtCliente.Text:='';
                 FrmPedidosRegistro.txtValor_Lanches.Caption:='0,00';
                 FrmPedidosRegistro.txtValor_Adicionais.Caption:='0,00';
                 FrmPedidosRegistro.txtValor_Pedido.Caption:='0,00';
                 FrmPedidosRegistro.txtValor_Desconto.Caption:='0,00';
                 FrmPedidosRegistro.txtValor_Total.Caption:='0,00';
                 FrmPedidosRegistro.txtQtd_Lanches.Caption:='0,00';
                 FrmPedidosRegistro.txtPercentual_Desconto.Caption:='0,00';

                 //Ativa a edição
                 FrmPedidosRegistro.txtCliente.Enabled:=true;
                 FrmPedidosRegistro.txtMesa.Enabled:=true;
                 FrmPedidosRegistro.txtEndereco.Enabled:=true;

                 FrmPedidosRegistro.GrupoItens.Enabled:=true;



                 FrmPedidosRegistro.txtCliente.Enabled:=true;


                 FrmPedidosRegistro.ShowModal;
                 FreeAndNil(FrmPedidosRegistro);
end;

procedure TFrmPedidos.btnExcluirClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryPedidos.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;
 //Chama a tela de registro
  if not assigned(FrmPedidosRegistro) then
                 FrmPedidosRegistro:=TFrmPedidosRegistro.Create(Application);
                 FrmPedidosRegistro.Caption            :='[ EXCLUIR ]';
                 FrmPedidosRegistro.txtCodigo.text             := Datamodule1.qryPedidosidpedido.AsString;
                 FrmPedidosRegistro.txtCliente.Text               := Datamodule1.qryPedidoscliente.AsString;
                 FrmPedidosRegistro.txtMesa.Text                  := Datamodule1.qryPedidosmesa.AsString;
                 FrmPedidosRegistro.txtEndereco.Text              := Datamodule1.qryPedidosendereco.AsString;

                 FrmPedidosRegistro.txtQtd_Lanches.Caption        :=Datamodule1.qryPedidosqtd_lanches.AsString;
                 FrmPedidosRegistro.txtPercentual_Desconto.Caption:=Datamodule1.qryPedidospercentual_desconto.AsString;
                 FrmPedidosRegistro.txtValor_Lanches.Caption      :=FormatarValores(DataModule1.qryPedidosvalor_lanches.AsString);
                 FrmPedidosRegistro.txtValor_Adicionais.Caption   :=FormatarValores(Datamodule1.qryPedidosvalor_adicionais.AsString);
                 FrmPedidosRegistro.txtValor_Pedido.Caption       :=FormatarValores(Datamodule1.qryPedidosvalor_adicionais.AsString);
                 FrmPedidosRegistro.txtValor_Desconto.Caption     :=FormatarValores(Datamodule1.qryPedidosvalor_desconto.AsString);
                 FrmPedidosRegistro.txtValor_Total.Caption        :=FormatarValores(Datamodule1.qryPedidosvalor_total.AsString);


                 //Desativa a edição
                 FrmPedidosRegistro.txtCliente.Enabled:=false;
                 FrmPedidosRegistro.txtMesa.Enabled:=false;
                 FrmPedidosRegistro.txtEndereco.Enabled:=false;

                 FrmPedidosRegistro.GrupoItens.Enabled:=false;

                 FrmPedidosRegistro.btnAcao.Caption:='Confirmar a Exclusão';
                 FrmPedidosRegistro.btnRetornar.Caption:='Retornar';

                 FrmPedidosRegistro.ShowModal;
                 FreeAndNil(FrmPedidosRegistro);

end;

procedure TFrmPedidos.btnAlterarClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryPedidos.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;
 //Chama a tela de registro
  if not assigned(FrmPedidosRegistro) then
                 FrmPedidosRegistro:=TFrmPedidosRegistro.Create(Application);
                 FrmPedidosRegistro.Caption            :='[ ALTERAR ]';
                 FrmPedidosRegistro.txtCodigo.text             := Datamodule1.qryPedidosidpedido.AsString;
                 FrmPedidosRegistro.txtCliente.Text               := Datamodule1.qryPedidoscliente.AsString;
                 FrmPedidosRegistro.txtMesa.Text                  := Datamodule1.qryPedidosmesa.AsString;
                 FrmPedidosRegistro.txtEndereco.Text              := Datamodule1.qryPedidosendereco.AsString;

                 FrmPedidosRegistro.txtQtd_Lanches.Caption        :=Datamodule1.qryPedidosqtd_lanches.AsString;
                 FrmPedidosRegistro.txtPercentual_Desconto.Caption:=Datamodule1.qryPedidospercentual_desconto.AsString;


                 FrmPedidosRegistro.txtValor_Lanches.Caption      :=FormatarValores(DataModule1.qryPedidosvalor_lanches.AsString);
                 FrmPedidosRegistro.txtValor_Adicionais.Caption   :=FormatarValores(Datamodule1.qryPedidosvalor_adicionais.AsString);
                 FrmPedidosRegistro.txtValor_Pedido.Caption       :=FormatarValores(Datamodule1.qryPedidosvalor_adicionais.AsString);
                 FrmPedidosRegistro.txtValor_Desconto.Caption     :=FormatarValores(Datamodule1.qryPedidosvalor_desconto.AsString);
                 FrmPedidosRegistro.txtValor_Total.Caption        :=FormatarValores(Datamodule1.qryPedidosvalor_total.AsString);

                 //Ativa a edição
                 FrmPedidosRegistro.txtCliente.Enabled:=true;
                 FrmPedidosRegistro.txtMesa.Enabled:=true;
                 FrmPedidosRegistro.txtEndereco.Enabled:=true;

                 FrmPedidosRegistro.GrupoItens.Enabled:=true;


                 FrmPedidosRegistro.ShowModal;
                 FreeAndNil(FrmPedidosRegistro);
end;

procedure TFrmPedidos.DBGrid1DblClick(Sender: TObject);
begin
 btnAlterar.Click;
end;

procedure TFrmPedidos.BitBtn1Click(Sender: TObject);
var
 strIdPedido:string;
begin

 Datamodule1.qryComanda.Close;
 Datamodule1.qryComanda_Itens.Close;

 strIdPedido:= trimright(trimleft(Datamodule1.qryPedidosidpedido.AsString));
 if (strIdPedido='') or (strIdPedido='0') then exit;

 if not assigned(FrmComanda) then FrmComanda:=TFrmComanda.Create(Application);

 Datamodule1.qryComanda.Parameters[0].Value:=strIdPedido;
 Datamodule1.qryComanda_Itens.Parameters[0].Value:=strIdPedido;
 Datamodule1.qryComanda_Itens.Parameters[1].Value:=strIdPedido;

 Datamodule1.qryComanda.open;
 Datamodule1.qryComanda_Itens.open;

 FrmComanda.QuickRep1.Preview;
 FreeAndNil(FrmComanda);




 Datamodule1.qryComanda.Close;
 Datamodule1.qryComanda_Itens.Close;

end;

procedure TFrmPedidos.btnprinterClick(Sender: TObject);

begin


 if not assigned(FrmPedidosListagem) then FrmPedidosListagem:=TFrmPedidosListagem.Create(Application);
 FrmPedidosListagem.QuickRep1.Preview;
 FreeAndNil(FrmPedidosListagem);


end;

end.

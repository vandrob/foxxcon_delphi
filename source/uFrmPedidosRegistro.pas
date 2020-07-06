unit uFrmPedidosRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons;

type
  TFrmPedidosRegistro = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnRetornar: TBitBtn;
    btnAcao: TBitBtn;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    txtCliente: TEdit;
    txtEndereco: TEdit;
    StaticText3: TStaticText;
    txtMesa: TEdit;
    StaticText5: TStaticText;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Shape2: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Shape3: TShape;
    GrupoItens: TGroupBox;
    GroupBox4: TGroupBox;
    grpGrid: TGroupBox;
    Panel1: TPanel;
    Image1: TImage;
    btnExcluirIngrediente: TBitBtn;
    btnAlterarIngrediente: TBitBtn;
    btnIncluirIngrediente: TBitBtn;
    DBNavigator1: TDBNavigator;
    Panel3: TPanel;
    Image2: TImage;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    DBGrid2: TDBGrid;
    btnIncluirLanche: TBitBtn;
    DBNavigator2: TDBNavigator;
    btnAlteraLanche: TBitBtn;
    btnExcluirLanche: TBitBtn;
    DBGrid1: TDBGrid;
    txtValor_Lanches: TStaticText;
    txtValor_Adicionais: TStaticText;
    txtValor_Pedido: TStaticText;
    txtValor_Desconto: TStaticText;
    txtValor_Total: TStaticText;
    txtQtd_Lanches: TStaticText;
    txtPercentual_Desconto: TStaticText;
    txtCodigo: TEdit;
    procedure btnRetornarClick(Sender: TObject);
    procedure btnAcaoClick(Sender: TObject);
    procedure txtClienteExit(Sender: TObject);
    procedure txtEnderecoExit(Sender: TObject);
    procedure txtMesaExit(Sender: TObject);
    procedure btnIncluirLancheClick(Sender: TObject);
    procedure btnAlteraLancheClick(Sender: TObject);
    procedure btnExcluirLancheClick(Sender: TObject);
    procedure btnIncluirIngredienteClick(Sender: TObject);
    procedure btnAlterarIngredienteClick(Sender: TObject);
    procedure btnExcluirIngredienteClick(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtCodigoChange(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
        procedure forcarInsercaoRegistro;
        procedure abrirItensdoPedido;
        function  camposObrigatoriosPreenchidos:Boolean;
        procedure atualizarQuadroTotalizador;


  public
    { Public declarations }
  end;

var
  FrmPedidosRegistro: TFrmPedidosRegistro;

implementation

uses  uDataModule, uFuncoes , uFrmPedidosRegistroLanches,
  uFrmPedidosRegistroAdicionais;

{$R *.dfm}

procedure TFrmPedidosRegistro.btnRetornarClick(Sender: TObject);
begin
 close;
end;

procedure TFrmPedidosRegistro.btnAcaoClick(Sender: TObject);
var
    strSQL:string;
    strOpcao:string;
    strProximoID:string;
begin
 strOpcao :=trimright(trimleft( FrmPedidosRegistro.Caption ));

 //consiste os preenchimentos
 if strOpcao<>'[ EXCLUIR ]' then begin
  if not CamposObrigatoriosPreenchidos then exit;
 end;
 //Monta a String de Inserção/Atualização.
 strSQL:='';



 if strOpcao='[ INCLUIR ]' then
  begin
   strProximoID:=proximoID('pedidos','idpedido');
   txtCodigo.Text:=strProximoID;
   strSQL:='INSERT INTO pedidos ('+
                                  ' idpedido,cliente,mesa,endereco,'+
                                  ' qtd_lanches,percentual_desconto,'+
                                  ' valor_lanches,'+
                                  ' valor_adicionais,'+
                                  ' valor_pedido,'+
                                  ' valor_desconto,'+
                                  ' valor_total) '+
         '            VALUES   '+
         ' ( '+
         #39+ strProximoID +#39+ ',' +
         #39+ trimright(trimleft( Uppercase(txtCliente.Text ))) +#39+ ',' +
         #39+ trimright(trimleft( Uppercase(txtMesa.Text ))) +#39+ ',' +
         #39+ trimright(trimleft( Uppercase(txtEndereco.Text ))) +#39+ ',' +
         #39+ trimright(trimleft( txtQtd_Lanches.caption )) +#39+ ',' +
         #39+ trimright(trimleft( txtPercentual_Desconto.caption )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor_Lanches.caption )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor_Adicionais.caption )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor_Pedido.caption )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor_Desconto.caption )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor_total.caption )) +#39+ 
         ' )';

  end
 else if strOpcao='[ ALTERAR ]' then
  begin
    strSQL:='UPDATE pedidos SET '+
            '   cliente             = ' +#39+ trimright(trimleft( txtCliente.Text ))                +#39+ ',' +
            '   mesa                = ' +#39+ trimright(trimleft( txtMesa.Text ))                   +#39+ ',' +
            '   endereco            = ' +#39+ trimright(trimleft( txtEndereco.Text ))               +#39+ 
            ' WHERE  idpedido       = ' +trimright(trimleft( txtCodigo.text )) ;
  end
 else if strOpcao='[ EXCLUIR ]' then
  begin
    strSQL:='DELETE FROM pedidos  '+
            ' WHERE  idpedido     = ' +trimright(trimleft( txtCodigo.text)) ;
  end
 ;
 if (strSQL<>'') then begin
  comandoSQL(strSQL);
  atualizarQuadroTotalizador;
  datamodule1.qryPedidos.Requery;
 end;
 Close;

end;

procedure TFrmPedidosRegistro.txtClienteExit(Sender: TObject);
begin
 txtCliente.Text:=trimright(trimleft( uppercase( txtCliente.Text )));
end;

procedure TFrmPedidosRegistro.txtEnderecoExit(Sender: TObject);
begin
txtEndereco.Text:=trimright(trimleft( uppercase( txtEndereco.Text )));
end;

procedure TFrmPedidosRegistro.txtMesaExit(Sender: TObject);
begin
txtMesa.Text:=trimright(trimleft( uppercase( txtMesa.Text )));
end;

procedure TFrmPedidosRegistro.forcarInsercaoRegistro;

//salvar anteriormente o registro para obter o id mantendo obrigatoriedade relacional 1xN
//e mudar a opção para ALTERAR registro
var strSQL,strProximoID:String;
begin
   strProximoID:=proximoID('pedidos','idpedido');
   strSQL:='INSERT INTO pedidos (idpedido,qtd_lanches,percentual_desconto,valor_lanches,valor_adicionais,valor_pedido,valor_desconto,valor_total) '+
         '            VALUES   '+
         ' ( '+
         #39+ strProximoID +#39+ ',' +
         #39+ '0' +#39+ ',' +
         #39+ '0' +#39+ ',' +
         #39+ '0' +#39+ ',' +
         #39+ '0' +#39+ ',' +
         #39+ '0' +#39+ ',' +
         #39+ '0' +#39+ ',' +
         #39+ '0' +#39+ 
         ' )';

   comandoSQL(strSQL);


   //muda o status para alteracao
   FrmPedidosRegistro.Caption:='[ ALTERAR ]';
   FrmPedidosRegistro.txtCodigo.text:=strProximoID;
  
end;

procedure TFrmPedidosRegistro.btnIncluirLancheClick(Sender: TObject);

var
 sStatus:string;
begin
 sStatus:=trimright(trimleft(txtCodigo.text));
 if (sStatus='[ NOVO ]') then
  begin
   //showmessage( 'Para Efetuarmos Lançamentos de Ingredientes,'+#13+#10+'Iremos efetuar a Gravação do Registro corrente...'+#13+#10+#13+#10+'Clique em [OK] para continuar...' );
   forcarInsercaoRegistro;
  end;

if not assigned(FrmPedidosRegistroLanches) then   FrmPedidosRegistroLanches:=TFrmPedidosRegistroLanches.create(application);

 FrmPedidosRegistroLanches.Caption            :='[ INCLUIR ]';

 FrmPedidosRegistroLanches.txtCodigo.Caption:= '[ NOVO ]';
 FrmPedidosRegistroLanches.txtIdPedido.Caption:= TrimRight(TrimLeft( txtCodigo.text ));
 FrmPedidosRegistroLanches.txtIdLanche.Text:= '0';
 FrmPedidosRegistroLanches.txtQtd.Text:= '0';
 FrmPedidosRegistroLanches.txtValorUnitario.Caption:= '0';
 FrmPedidosRegistroLanches.txtValor.Caption:= '0';

 FrmPedidosRegistroLanches.Showmodal;
 FreeAndNil(FrmPedidosRegistroLanches);
 atualizarQuadroTotalizador;
 abrirItensdoPedido;
end;

function TFrmPedidosRegistro.camposObrigatoriosPreenchidos: Boolean;

var
      s:string;
      status:boolean;
begin
 status:=true;
 s:=trimright(trimleft( txtCliente.Text ));
 if (s='') then begin
  showmessage('Informe o campo: Nome do Cliente');
  status:=false;
  result:=status;
  exit;
 end;



  result:=status;
end;

procedure TFrmPedidosRegistro.atualizarQuadroTotalizador;
var
 strRetorno:string;
 strIdPedido:string;
 strSQL:string;
 qtdLanches:integer;
 vlrLanches,percDesconto,vlrDesconto,vlrAdicionais,vlrPedido,vlrTotal:real;
begin
  //------------------------------------------------------------------
  //Rotina para atualização dos totais e calculo do desconto
  // regra de desconto:   2 lanches: 3% de desconto
  //                      3 lanches: 5% de desconto
  //                    >=5 lanches: 10% de desconto
  //-----------------------------------------------------------------
  txtQtd_lanches.Caption        := '0';
  txtPercentual_Desconto.Caption:= '0';
  txtQtd_lanches.Caption        := '0';
  txtValor_lanches.Caption      := '0,00';
  txtValor_adicionais.Caption   := '0,00';
  txtValor_pedido.Caption       := '0,00';
  txtValor_desconto.Caption     := '0,00';
  txtValor_total.Caption        := '0,00';


  strIdPedido:=trimright(trimleft(txtCodigo.text));
  if (strIdPedido='[ NOVO ]') or (strIdPedido='000') then strIdPedido:='0';

  //------------------------------------------
  //Computando vlr,qtd de lanches e desconto
  //------------------------------------------
  strSQL:='SELECT SUM( valortotal ) as v from pedidos_lanches WHERE idpedido='+strIdPedido;
  strRetorno:=qryRetorno(strSQL);   if strRetorno='' then strRetorno:='0';
  vlrLanches:=strToFloat(strRetorno) ;
  //quantidade de lanches
  strSQL:='SELECT SUM( qtd ) as q from pedidos_lanches WHERE idpedido='+strIdPedido;
  strRetorno:=qryRetorno(strSQL);   if strRetorno='' then strRetorno:='0';
  qtdLanches:=strtoint(strRetorno);
  percDesconto:=0;
  if ( qtdLanches=2 ) then
      percDesconto:=3
  else if ( qtdLanches=3 ) then
      percDesconto:=5
  else if (qtdLanches>=5) then
      percDesconto:=10
  ;
  vlrDesconto:=0;
  if (percDesconto>0) and (vlrLanches>0) then begin
     vlrDesconto:= (vlrLanches * ( percDesconto/100 ) );
  end;
  //---------------------------------------------------------------------------------------------


  //-----------------------
  //total dos itens:adicionais
  //-----------------------
  strSQL:='SELECT SUM( valortotal ) as v from pedidos_adicionais WHERE idpedido='+strIdPedido;
  strRetorno:=qryRetorno(strSQL);   if strRetorno='' then strRetorno:='0';
  vlrAdicionais:=strTofloat( strRetorno );
  //---------------------------------------------------------------------------------------------


  vlrPedido:= ( vlrLanches + vlrAdicionais ) ;

  vlrTotal := ( vlrPedido - vlrDesconto );


  //---------------------------
  //atualizar a tela
  //---------------------------
  txtQtd_lanches.Caption        :=  IntToStr(   qtdLanches ) ;
  txtPercentual_Desconto.Caption:= FormatarValores( FloatToStr( percDesconto ) ) + ' %';
  txtValor_lanches.Caption      := FormatarValores( FloatToStr( vlrLanches ) );
  txtValor_adicionais.Caption   := FormatarValores( FloatToStr( vlrAdicionais ) );
  txtValor_pedido.Caption       := FormatarValores( FloatToStr( vlrPedido ) );
  txtValor_desconto.Caption     := FormatarValores( FloatToStr( vlrDesconto ) );
  txtValor_total.Caption        := FormatarValores( FloatToStr( vlrTotal ) );


  //---------------------------
  //atualizar a base de dados
  //---------------------------
  strSQL:='UPDATE pedidos SET '+
                        '   valor_lanches       ='+#39+ FormatarValores( FloatToStr( vlrLanches ) ) +#39+','+
                        '   valor_adicionais    ='+#39+ FormatarValores( FloatToStr( vlrAdicionais ) ) +#39+','+
                        '   valor_pedido        ='+#39+ FormatarValores( FloatToStr( vlrPedido ) ) +#39+','+
                        '   valor_desconto      ='+#39+ FormatarValores( FloatToStr( vlrDesconto ) ) +#39+','+
                        '   valor_total         ='+#39+ FormatarValores( FloatToStr( vlrTotal ) ) +#39+','+
                        '   qtd_lanches         ='+#39+ FormatarValores( FloatToStr( qtdLanches ) ) +#39+','+
                        '   percentual_desconto ='+#39+ FormatarValores( FloatToStr( percDesconto ) ) +#39+
                        ' WHERE  '+
                        '   idpedido=' + strIdPedido;
                        
  comandoSQL(strSQL);
end;

procedure TFrmPedidosRegistro.btnAlteraLancheClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryPedidos_Lanches.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 if not assigned(FrmPedidosRegistroLanches) then   FrmPedidosRegistroLanches:=TFrmPedidosRegistroLanches.create(application);

 FrmPedidosRegistroLanches.Caption                  :='[ ALTERAR ]';

 FrmPedidosRegistroLanches.txtCodigo.Caption        := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesid.AsString));
 FrmPedidosRegistroLanches.txtIdPedido.Caption      := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesidpedido.AsString));
 FrmPedidosRegistroLanches.txtIdLanche.Text         := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesidlanche.AsString));
 FrmPedidosRegistroLanches.txtQtd.Text              := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesqtd.AsString ));
 FrmPedidosRegistroLanches.txtValorUnitario.Caption := FormatarValores(Trimright(trimleft(Datamodule1.qryPedidos_Lanchesvalorunitario.AsString )));
 FrmPedidosRegistroLanches.txtValor.Caption         := FormatarValores(Trimright(trimleft(Datamodule1.qryPedidos_Lanchesvalortotal.AsString )));

 FrmPedidosRegistroLanches.Showmodal;
 FreeAndNil(FrmPedidosRegistroLanches);
 atualizarQuadroTotalizador;
 abrirItensdoPedido;
end;

procedure TFrmPedidosRegistro.btnExcluirLancheClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryPedidos_Lanches.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 if not assigned(FrmPedidosRegistroLanches) then   FrmPedidosRegistroLanches:=TFrmPedidosRegistroLanches.create(application);

 FrmPedidosRegistroLanches.Caption                  :='[ EXCLUIR ]';

 FrmPedidosRegistroLanches.txtCodigo.Caption        := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesid.AsString));
 FrmPedidosRegistroLanches.txtIdPedido.Caption      := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesidpedido.AsString));
 FrmPedidosRegistroLanches.txtIdLanche.Text         := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesidlanche.AsString));
 FrmPedidosRegistroLanches.txtQtd.Text              := Trimright(trimleft(Datamodule1.qryPedidos_Lanchesqtd.AsString ));

 FrmPedidosRegistroLanches.txtValorUnitario.Caption := FormatarValores(Trimright(trimleft(Datamodule1.qryPedidos_Lanchesvalorunitario.AsString )));
 FrmPedidosRegistroLanches.txtValor.Caption         := FormatarValores(Trimright(trimleft(Datamodule1.qryPedidos_Lanchesvalortotal.AsString )));


                 FrmPedidosRegistroLanches.txtQtd.Enabled:=false;
                 FrmPedidosRegistroLanches.btnPesquisar.Enabled:=false;


                 FrmPedidosRegistroLanches.btnAcao.Caption:='Confirmar a Exclusão';
                 FrmPedidosRegistroLanches.btnRetornar.Caption:='Retornar';


 FrmPedidosRegistroLanches.Showmodal;
 FreeAndNil(FrmPedidosRegistroLanches);
 atualizarQuadroTotalizador;
 abrirItensdoPedido; 
end;

procedure TFrmPedidosRegistro.btnIncluirIngredienteClick(Sender: TObject);
var
 sStatus:string;
begin
 sStatus:=trimright(trimleft(txtCodigo.text));
 if (sStatus='[ NOVO ]') then
  begin
   //showmessage( 'Para Efetuarmos Lançamentos de Ingredientes Adicionais,'+#13+#10+'Iremos efetuar a Gravação do Registro corrente...'+#13+#10+#13+#10+'Clique em [OK] para continuar...' );
   forcarInsercaoRegistro;
  end;

if not assigned(FrmPedidosRegistroAdicionais) then   FrmPedidosRegistroAdicionais:=TFrmPedidosRegistroAdicionais.create(application);

 FrmPedidosRegistroAdicionais.Caption            :='[ INCLUIR ]';

 FrmPedidosRegistroAdicionais.txtCodigo.Caption:= '[ NOVO ]';
 FrmPedidosRegistroAdicionais.txtIdPedido.Caption:= TrimRight(TrimLeft( txtCodigo.text ));
 FrmPedidosRegistroAdicionais.txtIdIngrediente.Text:= '0';
 FrmPedidosRegistroAdicionais.txtQtd.Text:= '0';
 FrmPedidosRegistroAdicionais.txtValorUnitario.Caption:= '0';
 FrmPedidosRegistroAdicionais.txtValor.Caption:= '0';

 FrmPedidosRegistroAdicionais.Showmodal;
 FreeAndNil(FrmPedidosRegistroAdicionais);
 atualizarQuadroTotalizador;
 abrirItensdoPedido; 
end;

procedure TFrmPedidosRegistro.btnAlterarIngredienteClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryPedidos_Adicionais.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 if not assigned(FrmPedidosRegistroAdicionais) then   FrmPedidosRegistroAdicionais:=TFrmPedidosRegistroAdicionais.create(application);

 FrmPedidosRegistroAdicionais.Caption                  :='[ ALTERAR ]';

 FrmPedidosRegistroAdicionais.txtCodigo.Caption        := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisid.AsString));
 FrmPedidosRegistroAdicionais.txtIdPedido.Caption      := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisidpedido.AsString));
 FrmPedidosRegistroAdicionais.txtIdIngrediente.Text    := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisidingrediente.AsString));
 FrmPedidosRegistroAdicionais.txtQtd.Text              := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisqtd.AsString));
 FrmPedidosRegistroAdicionais.txtValorUnitario.Caption := FormatarValores(Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisvalorunitario.AsString) ));
 FrmPedidosRegistroAdicionais.txtValor.Caption         := FormatarValores(Trimright(trimleft( Datamodule1.qryPedidos_Adicionaisvalortotal.AsString)));

 FrmPedidosRegistroAdicionais.Showmodal;
 FreeAndNil(FrmPedidosRegistroAdicionais);
 atualizarQuadroTotalizador;
 abrirItensdoPedido;
end;

procedure TFrmPedidosRegistro.btnExcluirIngredienteClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryPedidos_Lanches.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 if not assigned(FrmPedidosRegistroAdicionais) then   FrmPedidosRegistroAdicionais:=TFrmPedidosRegistroAdicionais.create(application);

 FrmPedidosRegistroAdicionais.Caption                  :='[ EXCLUIR ]';


 FrmPedidosRegistroAdicionais.txtCodigo.Caption        := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisid.AsString));
 FrmPedidosRegistroAdicionais.txtIdPedido.Caption      := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisidpedido.AsString));
 FrmPedidosRegistroAdicionais.txtIdIngrediente.Text    := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisidingrediente.AsString));
 FrmPedidosRegistroAdicionais.txtQtd.Text              := Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisqtd.AsString));
 FrmPedidosRegistroAdicionais.txtValorUnitario.Caption := FormatarValores(Trimright(trimleft(Datamodule1.qryPedidos_Adicionaisvalorunitario.AsString) ));
 FrmPedidosRegistroAdicionais.txtValor.Caption         := FormatarValores(Trimright(trimleft( Datamodule1.qryPedidos_Adicionaisvalortotal.AsString)));


                 FrmPedidosRegistroAdicionais.txtQtd.Enabled:=false;
                 FrmPedidosRegistroAdicionais.btnPesquisar.Enabled:=false;


                 FrmPedidosRegistroAdicionais.btnAcao.Caption:='Confirmar a Exclusão';
                 FrmPedidosRegistroAdicionais.btnRetornar.Caption:='Retornar';


 FrmPedidosRegistroAdicionais.Showmodal;
 FreeAndNil(FrmPedidosRegistroAdicionais);
 atualizarQuadroTotalizador;
 abrirItensdoPedido;
end;

procedure TFrmPedidosRegistro.DBGrid2DblClick(Sender: TObject);
begin
 btnAlteraLanche.Click;
end;

procedure TFrmPedidosRegistro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 Datamodule1.qryPedidos_Lanches.Close;
 Datamodule1.qryPedidos_Adicionais.Close;

end;

procedure TFrmPedidosRegistro.abrirItensdoPedido;
var
 strIdPedido:string;
 strSQL:String;
begin
strIdPedido:= trimright(trimleft(txtCodigo.text));

Datamodule1.qryPedidos_Lanches.close;
Datamodule1.qryPedidos_Adicionais.Close;

if ( (strIdPedido='[ NOVO ]') or (strIdPedido='000') ) then
 begin
     exit;
 end;




  with Datamodule1.qryPedidos_Lanches do begin
    strSQL:='SELECT  PL.*,  L.nome as nome_lanche FROM  pedidos_lanches PL  INNER JOIN lanches L ON ( L.idlanche=PL.idlanche ) '+
            '  WHERE  PL.idpedido='+strIdPedido+
            '  ORDER BY   PL.idpedido,   L.nome;';

    SQL.Clear;
    SQL.Add(strSQL);
    open;
  end;
  with Datamodule1.qryPedidos_Adicionais do begin
     strSQL:='SELECT  PL.*,  I.nome as nome_ingrediente FROM  pedidos_adicionais PL  INNER JOIN ingredientes I ON ( I.idingrediente=PL.idingrediente ) '+
             ' WHERE  PL.idpedido='+strIdPedido+
             ' ORDER BY   PL.idpedido,  I.nome; ';
    SQL.Clear;
    SQL.Add(strSQL);
    open;
  end;

end;

procedure TFrmPedidosRegistro.txtCodigoChange(Sender: TObject);
begin
   abrirItensdoPedido;
end;

procedure TFrmPedidosRegistro.DBGrid1DblClick(Sender: TObject);
begin
 btnAlterarIngrediente.Click;
end;

end.

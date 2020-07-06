unit uFrmPedidosRegistroAdicionais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmPedidosRegistroAdicionais = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnRetornar: TBitBtn;
    btnAcao: TBitBtn;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    StaticText2: TStaticText;
    txtQtd: TEdit;
    btnPesquisar: TBitBtn;
    StaticText5: TStaticText;
    txtValorUnitario: TStaticText;
    txtValor: TStaticText;
    txtIdIngrediente: TEdit;
    txtCodigo: TStaticText;
    txtNomeLanche: TStaticText;
    txtIdPedido: TStaticText;
    procedure btnRetornarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure txtIdIngredienteChange(Sender: TObject);
    procedure txtQtdChange(Sender: TObject);
    procedure btnAcaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure atualizarTotal;
  public
    { Public declarations }
  end;

var
  FrmPedidosRegistroAdicionais: TFrmPedidosRegistroAdicionais;

implementation

uses uFrmPesquisar,ufuncoes, uDataModule;

{$R *.dfm}

procedure TFrmPedidosRegistroAdicionais.btnRetornarClick(Sender: TObject);
begin
 close;
end;

procedure TFrmPedidosRegistroAdicionais.btnPesquisarClick(Sender: TObject);
begin
 if not assigned(FrmPesquisar) then FrmPesquisar:=TFrmPesquisar.Create(Application);
 uFrmPesquisar.strTabela:='ingredientes';
 FrmPesquisar.ShowModal;
 txtIdIngrediente.Text:=uFrmPesquisar.strIdCapturado;
 if (strValorCapturado='') then strValorCapturado:='0';
 txtValorUnitario.Caption:=FormatarValores(uFrmPesquisar.strValorCapturado);
 //atualizarTotal;
 FreeAndNil(FrmPesquisar);
 txtQtd.SetFocus;
end;

procedure TFrmPedidosRegistroAdicionais.txtIdIngredienteChange(Sender: TObject);
var
   strNome:string;
   strIdIngrediente:string;
begin
 strNome:='';
 strIdIngrediente:=trimright(trimleft(txtIdIngrediente.Text));
 if (strIdIngrediente<>'') then  strNome:=qryRetorno( 'SELECT nome FROM ingredientes WHERE idingrediente='+strIdIngrediente+' ORDER BY idingrediente ');
 txtNomeLanche.Caption:=strNome;

end;

procedure TFrmPedidosRegistroAdicionais.atualizarTotal;
var
 sQtd,sVlrUnitario:string;
begin
  //atualizar o total do lançamento
  sQtd:=txtQtd.Text;
  sVlrUnitario:=txtValorUnitario.Caption;

  if (sQtd='') then sQtd:='0';
  if (sVlrUnitario='') then sVlrUnitario:='0';

  txtValor.Caption:= FormatarValores( FloatToStr(StrToFloat(sQtd) * strToFloat( sVlrUnitario )));



end;

procedure TFrmPedidosRegistroAdicionais.txtQtdChange(Sender: TObject);
begin
   atualizarTotal;
end;

procedure TFrmPedidosRegistroAdicionais.btnAcaoClick(Sender: TObject);
var s:string;
    cValor:real;
    strSQL:string;

    strOpcao:string;
begin
 strOpcao :=trimright(trimleft( FrmPedidosRegistroAdicionais.Caption ));

 //consiste os preenchimentos
 if strOpcao<>'[ EXCLUIR ]' then begin
  s:=trimright(trimleft( txtNomeLanche.Caption ));
  if (s='') then begin
   showmessage('Selecione um lanche a cadastrar, clique no botão pesquisar');
   btnPesquisar.setfocus;
   exit;
  end;


  cValor := StrToFloat(txtQtd.Text);
  if (cValor<=0) then begin
   showmessage('Informe o campo: Quantidade');
   txtQtd.setfocus;
   exit;
  end;
 end;

 //Monta a String de Inserção/Atualização.
  strSQL:='';

   atualizarTotal;


 if strOpcao='[ INCLUIR ]' then
  begin
   strSQL:='INSERT INTO pedidos_adicionais (idpedido,idingrediente,qtd,valorunitario,valortotal) '+
         '            VALUES   '+
         ' ( '+
          #39+ trimright(trimleft( txtIdpedido.Caption ))      +#39+ ',' +
          #39+ trimright(trimleft( txtIdIngrediente.Text ))         +#39+ ',' +
          #39+ trimright(trimleft( txtQtd.Text ))              +#39+ ',' +
          #39+ trimright(trimleft( txtValorUnitario.Caption )) +#39+ ',' +
          #39+ trimright(trimleft( txtValor.Caption ))         +#39 +
         ' )';

  end
 else if strOpcao='[ ALTERAR ]' then
  begin
    strSQL:='UPDATE pedidos_adicionais SET '+
            '   qtd    = ' +#39+ trimright(trimleft( txtQtd.Text ))              +#39+ ',' +
            '   valorunitario = ' +#39+ trimright(trimleft( txtValorUnitario.Caption )) +#39+ ',' +
            '   valortotal    = ' +#39+ trimright(trimleft( txtValor.Caption ))         +#39+
            ' WHERE  id     = ' +trimright(trimleft( txtCodigo.Caption )) ;

  end
 else if strOpcao='[ EXCLUIR ]' then
  begin
    strSQL:='DELETE FROM pedidos_adicionais  '+
            ' WHERE  id     = ' +trimright(trimleft( txtCodigo.Caption )) ;

  end
 ;

 if (strSQL<>'') then begin
  comandoSQL(strSQL);
  datamodule1.qryPedidos_Adicionais.Requery;
 end;
 Close;

end;


end.

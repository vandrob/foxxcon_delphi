unit uFrmPedidosRegistroLanches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmPedidosRegistroLanches = class(TForm)
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
    txtIdLanche: TEdit;
    txtCodigo: TStaticText;
    txtNomeLanche: TStaticText;
    txtIdPedido: TStaticText;
    procedure btnRetornarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure txtIdLancheChange(Sender: TObject);
    procedure txtQtdChange(Sender: TObject);
    procedure btnAcaoClick(Sender: TObject);
  private
    { Private declarations }
    procedure atualizarTotal;
  public
    { Public declarations }
  end;

var
  FrmPedidosRegistroLanches: TFrmPedidosRegistroLanches;

implementation

uses uFrmPesquisar,ufuncoes, uDataModule;

{$R *.dfm}

procedure TFrmPedidosRegistroLanches.btnRetornarClick(Sender: TObject);
begin
 close;
end;

procedure TFrmPedidosRegistroLanches.btnPesquisarClick(Sender: TObject);
begin
 if not assigned(FrmPesquisar) then FrmPesquisar:=TFrmPesquisar.Create(Application);
 uFrmPesquisar.strTabela:='lanches';
 FrmPesquisar.ShowModal;
 txtIdLanche.Text:=uFrmPesquisar.strIdCapturado;
 if (strValorCapturado='') then strValorCapturado:='0';
 txtValorUnitario.Caption:=FormatarValores(uFrmPesquisar.strValorCapturado);
 //atualizarTotal;
 FreeAndNil(FrmPesquisar);
 txtQtd.SetFocus;
end;

procedure TFrmPedidosRegistroLanches.txtIdLancheChange(Sender: TObject);
var
   strNome:string;
   strIdLanche:string;
begin
 strNome:='';
 strIdLanche:=trimright(trimleft(txtIdLanche.Text));
 if (strIdLanche<>'') then  strNome:=qryRetorno( 'SELECT nome FROM lanches WHERE idlanche='+strIdLanche+' ORDER BY idlanche ');
 txtNomeLanche.Caption:=strNome;

end;

procedure TFrmPedidosRegistroLanches.atualizarTotal;
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

procedure TFrmPedidosRegistroLanches.txtQtdChange(Sender: TObject);
begin
   atualizarTotal;
end;

procedure TFrmPedidosRegistroLanches.btnAcaoClick(Sender: TObject);
var s:string;
    cValor:real;
    strSQL:string;

    strOpcao:string;
begin
 strOpcao :=trimright(trimleft( FrmPedidosRegistroLanches.Caption ));
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
   strSQL:='INSERT INTO pedidos_lanches (idpedido,idlanche,qtd,valorunitario,valortotal) '+
         '            VALUES   '+
         ' ( '+
          #39+ trimright(trimleft( txtIdpedido.Caption ))      +#39+ ',' +
          #39+ trimright(trimleft( txtIdLanche.Text ))         +#39+ ',' +
          #39+ trimright(trimleft( txtQtd.Text ))              +#39+ ',' +
          #39+ trimright(trimleft( txtValorUnitario.Caption )) +#39+ ',' +
          #39+ trimright(trimleft( txtValor.Caption ))         +#39 +
         ' )';

  end
 else if strOpcao='[ ALTERAR ]' then
  begin
    strSQL:='UPDATE pedidos_lanches SET '+
            '   qtd    = ' +#39+ trimright(trimleft( txtQtd.Text ))              +#39+ ',' +
            '   valorunitario = ' +#39+ trimright(trimleft( txtValorUnitario.Caption )) +#39+ ',' +
            '   valortotal    = ' +#39+ trimright(trimleft( txtValor.Caption ))         +#39+
            ' WHERE  id     = ' +trimright(trimleft( txtCodigo.Caption )) ;

  end
 else if strOpcao='[ EXCLUIR ]' then
  begin
    strSQL:='DELETE FROM pedidos_lanches  '+
            ' WHERE  id     = ' +trimright(trimleft( txtCodigo.Caption )) ;

  end
 ;
 if (strSQL<>'') then begin
  comandoSQL(strSQL);
  datamodule1.qryPedidos_Lanches.Requery;
 end;
 Close;

end;


end.

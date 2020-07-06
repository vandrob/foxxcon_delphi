unit uFrmLanchesIngredientesRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmLanchesIngredientesRegistro = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnRetornar: TBitBtn;
    btnAcao: TBitBtn;
    StaticText1: TStaticText;
    StaticText4: TStaticText;
    StaticText2: TStaticText;
    txtQtd: TEdit;
    StaticText3: TStaticText;
    btnPesquisar: TBitBtn;
    txtIdIngrediente: TEdit;
    txtNomeIngrediente: TStaticText;
    StaticText5: TStaticText;
    txtValorUnitario: TStaticText;
    txtValor: TStaticText;
    txtIdLanche: TEdit;
    txtCodigo: TStaticText;
    txtNomeLanche: TStaticText;
    procedure btnAcaoClick(Sender: TObject);
    procedure txtValorKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisarClick(Sender: TObject);
    procedure txtIdIngredienteChange(Sender: TObject);
    procedure txtQtdChange(Sender: TObject);
    procedure txtIdLancheChange(Sender: TObject);
  private
    { Private declarations }
    procedure atualizarTotal();
    procedure atualizarSomatoriaIngredientes();
  public
    { Public declarations }
  end;

var
  FrmLanchesIngredientesRegistro: TFrmLanchesIngredientesRegistro;
implementation

uses uDataModule,uFuncoes, uFrmIngredientesRegistro, uFrmPesquisar,uFrmLanchesRegistro;

{$R *.dfm}


procedure TFrmLanchesIngredientesRegistro.btnAcaoClick(Sender: TObject);
var s:string;
    cValor:real;
    strSQL:string;

    strOpcao:string;
begin
 strOpcao :=trimright(trimleft( FrmLanchesIngredientesRegistro.Caption ));

 //consiste os preenchimentos
 if strOpcao<>'[ EXCLUIR ]' then begin
  s:=trimright(trimleft( txtNomeIngrediente.Caption ));
  if (s='') then begin
   showmessage('Selecione um Ingrediente a cadastrar, clique no botão pesquisar');
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



 if strOpcao='[ INCLUIR ]' then
  begin
   strSQL:='INSERT INTO lanches_ingredientes (idlanche,idingrediente,quantidade,valorunitario,valortotal) '+
         '            VALUES   '+
         ' ( '+
          #39+ trimright(trimleft( txtIdLanche.Text ))         +#39+ ',' +
          #39+ trimright(trimleft( txtIdIngrediente.Text ))    +#39+ ',' +
          #39+ trimright(trimleft( txtQtd.Text ))              +#39+ ',' +
          #39+ trimright(trimleft( txtValorUnitario.Caption )) +#39+ ',' +
          #39+ trimright(trimleft( txtValor.Caption ))         +#39 +
         ' )';

  end
 else if strOpcao='[ ALTERAR ]' then
  begin
    strSQL:='UPDATE lanches_ingredientes SET '+
            '   quantidade    = ' +#39+ trimright(trimleft( txtQtd.Text ))              +#39+ ',' +
            '   valorunitario = ' +#39+ trimright(trimleft( txtValorUnitario.Caption )) +#39+ ',' +
            '   valortotal    = ' +#39+ trimright(trimleft( txtValor.Caption ))         +#39+
            ' WHERE  id     = ' +trimright(trimleft( txtCodigo.Caption )) ;

  end
 else if strOpcao='[ EXCLUIR ]' then
  begin
    strSQL:='DELETE FROM lanches_ingredientes  '+
            ' WHERE  id     = ' +trimright(trimleft( txtCodigo.Caption )) ;

  end
 ;
 if (strSQL<>'') then begin
  comandoSQL(strSQL);
  datamodule1.qryLanches_Ingredientes.Requery;
  atualizarSomatoriaIngredientes;
 end;
 Close;
end;

procedure TFrmLanchesIngredientesRegistro.txtValorKeyPress(Sender: TObject;
  var Key: Char);


begin
   if not (Key in ['0'..'9',',',#8]) then
   begin
        Key := #0;
   end;


end;




procedure TFrmLanchesIngredientesRegistro.btnPesquisarClick(
  Sender: TObject);
begin
 if not assigned(FrmPesquisar) then FrmPesquisar:=TFrmPesquisar.Create(Application);
 uFrmPesquisar.strTabela:='ingredientes';
 FrmPesquisar.ShowModal;
 txtIdIngrediente.Text:=uFrmPesquisar.strIdCapturado;
 if (strValorCapturado='') then strValorCapturado:='0';
 txtValorUnitario.Caption:=FormatarValores(uFrmPesquisar.strValorCapturado);
 atualizarTotal;
 FreeAndNil(FrmPesquisar);
 txtQtd.SetFocus;
 
end;

procedure TFrmLanchesIngredientesRegistro.txtIdIngredienteChange(
  Sender: TObject);
  var
   strNome:string;
   strIdIngrediente:string;
begin
 strNome:='';
 strIdIngrediente:=trimright(trimleft(txtIdIngrediente.Text));
 if (strIdIngrediente<>'') then  strNome:=qryRetorno( 'SELECT nome FROM ingredientes WHERE idingrediente='+strIdIngrediente+' ORDER BY idingrediente ');
 txtNomeIngrediente.Caption:=strNome;

end;

procedure TFrmLanchesIngredientesRegistro.atualizarTotal;
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

procedure TFrmLanchesIngredientesRegistro.txtQtdChange(Sender: TObject);
begin
 atualizarTotal;
end;

procedure TFrmLanchesIngredientesRegistro.txtIdLancheChange(
  Sender: TObject);
 var
   strNome:string;
   strIdLanche:string;
begin
 strNome:='';
 strIdLanche:=trimright(trimleft(txtIdLanche.Text));
 if (strIdLanche<>'') then  strNome:=qryRetorno( 'SELECT nome FROM lanches WHERE idlanche='+strIdLanche+' ORDER BY idlanche ');
 txtNomeLanche.Caption:=strNome;
end;

procedure TFrmLanchesIngredientesRegistro.atualizarSomatoriaIngredientes;
var
 strValorSomatoriaIngredientes:string;
 strIdLanche:string;
 strSQL:string;
begin
  //atualizar a somatoria de todos os ingredientes para o lanche selecionado
  strIdLanche:=trimright(trimleft(txtIdLanche.Text));
  strSQL:='SELECT SUM( valortotal ) as valor from lanches_ingredientes WHERE idlanche='+strIdLanche;
  strValorSomatoriaIngredientes:=qryRetorno(strSQL);
  if strValorSomatoriaIngredientes='' then strValorSomatoriaIngredientes:='0';
  //atualizar o custo lanche..
  strSQL:='UPDATE lanches SET valor='+#39+ strValorSomatoriaIngredientes+#39+ ' WHERE idlanche=' + strIdLanche;
  comandoSQL(strSQL);
  //atualizar na tela ancestora o campo do total do lanche
  FrmLanchesRegistro.txtValor.Text:=FormatarValores( strValorSomatoriaIngredientes );
end;

end.

unit uFrmLanchesRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls,  Grids, DBGrids;

type
  TFrmLanchesRegistro = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnRetornar: TBitBtn;
    btnAcao: TBitBtn;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    txtNome: TEdit;
    txtValor: TEdit;
    StaticText3: TStaticText;
    txtDescricao: TMemo;
    grpGrid: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Image1: TImage;
    btnExcluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnIncluir: TBitBtn;
    DBNavigator1: TDBNavigator;
    txtCodigo: TEdit;
    procedure txtNomeExit(Sender: TObject);
    procedure btnAcaoClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    function  CamposObrigatoriosPreenchidos():Boolean;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormActivate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure txtCodigoChange(Sender: TObject);
  private
    procedure forcarInsercaoRegistro;
    procedure abrirIngredientesLanche();
    procedure alterarRegistroIngrediente();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLanchesRegistro: TFrmLanchesRegistro;

implementation

uses uDataModule,uFuncoes, uFrmLanchesIngredientesRegistro;


{$R *.dfm}

procedure TFrmLanchesRegistro.txtNomeExit(Sender: TObject);
begin
  txtNome.Text:= trimright(trimleft( Uppercase(txtNome.Text ) ));
end;

procedure TFrmLanchesRegistro.btnAcaoClick(Sender: TObject);
var
    strSQL:string;
    strOpcao:string;
    strProximoID:string;
begin
 strOpcao :=trimright(trimleft( FrmLanchesRegistro.Caption ));
 //consiste os preenchimentos
 if strOpcao<>'[ EXCLUIR ]' then begin
  if not CamposObrigatoriosPreenchidos then exit;
 end;
 //Monta a String de Inserção/Atualização.
 strSQL:='';



 if strOpcao='[ INCLUIR ]' then
  begin
   strProximoID:=proximoID('lanches','idlanche');
   strSQL:='INSERT INTO lanches (idlanche,nome,descricao,valor) '+
         '            VALUES   '+
         ' ( '+
         #39+ strProximoID +#39+ ',' +
         #39+ trimright(trimleft( Uppercase(txtNome.Text ))) +#39+ ',' +
         #39+ trimright(trimleft( txtDescricao.Text )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor.text )) +#39+
         ' )';
  end
 else if strOpcao='[ ALTERAR ]' then
  begin
    strSQL:='UPDATE lanches SET '+
            '   nome   = ' +#39+ trimright(trimleft( Uppercase(txtNome.Text ))) +#39+ ',' +
            '   descricao   = ' +#39+ trimright(trimleft( txtDescricao.Text )) +#39+ ',' +
            '   valor = ' +#39+ trimright(trimleft( txtValor.text )) +#39+
            ' WHERE  idlanche     = ' +trimright(trimleft( txtCodigo.text )) ;
  end
 else if strOpcao='[ EXCLUIR ]' then
  begin
    strSQL:='DELETE FROM lanches  '+
            ' WHERE  idlanche     = ' +trimright(trimleft( txtCodigo.text )) ;
  end
 ;
 if (strSQL<>'') then begin
  comandoSQL(strSQL);
  datamodule1.qryLanches.Requery;
 end;
 Close;
end;



procedure TFrmLanchesRegistro.btnIncluirClick(Sender: TObject);
var
 sStatus:string;
begin
 sStatus:=trimright(trimleft(txtCodigo.text));
 if (sStatus='[ NOVO ]') then
  begin
   //showmessage( 'Para Efetuarmos Lançamentos de Ingredientes,'+#13+#10+'Iremos efetuar a Gravação do Registro corrente...'+#13+#10+#13+#10+'Clique em [OK] para continuar...' );
   forcarInsercaoRegistro;
  end;

if not assigned(FrmLanchesIngredientesRegistro) then   FrmLanchesIngredientesRegistro:=TFrmLanchesIngredientesRegistro.create(application);

 FrmLanchesIngredientesRegistro.Caption            :='[ INCLUIR ]';
 FrmLanchesIngredientesRegistro.txtCodigo.Caption:= '[ NOVO ]';
 FrmLanchesIngredientesRegistro.txtIdIngrediente.Text:= '0';
 FrmLanchesIngredientesRegistro.txtIdLanche.Text:= TrimRight(TrimLeft( txtCodigo.text ));
 FrmLanchesIngredientesRegistro.txtQtd.Text:= '0';
 FrmLanchesIngredientesRegistro.txtValorUnitario.Caption:= '0';
 FrmLanchesIngredientesRegistro.txtValor.Caption:= '0';

 FrmLanchesIngredientesRegistro.Showmodal;
 FreeAndNil(FrmLanchesIngredientesRegistro);

end;

procedure TFrmLanchesRegistro.forcarInsercaoRegistro;
//salvar anteriormente o registro para obter o id mantendo obrigatoriedade relacional 1xN
//e mudar a opção para ALTERAR registro
var strSQL,strProximoID:String;
begin
   strProximoID:=proximoID('lanches','idlanche');
   strSQL:='INSERT INTO lanches (idlanche,nome,descricao,valor) '+
         '            VALUES   '+
         ' ( '+
         #39+ strProximoID +#39+ ',' +
         #39+ trimright(trimleft( Uppercase(txtNome.Text ))) +#39+ ',' +
         #39+ trimright(trimleft( txtDescricao.Text )) +#39+ ',' +
         #39+ trimright(trimleft( txtValor.text )) +#39+
         ' )';
    comandoSQL(strSQL);

   //muda o status para alteracao
   FrmLanchesRegistro.Caption:='[ ALTERAR ]';
   FrmLanchesRegistro.txtCodigo.text:=strProximoID;
   abrirIngredientesLanche();
end;

function TFrmLanchesRegistro.CamposObrigatoriosPreenchidos: Boolean;

var
    s:string;
    cValor:real;
    strDescricao:widestring;
    status:boolean;
begin
 status:=true;
 s:=trimright(trimleft( txtNome.Text ));
 if (s='') then begin
  showmessage('Informe o campo: Nome do Lanche');
  txtNome.setfocus;
  status:=false;
  result:=status;
  exit;
 end;


 cValor := StrToFloat(txtValor.Text);
 if (cValor<=0) then begin
  showmessage('Insira ingredientes para calcular o Valor!');
  status:=false;
  result:=status;
  exit;
 end;

 strDescricao:=trimright(trimleft( txtDescricao.Text ));
 if (strDescricao='') then begin
  showmessage('Informe o campo: Descrição do Lanche');
  txtDescricao.setfocus;
  status:=false;
  result:=status;
  exit;
 end;

  result:=status;
end;

procedure TFrmLanchesRegistro.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
   grid : TDBGrid;
   row : integer;
begin
  if Sender is TDBGrid then begin
    with (Sender as TDBGrid) do  begin
      if (gdSelected in State) then
       begin
        Canvas.Brush.Color := clblue;
       end
      else
       begin
        grid := sender as TDBGrid;
        row := grid.DataSource.DataSet.RecNo;
        if Odd(row) then
          grid.Canvas.Brush.Color := $00FFCB97
        else
          grid.Canvas.Brush.Color := $00FFAE5E;
          grid.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;
       end
      ;
    end
 end;


end;

procedure TFrmLanchesRegistro.abrirIngredientesLanche();
var
  str_idlanche:string;
  strSQL:string;
begin
 //abrir os ingredientes com estão cadastrados para o lanche
 //-------------------------------------------------------------
 str_idlanche:=trimright(trimleft( txtCodigo.text ));

 datamodule1.qryLanches_Ingredientes.Close;
 
 if ( (str_idlanche='[ NOVO ]') or (str_idlanche='000') ) then
  begin
     exit;
  end;


  with datamodule1.qryLanches_Ingredientes do begin
   disablecontrols;
   if active then close;
   strSQL:='SELECT   I.nome as ingrediente_nome,   LI.* FROM  lanches_ingredientes LI '+
           ' INNER JOIN ingredientes I ON ( I.idingrediente=LI.idingrediente) '+
           ' WHERE  LI.idlanche='+ str_idlanche+
           ' ORDER BY  I.nome,LI.idlanche';


    sql.Clear;
    sql.Add(strSQL);
    
    open;
    enablecontrols;
  end;
  
end;

procedure TFrmLanchesRegistro.FormActivate(Sender: TObject);
begin
   abrirIngredientesLanche();
end;

procedure TFrmLanchesRegistro.btnAlterarClick(Sender: TObject);
begin
 alterarRegistroIngrediente;
end;

procedure TFrmLanchesRegistro.alterarRegistroIngrediente;
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryLanches_Ingredientes.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 if not assigned(FrmLanchesIngredientesRegistro) then   FrmLanchesIngredientesRegistro:=TFrmLanchesIngredientesRegistro.create(application);

 FrmLanchesIngredientesRegistro.Caption            :='[ ALTERAR ]';

 FrmLanchesIngredientesRegistro.txtCodigo.Caption:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesid.AsString ));
 FrmLanchesIngredientesRegistro.txtIdIngrediente.Text:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesidingrediente.AsString ));
 FrmLanchesIngredientesRegistro.txtIdLanche.Text:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesidlanche.AsString ));
 FrmLanchesIngredientesRegistro.txtQtd.Text:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesquantidade.AsString ));
 FrmLanchesIngredientesRegistro.txtValorUnitario.Caption:= FormatarValores(TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesvalorunitario.AsString )));
 FrmLanchesIngredientesRegistro.txtValor.Caption:= FormatarValores(TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesvalortotal.AsString )));

 FrmLanchesIngredientesRegistro.Showmodal;
 FreeAndNil(FrmLanchesIngredientesRegistro);


end;

procedure TFrmLanchesRegistro.DBGrid1DblClick(Sender: TObject);
begin
 alterarRegistroIngrediente;
end;

procedure TFrmLanchesRegistro.btnExcluirClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryLanches_Ingredientes.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

  if not assigned(FrmLanchesIngredientesRegistro) then
                 FrmLanchesIngredientesRegistro:=TFrmLanchesIngredientesRegistro.Create(Application);
                 FrmLanchesIngredientesRegistro.Caption            :='[ EXCLUIR ]';
                 FrmLanchesIngredientesRegistro.txtCodigo.Caption:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesid.AsString ));
                 FrmLanchesIngredientesRegistro.txtIdIngrediente.Text:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesidingrediente.AsString ));
                 FrmLanchesIngredientesRegistro.txtIdLanche.Text:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesidlanche.AsString ));
                 FrmLanchesIngredientesRegistro.txtQtd.Text:= TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesquantidade.AsString ));
                 FrmLanchesIngredientesRegistro.txtValorUnitario.Caption:= FormatarValores(TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesvalorunitario.AsString )));
                 FrmLanchesIngredientesRegistro.txtValor.Caption:= FormatarValores(TrimRight(TrimLeft( Datamodule1.qryLanches_Ingredientesvalortotal.AsString )));

                 //Desativa a edição
                 FrmLanchesIngredientesRegistro.btnPesquisar.Visible:=false;
                 FrmLanchesIngredientesRegistro.txtQtd.Enabled:=false;


                 FrmLanchesIngredientesRegistro.btnAcao.Caption:='Confirmar a Exclusão';
                 FrmLanchesIngredientesRegistro.btnRetornar.Caption:='Retornar';

                 FrmLanchesIngredientesRegistro.ShowModal;
                 FreeAndNil(FrmLanchesIngredientesRegistro);

end;

procedure TFrmLanchesRegistro.txtCodigoChange(Sender: TObject);
begin
 abrirIngredientesLanche();
end;

end.


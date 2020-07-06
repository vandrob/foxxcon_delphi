unit uFrmPesquisar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls;

type
  TFrmPesquisar = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnRetornar: TBitBtn;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    txtNome: TEdit;
    TabControl1: TTabControl;
    lblTrecho: TLabel;
    txtExemplo: TLabel;
    procedure btnRetornarClick(Sender: TObject);
    procedure abrirBasePesquisa(sOpcao:integer);
    procedure TabControl1Change(Sender: TObject);
    procedure txtNomeChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPesquisar: TFrmPesquisar;
  strTabela:string;
  strIdCapturado:string;
  strValorCapturado:string;
implementation
uses uDatamodule;
{$R *.dfm}

procedure TFrmPesquisar.abrirBasePesquisa(sOpcao:integer);
var
 strWhere:string;
 strCampoID:String;
 strNome:string;
 strSQL:string;

begin
// tela para pesquisas nas tabelas de ingredientes e lanches
// para catura do ID a ser transferido para os ingredientes por lanche
// ou lanches no pedido.
 strWhere:='';

 if (sOpcao=1) then
  begin
   //Opçao 1 pesquisar a string em qualquer posicao do nome %xxx%
   strNome:=trimright(trimleft( txtNOME.text ));
   if (strNome<>'') then begin
     strWhere:=' WHERE nome LIKE '+ #39+'%'+strNOME+'%'+#39;
   end;
  end
 else
  begin
   //opção 2 pesquisar através da letra obtida no Tab Alfabético
   strNome:=trimright(trimleft(TabControl1.Tabs[TabControl1.TabIndex]));
    if (strNome<>'') then
     begin
      if strNome<>'ALL' then strWhere:=' WHERE nome LIKE '+ #39+strNOME+'%'+#39;
     end
    else
     begin
      exit ;
     end
    ;
  end
 ;


 if (strTabela='ingredientes') then
  strCampoId:='idingrediente'
 else
  strCampoId:='idlanche'
 ;

 strSQL :='SELECT '+strCampoId+' as id, nome, valor from '+strTabela+strWhere+' ORDER BY nome';

 with Datamodule1.qryPesquisar do begin
      disablecontrols;
      if active then close;
      sql.clear;
      sql.add(strSQL);
      enablecontrols;
      open;
 end;
end;

procedure TFrmPesquisar.btnRetornarClick(Sender: TObject);
begin
 strIdCapturado:='';
 Datamodule1.qryPesquisar.close;
 close;
end;

procedure TFrmPesquisar.TabControl1Change(Sender: TObject);
begin
 abrirBasePesquisa(2);
end;

procedure TFrmPesquisar.txtNomeChange(Sender: TObject);
begin
 abrirBasePesquisa(1);
end;

procedure TFrmPesquisar.FormActivate(Sender: TObject);
begin
 if strTabela='ingredientes' then
  begin
   txtExemplo.Caption:='FRITAS'   ;
   lblTrecho.Caption:='Digite um frase para pesquisar no cadastro de ingredientes/adicionais ex:';
  end
 else
  begin
   lblTrecho.Caption:='Digite um frase para pesquisar em nosso cardápio ex:';
   txtExemplo.Caption:='BAURU'   ;
  end
 ;

 txtNome.SetFocus;
end;

procedure TFrmPesquisar.DBGrid1DblClick(Sender: TObject);
begin
 strIdCapturado   := TrimRight(TrimLeft(Datamodule1.qryPesquisar.Fields[0].AsString));
 strValorCapturado:= TrimRight(TrimLeft(Datamodule1.qryPesquisar.Fields[2].AsString));

 Datamodule1.qryPesquisar.close;
 close;

end;

initialization
 strTabela:='ingredientes';
 strIdCapturado:='';
 strValorCapturado:='';
end.

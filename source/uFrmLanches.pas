unit uFrmLanches;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons,  ExtCtrls, Grids, DBGrids;

type
  TFrmLanches = class(TForm)
    grpGrid: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    btnExcluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnIncluir: TBitBtn;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    btnprinter: TBitBtn;
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnprinterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLanches: TFrmLanches;

implementation

{$R *.dfm}
uses uDataModule,uFuncoes,uFrmLanchesRegistro, uFrmCardapio;

procedure TFrmLanches.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TFrmLanches.FormCreate(Sender: TObject);
begin
  uDataModule.DataModule1.qryLanches.Open;
end;
procedure TFrmLanches.DBGrid1TitleClick(Column: TColumn);
var
   i: Integer;
begin

      with DBGrid1 do
      for i := 0 to Columns.Count - 1 do
         Columns[i].Title.Font.Style := Columns[i].Title.Font.Style - [fsBold];
         Column.Title.Font.Style := Column.Title.Font.Style + [fsBold]
      ;
      with uDataModule.DataModule1.qryLanches do begin
         DisableControls;
         Close;
         SQL.Clear;
         SQL.Add('SELECT * FROM lanches ORDER BY '+Column.FieldName);
         Open;
         EnableControls;
     end;



end;

procedure TFrmLanches.btnIncluirClick(Sender: TObject);
begin
 //Chama a tela de registro
  if not assigned(FrmLanchesRegistro) then
                 FrmLanchesRegistro:=TFrmLanchesRegistro.Create(Application);
                 FrmLanchesRegistro.Caption          :='[ INCLUIR ]' ;
                 FrmLanchesRegistro.txtCodigo.text:='[ NOVO ]';
                 FrmLanchesRegistro.txtNome.Text:='';
                 FrmLanchesRegistro.txtDescricao.lines.clear;
                 FrmLanchesRegistro.txtValor.text:='0,00';

                 //Ativa a edição
                 FrmLanchesRegistro.txtCodigo.Enabled:=true;
                 FrmLanchesRegistro.txtNome.Enabled:=true;
                 FrmLanchesRegistro.txtValor.Enabled:=false;
                 FrmLanchesRegistro.txtDescricao.Enabled:=true;


                 FrmLanchesRegistro.ShowModal;
                 FreeAndNil(FrmLanchesRegistro);
end;

procedure TFrmLanches.btnAlterarClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryLanches.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

//Chama a tela de registro
  if not assigned(FrmLanchesRegistro) then
                 FrmLanchesRegistro:=TFrmLanchesRegistro.Create(Application);
                 FrmLanchesRegistro.Caption            :='[ ALTERAR ]';
                 FrmLanchesRegistro.txtCodigo.text  := Datamodule1.qryLanchesidlanche.AsString;
                 FrmLanchesRegistro.txtNome.Text       := Datamodule1.qryLanchesnome.AsString;
                 FrmLanchesRegistro.txtDescricao.Text  := Datamodule1.qryLanchesdescricao.AsString;
                 FrmLanchesRegistro.txtValor.Text      := Datamodule1.qryLanchesvalor.AsString;

                 //Ativa a edição
                 FrmLanchesRegistro.txtNome.Enabled:=true;
                 FrmLanchesRegistro.txtValor.Enabled:=false;
                 FrmLanchesRegistro.txtDescricao.Enabled:=true;



                 FrmLanchesRegistro.ShowModal;
                 FreeAndNil(FrmLanchesRegistro);
end;

procedure TFrmLanches.DBGrid1DblClick(Sender: TObject);
begin
 btnAlterar.click;
end;

procedure TFrmLanches.btnExcluirClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryLanches.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 //Chama a tela de registro
  if not assigned(FrmLanchesRegistro) then
                 FrmLanchesRegistro:=TFrmLanchesRegistro.Create(Application);
                 FrmLanchesRegistro.Caption            :='[ EXCLUIR ]';
                 FrmLanchesRegistro.txtCodigo.text  := Datamodule1.qryLanchesidlanche.AsString;
                 FrmLanchesRegistro.txtNome.Text       := Datamodule1.qryLanchesnome.AsString;
                 FrmLanchesRegistro.txtDescricao.Text  := Datamodule1.qryLanchesdescricao.AsString;
                 FrmLanchesRegistro.txtValor.Text      := Datamodule1.qryLanchesvalor.AsString;

                 //Desativa a edição
                 FrmLanchesRegistro.txtNome.Enabled:=false;
                 FrmLanchesRegistro.txtValor.Enabled:=false;
                 FrmLanchesRegistro.txtDescricao.Enabled:=false;


                 FrmLanchesRegistro.btnAcao.Caption:='Confirmar a Exclusão';
                 FrmLanchesRegistro.btnRetornar.Caption:='Retornar';

                 FrmLanchesRegistro.ShowModal;
                 FreeAndNil(FrmLanchesRegistro);
end;

procedure TFrmLanches.btnprinterClick(Sender: TObject);
begin
 uDataModule.DataModule1.qryCardapio.Open;
 uDataModule.DataModule1.qryCardapio_Itens.Open;
 if not assigned(FrmCardapio) then FrmCardapio:=TFrmCardapio.Create(Application);
                 FrmCardapio.QuickRep1.Preview;
                 FreeAndNil(FrmCardapio);
 uDataModule.DataModule1.qryCardapio.close;
 uDataModule.DataModule1.qryCardapio_Itens.close;
end;

end.

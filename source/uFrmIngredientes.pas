unit uFrmIngredientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids;

type
  TFrmIngredientes = class(TForm)
    grpGrid: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    btnExcluir: TBitBtn;
    btnAlterar: TBitBtn;
    btnIncluir: TBitBtn;
    Image1: TImage;
    Label1: TLabel;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    btnprinter: TBitBtn;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure btnprinterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIngredientes: TFrmIngredientes;

implementation


uses uDataModule,uFrmIngredientesRegistro, uFrmIngredientesListagem;
{$R *.dfm}

procedure TFrmIngredientes.btnIncluirClick(Sender: TObject);
begin
 //Chama a tela de registro
  if not assigned(FrmIngredientesRegistro) then
                 FrmIngredientesRegistro:=TFrmIngredientesRegistro.Create(Application);
                 FrmIngredientesRegistro.Caption          :='[ INCLUIR ]' ;
                 FrmIngredientesRegistro.txtCodigo.Caption:='[ NOVO ]';
                 FrmIngredientesRegistro.txtNome.Text:='';
                 FrmIngredientesRegistro.txtValor.Text:='0,00';

                 //Ativa a edição
                 FrmIngredientesRegistro.txtCodigo.Enabled:=true;
                 FrmIngredientesRegistro.txtNome.Enabled:=true;
                 FrmIngredientesRegistro.txtValor.Enabled:=true;


                 FrmIngredientesRegistro.ShowModal;
                 FreeAndNil(FrmIngredientesRegistro);
end;

procedure TFrmIngredientes.btnAlterarClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryIngredientes.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

 //Chama a tela de registro
  if not assigned(FrmIngredientesRegistro) then
                 FrmIngredientesRegistro:=TFrmIngredientesRegistro.Create(Application);
                 FrmIngredientesRegistro.Caption            :='[ ALTERAR ]';
                 FrmIngredientesRegistro.txtCodigo.Caption  :=Datamodule1.qryIngredientesidingrediente.AsString;
                 FrmIngredientesRegistro.txtNome.Text  :=Datamodule1.qryIngredientesnome.AsString;
                 FrmIngredientesRegistro.txtValor.Text:=Datamodule1.qryIngredientesvalor.AsString;

                 //Ativa a edição
                 FrmIngredientesRegistro.txtNome.Enabled:=true;
                  FrmIngredientesRegistro.txtValor.Enabled:=true;



                 FrmIngredientesRegistro.ShowModal;
                 FreeAndNil(FrmIngredientesRegistro);
end;

procedure TFrmIngredientes.DBGrid1DblClick(Sender: TObject);
begin
 btnAlterar.click;
end;

procedure TFrmIngredientes.btnExcluirClick(Sender: TObject);
var
 qtdLinhas:integer;
begin
 qtdLinhas:=DataModule1.qryIngredientes.RecordCount;
 if (qtdLinhas<=0) then begin
  showmessage('Tabela Vazia, efetue lançamentos para usar este botão..');
  exit;
 end;

  if not assigned(FrmIngredientesRegistro) then
                 FrmIngredientesRegistro:=TFrmIngredientesRegistro.Create(Application);
                 FrmIngredientesRegistro.Caption            :='[ EXCLUIR ]';
                 FrmIngredientesRegistro.txtCodigo.Caption  :=Datamodule1.qryIngredientesidingrediente.AsString;
                 FrmIngredientesRegistro.txtNome.Text  :=Datamodule1.qryIngredientesnome.AsString;
                 FrmIngredientesRegistro.txtValor.Text:=Datamodule1.qryIngredientesvalor.AsString;

                 //Desativa a edição
                 FrmIngredientesRegistro.txtNome.Enabled:=false;
                 FrmIngredientesRegistro.txtValor.Enabled:=false;


                 FrmIngredientesRegistro.btnAcao.Caption:='Confirmar a Exclusão';
                 FrmIngredientesRegistro.btnRetornar.Caption:='Retornar';

                 FrmIngredientesRegistro.ShowModal;
                 FreeAndNil(FrmIngredientesRegistro);
end;

procedure TFrmIngredientes.FormCreate(Sender: TObject);
begin
    uDataModule.DataModule1.qryIngredientes.Open;
end;

procedure TFrmIngredientes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  uDataModule.DataModule1.qryIngredientes.Close;
end;

procedure TFrmIngredientes.DBGrid1TitleClick(Column: TColumn);
var
   i: Integer;
begin
      with DBGrid1 do
      for i := 0 to Columns.Count - 1 do
         Columns[i].Title.Font.Style := Columns[i].Title.Font.Style - [fsBold];
         Column.Title.Font.Style := Column.Title.Font.Style + [fsBold]
      ;


     with uDataModule.DataModule1.qryIngredientes do begin
         DisableControls;
         Close;
         SQL.Clear;
         SQL.Add('SELECT * FROM ingredientes ORDER BY '+Column.FieldName);
         Open;
         EnableControls;
     end;


end;

procedure TFrmIngredientes.DBGrid1DrawColumnCell(Sender: TObject;
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

procedure TFrmIngredientes.btnprinterClick(Sender: TObject);
begin

 if not assigned(FrmIngredientesListagem) then FrmIngredientesListagem:=TFrmIngredientesListagem.Create(Application);
                 FrmIngredientesListagem.QuickRep1.Preview;
                 FreeAndNil(FrmIngredientesListagem);
end;

end.

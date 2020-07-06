unit uFrmIngredientesRegistro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TFrmIngredientesRegistro = class(TForm)
    GroupBox1: TGroupBox;
    Panel2: TPanel;
    btnRetornar: TBitBtn;
    btnAcao: TBitBtn;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText4: TStaticText;
    txtCodigo: TStaticText;
    txtNome: TEdit;
    txtValor: TEdit;
    procedure btnAcaoClick(Sender: TObject);
    procedure txtNomeExit(Sender: TObject);
    procedure txtValorExit(Sender: TObject);
    procedure txtValorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmIngredientesRegistro: TFrmIngredientesRegistro;

implementation

uses uDataModule,uFuncoes;

{$R *.dfm}


procedure TFrmIngredientesRegistro.btnAcaoClick(Sender: TObject);
var s:string;
    cValor:real;
    strSQL:string;

    strOpcao:string;
begin
 strOpcao :=trimright(trimleft( FrmIngredientesRegistro.Caption ));

 //consiste os preenchimentos
 if strOpcao<>'[ EXCLUIR ]' then begin
  s:=trimright(trimleft( txtNome.Text ));
  if (s='') then begin
   showmessage('Informe o campo: Nome do Ingrediente');
   txtNome.setfocus;
   exit;
  end;


  cValor := StrToFloat(txtValor.Text);
  if (cValor<=0) then begin
   showmessage('Informe o campo: Valor Unitário');
   txtValor.setfocus;
   exit;
  end;
 end;

 //Monta a String de Inserção/Atualização.
  strSQL:='';



 if strOpcao='[ INCLUIR ]' then
  begin
   strSQL:='INSERT INTO ingredientes (nome,valor) '+
         '            VALUES   '+
         ' ( '+
         #39+ trimright(trimleft( Uppercase(txtNome.Text ))) +#39+ ',' +
         #39+ trimright(trimleft( txtValor.text )) +#39+
         ' )';
  end
 else if strOpcao='[ ALTERAR ]' then
  begin
    strSQL:='UPDATE ingredientes SET '+
            '   nome   = ' +#39+ trimright(trimleft( Uppercase(txtNome.Text ))) +#39+ ',' +
            '   valor = ' +#39+ trimright(trimleft( txtValor.text )) +#39+
            ' WHERE  idingrediente     = ' +trimright(trimleft( txtCodigo.Caption )) ;
  end
 else if strOpcao='[ EXCLUIR ]' then
  begin
    strSQL:='DELETE FROM ingredientes  '+
            ' WHERE  idingrediente     = ' +trimright(trimleft( txtCodigo.Caption )) ;
  end
 ;
 if (strSQL<>'') then begin
  comandoSQL(strSQL);
  datamodule1.qryIngredientes.Requery;
 end;
 Close;
end;

procedure TFrmIngredientesRegistro.txtNomeExit(Sender: TObject);
begin
txtNome.Text:= trimright(trimleft( Uppercase(txtNome.Text ) ));
end;

procedure TFrmIngredientesRegistro.txtValorExit(Sender: TObject);
var
 sTexto:string;
 cValor:Real;
begin
      sTexto := StringReplace(txtValor.Text, '.','', []);
      cValor := StrToCurrDef(sTexto, 0);
      txtValor.Text := FormatFloat('0.00', cValor);

end;

procedure TFrmIngredientesRegistro.txtValorKeyPress(Sender: TObject;
  var Key: Char);

 
begin
   if not (Key in ['0'..'9',',',#8]) then
   begin
        Key := #0;
   end;


end;




end.

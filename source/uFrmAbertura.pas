unit uFrmAbertura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls, StdCtrls,comobj, Gauges,DB, ADODB;

type
  TFrmAbertura = class(TForm)
    btnSair: TLabel;
    memoMSG: TMemo;
    btnCriarBase: TButton;
    btnContinuar: TButton;
    Timer1: TTimer;
    memoSCRIPT: TMemo;
    Gauge1: TGauge;
    Image1: TImage;
    Label1: TLabel;
    procedure btnSairClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function CreateMDB(FileName : String) : String;
    procedure CreateTABLES();
    procedure btnCriarBaseClick(Sender: TObject);
    procedure btnContinuarClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
var
  FrmAbertura: TFrmAbertura;
  nomePASTA,nomeARQUIVO:string;
 implementation
uses uDatamodule, uFrmMenu;
{$R *.dfm}
procedure TFrmAbertura.btnSairClick(Sender: TObject);
begin
 DataModule1.ADOConnection1.Connected:=false;
 Application.Terminate;
end;

function TFrmAbertura.CreateMDB(FileName: String): String;
var myOBJ : OLEVariant;
begin
result := '';
try
  // ----------------------------------------------------------------------
  // Para fins didáticos do teste, optei em por um database de
  // simples criação através do OLE da Microsoft não necessitando de
  // instalação de outros softwares de SGDB mas com utilização comandos SQL
  // através do script contido nas linhas do componente memoSCRIPT, e nos
  // comandos de select, update, delete, insert nos componentes ADO,
  // criados em Run-Time ou Agregados diretamente aos Forms, e DataModule.
  // -----------------------------------------------------------------------
  memoMSG.Lines.Add('----------------------------------------');
  memoMSG.Lines.Add('Criando base de dados....');
  myOBJ := CreateOleObject('ADOX.Catalog');
  myOBJ.create ('Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+Filename+';');
  myOBJ := NULL;
  memoMSG.Lines.Add('Base de dados criada com sucesso!....');
  btnCriarBase.Visible:=False;
  btnContinuar.Visible:=True;

except
  on e : Exception do begin
                     btnCriarBase.Visible:=true;
                     btnContinuar.Visible:=False;

                      memoMSG.Lines.Add('Erro ao criar a base de dados:');
                      memoMSG.Lines.Add(e.message);
                      result := e.message;
                      end;
end;
end;

procedure TFrmAbertura.FormCreate(Sender: TObject);
begin
 memoMSG.Lines.Clear;
 memoMSG.Lines.Add('Bem vindo ao FoxxFood!');
 memoMSG.Lines.Add('-------------------------');
 memoMSG.Lines.Add('O Aplicativo para o controle de pedidos');
 memoMSG.Lines.Add('da lanchonete dos funcionários da Foxxcon!');
 memoMSG.Lines.Add('');
 btnCriarBase.Visible:=not fileExists( nomeARQUIVO ) ;
 btnContinuar.Visible:=not BtnCriarBase.Visible;
end;

procedure TFrmAbertura.btnCriarBaseClick(Sender: TObject);
begin
     //criar a base de dados
     createMDB( nomeARQUIVO );
     //em caso positivo criar as tabelas
     if fileExists( nomeARQUIVO ) then createTABLES;
end;

procedure TFrmAbertura.btnContinuarClick(Sender: TObject);
var
 strConn:string;
begin
 btnContinuar.Hide;
 strConn:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";'+
          'Data Source='+#39+nomeARQUIVO+#39+';Persist Security Info=True';
 memoMSG.Lines.Add('Tentando conectar a base de dados...');

 try
  Datamodule1.ADOConnection1.Connected:=false;
  Datamodule1.ADOConnection1.ConnectionString:=strConn;
  Datamodule1.ADOConnection1.Connected:=true;
  memoMSG.Lines.Add('Conexão a base de dados efetuada com sucesso!');


  timer1.Enabled:=true;

  except
     On E : EOleException do
      begin
       memoMSG.Lines.Add('*****************************************************');
       memoMSG.Lines.Add('Erro ao abrir a base de dados:');
       memoMSG.Lines.Add('========================================');
       memoMSG.Lines.Add(E.Message);
       memoMSG.Lines.Add('*****************************************************');
      end
      else
        MessageDlg('Erro ao abrir a base de dados',mtError,[mbAbort],0);
      ;
   end;

end;

procedure TFrmAbertura.Timer1Timer(Sender: TObject);
begin
 timer1.Enabled:=false;
  hide;
  if not assigned(FrmMenu) then
                 FrmMenu:=TFrmMenu.Create(Application);
                 FrmMenu.ShowModal;
                 FreeAndNil(FrmMenu);
                  close;

end;

procedure TFrmAbertura.CreateTABLES;
var
 strConn,strSQL:widestring;
 myConn: TADOConnection;
 myCommand: TADOCommand;
 t,i:integer;
begin
 //criar as tabelas na base
 memoMSG.Lines.Add('=============================================');
 memoMSG.Lines.Add('Criando tabelas na base de dados...!') ;
 strConn:='Provider=Microsoft.Jet.OLEDB.4.0;Password="";Data Source='+#39+ nomeARQUIVO +#39+';Persist Security Info=True';
 myConn:=TADOConnection.create(nil);
 myConn.ConnectionString:=strConn;
 myConn.LoginPrompt:=false;
 myConn.Connected:=true;

 t:=memoSCRIPT.Lines.Count;
 gauge1.Visible:=true;
 gauge1.Progress:=0;
 gauge1.MaxValue:=t;
 myCommand:=TADOCommand.Create(nil);
 myCommand.Connection:=myConn;
 for i:=0 to (t-1) do begin
     strSQL:=memoSCRIPT.Lines[i];
     memoMSG.Lines.Add(strSQL);
     gauge1.Progress:=gauge1.Progress+1;
     if (strSQL<>'') then begin
      myCommand.CommandText:=strSQL;
      myCommand.Execute;
     end;
 end;
 myConn.Connected:=false;
 FreeAndNil(myCommand);
 FreeAndNil(myConn);
 gauge1.Visible:=false;
 memoMSG.Lines.Add('=============================================');
 memoMSG.Lines.Add('Tabelas criadas com sucesso!, clique em [OK] para continuar...');


end;

initialization
 nomePASTA:=trimright(trimleft(ExtractFilePath(Application.ExeName)));
 nomeARQUIVO:=nomePasta+'foxxfood.mdb';

end.

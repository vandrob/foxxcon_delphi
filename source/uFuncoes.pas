unit uFuncoes;

interface

uses
   SysUtils,  Dialogs;

Procedure comandoSQL(strSQL:string);
Function  qryRetorno(strSQL:string):string;
Function  proximoID(nomeTabela,nomeColunaID:string):string;
Function  FormatarValores(strValor:string):string;

implementation

uses uDatamodule;

procedure comandoSQL(strSQL:string);
begin
 //procedimento para execução de comandos de inserção/exclusão/atualização de
 //registros nas tabelas em foxxfood.mdb
 Try
   Datamodule1.ADOCommand1.CommandText:=strSQL;
   Datamodule1.ADOCommand1.Execute();
  Except
    on E: Exception do
    ShowMessage('Erro ao executar o comando sql: '+#13+#10 + E.Message );
  end;

end;

function  qryRetorno(strSQL:string):string;
var
 s:string;
begin
 //Recebe uma select e retorna a string com o conteúdo de um campo
 s:='';
 Try
    Datamodule1.qryGenerica.Close;
    Datamodule1.qryGenerica.SQL.Clear;
    Datamodule1.qryGenerica.SQL.Add(strSQL);
    Datamodule1.qryGenerica.Open;
    s:=trimright(trimleft( DataModule1.qryGenerica.Fields[0].AsString ));
    Datamodule1.qryGenerica.Close;
    result:=s;
  Except
    on E: Exception do
    ShowMessage('Erro ao executar o comando sql: '+#13+#10 + E.Message );
  end;

end;

Function  proximoID(nomeTabela,nomeColunaID:string):string;
var strSQL,proximoID:string;
begin
//em Tabelas referenciadas 1xN ,
//obter o próximo ID a registrar a linha
//da tabela pai na ocasião de lançamentos de registros na tabela filha (N)
    strSQL:='SELECT MAX('+nomeCOLUNAID+') as proximoID FROM '+nomeTabela;
    proximoID:=qryRetorno( strSQL );
    if (proximoID='') then proximoID:='0';
    proximoID:=inttostr( ( strtoint( proximoID ) +1 ) );
    result:=proximoID;
end;

Function FormatarValores(strValor:string):string;
var
 sTexto:string;
 cValor:Real;
begin
      sTexto := StringReplace(strValor, '.','', []);
      cValor := StrToCurrDef(sTexto, 0);
      result:= FormatFloat('0.00', cValor);
end;

end.

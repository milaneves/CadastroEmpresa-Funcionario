unit cEmpresa;

interface

uses Classes,Controls, ExtCtrls, Dialogs, ZAbstractConnection, ZConnection,
ZAbstractRODataset, ZAbstractDataset, ZDataset, SysUtils;

type
 TEmpresa  = class
   private
    ConexaoDB: TZConnection;
    F_IdEmpresa: Integer;
    F_CNPJ:String;
    F_Razao_Social: String;
    F_Nome_Fantasia:String;
    F_CEP:String;
    F_Endereco:String;
    F_Bairro:String;
    F_Cidade:String;
    F_Numero:String;
    F_Complemento:String;
    F_Telefone:String;
    F_Email:String;
    QryLocalizar:TzQuery;
    CodigoEndereco:Integer;
    function getCNPJ: String;
    procedure setCNPJ(const Value: String);
    function getEmail: String;
    procedure setEmail(const Value: String);
    procedure NomeEndereco(CNPJ:String);
    procedure VerificaIgualdadeCampos;

   public
    constructor Create(Conexao: TZConnection);
    destructor Destroy ;override;
    function Inserir:Boolean;
    function Atualizar:Boolean;
    function Apagar(CNPJ:String):Boolean;
    function Selecionar(CNPJ:String):Boolean;
    function IsValidEmail(const Value: string): Boolean;


   published
     property IdEmpresa:Integer read F_IdEmpresa write F_IdEmpresa;
     property CNPJ:String read getCNPJ write setCNPJ;
     property RazaoSocial:String read F_Razao_Social write F_Razao_Social;
     property NomeFantasia:String read F_Nome_Fantasia  write F_Nome_Fantasia ;
     property CEP:String read F_CEP  write F_CEP ;
     property Endereco:String read F_Endereco  write F_Endereco ;
     property Bairro:String read F_Bairro  write F_Bairro ;
     property Cidade:String read F_Cidade  write F_Cidade ;
     property Numero:String read F_Numero  write F_Numero ;
     property Complemento:String read F_Complemento  write F_Complemento;
     property Telefone:String read F_Telefone  write F_Telefone ;
     property Email:String read getEmail  write setEmail ;
 end;

implementation

{ TEmpresa }

 //Passando a conex�o para a propriedade da classe.
constructor TEmpresa.Create(Conexao:TZConnection);
begin
   ConexaoDB:=Conexao;
end;

destructor TEmpresa.Destroy;
begin

end;


procedure TEmpresa.NomeEndereco(CNPJ: String);
begin

    QryLocalizar:=TZQuery.Create(Nil);
    QryLocalizar.Connection:=ConexaoDB;
    QryLocalizar.SQL.Clear;
    QryLocalizar.SQL.Add('select  * from Endereco where CNPJ = '+''''+ CNPJ+''''+ 'and Ativo = 1');
    QryLocalizar.Open;

    CodigoEndereco:= QryLocalizar.FieldByName('IdEndereco').AsInteger;

end;

function TEmpresa.getCNPJ: String;
begin
  Result:=Self.F_CNPJ;
end;

procedure TEmpresa.setCNPJ(const Value: String);
begin
 Self.F_CNPJ:= Value;
end;


function TEmpresa.getEmail: String;
begin
  Result:=Self.F_Email;
end;

procedure TEmpresa.setEmail(const Value: String);
begin
 if IsValidEmail(Value) then
 else
     begin
      ShowMessage('O Email n�o � v�lido');
      Abort;
     end;

   Self.F_Email:= Value;

end;

procedure TEmpresa.VerificaIgualdadeCampos;
var Qry:TzQuery;
begin

//Verifica se existe endere�o cadastrado para o CNPJ informado
 NomeEndereco(CNPJ);
  //se os campos de endere�o informados na tela n�o for o mesmo que est� no banco inseri um novo registro
      if
       ( 
         ( QryLocalizar.FieldByName('Endereco').Value  <> Self.F_Endereco )or
         ( QryLocalizar.FieldByName('Bairro').Value  <> Self.F_Bairro) or
         ( QryLocalizar.FieldByName('Cidade').Value <> Self.F_Cidade )  or
         ( QryLocalizar.FieldByName('CEP').Value  <> Self.F_CEP) or
         ( QryLocalizar.FieldByName('Numero').Value <>  Self.F_Numero)or
         ( QryLocalizar.FieldByName('Complemento').Value <> Self.F_Complemento ) 
       ) then
       begin
       try
        Qry:=TzQuery.Create(nil);
        Qry.Connection:=ConexaoDB;
        Qry.SQL.Clear;                                      
        Qry.SQL.Add('Insert into   Endereco '+
                                          '(CNPJ , ' +
                                          'Endereco, '+
                                          'Bairro,  '+
                                          'Cidade,  '+
                                          'CEP,   '+
                                          'Numero, '+
                                          'Complemento, '+
                                          'Data_Cadastro, '+
                                          'Ativo )'+

                           'Values       (:CNPJ ,'+
                                         ':Endereco, '+
                                         ':Bairro,  '+
                                         ':Cidade, '+
                                         ':CEP, '+
                                         ':Numero, '+
                                         ':Complemento, '+
                                         ':Data_Cadastro, '+
                                         ':Ativo )');
          Qry.ParamByname('CNPJ').Value:= Self.F_CNPJ;
          Qry.ParamByname('Endereco').Value:= Self.F_Endereco;
          Qry.ParamByname('Bairro').Value:= Self.F_Bairro;
          Qry.ParamByname('Cidade').Value:= Self.F_Cidade;
          Qry.ParamByname('CEP').Value:= Self.F_CEP;
          Qry.ParamByname('Numero').Value:= Self.F_Numero;
          Qry.ParamByname('Complemento').Value:= Self.F_Complemento;
          Qry.ParamByname('Data_Cadastro').Value:= DateToStr(Date());
          Qry.ParamByname('Ativo').Value:= 1;
          Qry.ExecSQL;

          
          Qry:=TzQuery.Create(nil);
          Qry.Connection:=ConexaoDB;
          Qry.SQL.Clear;
          Qry.SQL.Add('update Endereco set Ativo = 0 where IdEndereco = ' +IntToStr(CodigoEndereco) );
          Qry.ExecSQL;

          //Pega o �ltimo id do Endere�o atualizado
          NomeEndereco(CNPJ);
          Qry:=TzQuery.Create(nil);
          Qry.Connection:=ConexaoDB;
          Qry.SQL.Clear;
          Qry.SQL.Add('update empresa set IdEndereco = ' +IntToStr(CodigoEndereco)+ 'where CNPJ =  '+Self.F_CNPJ );
          Qry.ExecSQL;
          finally
            if Assigned(Qry) then
             FreeAndNil(Qry);
           if Assigned(QryLocalizar) then
             FreeAndNil(QryLocalizar)
         end;
       end;
end;

function TEmpresa.Inserir: Boolean;
var Qry:TzQuery;
begin
  try
    Result:=True;
    Qry:=TZQuery.Create(Nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add ('Insert into   Endereco '+
                                              '(CNPJ , ' +
                                              'Endereco, '+
                                              'Bairro,  '+
                                              'Cidade,  '+
                                              'CEP,   '+
                                              'Numero, '+
                                              'Complemento, '+
                                              'Data_Cadastro, '+
                                              'Ativo )'+

                               'Values       (:CNPJ ,'+
                                             ':Endereco, '+
                                             ':Bairro,  '+
                                             ':Cidade, '+
                                             ':CEP, '+
                                             ':Numero, '+
                                             ':Complemento, '+
                                             ':Data_Cadastro, '+
                                             ':Ativo )');
        Qry.ParamByname('CNPJ').Value:= Self.F_CNPJ;
        Qry.ParamByname('Endereco').Value:= Self.F_Endereco;
        Qry.ParamByname('Bairro').Value:= Self.F_Bairro;
        Qry.ParamByname('Cidade').Value:= Self.F_Cidade;
        Qry.ParamByname('CEP').Value:= Self.F_CEP;
        Qry.ParamByname('Numero').Value:= Self.F_Numero;
        Qry.ParamByname('Complemento').Value:= Self.F_Complemento;
        Qry.ParamByname('Data_Cadastro').Value:= DateToStr(Date());
        Qry.ParamByname('Ativo').Value:= 1;

 try
   Qry.ExecSQL;
  Except
   Result:=False;
  end;
 finally
   if Assigned(Qry) then
   FreeAndNil(Qry)

end;

  //Retornando o Id do Endere�o
  NomeEndereco(CNPJ);

try

  Qry:=TZQuery.Create(Nil);
  Qry.Connection:=ConexaoDB;
  Qry.SQL.Clear;
  Qry.SQL.Add(' insert into Empresa( CNPJ ,'+
                                   'IdEndereco, '+
                                   'Razao_Social, '+
                                   'Nome_Fantasia ,'+
                                   'Email ,'+
                                   'Telefone ,'+
                                   'Data_Atualizacao )'+

                 'values           (:CNPJ,  '+
                                   ':IdEndereco, '+
                                   ':Razao_Social, '+
                                   ':Nome_Fantasia, '+
                                   ':Email, '+
                                   ':Telefone, '+
                                   ':Data_Atualizacao)');
  Qry.ParamByname('CNPJ').Value:= Self.F_CNPJ;
  Qry.ParamByname('IdEndereco').Value:= CodigoEndereco;
  Qry.ParamByname('Razao_Social').Value:= Self.F_Razao_Social;
  Qry.ParamByname('Nome_Fantasia').Value:=  Self.F_Nome_Fantasia;
  Qry.ParamByname('Email').Value:= Self.F_Email;
  Qry.ParamByname('Telefone').Value:= Self.F_Telefone;
  Qry.ParamByname('Data_Atualizacao').Value:= DateToStr(Date());
  try
   Qry.ExecSQL;
   ShowMessage('Registro Inserido com Sucesso');
  Except
   Result:=False;
  end;
  finally
   if Assigned(Qry) then
   FreeAndNil(Qry)


end;

end;

function TEmpresa.Apagar(CNPJ:String):Boolean;
var Qry:TzQuery;
begin
 if MessageDlg( 'Apagar o registro: '+#13+#13+
                'CNPJ: '+F_CNPJ+#13+
                'Descri��o: '+F_Nome_Fantasia, mtConfirmation, [mbYes, mbNo],0)=mrNo then
                begin
                  Result:=false;
                  Abort;
                end;
 try
     Result:= true;
     Qry:=TzQuery.Create(nil);
     Qry.Connection:=ConexaoDB;
     Qry.SQL.Clear;
     Qry.SQL.Add(
                'delete from Empresa '+
                'where CNPJ = :CNPJ');
     Qry.ParamByName('CNPJ').value:=CNPJ;
    try
     Qry.ExecSQL;
     ShowMessage('Exclu�do com sucesso');
    Except
      Result:=False;
    end;
    finally
      if Assigned(Qry) then
         FreeAndNil(Qry)
   end;

end;

function TEmpresa.Atualizar: Boolean;
var Qry:TzQuery;
begin

//Verificando se existe O endere�o na base;
VerificaIgualdadeCampos;

//Retornando o Id do Endere�o  
NomeEndereco(CNPJ);


   Result:= true;
   try
     Qry:=TzQuery.Create(nil);
     Qry.Connection:=ConexaoDB;
     Qry.SQL.Clear;
     Qry.SQL.Add(
                'update Empresa '+
                'set  CNPJ =             :CNPJ,'+
                     'IdEndereco =       :IdEndereco, '+
                     'Razao_Social =     :Razao_Social, '+
                     'Nome_Fantasia =    :Nome_Fantasia, '+
                     'Email =            :Email, '+
                     'Telefone =         :Telefone, '+
                     'Data_Atualizacao = :Data_Atualizacao ' +
                'where CNPJ = :CNPJ' );     
      Qry.ParamByname('IdEndereco').AsInteger:=CodigoEndereco;
      Qry.ParamByname('CNPJ').Value:= Self.F_CNPJ;
      Qry.ParamByname('Razao_Social').Value:= Self.F_Razao_Social;
      Qry.ParamByname('Nome_Fantasia').Value:= Self.F_Nome_Fantasia;
      Qry.ParamByname('Email').Value:= Self.F_Email;
      Qry.ParamByname('Telefone').Value:= Self.F_Telefone;
      Qry.ParamByname('Data_Atualizacao').Value:= DateToStr(Date());

    try
     Qry.ExecSQL;
     ShowMessage('Registro Atualizado com Sucesso');

    Except
      Result:=False;
    end;
    finally
      if Assigned(Qry) then
         FreeAndNil(Qry)
   end;


end;

function TEmpresa.Selecionar(CNPJ: String): Boolean;
var Qry:TzQuery;
begin
 try
   Result:= true;
   Qry:=TzQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('select IdEmpresa ,'+
                       'a.CNPJ, '+
                       'Razao_Social, '+
                       'Nome_Fantasia, '+
                       'Endereco, '+
                       'Bairro, '+
                       'Cidade, '+
                       'CEP, '+
                       'Numero, '+
                       'Complemento, '+
                       'Email, '+
                       'Telefone '+
                'from empresa as a join Endereco as b on (a.CNPJ = b.CNPJ) '+
               'where a.CNPJ = :CNPJ and Ativo = 1');
    Qry.ParamByname('CNPJ').value:=CNPJ;
  try
    Qry.Open;

    Self.F_IdEmpresa:=Qry.FieldByName('IdEmpresa').AsInteger;
    Self.F_CNPJ:=Qry.FieldByName('CNPJ').Value;
    Self.F_Razao_Social:=Qry.FieldByName('Razao_Social').Value;
    Self.F_Nome_Fantasia:=Qry.FieldByName('Nome_Fantasia').Value;
    Self.F_Endereco:=Qry.FieldByName('Endereco').Value;
    Self.F_Bairro:=Qry.FieldByName('Bairro').Value;
    Self.F_Cidade:=Qry.FieldByName('Cidade').Value;
    Self.F_CEP:=Qry.FieldByName('CEP').Value;
    Self.F_Numero:=Qry.FieldByName('Numero').Value;
    Self.F_Complemento:=Qry.FieldByName('Complemento').Value;
    Self.F_Email:=Qry.FieldByName('Email').Value;
    Self.F_Telefone:=Qry.FieldByName('Telefone').Value;
  Except
   Result:=false;
  end;

  finally
    if Assigned(Qry) then
       FreeAndNil(Qry);

   end;
end;

function TEmpresa.IsValidEmail(const Value: string): Boolean;
  function CheckAllowed(const s: string): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 1 to Length(s) do
      if not(s[i] in ['a' .. 'z', 'A' .. 'Z', '0' .. '9', '_', '-', '.']) then
        Exit;
    Result := true;
  end;
var
  i: Integer;
  NamePart, ServerPart: string;
begin
  Result := False;
  i := Pos('@', Value);
  if i = 0 then
    Exit;
  NamePart := Copy(Value, 1, i - 1);
  ServerPart := Copy(Value, i + 1, Length(Value));
  if (Length(NamePart) = 0) or ((Length(ServerPart) < 5)) then
    Exit;
  i := Pos('.', ServerPart);
  if (i = 0) or (i > (Length(ServerPart) - 2)) then
    Exit;
  Result := CheckAllowed(NamePart) and CheckAllowed(ServerPart);
end;

end.

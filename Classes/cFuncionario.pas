unit cFuncionario;

interface

uses Classes,Controls, ExtCtrls, Dialogs, ZAbstractConnection, ZConnection,
ZAbstractRODataset, ZAbstractDataset, ZDataset, SysUtils;


type
 TFuncionario  = class
    private
      ConexaoDB: TZConnection;
      F_IdFuncionario: Integer;
      F_IdEmpresa: string;
      F_CPF:String;
      F_Nome: String;
      F_CEP:String;
      F_Endereco:String;
      F_Bairro:String;
      F_Cidade:String;
      F_Numero:String;
      F_Complemento:String;
      F_Telefone:String;
      F_Email:String;
      F_Salario:Currency;
      QryLocalizar:TzQuery;
      CodigoEmpresa, CodigoCargo ,CodigoEndereco:Integer;
      procedure NomeEmpresa(nome:String);
      procedure NomeEndereco(CPF:String);
      procedure VerificaIgualdadeCampos;
    function getEmail: String;
    procedure setEmail(const Value: String);
    public
      constructor Create(Conexao:TZConnection);
      destructor Destroy;override;
      function Inserir:Boolean;
      function Atualizar:Boolean;
      function Apagar(id:integer):Boolean;
      function Selecionar(CPF:String):Boolean;
      function IsValidEmail(const Value: string): Boolean;




   published
     property IdFuncionario:Integer read F_IdFuncionario write F_IdFuncionario;
     property IdEmpresa:string read F_IdEmpresa write F_IdEmpresa;
     property CPF:String read F_CPF write F_CPF;
     property Nome:String read F_Nome  write F_Nome ;
     property CEP:String read F_CEP  write F_CEP ;
     property Endereco:String read F_Endereco  write F_Endereco ;
     property Bairro:String read F_Bairro  write F_Bairro ;
     property Cidade:String read F_Cidade  write F_Cidade ;
     property Numero:String read F_Numero  write F_Numero ;
     property Complemento:String read F_Complemento  write F_Complemento;
     property Telefone:String read F_Telefone  write F_Telefone ;
     property Email:String read getEmail  write setEmail ;
     property Salario:Currency read F_Salario  write F_Salario ;


 end;

implementation

{ TFuncionario }



constructor TFuncionario.Create(Conexao: TZConnection);
begin
   ConexaoDB:=Conexao;
end;

destructor TFuncionario.Destroy;
begin
 inherited;
end;


function TFuncionario.getEmail: String;
begin
    Result:=Self.F_Email;
end;

procedure TFuncionario.setEmail(const Value: String);
begin
   if IsValidEmail(Value) then
 else
     begin
      ShowMessage('O Email n�o � v�lido');
      Abort;
     end;

   Self.F_Email:= Value;
end;

function TFuncionario.Inserir: Boolean;
var Qry:TzQuery;
begin

  NomeEmpresa(IdEmpresa);

    Result:=True;
    Qry:=TZQuery.Create(Nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add ('Insert into   Endereco '+
                                              '(CPF , ' +
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
        Qry.ParamByname('CNPJ').Value:= Self.F_CPF;
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

    //Retornando o Id do Endere�o
    NomeEndereco(CPF);

        Qry:=TZQuery.Create(Nil);
        Qry.Connection:=ConexaoDB;
        Qry.SQL.Clear;
        Qry.SQL.Add(' insert into Funcionario '+
                                           '(CPF ,'+
                                           'IdEmpresa , '+
                                           'IdEndereco, '+
                                           'Nome, '+
                                           'Salario, '+
                                           'Email,  '+
                                           'Telefone, '+
                                           'Data_Cadastro  )'+

                         'values           (:CPF, '+
                                           ':IdEmpresa, '+
                                           ':IdEndereco, '+
                                           ':Nome, '+
                                           ':Salario, '+
                                           ':Email,  '+
                                           ':Telefone, '+
                                           ':Data_Cadastro  )');
        Qry.ParamByname('CPF').Value:= Self.F_CPF;
        Qry.ParamByname('IdEmpresa').Value:= CodigoEmpresa;
        Qry.ParamByname('IdEndereco').Value:= CodigoEndereco;
        Qry.ParamByname('Nome').Value:= Self.F_Nome;
        Qry.ParamByname('Salario').Value:= Self.F_Salario;
        Qry.ParamByname('Email').Value:= Self.F_Email;
        Qry.ParamByname('Telefone').Value:= Self.F_Telefone;
        Qry.ParamByname('Data_Cadastro').Value:= DateToStr(Date());

     try
     Qry.ExecSQL;
   finally

     if Assigned(Qry) then
     FreeAndNil(Qry)

 end;

end;


function TFuncionario.IsValidEmail(const Value: string): Boolean;
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

function TFuncionario.Atualizar: Boolean;
var Qry:TzQuery;
begin

//Verificando se existe O endere�o na base;
VerificaIgualdadeCampos;

//Retornando o Id do Endere�o
NomeEndereco(CPF);

 try
    Result:=True;
    Qry:=TZQuery.Create(Nil);
    Qry.Connection:=ConexaoDB;
    Qry.SQL.Clear;
    Qry.SQL.Add(' Update Funcionario '+
                   'set CPF = :CPF ,'+
                        'Nome = :Nome, '+
                        'Salario = :Salario, '+
                        'Email = :Email,  '+
                        'Telefone = :Telefone, '+
                        'Data_Atualizacao = :Data_Atualizacao ' +
                   'where  CPF = :CPF');
    Qry.ParamByname('CPF').Value:= Self.F_CPF;
    Qry.ParamByname('Nome').Value:= Self.F_Nome;
    Qry.ParamByname('Salario').Value:= Self.F_Salario;
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


function TFuncionario.Apagar(id: integer): Boolean;
var Qry:TzQuery;
begin
 if MessageDlg( 'Apagar o registro: '+#13+#13+
                'CPF: '+ F_CPF+#13+
                'Nome: '+F_Nome, mtConfirmation, [mbYes, mbNo],0)=mrNo then
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
                'delete from Funcionario '+
                'where IdFuncionario = :IdFuncionario');
     Qry.ParamByName('IdFuncionario').AsInteger:=id;
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

function TFuncionario.Selecionar(CPF: String): Boolean;
var Qry:TzQuery;
begin
 try
   Result:= true;
   Qry:=TzQuery.Create(nil);
   Qry.Connection:=ConexaoDB;
   Qry.SQL.Clear;
   Qry.SQL.Add('select  IdFuncionario , '+
                       'a.CPF ,'+
                       'a.Nome as NomeFuncionario, '+
                       'b.Nome_Fantasia as NomeEmpresa, '+
                       'Salario, '+
                       'Endereco, '+
                       'Bairro,  '+
                       'Cidade,  '+
                       'CEP,   '+
                       'Numero, '+
                       'Complemento, '+
                       'a.Email,  '+
                       'a.Telefone '+
                'from Funcionario as a  '+
                            'join empresa as b on (a.idEmpresa = b.IdEmpresa) '+
                            'join endereco as c on (a.CPF = c.CPF) '+
                ' where a.CPF = :CPF and Ativo = 1');
    Qry.ParamByname('CPF').value:=CPF;
  try
    Qry.Open;

    Self.F_IdFuncionario:=Qry.FieldByName('IdFuncionario').AsInteger;
    Self.F_CPF:=Qry.FieldByName('CPF').Value;
    Self.F_Nome:=Qry.FieldByName('NomeFuncionario').Value;
    Self.F_IdEmpresa:=Qry.FieldByName('NomeEmpresa').Value;
    Self.F_Salario:=Qry.FieldByName('Salario').Value;
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



procedure TFuncionario.NomeEmpresa(nome: String);
begin

    QryLocalizar:=TZQuery.Create(Nil);
    QryLocalizar.Connection:=ConexaoDB;
    QryLocalizar.SQL.Clear;
    QryLocalizar.SQL.Add('select IdEmpresa from empresa where Nome_Fantasia = '+''''+ nome+'''');
    QryLocalizar.Open;

    CodigoEmpresa:= QryLocalizar.FieldByName('IdEmpresa').AsInteger;


end;

procedure TFuncionario.NomeEndereco(CPF: String);
begin
  QryLocalizar:=TZQuery.Create(Nil);
  QryLocalizar.Connection:=ConexaoDB;
  QryLocalizar.SQL.Clear;
  QryLocalizar.SQL.Add('select  * from Endereco where CPF = '+''''+ CPF+''''+ 'and Ativo = 1');
  QryLocalizar.Open;

  CodigoEndereco:= QryLocalizar.FieldByName('IdEndereco').AsInteger;
end;


procedure TFuncionario.VerificaIgualdadeCampos;
var Qry:TzQuery;
begin
//Verifica se existe endere�o cadastrado para o CPF informado
 NomeEndereco(CPF);
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
                                          '(CPF , ' +
                                          'Endereco, '+
                                          'Bairro,  '+
                                          'Cidade,  '+
                                          'CEP,   '+
                                          'Numero, '+
                                          'Complemento, '+
                                          'Data_Cadastro, '+
                                          'Ativo )'+

                           'Values       (:CPF ,'+
                                         ':Endereco, '+
                                         ':Bairro,  '+
                                         ':Cidade, '+
                                         ':CEP, '+
                                         ':Numero, '+
                                         ':Complemento, '+
                                         ':Data_Cadastro, '+
                                         ':Ativo )');
          Qry.ParamByname('CPF').Value:= Self.F_CPF;
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
          NomeEndereco(CPF);
          Qry:=TzQuery.Create(nil);
          Qry.Connection:=ConexaoDB;
          Qry.SQL.Clear;
          Qry.SQL.Add('update Funcionario set IdEndereco = ' +IntToStr(CodigoEndereco)+ 'where CPF =  '+Self.F_CPF );
          Qry.ExecSQL;
          finally
            if Assigned(Qry) then
             FreeAndNil(Qry);
           if Assigned(QryLocalizar) then
             FreeAndNil(QryLocalizar)
         end;
       end;

end;

end.

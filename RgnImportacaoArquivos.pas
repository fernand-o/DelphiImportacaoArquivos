unit RgnImportacaoArquivos;

interface

uses
  BaseLayout,
  System.Rtti;

type
  TRgnImportacaoArquivos = class
  private
    FLayoutClass: TLayoutBaseClass;
    function ObterValor(const Linha: string; Field: TRttiField): TValue;
    function ProcessarArquivo(CaminhoArquivo: string): TArray<TLayoutBase>;
    function ProcessarLinha(const Linha: string): TLayoutBase;
  public
    function ImportarProdutos(const CaminhoArquivo: string; LayoutClass: TLayoutBaseClass): TArray<TLayoutBase>;
  end;

implementation

uses
  System.SysUtils,
  System.Classes;

function TRgnImportacaoArquivos.ImportarProdutos(const CaminhoArquivo: string; LayoutClass: TLayoutBaseClass): TArray<TLayoutBase>;
resourcestring
  StrArquivoNaoEncontrado = 'Arquivo %s não encontrado';
begin
  Assert(FileExists(CaminhoArquivo), Format(StrArquivoNaoEncontrado, [CaminhoArquivo]));
  FLayoutClass := LayoutClass;

  Result := ProcessarArquivo(CaminhoArquivo);
end;

function TRgnImportacaoArquivos.ObterValor(const Linha: string; Field: TRttiField): TValue;
resourcestring
  StrPosicaoNaoDefinida = 'Posição não definida para %s';
  StrFormatoNaoDefinido = 'Formato não definido para %s';
var
  Valor: string;
  ValorFormatado: Variant;
  Atributo: TCustomAttribute;
  Posicao: TPosicao;
  Formato: TFormato;
begin
  Posicao := nil;
  Formato := nil;
  for Atributo in Field.GetAttributes do
  begin
    if Atributo is TPosicao then
      Posicao := TPosicao(Atributo);

    if Atributo is TFormato then
      Formato := TFormato(Atributo);
  end;

  Assert(Assigned(Posicao), Format(StrPosicaoNaoDefinida, [Field.Name]));
  Assert(Assigned(Formato), Format(StrFormatoNaoDefinido, [Field.Name]));

  Valor := Copy(Linha, Posicao.Inicio, Posicao.Tamanho);
  ValorFormatado := Formato.FormatarValor(Valor);

  Result := TValue.FromVariant(ValorFormatado);
end;

function TRgnImportacaoArquivos.ProcessarArquivo(CaminhoArquivo: string): TArray<TLayoutBase>;
var
  Arquivo: TStringList;
  I: Integer;
begin
  Result := [];

  Arquivo := TStringList.Create;
  try
    Arquivo.LoadFromFile(CaminhoArquivo);
    for I := 0 to Pred(Arquivo.Count) do
      Result := Result + [ProcessarLinha(Arquivo[I])];
  finally
    Arquivo.Free;
  end;
end;

function TRgnImportacaoArquivos.ProcessarLinha(const Linha: string): TLayoutBase;
var
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiField: TRttiField;
  Valor: TValue;
begin
  Result := FLayoutClass.Create;

  RttiContext := TRttiContext.Create;
  RttiType := RttiContext.GetType(FLayoutClass);

  for RttiField in RttiType.GetFields do
  begin
    Valor := ObterValor(Linha, RttiField);
    RttiType.GetField(RttiField.Name).SetValue(Result, Valor);
  end;

  Result.ValidarValores;
end;

end.


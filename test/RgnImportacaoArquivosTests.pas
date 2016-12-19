unit RgnImportacaoArquivosTests;

interface

uses
  DUnitX.TestFramework,
  RgnImportacaoArquivos,
  BaseLayout,
  Layouts;

type
  {$M+}
  [TestFixture]
  TRgnImportacaoArquivosTests = class
  private
    FProdutos: TArray<TLayoutBase>;
    FSUT: TRgnImportacaoArquivos;
  public
    [Setup]
    procedure SetUp;
    [TearDown]
    procedure TearDown;
  published
    procedure ImportarProdutos_Layout100_ImportarCorretamente;
    procedure ImportarProdutos_Layout101_ImportarCorretamente;
  end;

implementation

{ TRgnImportacaoArquivosTests }

procedure TRgnImportacaoArquivosTests.SetUp;
begin
  inherited;
  FSUT := TRgnImportacaoArquivos.Create;
end;

procedure TRgnImportacaoArquivosTests.TearDown;
var
  Produto: TLayoutBase;
begin
  inherited;
  for Produto in FProdutos do
    Produto.Free;

  FSUT.Free;
end;

procedure TRgnImportacaoArquivosTests.ImportarProdutos_Layout100_ImportarCorretamente;
const
  ArquivoLayout100 = 'Arquivo100.txt';
var
  Produto: TLayout100;
begin
  FProdutos := FSUT.ImportarProdutos(ArquivoLayout100, TLayout100);

  Assert.AreEqual(2, Length(FProdutos), 'Quantidade de linhas incorreta');

  Produto := FProdutos[0] as TLayout100;
  Assert.AreEqual('FEIJAO PRETO', Produto.DescricaoProduto, 'Descricao incorreta');
  Assert.AreEqual(999, Produto.Quantidade, 'Quantidade incorreta');
//  Assert.AreEqual(Produto.Preco, 575, 'Valor incorreto');

  Produto := FProdutos[1] as TLayout100;
  Assert.AreEqual('ARROZ BRANCO', Produto.DescricaoProduto, 'Descricao incorreta');
  Assert.AreEqual(48, Produto.Quantidade, 'Quantidade incorreta');
//  Assert.AreEqual(Produto.Preco, 7, 'Valor incorreto');
end;

procedure TRgnImportacaoArquivosTests.ImportarProdutos_Layout101_ImportarCorretamente;
const
  ArquivoLayout101 = 'Arquivo101.txt';
var
  Produto: TLayout101;
begin
  FProdutos := FSUT.ImportarProdutos(ArquivoLayout101, TLayout101);

  Assert.AreEqual(2, Length(FProdutos), 'Quantidade de linhas incorreta');

  Assert.IsTrue(FProdutos[0] is TLayout101);
  Produto := FProdutos[0] as TLayout101;
  Assert.AreEqual(Produto.Vendedor, 'FERNANDO', 'Vendedor 0 incorreto');

  Produto := FProdutos[1] as TLayout101;
  Assert.AreEqual(Produto.Vendedor, 'ALMEIDA', 'Vendedor 1 incorreto');
end;

initialization
  TDUnitX.RegisterTestFixture(TRgnImportacaoArquivosTests);

end.

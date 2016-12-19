unit Layouts;

interface

uses
  BaseLayout;

type
  TLayout100 = class(TLayoutBase)
    [TPosicao(1,21), TFormato(tvString),   TFieldName('DSC')]  DescricaoProduto: string;
    [TPosicao(22,4), TFormato(tvInteger),  TFieldName('QNT')]  Quantidade: Integer;
    [TPosicao(26,8), TFormato(tvCurrency), TFieldName('PRC')]  Preco: Currency;
    procedure ValidarValores; override;
  end;

  TLayout101 = class(TLayout100)
    [TPosicao(34,15), TFormato(tvString),  TFieldName('VENDEDOR_NOME')]  Vendedor: string;
  end;

  TLayoutInfo = record
    Descricao: string;
    Classe: TLayoutBaseClass;
    constructor Create(Descricao: string; Classe: TLayoutBaseClass);
  end;

  TLayoutsDisponiveis = class
    class function Lista: TArray<TLayoutInfo>;
  end;

implementation

procedure TLayout100.ValidarValores;
begin
  inherited;

  if Quantidade > 999 then
    Quantidade := 999;
end;

{ TLayoutsDisponiveis }

class function TLayoutsDisponiveis.Lista: TArray<TLayoutInfo>;
begin
  Result := [
    TLayoutInfo.Create('Layout 1.00', TLayout100),
    TLayoutInfo.Create('Layout 1.01', TLayout101)
  ];
end;

{ TLayoutInfo }

constructor TLayoutInfo.Create(Descricao: string; Classe: TLayoutBaseClass);
begin
  Self.Descricao := Descricao;
  Self.Classe := Classe;
end;

end.

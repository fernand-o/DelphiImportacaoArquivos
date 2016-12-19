unit BaseLayout;

interface

type
  TLayoutBase = class
  public
    procedure ValidarValores; virtual;
  end;
  TLayoutBaseClass = class of TLayoutBase;

  TFieldName = class(TCustomAttribute)
  private
    FFieldName: string;
  public
    constructor Create(Field: string);
  end;

  TPosicao = class(TCustomAttribute)
  public
    Inicio: Integer;
    Tamanho: Integer;
    constructor Create(Inicio, Tamanho: Integer);
  end;

  TTipoValor = (tvString, tvCurrency, tvInteger);
  TFormato = class(TCustomAttribute)
  private
    FTipoValor: TTipoValor;
  public
    constructor Create(TipoValor: TTipoValor);
    function FormatarValor(const Valor: string): Variant;
  end;

implementation

uses
  System.SysUtils;

constructor TFieldName.Create(Field: string);
begin
  FFieldName := Field;
end;

{ TPosicao }

constructor TPosicao.Create(Inicio, Tamanho: Integer);
begin
  Self.Inicio := Inicio;
  Self.Tamanho := Tamanho;
end;

{ TLayoutBase }

procedure TLayoutBase.ValidarValores;
begin
end;

{ TFormato }

constructor TFormato.Create(TipoValor: TTipoValor);
begin
  FTipoValor := TipoValor;
end;

function TFormato.FormatarValor(const Valor: string): Variant;
begin
  case FTipoValor of
    tvString: Result := Valor.Trim;
    tvCurrency: Result := StrToCurrDef(Valor, 0);
    tvInteger:  Result := StrToIntDef(Valor, 0);
  end;
end;

end.

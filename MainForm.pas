unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Generics.Collections,
  System.Rtti,
  Layouts,
  BaseLayout,
  RgnImportacaoArquivos;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ConfigurarCombo;
    procedure ListarProdutosMemo(Produtos: TArray<TLayoutBase>; Layout: TLayoutBaseClass);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  LayoutSelecionado: TLayoutBaseClass;
  RgnImportacao: TRgnImportacaoArquivos;
  Produtos: TArray<TLayoutBase>;
begin
  LayoutSelecionado := TLayoutsDisponiveis.Lista[ComboBox1.ItemIndex].Classe;

  RgnImportacao := TRgnImportacaoArquivos.Create;
  try
    Produtos := RgnImportacao.ImportarProdutos(Edit1.Text, LayoutSelecionado);

    ListarProdutosMemo(Produtos, LayoutSelecionado);
  finally
    RgnImportacao.Free;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  OpenDialog1.InitialDir := ExtractFilePath(ParamStr(0));
  if OpenDialog1.Execute() then
    Edit1.Text := OpenDialog1.FileName;
end;

procedure TForm1.ConfigurarCombo;
var
  Layout: TLayoutInfo;
begin
  for Layout in TLayoutsDisponiveis.Lista do
    ComboBox1.Items.Add(Layout.Descricao);

  ComboBox1.ItemIndex := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ConfigurarCombo;
end;

procedure TForm1.ListarProdutosMemo(Produtos: TArray<TLayoutBase>; Layout: TLayoutBaseClass);
var
  Produto: TLayoutBase;
  RttiContext: TRttiContext;
  RttiType: TRttiType;
  RttiField: TRttiField;
begin
  memo1.Lines.Clear;
  RttiContext := TRttiContext.Create;
  RttiType := RttiContext.GetType(Layout);

  for Produto in Produtos do
  begin
    for RttiField in RttiType.GetFields do
      Memo1.Lines.Add(RttiField.Name +': '+ VarToStr(RttiField.GetValue(Produto).AsVariant));
    memo1.lines.Add('---------------')
  end;
end;

end.

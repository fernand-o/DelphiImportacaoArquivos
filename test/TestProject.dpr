program TestProject;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Layouts in '..\Layouts.pas',
  BaseLayout in '..\BaseLayout.pas',
  DunitXTestRunner in 'DunitXTestRunner.pas',
  RgnImportacaoArquivosTests in 'RgnImportacaoArquivosTests.pas';

begin
  TDunitXTestRunner.Execute;
end.

unit DunitXTestRunner;

interface

uses
  System.SysUtils;

type
  TDUnitXTestRunner = class
  public
    class procedure Execute;
    class procedure MostrarErro(E: Exception);
  end;

implementation

uses
  DUnitX.TestFramework,
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.Windows.Console;

class procedure TDUnitXTestRunner.Execute;
var
  Runner : ITestRunner;
  Results : IRunResults;
  ConsoleLogger : ITestLogger;
begin
  // Define o diretório para o diretório do exe para permitir que o teste seja executado a partir de qualquer pasta
  SetCurrentDir(ExtractFileDir(ParamStr(0)));
  try
    TDUnitX.CheckCommandLine;
    Runner := TDUnitX.CreateRunner;
    Runner.UseRTTI := True;
    ConsoleLogger := TDUnitXConsoleLogger.Create(true);
    Runner.AddLogger(ConsoleLogger);

    Results := Runner.Execute;
    if not Results.AllPassed then
      ExitCode := 1;

    System.Write('Done.. press <Enter> key to quit.');
    System.Readln;
  except
    on E: Exception do
      MostrarErro(E);
  end;
end;

class procedure TDUnitXTestRunner.MostrarErro(E: Exception);
begin
  ExitCode := 2;
  System.Writeln(E.ClassName, ': ', E.Message);
end;

end.

program Project1;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

begin
  ReportMemoryLeaksOnShutDown := false;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //Application.Title := 'UAC Bypass';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

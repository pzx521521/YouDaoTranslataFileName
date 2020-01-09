program YouDaoTransLate;

uses
  ExceptionLog,
  Forms,
  ufrmYouDaoTranslataFileName in 'ufrmYouDaoTranslataFileName.pas' {frmTranslataFileName},
  uMyHttp in 'uMyHttp.pas',
  superobject in 'superobject.pas',
  ufrmdrag in 'ufrmdrag.pas' {frmDrag};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmTranslataFileName, frmTranslataFileName);
  Application.CreateForm(TfrmDrag, frmDrag);
  Application.Run;
end.

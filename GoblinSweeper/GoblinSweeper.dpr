program GoblinSweeper;





{$R *.dres}

uses
  System.StartUpCopy,
  FMX.Forms,
  Form_Params in 'Form_Params.pas' {FormParams},
  Form_Goblinsweeper in 'Form_Goblinsweeper.pas' {GoblinsweeperForm},
  Form_ScoreBoard in 'Form_ScoreBoard.pas' {FormScoreBoard},
  DataModule_Local in 'DataModule_Local.pas' {DMLocal: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDMLocal, DMLocal);
  Application.CreateForm(TGoblinsweeperForm, GoblinsweeperForm);
  Application.CreateForm(TFormParams, FormParams);
  Application.CreateForm(TFormScoreBoard, FormScoreBoard);
  Application.Run;
end.

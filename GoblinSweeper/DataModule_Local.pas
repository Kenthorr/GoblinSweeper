unit DataModule_Local;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, System.JSON,
  System.Generics.Collections, System.Generics.Defaults,
  System.NetEncoding,
  FMX.Types, FMX.Media;

const
  RT_RCDATA = PChar(10);

type
  TSound = (tsPelle, tsAmbiance, tsCriGoblin, tsFeuArtifice, tsDrapeau);

type
  TDMLocal = class(TDataModule)
    MediaPlayerPelle: TMediaPlayer;
    MediaPlayerAmbiance: TMediaPlayer;
    MediaPlayerCriGoblin: TMediaPlayer;
    TimerAmbiance: TTimer;
    MediaPlayerFeuArtifice: TMediaPlayer;
    TimerFeuArtifice: TTimer;
    MediaPlayerDrapeau: TMediaPlayer;
    procedure TimerAmbianceTimer(Sender: TObject);
    procedure TimerFeuArtificeTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    FScoreBoard : TJsonArray ;

    FCheminDossier               : string ;
    FCheminFichierScoreBoard     : string ;
    FCheminFichierSonPelle       : string ;
    FCheminFichierSonAmbiance    : string ;
    FCheminFichierSonCriGoblin   : string ;
    FCheminFichierSonFeuArtifice : string ;
    FCheminFichierSonDrapeau     : string ;

    procedure GestionCheminFichier ;
    procedure CreateDirectory ;
    procedure ChargerFichierScoreBoard ;
    procedure SauvegarderFichierScoreBoard ;
    function VerifierSiScoreEstDansTop10(const aNouveauScore: Integer): Boolean;
    procedure SauvegarderNouveauScore(const aNom: string; const aNouveauScore: Integer);
    procedure TrierFScoreBoardParScore;
    procedure TelechargerFichier ;

    procedure PlaySound(aTypeSound : TSound) ;
    procedure StopSound(aTypeSound : TSound) ;

  end;

var
  DMLocal: TDMLocal;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

uses Form_Goblinsweeper;

{$R *.dfm}


{$REGION 'File/Directory'}

procedure TDmLocal.GestionCheminFichier ;
begin

  {$IFDEF ANDROID}

    FCheminDossier := TPath.GetPublicPath + PathDelim + 'GoblinSweeper' ;

  {$ENDIF}

  {$IFDEF MSWINDOWS}

    FCheminDossier := GetEnvironmentVariable('APPDATA') + '\GoblinSweeper' ;

  {$ENDIF}

  FCheminFichierScoreBoard      := FCheminDossier + PathDelim + 'SB'   ;

  FCheminFichierSonPelle        := FCheminDossier + PathDelim + 'Pelle.wav'         ;
  FCheminFichierSonAmbiance     := FCheminDossier + PathDelim + 'Ambiance.wav'      ;
  FCheminFichierSonCriGoblin    := FCheminDossier + PathDelim + 'CriGoblin.wav'     ;
  FCheminFichierSonFeuArtifice  := FCheminDossier + PathDelim + 'FeuArtifice.wav'   ;
  FCheminFichierSonDrapeau      := FCheminDossier + PathDelim + 'Drapeau.wav'       ;

end;


procedure TDmLocal.CreateDirectory ;
begin
  if not DirectoryExists(FCheminDossier) then
    CreateDir(FCheminDossier) ;
end;

{$ENDREGION 'File/Directory'}


{$REGION 'ScoreBoard'}

procedure TDmLocal.ChargerFichierScoreBoard ;
var
  cStringList : TStringList ;
  cScoreBoardDecoded : string ;
begin

  cStringList := TStringList.Create ;

  try

    if not FileExists(FCheminFichierScoreBoard) then begin
      cStringList.Add('[]') ;
      cStringList.Text := System.NetEncoding.TBase64Encoding.Base64.Encode(cStringList.Text) ;
      //FileCreate(FCheminFichierScoreBoard) ;
      cStringList.SaveToFile(FCheminFichierScoreBoard) ;
    end;

    cStringList.LoadFromFile(FCheminFichierScoreBoard) ;
    cScoreBoardDecoded := System.NetEncoding.TBase64Encoding.Base64.Decode(cStringList.Text) ;
    FScoreBoard := TJSONObject.ParseJSONValue(cScoreBoardDecoded) as TJSONArray ;

  finally
    cStringList.Free ;
  end;

end;


procedure TDmLocal.SauvegarderFichierScoreBoard ;
var
  cStringList : TStringList ;
begin

  cStringList := TStringList.Create ;

  try
    cStringList.Text := FScoreBoard.ToString ;
    cStringList.Text := System.NetEncoding.TBase64Encoding.Base64.Encode(cStringList.Text) ;
    cStringList.SaveToFile(FCheminFichierScoreBoard) ;
  finally
    cStringList.Free ;
  end;

end;


function TDmLocal.VerifierSiScoreEstDansTop10(const aNouveauScore: Integer): Boolean;
var
  i                : Integer     ;
  cJsonObjectScore : TJsonObject ;
  cScore           : Integer     ;
begin
  Result := False; // Par défaut, le score n'est pas dans le top 10

  ChargerFichierScoreBoard ;

  if FScoreBoard.Count = 0 then Result := True ;

  for I := 0 to FScoreBoard.Count-1 do begin

    cJsonObjectScore := FScoreBoard.Items[i] as TJsonObject;

    try

      cJsonObjectScore.TryGetValue<Integer>('Score', cScore) ;

      if (FScoreBoard.Count < 10) or (aNouveauScore > cScore) then begin
        Result := True ;
        Break ;
      end;


    finally
      cJsonObjectScore.Free ;
    end;

  end;

end;


procedure TDmLocal.SauvegarderNouveauScore(const aNom: string; const aNouveauScore: Integer);
var
  i                : Integer     ;
  cJsonObjectScore : TJsonObject ;
  cScore           : Integer     ;
  cScoreMin        : Integer     ;
  cIndexScoreMin   : integer     ;
begin

  ChargerFichierScoreBoard ;

  cIndexScoreMin := -1      ;
  cScoreMin      := MaxInt  ;

  // on cerche le score minimum
  for I := 0 to FScoreBoard.Count-1 do begin

    cJsonObjectScore := FScoreBoard.Items[i] as TJsonObject;

    cJsonObjectScore.TryGetValue<Integer>('Score', cScore) ;

    if cScore < cScoreMin then begin
      cScoreMin      := cScore ;
      cIndexScoreMin := I      ;
    end;

  end;

  // on le retire de la liste
  if (cIndexScoreMin <> -1) and (FScoreBoard.Count = 10) then
    FScoreBoard.Remove(cIndexScoreMin) ;

  // on ajoute le nouveau score
  cJsonObjectScore := TJsonObject.Create ;
  cJsonObjectScore.AddPair('Name'  , aNom          ) ;
  cJsonObjectScore.AddPair('Score' , aNouveauScore ) ;

  FScoreBoard.Add(cJsonObjectScore) ;


  SauvegarderFichierScoreBoard;

end;


procedure TDmLocal.TrierFScoreBoardParScore;
var
  TempList     : TList<TJsonObject>;
  i            : Integer;
  Obj          : TJsonObject;
  NewJsonArray : TJsonArray;
  ScoreL, ScoreR: Integer;
begin
  TempList := TList<TJsonObject>.Create;
  try
    // Extraction des objets
    for i := 0 to FScoreBoard.Count - 1 do
      TempList.Add(FScoreBoard.Items[i] as TJsonObject);

    // Tri décroissant
    TempList.Sort(
      TComparer<TJsonObject>.Construct(
        function(const L, R: TJsonObject): Integer
        begin
          L.TryGetValue<Integer>('Score', ScoreL);
          R.TryGetValue<Integer>('Score', ScoreR);
          Result := ScoreR - ScoreL;
        end
      )
    );

    // Nouvelle JsonArray triée
    NewJsonArray := TJsonArray.Create;
    for Obj in TempList do
      NewJsonArray.AddElement(Obj.Clone as TJsonObject);

    // Remplacement de FScoreBoard
    FScoreBoard.Free;
    FScoreBoard := NewJsonArray;

  finally
    TempList.Free;
  end;
end;

{$ENDREGION 'ScoreBoard'}


{$REGION 'Son'}

procedure TDmLocal.TelechargerFichier ;
var
  cResStream : TResourceStream;
begin

  if not FileExists(FCheminFichierSonPelle) then begin

    cResStream := TResourceStream.Create(HInstance, 'Pelle', RT_RCDATA);

    try
      cResStream.SaveToFile(FCheminFichierSonPelle);
    finally
      cResStream.Free;
    end;

  end;

  if not FileExists(FCheminFichierSonAmbiance) then begin

    cResStream := TResourceStream.Create(HInstance, 'Ambiance', RT_RCDATA);

    try
      cResStream.SaveToFile(FCheminFichierSonAmbiance);
    finally
      cResStream.Free;
    end;

  end;

  if not FileExists(FCheminFichierSonCriGoblin) then begin

    cResStream := TResourceStream.Create(HInstance, 'CriGoblin', RT_RCDATA);

    try
      cResStream.SaveToFile(FCheminFichierSonCriGoblin);
    finally
      cResStream.Free;
    end;

  end;

  if not FileExists(FCheminFichierSonFeuArtifice) then begin

    cResStream := TResourceStream.Create(HInstance, 'FeuArtifice', RT_RCDATA);

    try
      cResStream.SaveToFile(FCheminFichierSonFeuArtifice);
    finally
      cResStream.Free;
    end;

  end;

  if not FileExists(FCheminFichierSonDrapeau) then begin

    cResStream := TResourceStream.Create(HInstance, 'Drapeau', RT_RCDATA);

    try
      cResStream.SaveToFile(FCheminFichierSonDrapeau);
    finally
      cResStream.Free;
    end;

  end;

  MediaPlayerPelle.FileName        := FCheminFichierSonPelle        ;
  MediaPlayerAmbiance.FileName     := FCheminFichierSonAmbiance     ;
  MediaPlayerCriGoblin.FileName    := FCheminFichierSonCriGoblin    ;
  MediaPlayerFeuArtifice.FileName  := FCheminFichierSonFeuArtifice  ;
  MediaPlayerDrapeau.FileName      := FCheminFichierSonDrapeau      ;

end;


procedure TDmLocal.PlaySound(aTypeSound : TSound) ;
begin

  if aTypeSound = tsPelle then begin
    MediaPlayerPelle.CurrentTime := 0;
    MediaPlayerPelle.Play ;
  end;

  if aTypeSound = tsAmbiance then begin
    if (MediaPlayerAmbiance.State = TMediaState.Stopped)
    or (MediaPlayerAmbiance.State = TMediaState.Unavailable) then begin
      MediaPlayerAmbiance.CurrentTime := 0;
      MediaPlayerAmbiance.Play ;
      TimerAmbiance.Enabled := True ;
    end;
  end;

  if aTypeSound = tsCriGoblin then begin
    MediaPlayerCriGoblin.CurrentTime := 0;
    MediaPlayerCriGoblin.Play ;
  end;

  if aTypeSound = tsFeuArtifice then begin
    if (MediaPlayerFeuArtifice.State = TMediaState.Stopped)
    or (MediaPlayerFeuArtifice.State = TMediaState.Unavailable) then begin
      MediaPlayerFeuArtifice.CurrentTime := 0;
      MediaPlayerFeuArtifice.Play ;
      TimerFeuArtifice.Enabled := True ;
    end;
  end;

  if aTypeSound = tsDrapeau then begin
    MediaPlayerDrapeau.CurrentTime := 0;
    MediaPlayerDrapeau.Play ;
  end;

end;


procedure TDmLocal.StopSound(aTypeSound : TSound) ;
begin

  if aTypeSound = tsPelle then begin
    if MediaPlayerPelle.State = TMediaState.Playing then
      MediaPlayerPelle.Stop ;
  end;

  if aTypeSound = tsAmbiance then begin
    if MediaPlayerAmbiance.State = TMediaState.Playing then begin
      TimerAmbiance.Enabled := False ;
      MediaPlayerAmbiance.Stop ;
    end;
  end;

  if aTypeSound = tsCriGoblin then begin
    if MediaPlayerCriGoblin.State = TMediaState.Playing then
      MediaPlayerCriGoblin.Stop ;
  end;

  if aTypeSound = tsFeuArtifice then begin
    if MediaPlayerFeuArtifice.State = TMediaState.Playing then begin
      TimerFeuArtifice.Enabled := False ;
      MediaPlayerFeuArtifice.Stop ;
    end;
  end;

  if aTypeSound = tsDrapeau then begin
    if MediaPlayerDrapeau.State = TMediaState.Playing then
      MediaPlayerDrapeau.Stop ;
  end;

end;


procedure TDMLocal.TimerAmbianceTimer(Sender: TObject);
begin
  if MediaPlayerAmbiance.State = TMediaState.Stopped then
  begin
    MediaPlayerAmbiance.CurrentTime := 0;
    MediaPlayerAmbiance.Play;
  end;
end;


procedure TDMLocal.TimerFeuArtificeTimer(Sender: TObject);
begin
  if MediaPlayerFeuArtifice.State = TMediaState.Stopped then
  begin
    MediaPlayerFeuArtifice.CurrentTime := 0;
    MediaPlayerFeuArtifice.Play;
  end;
end;

{$ENDREGION 'Son'}


end.

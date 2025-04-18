unit Form_Goblinsweeper;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.DateUtils,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.StdCtrls, FMX.Objects, FMX.Controls.Presentation, Form_Params, FMX.Ani,
  FMX.Memo.Types, FMX.ScrollBox, FMX.Memo, FMX.Media, FMX.Edit, FMX.Effects,
  FMX.Filter.Effects;

type
  TCell = record
    IsMine              : Boolean              ;
    Revealed            : Boolean              ;
    Marked              : Boolean              ;
    AdjacentMines       : Integer              ;
    Rect                : TRectangle           ;
    RectGoblin          : TRectangle           ;
    Text                : TText                ;
    Image               : tImage               ;
    BitmapListAnimation : TBitmapListAnimation ;
  end;

  TGoblinsweeperForm = class(TForm)
    LabelTimer: TLabel;
    Timer1: TTimer;
    LayoutClient: TLayout;
    LayoutTop: TLayout;
    ImageTileSetSol1: TImage;
    ImageTileSetSol3: TImage;
    ImageTileSetSol2: TImage;
    ImageTileSetHerbe: TImage;
    ImageTileSetSol4: TImage;
    ImageTileSetSolHautGaucheDroite: TImage;
    ImageTileSetSolBasGaucheDroite: TImage;
    ImageTileSetSolHautBasGauche: TImage;
    ImageTileSetSolHautBasDroite: TImage;
    ImageTileSetSolHaut: TImage;
    ImageTileSetSolBas: TImage;
    ImageTileSetSolGauche: TImage;
    ImageTileSetSolDroite: TImage;
    ImageTileSetSolHautBas: TImage;
    ImageTileSetSolHautGauche: TImage;
    ImageTileSetSolBasGauche: TImage;
    ImageTileSetSolHautDroite: TImage;
    ImageTileSetSolBasDroite: TImage;
    ImageTileSetSolGaucheDroite: TImage;
    BitmapListAnimationGoblin: TBitmapListAnimation;
    ImageFlag: TImage;
    GridPanel: TGridPanelLayout;
    ImageGobelin: TImage;
    ImageGoblinAnimated: TImage;
    FloatAnimationGoblinHeight: TFloatAnimation;
    FloatAnimationGoblinWidth: TFloatAnimation;
    LayoutBlockClick: TLayout;
    LayoutImages: TLayout;
    ImageFond: TImage;
    ImageStartGame: TImage;
    LabelStartGame: TLabel;
    ImageParams: TImage;
    LayoutParams: TLayout;
    LayoutContentBot: TLayout;
    LayoutBot: TLayout;
    ImagePlateau: TImage;
    LayoutContentTop: TLayout;
    LabelTitre: TLabel;
    Layout1: TLayout;
    ImageHerbe: TImage;
    ImageFeuArtifice1: TImage;
    BitmapListAnimationFeuArtifice1: TBitmapListAnimation;
    ImageFeuArtifice2: TImage;
    BitmapListAnimationFeuArtifice2: TBitmapListAnimation;
    ImageFeuArtifice3: TImage;
    BitmapListAnimationFeuArtifice3: TBitmapListAnimation;
    ImageFeuArtifice4: TImage;
    BitmapListAnimationFeuArtifice4: TBitmapListAnimation;
    ImageFeuArtifice5: TImage;
    BitmapListAnimationFeuArtifice5: TBitmapListAnimation;
    LayoutScoreBoard: TLayout;
    ImageScoreBoard: TImage;
    LayoutTimer: TLayout;
    ImageTimer: TImage;
    LayoutGoblins: TLayout;
    LabelGoblins: TLabel;
    ImageGoblins: TImage;
    BitmapListAnimation1: TBitmapListAnimation;
    LayoutBestScore: TLayout;
    ImageBestScore: TImage;
    Label1: TLabel;
    EditNameTop10Score: TEdit;
    Layout2: TLayout;
    Label3: TLabel;
    Layout3: TLayout;
    Rectangle1: TRectangle;
    Layout4: TLayout;
    Label4: TLabel;
    LabelScore: TLabel;
    ImageValiderTop10Score: TImage;
    LayoutButtonInfos: TLayout;
    ImageButtonInfos: TImage;
    FillRGBEffectButtonInfos: TFillRGBEffect;
    LayoutInfos: TLayout;
    Rectangle2: TRectangle;
    Image1: TImage;
    Layout6: TLayout;
    Label2: TLabel;
    Layout7: TLayout;
    LabelInfos: TLabel;
    ImageValiderInfos: TImage;
    VertScrollBox1: TVertScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FloatAnimationGoblinHeightFinish(Sender: TObject);
    procedure ImageStartGameClick(Sender: TObject);
    procedure LayoutParamsClick(Sender: TObject);
    procedure LayoutScoreBoardClick(Sender: TObject);
    procedure ImageValiderTop10ScoreMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutButtonInfosClick(Sender: TObject);
    procedure ImageValiderInfosMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private

    Grid: array of array of TCell;

    FJeSuisEnLongTap         : boolean ;
    FJeViensDeFaireUnLongTap : boolean ;

    procedure ResetGame;
    procedure StopGame;
    procedure InitializeGrid;
    procedure FreeGrid;
    procedure StartTimerGame ;
    procedure PlaceMines;
    procedure CalculateHints;
    procedure CellMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure CellMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure CellTap(Sender: TObject; const Point: TPointF);
    procedure CellGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
    procedure RevealCell(X, Y: Integer);
    procedure RevealAdjacentCells(X, Y: Integer);
    procedure ChooseTileSet ;
    procedure MarkCell(X, Y: Integer);
    function CountAdjacentMines(X, Y: Integer): Integer;
    procedure CheckWinCondition;
    procedure Win;
    procedure Loose;

    function CalculerScore(temps: Integer): Integer;

  public

    FGridSize         : integer ;
    FNumGoblins       : integer ;
    FNumGoblinsMarked : integer ;
    FTimeGame         : integer ;
    FTime             : integer ;
    FScore            : integer ;

    FDateTimeDebut : TDateTime ;

    FGameEnCours : boolean ;

    FFirstTapSafeCheck : boolean ;
    FFirstTap          : boolean ;

  end;

var
  GoblinsweeperForm: TGoblinsweeperForm;

implementation

{$R *.fmx}

uses Form_ScoreBoard, DataModule_Local;


{$REGION 'FORM'}

procedure TGoblinsweeperForm.FormCreate(Sender: TObject);
begin

  DmLocal.GestionCheminFichier ;
  DmLocal.CreateDirectory ;
  DmLocal.TelechargerFichier ;

  FGridSize          := 10    ;
  FNumGoblins        := 10    ;
  FNumGoblinsMarked  := 0     ;
  FTimeGame          := 120   ;
  FFirstTapSafeCheck := False ;
  FFirstTap          := True  ;
  FGameEnCours       := False ;
end;

{$ENDREGION 'FORM'}


{$REGION 'HIM'}

procedure TGoblinsweeperForm.ImageStartGameClick(Sender: TObject);
begin
  if LabelStartGame.Text = 'Start Game' then begin
    LabelStartGame.Text := 'Stop Game' ;
    LayoutParams.Enabled := False ;
    ResetGame ;
  end
  else
  begin
    LabelStartGame.Text := 'Start Game' ;
    LayoutParams.Enabled := True ;
    StopGame ;
  end;
end;


procedure TGoblinsweeperForm.LayoutButtonInfosClick(Sender: TObject);
begin
  VertScrollBox1.ViewportPosition := TPointF.Create(0,0) ;
  LayoutInfos.Visible := True ;
end;

procedure TGoblinsweeperForm.LayoutParamsClick(Sender: TObject);
begin
  FormParams.Show ;
  Self.Hide ;
end;


procedure TGoblinsweeperForm.LayoutScoreBoardClick(Sender: TObject);
begin
  FormScoreBoard.Show ;
  Self.Hide ;
end;

{$ENDREGION 'HIM'}


{$REGION 'Game'}

procedure TGoblinsweeperForm.ResetGame;
begin

  BitmapListAnimationFeuArtifice1.Stop ;
  ImageFeuArtifice1.Visible := False ;
  BitmapListAnimationFeuArtifice2.Stop ;
  ImageFeuArtifice2.Visible := False ;
  BitmapListAnimationFeuArtifice3.Stop ;
  ImageFeuArtifice3.Visible := False ;
  BitmapListAnimationFeuArtifice4.Stop ;
  ImageFeuArtifice4.Visible := False ;
  BitmapListAnimationFeuArtifice5.Stop ;
  ImageFeuArtifice5.Visible := False ;

  DMLocal.StopSound(tsFeuArtifice) ;
  DMLocal.PlaySound(tsAmbiance) ;

  FTime             := 0 ;
  FNumGoblinsMarked := 0 ;
  LabelGoblins.Text := ': ' + FNumGoblinsMarked.ToString + '/' + FNumGoblins.ToString ;

  FFirstTap      := True  ;
  FGameEnCours   := True  ;
  StartTimerGame ;
  FreeGrid;
  InitializeGrid;
  PlaceMines;
  CalculateHints;
  LayoutBlockClick.HitTest := False ;

end;


procedure TGoblinsweeperForm.StopGame;
begin

  DMLocal.StopSound(tsAmbiance) ;
  Timer1.Enabled := false ;
  FGameEnCours   := False ;
  FreeGrid;
  LayoutBlockClick.HitTest := True ;
  LabelTimer.Text := ': 0s' ;

end;


procedure TGoblinsweeperForm.InitializeGrid;
var
  X, Y                     : Integer              ;
  cCellRect                : TRectangle           ;
  cCellRectGoblin          : TRectangle           ;
  cCellText                : TText                ;
  cCellImage               : TImage               ;
  cCellBitmapListAnimation : TBitmapListAnimation ;
begin

  GridPanel.RowCollection.Clear;
  GridPanel.ColumnCollection.Clear;
  GridPanel.RowCollection.Capacity    := FGridSize      ;
  GridPanel.ColumnCollection.Capacity := FGridSize      ;

  for X := 0 to FGridSize - 1 do begin

    with GridPanel.RowCollection.Add do begin
      SizeStyle := TGridPanelLayout.TSizeStyle.Weight ;
      Value := 100 / FGridSize;
    end;

    with GridPanel.ColumnCollection.Add do begin
      SizeStyle := TGridPanelLayout.TSizeStyle.Weight ;
      Value := 100 / FGridSize;
    end;

  end;

  SetLength(grid, FGridSize, FGridSize) ;

  for X := 0 to FGridSize - 1 do begin
    for Y := 0 to FGridSize - 1 do begin

      Grid[X, Y].IsMine        := False ;
      Grid[X, Y].Revealed      := False ;
      Grid[X, Y].Marked        := False ;
      Grid[X, Y].AdjacentMines := 0     ;

      cCellRect                      := TRectangle.Create(Self)       ;
      cCellRect.Parent               := GridPanel                     ;
      cCellRect.Width                := GridPanel.Width / FGridSize   ;
      cCellRect.Height               := GridPanel.Height / FGridSize  ;
      cCellRect.Fill.Kind            := TBrushKind.Bitmap             ;
      cCellRect.Fill.Bitmap.Bitmap   := ImageTileSetHerbe.Bitmap      ;
      cCellRect.Fill.Bitmap.WrapMode := TWrapMode.TileStretch         ;
      cCellRect.Stroke.Color         := TAlphaColorRec.grey           ;
      cCellRect.Stroke.Thickness     := 0.5                           ;
      cCellRect.Tag                  := X * FGridSize + Y             ;
      cCellRect.OnMouseDown          := CellMouseDown                 ;
      cCellRect.OnMouseUp            := CellMouseUp                   ;
      cCellRect.OnTap                := CellTap                       ;
      cCellRect.OnGesture            := CellGesture                   ;
      cCellRect.Touch.InteractiveGestures := [TInteractiveGesture.LongTap] ;
      cCellRect.Align                := TAlignLayout.Client           ;
      cCellRect.SendToBack ;

      cCellRectGoblin                      := TRectangle.Create(Self)       ;
      cCellRectGoblin.Parent               := cCellRect                     ;
      cCellRectGoblin.Width                := GridPanel.Width / FGridSize   ;
      cCellRectGoblin.Height               := GridPanel.Height / FGridSize  ;
      cCellRectGoblin.Fill.Kind            := TBrushKind.Solid              ;
      cCellRectGoblin.Fill.Color           := TAlphaColors.Null             ;
      cCellRectGoblin.Stroke.Thickness     := 0                             ;
      cCellRectGoblin.Opacity              := 0.4                           ;
      cCellRectGoblin.HitTest              := False                         ;
      cCellRectGoblin.Align                := TAlignLayout.Contents         ;
      cCellRectGoblin.SendToBack ;

      cCellText                        := TText.Create(Self)    ;
      cCellText.Parent                 := cCellRect             ;
      cCellText.Align                  := TAlignLayout.Contents ;
      cCellText.Visible                := False                 ;
      cCellText.Text                   := ''                    ;
      cCellText.TextSettings.FontColor := TAlphaColors.White    ;
      cCellText.Font.Size              := 14                    ;

      cCellImage                := TImage.Create(Self)   ;
      cCellImage.Parent         := cCellRect             ;
      cCellImage.Align          := TAlignLayout.Contents ;
      cCellImage.Margins.Top    := 2                     ;
      cCellImage.Margins.Bottom := 2                     ;
      cCellImage.Margins.Left   := 2                     ;
      cCellImage.Margins.Right  := 2                     ;
      cCellImage.Visible        := False                 ;
      cCellImage.HitTest        := False                 ;
      cCellImage.BringToFront ;

      cCellBitmapListAnimation                 := TBitmapListAnimation.Create(Self)  ;
      cCellBitmapListAnimation.Parent          := cCellImage                         ;
      cCellBitmapListAnimation.AnimationCount  := 6                                  ;
      cCellBitmapListAnimation.Duration        := 1.5                                ;
      cCellBitmapListAnimation.Loop            := True                               ;
      cCellBitmapListAnimation.PropertyName    := 'bitmap'                           ;

      Grid[X, Y].Rect                := cCellRect                ;
      Grid[X, Y].Text                := cCellText                ;
      Grid[X, Y].Image               := cCellImage               ;
      Grid[X, Y].BitmapListAnimation := cCellBitmapListAnimation ;
      Grid[X, Y].RectGoblin          := cCellRectGoblin ;

    end;
  end;
end;


procedure TGoblinsweeperForm.FreeGrid;
var
  I : integer ;
begin

  for I := GridPanel.ControlsCount - 1 downto 0 do begin
    GridPanel.Controls[I].Free;
  end;

  GridPanel.RowCollection.Clear;
  GridPanel.ColumnCollection.Clear;

end;



procedure TGoblinsweeperForm.PlaceMines;
var
  X, Y, MinesPlaced: Integer;
begin

  Randomize;
  MinesPlaced := 0;

  while MinesPlaced < FNumGoblins do begin

    X := Random(FGridSize);
    Y := Random(FGridSize);

    if not Grid[X, Y].IsMine then begin
      Grid[X, Y].IsMine := True;
      Inc(MinesPlaced);
    end;

  end;

end;


procedure TGoblinsweeperForm.CalculateHints;
var
  X, Y: Integer;
begin
  for X := 0 to FGridSize - 1 do begin
    for Y := 0 to FGridSize - 1 do begin
      if not Grid[X, Y].IsMine then
        Grid[X, Y].AdjacentMines := CountAdjacentMines(X, Y);
    end;
  end;
end;


function TGoblinsweeperForm.CountAdjacentMines(X, Y: Integer): Integer;
var
  DX, DY, NX, NY: Integer;
begin
  Result := 0;
  for DX := -1 to 1 do
    for DY := -1 to 1 do
    begin
      NX := X + DX;
      NY := Y + DY;
      if (NX >= 0) and (NX < FGridSize) and (NY >= 0) and (NY < FGridSize) then
        if Grid[NX, NY].IsMine then
          Inc(Result);
    end;
end;


procedure TGoblinsweeperForm.CellMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
var
  cX, cY: Integer;
begin

  cX := (Sender as TRectangle).Tag div FGridSize;
  cY := (Sender as TRectangle).Tag mod FGridSize;

  FJeSuisEnLongTap := True ;
  FJeViensDeFaireUnLongTap := False ;

  {$IFDEF MSWINDOWS}
  if Button = TMouseButton.mbLeft then begin
    if (cX < 0) or (cX >= FGridSize) or (cY < 0) or (cY >= FGridSize) or Grid[cX, cY].Revealed or Grid[cX, cY].Marked then Exit;
    DMLocal.PlaySound(tsPelle) ;
    RevealCell(cX, cY);
    if FGameEnCours then begin
      ChooseTileSet;
      CheckWinCondition;
    end;
  end;

  if Button = TMouseButton.mbRight then begin
    if (cX < 0) or (cX >= FGridSize) or (cY < 0) or (cY >= FGridSize) or Grid[cX, cY].Revealed then Exit;
    DMLocal.PlaySound(tsDrapeau) ;
    MarkCell(cX, cY);
  end;
  {$ENDIF MSWINDOWS}

end;

procedure TGoblinsweeperForm.CellMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FJeSuisEnLongTap := False ;
end;


procedure TGoblinsweeperForm.CellTap(Sender: TObject; const Point: TPointF);
var
  cX, cY: Integer;
begin
  {$IFDEF ANDROID}

  if FJeViensDeFaireUnLongTap then exit ;


  cX := (Sender as TRectangle).Tag div FGridSize;
  cY := (Sender as TRectangle).Tag mod FGridSize;

  if Grid[cX, cY].Revealed or Grid[cX, cY].Marked then Exit;

  DMLocal.PlaySound(tsPelle);
  RevealCell(cX, cY);

  if FGameEnCours then
  begin
    ChooseTileSet;
    CheckWinCondition;
  end;
  {$ENDIF ANDROID}
end;

procedure TGoblinsweeperForm.CellGesture(Sender: TObject; const EventInfo: TGestureEventInfo; var Handled: Boolean);
var
  cX, cY: Integer;
begin
  {$IFDEF ANDROID}
  if EventInfo.GestureID = igiLongTap then
  begin
    cX := (Sender as TRectangle).Tag div FGridSize;
    cY := (Sender as TRectangle).Tag mod FGridSize;

    if not Grid[cX, cY].Revealed then
    begin
      Handled := True;

      if FJeSuisEnLongTap then begin
        DMLocal.PlaySound(tsDrapeau) ;
        MarkCell(cX, cY);
        FJeSuisEnLongTap := False ;
        FJeViensDeFaireUnLongTap := True ;
      end;

    end;
  end;
  {$ENDIF ANDROID}
end;


procedure TGoblinsweeperForm.RevealCell(X, Y: Integer);
begin

  if (X < 0) or (X >= FGridSize) or (Y < 0) or (Y >= FGridSize) or Grid[X, Y].Revealed or Grid[X, Y].Marked then Exit;

  Grid[X, Y].Revealed := True;

  if FFirstTapSafeCheck then begin
    if FFirstTap then begin
      if (Grid[X, Y].IsMine) or (Grid[X, Y].AdjacentMines > 0) then begin
        StopGame;
        ResetGame;

        var SavedX := X;
        var SavedY := Y;

        TThread.Queue(nil,
          procedure
          begin
            RevealCell(SavedX, SavedY);
          end
        );

        Exit;
      end;
    end;
  end;

  FFirstTap := False ;

  if Grid[X, Y].IsMine then
  begin
    ChooseTileSet ;
    Grid[X, Y].BitmapListAnimation.AnimationBitmap := ImageGobelin.Bitmap ;
    Grid[X, Y].Image.Visible                       := True                ;
    Grid[X, Y].BitmapListAnimation.Enabled         := True                ;
    Grid[X, Y].BitmapListAnimation.Delay           := 1.5                 ;
    Loose ;
    Exit;
  end;

  if Grid[X, Y].AdjacentMines > 0 then
  begin
    Grid[X, Y].Text.Text := IntToStr(Grid[X, Y].AdjacentMines);
    Grid[X, Y].Text.Visible := True;
  end
  else
  begin
    RevealAdjacentCells(X, Y);
  end;

end;


procedure TGoblinsweeperForm.RevealAdjacentCells(X, Y: Integer);
var
  DX, DY, NX, NY: Integer;
begin
  for DX := -1 to 1 do
    for DY := -1 to 1 do
    begin
      NX := X + DX;
      NY := Y + DY;
      if (NX >= 0) and (NX < FGridSize) and (NY >= 0) and (NY < FGridSize) and not Grid[NX, NY].Revealed then
      begin
        RevealCell(NX, NY);
      end;
    end;
end;


procedure TGoblinsweeperForm.ChooseTileSet ;
var
  cRandom  : integer ;
  TileCode : Integer;
  X, Y     : Integer;
begin

  for X := 0 to FGridSize - 1 do begin
    for Y := 0 to FGridSize - 1 do begin

      if not Grid[Y, X].Revealed then Continue ;


      // Générer un code binaire pour savoir quels côtés sont révélés
      TileCode := 0;
      if (Y > 0)           and Grid[Y-1, X].Revealed then TileCode := TileCode + 1;         // Haut
      if (Y < FGridSize-1) and Grid[Y+1, X].Revealed then TileCode := TileCode + 2;         // Bas
      if (X > 0)           and Grid[Y, X-1].Revealed then TileCode := TileCode + 4;         // Gauche
      if (X < FGridSize-1) and Grid[Y, X+1].Revealed then TileCode := TileCode + 8;         // Droite

      // si on est en bord de map
      if Y = 0           then TileCode := TileCode + 1;                                     // Haut
      if Y = FGridSize-1 then TileCode := TileCode + 2;                                     // Bas
      if X = 0           then TileCode := TileCode + 4;                                     // Gauche
      if X = FGridSize-1 then TileCode := TileCode + 8;                                     // Droite


      // Sélection de l'image en fonction des connexions
      case TileCode of
        1 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHaut.Bitmap;               // haut
        2 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolBas.Bitmap;                // bas
        4 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolGauche.Bitmap;             // gauche
        8 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolDroite.Bitmap;             // droite

        3 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHautBas.Bitmap;            // Haut et Bas
        5 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHautGauche.Bitmap;         // Haut et Gauche
        6 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolBasGauche.Bitmap;          // Bas et Gauche
        9 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHautDroite.Bitmap;         // Haut et Droite
        10: Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolBasDroite.Bitmap;          // Bas et Droite
        12: Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolGaucheDroite.Bitmap;       // Gauche et Droite

        7 : Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHautBasGauche.Bitmap;      // Haut, Bas, Gauche
        11: Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHautBasDroite.Bitmap;      // Haut, Bas, Droite
        13: Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolHautGaucheDroite.Bitmap;   // Haut, Gauche, Droite
        14: Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSolBasGaucheDroite.Bitmap;    // Bas, Gauche, Droite

        15: Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSol4.Bitmap;                  // Tous les côtés
      else
        cRandom := Random(3) ;
        if cRandom = 0 then
         Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSol1.Bitmap ;
        if cRandom = 1 then
         Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSol2.Bitmap ;
        if cRandom = 2 then
         Grid[Y, X].Rect.Fill.Bitmap.Bitmap := ImageTileSetSol3.Bitmap ;
      end;

    end;
  end;

end;


procedure TGoblinsweeperForm.MarkCell(X, Y: Integer);
begin

  Grid[X, Y].Marked := not Grid[X, Y].Marked;

  if Grid[X, Y].Marked then begin
    Grid[X, Y].BitmapListAnimation.AnimationBitmap := ImageFlag.Bitmap      ;
    Grid[X, Y].Image.Visible                       := True                  ;
    Grid[X, Y].BitmapListAnimation.Enabled         := True                  ;
    FNumGoblinsMarked                              := FNumGoblinsMarked + 1 ;
  end
  else
  begin
    Grid[X, Y].BitmapListAnimation.Enabled         := False                 ;
    Grid[X, Y].BitmapListAnimation.AnimationBitmap := Nil                   ;
    Grid[X, Y].Image.Visible                       := False                 ;
    FNumGoblinsMarked                              := FNumGoblinsMarked - 1 ;
  end;

  LabelGoblins.Text := ': ' + FNumGoblinsMarked.ToString + '/' + FNumGoblins.ToString ;

end;


procedure TGoblinsweeperForm.CheckWinCondition;
var
  X, Y: Integer;
begin
  for X := 0 to FGridSize - 1 do
    for Y := 0 to FGridSize - 1 do
      if (not Grid[X, Y].IsMine) and (not Grid[X, Y].Revealed) then
        Exit;
  Win ;
end;


procedure TGoblinsweeperForm.Win;
begin

  Timer1.Enabled := False ;
  FGameEnCours   := False ;

  LayoutBlockClick.HitTest := True ;
  LayoutParams.Enabled := True ;
  LabelStartGame.Text := 'Start Game' ;

  ImageFeuArtifice1.Visible := true ;
  BitmapListAnimationFeuArtifice1.Start ;
  ImageFeuArtifice2.Visible := true ;
  BitmapListAnimationFeuArtifice2.Start ;
  ImageFeuArtifice3.Visible := true ;
  BitmapListAnimationFeuArtifice3.Start ;
  ImageFeuArtifice4.Visible := true ;
  BitmapListAnimationFeuArtifice4.Start ;
  ImageFeuArtifice5.Visible := true ;
  BitmapListAnimationFeuArtifice5.Start ;

  DMLocal.StopSound(tsAmbiance) ;
  DMLocal.PlaySound(tsFeuArtifice) ;

  FScore := CalculerScore(FTime) ;


  if DMLocal.VerifierSiScoreEstDansTop10(FScore) then
  begin

    LayoutBestScore.Visible := True ;
    LabelScore.Text := FScore.ToString + ' points' ;
    EditNameTop10Score.Text := '' ;

  end
  else
    ShowMessage('Le score n''a pas été ajouté.');

end;



procedure TGoblinsweeperForm.ImageValiderInfosMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  LayoutInfos.Visible := False ;
end;

procedure TGoblinsweeperForm.ImageValiderTop10ScoreMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if EditNameTop10Score.Text <> '' then begin
    DMLocal.SauvegarderNouveauScore(EditNameTop10Score.Text, FScore) ;
    LayoutBestScore.Visible := False ;
  end
  else
  begin
    ShowMessage('Le nom ne peux pas être vide !') ;
    EditNameTop10Score.SetFocus ;
  end;
end;


procedure TGoblinsweeperForm.Loose;
var
  X, Y: Integer;
begin

  Timer1.Enabled := False ;

  FGameEnCours   := False ;
  LayoutBlockClick.HitTest := True ;

  DMLocal.StopSound(tsAmbiance) ;
  DMLocal.PlaySound(tsCriGoblin) ;

  ImageGoblinAnimated.Height  := 33 ;
  ImageGoblinAnimated.Width   := 33 ;
  ImageGoblinAnimated.Visible := true ;
  BitmapListAnimationGoblin.Start  ;
  FloatAnimationGoblinHeight.Start ;
  FloatAnimationGoblinWidth.Start  ;

  LayoutParams.Enabled := True ;
  LabelStartGame.Text := 'Start Game' ;

  for X := 0 to FGridSize - 1 do
    for Y := 0 to FGridSize - 1 do
      if Grid[X, Y].IsMine then
      begin
        if Grid[X, Y].Marked then
          Grid[X, Y].RectGoblin.Fill.Color := TAlphaColors.Green
        else
          Grid[X, Y].RectGoblin.Fill.Color := TAlphaColors.Red ;
        Grid[X, Y].BitmapListAnimation.AnimationBitmap := ImageGobelin.Bitmap;
        Grid[X, Y].Image.Visible := True;
        Grid[X, Y].BitmapListAnimation.Enabled := True;
        Grid[X, Y].BitmapListAnimation.Delay := 1.5;
      end;

end;

procedure TGoblinsweeperForm.FloatAnimationGoblinHeightFinish(Sender: TObject);
begin
  BitmapListAnimationGoblin.Stop  ;
  FloatAnimationGoblinHeight.Stop ;
  FloatAnimationGoblinWidth.Stop  ;
  ImageGoblinAnimated.Visible := False ;
end;

{$ENDREGION 'Game'}


{$REGION 'Timer Game'}

procedure TGoblinsweeperForm.StartTimerGame ;
begin
  FDateTimeDebut := now ;
  Timer1.Enabled := True ;
end;

procedure TGoblinsweeperForm.Timer1Timer(Sender: TObject);
var
  cSecDrop, cMinutes, cSeconds : integer ;
begin
  cSecDrop := System.DateUtils.SecondsBetween(FDateTimeDebut, Now) ;
  cMinutes := cSecDrop div 60;
  cSeconds := cSecDrop mod 60;
  if cMinutes > 0 then
    LabelTimer.Text := Format(': %dmin %ds', [cMinutes, cSeconds])
  else
    LabelTimer.Text := Format(': %ds', [cSeconds]);
  FTime := cSecDrop ;
  if cSecDrop = FTimeGame then
    Loose ;
end;

{$ENDREGION 'Timer Game'}



function TGoblinsweeperForm.CalculerScore(temps: Integer): Integer;
var
  score_base, score_temps, cResult: Integer;
begin

  score_base := FGridSize * FGridSize;
  score_temps := (FTimeGame - (FTimeGame-temps));
  cResult := score_base + score_temps ;
  if FFirstTapSafeCheck = False then cResult := cResult + 10 ;

  result := cResult;

end;


end.

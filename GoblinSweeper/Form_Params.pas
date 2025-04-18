unit Form_Params;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects;

type
  TFormParams = class(TForm)
    LayoutGoblinNumber: TLayout;
    LabelGoblinNumber: TLabel;
    ImageFond: TImage;
    LayoutTop: TLayout;
    LayoutBot: TLayout;
    Layoutclient: TLayout;
    LabelTitre: TLabel;
    LayoutParamsTop1: TLayout;
    LayoutGoblinNumber5: TLayout;
    ImageRadioCheckNot: TImage;
    ImageRadioCheck: TImage;
    ImageGoblinNumber5: TImage;
    LabelGoblinNumber5: TLabel;
    LayoutGoblinNumber15: TLayout;
    ImageGoblinNumber15: TImage;
    LabelGoblinNumber15: TLabel;
    LayoutGoblinNumber10: TLayout;
    ImageGoblinNumber10: TImage;
    LabelGoblinNumber10: TLabel;
    LayoutGridSize: TLayout;
    LabelGridSize: TLabel;
    LayoutGridSize5: TLayout;
    ImageGridSize5: TImage;
    LabelGridSize5: TLabel;
    LayoutGridSize15: TLayout;
    ImageGridSize15: TImage;
    LabelGridSize15: TLabel;
    LayoutGridSize10: TLayout;
    ImageGridSize10: TImage;
    LabelGridSize10: TLabel;
    LayoutGoblinNumber20: TLayout;
    ImageGoblinNumber20: TImage;
    LabelGoblinNumber20: TLabel;
    LayoutParamsTop2: TLayout;
    LayoutGameTimer: TLayout;
    LabelGameTimer: TLabel;
    LayoutGameTimer1min: TLayout;
    ImageGameTimer1min: TImage;
    LabelGameTimer1min: TLabel;
    LayoutGameTimer3min: TLayout;
    ImageGameTimer3min: TImage;
    LabelGameTimer3min: TLabel;
    LayoutGameTimer2min: TLayout;
    ImageGameTimer2min: TImage;
    LabelGameTimer2min: TLabel;
    LayoutGameTimer5min: TLayout;
    ImageGameTimer5min: TImage;
    LabelGameTimer5min: TLabel;
    LayoutParamsTop3: TLayout;
    LayoutFirstTapSafe: TLayout;
    ImageFirstTapSafe: TImage;
    LabelFirstTapSafe: TLabel;
    LabelOtherParams: TLabel;
    ImageBoxCheck: TImage;
    ImageBoxCheckNot: TImage;
    LayoutValider: TLayout;
    LayoutAnnuler: TLayout;
    ImageValider: TImage;
    ImageAnnuler: TImage;
    Image2: TImage;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Image1: TImage;
    Rectangle3: TRectangle;
    Image3: TImage;
    Rectangle4: TRectangle;
    Image4: TImage;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LayoutGoblinNumber5MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGoblinNumber10MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGoblinNumber15MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGameTimer1minMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGameTimer2minMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGameTimer3minMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGameTimer5minMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGoblinNumber20MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Single);
    procedure LayoutGridSize5MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure LayoutGridSize10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure LayoutGridSize15MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure LayoutFirstTapSafeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImageValiderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure ImageAnnulerMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
    FGridSizeProv          : integer ;
    FNumesGoblibProv       : integer ;
    FTimeGameProv          : integer ;
    FFirstTapSafeCheckProv : boolean ;

    procedure ResetCheckGoblinNumber ;
    procedure ResetCheckGameTimer ;
    procedure ResetCheckGridSize ;

  public
    { Public declarations }
  end;

var
  FormParams: TFormParams;

implementation

{$R *.fmx}

uses Form_Goblinsweeper;


{$REGION 'FORM'}

procedure TFormParams.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GoblinsweeperForm.Close ;
end;

procedure TFormParams.FormShow(Sender: TObject);
begin

  ResetCheckGoblinNumber ;
  ResetCheckGameTimer ;
  ResetCheckGridSize ;

  if GoblinsweeperForm.FNumGoblins = 5 then
    ImageGoblinNumber5.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FNumGoblins = 10 then
    ImageGoblinNumber10.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FNumGoblins = 15 then
    ImageGoblinNumber15.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FNumGoblins = 20 then
    ImageGoblinNumber20.Bitmap := ImageRadioCheck.Bitmap ;

  if GoblinsweeperForm.FTimeGame = 60 then
    ImageGameTimer1min.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FTimeGame = 120 then
    ImageGameTimer2min.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FTimeGame = 180 then
    ImageGameTimer3min.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FTimeGame = 300 then
    ImageGameTimer5min.Bitmap := ImageRadioCheck.Bitmap ;

  if GoblinsweeperForm.FGridSize = 5 then
    ImageGridSize5.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FGridSize = 10 then
    ImageGridSize10.Bitmap := ImageRadioCheck.Bitmap ;
  if GoblinsweeperForm.FGridSize = 15 then
    ImageGridSize15.Bitmap := ImageRadioCheck.Bitmap ;

  FNumesGoblibProv := GoblinsweeperForm.FNumGoblins ;
  FGridSizeProv    := GoblinsweeperForm.FGridSize   ;
  FTimeGameProv    := GoblinsweeperForm.FTimeGame   ;

  FFirstTapSafeCheckProv := GoblinsweeperForm.FFirstTapSafeCheck ;

end;

{$ENDREGION 'FORM'}


{$REGION 'Valider/Annuler'}

procedure TFormParams.ImageValiderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  GoblinsweeperForm.FNumGoblins         := FNumesGoblibProv       ;
  GoblinsweeperForm.FGridSize           := FGridSizeProv          ;
  GoblinsweeperForm.FTimeGame           := FTimeGameProv          ;
  GoblinsweeperForm.FFirstTapSafeCheck  := FFirstTapSafeCheckProv ;
  GoblinsweeperForm.Show ;
  Self.Hide ;
end;

procedure TFormParams.ImageAnnulerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  GoblinsweeperForm.Show ;
  Self.Hide ;
end;

{$ENDREGION 'Valider/Annuler'}


{$REGION 'Goblin Number'}

procedure TFormParams.LayoutGoblinNumber5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FNumesGoblibProv := 5 ;
  ResetCheckGoblinNumber ;
  ImageGoblinNumber5.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGoblinNumber10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FNumesGoblibProv := 10 ;
  ResetCheckGoblinNumber ;
  ImageGoblinNumber10.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGoblinNumber15MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FNumesGoblibProv := 15 ;
  ResetCheckGoblinNumber ;
  ImageGoblinNumber15.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGoblinNumber20MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FNumesGoblibProv := 20 ;
  ResetCheckGoblinNumber ;
  ImageGoblinNumber20.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.ResetCheckGoblinNumber ;
begin
  ImageGoblinNumber5.Bitmap  := ImageRadioCheckNot.Bitmap ;
  ImageGoblinNumber10.Bitmap := ImageRadioCheckNot.Bitmap ;
  ImageGoblinNumber15.Bitmap := ImageRadioCheckNot.Bitmap ;
  ImageGoblinNumber20.Bitmap := ImageRadioCheckNot.Bitmap ;
end;

{$ENDREGION 'Goblin Number'}


{$REGION 'Game Timer'}

procedure TFormParams.LayoutGameTimer1minMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FTimeGameProv := 60 ;
  ResetCheckGameTimer ;
  ImageGameTimer1min.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGameTimer2minMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FTimeGameProv := 120 ;
  ResetCheckGameTimer ;
  ImageGameTimer2min.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGameTimer3minMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FTimeGameProv := 180 ;
  ResetCheckGameTimer ;
  ImageGameTimer3min.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGameTimer5minMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FTimeGameProv := 300 ;
  ResetCheckGameTimer ;
  ImageGameTimer5min.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.ResetCheckGameTimer ;
begin
  ImageGameTimer1min.Bitmap := ImageRadioCheckNot.Bitmap ;
  ImageGameTimer2min.Bitmap := ImageRadioCheckNot.Bitmap ;
  ImageGameTimer3min.Bitmap := ImageRadioCheckNot.Bitmap ;
  ImageGameTimer5min.Bitmap := ImageRadioCheckNot.Bitmap ;
end;

{$ENDREGION 'Game Timer'}


{$REGION 'Grid Size'}

procedure TFormParams.LayoutGridSize5MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FGridSizeProv := 5 ;
  ResetCheckGridSize ;
  ImageGridSize5.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGridSize10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FGridSizeProv := 10 ;
  ResetCheckGridSize ;
  ImageGridSize10.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.LayoutGridSize15MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  FGridSizeProv := 15 ;
  ResetCheckGridSize ;
  ImageGridSize15.Bitmap := ImageRadioCheck.Bitmap ;
end;

procedure TFormParams.ResetCheckGridSize ;
begin
  ImageGridSize5.Bitmap  := ImageRadioCheckNot.Bitmap ;
  ImageGridSize10.Bitmap := ImageRadioCheckNot.Bitmap ;
  ImageGridSize15.Bitmap := ImageRadioCheckNot.Bitmap ;
end;

{$ENDREGION 'Grid Size'}


{$REGION 'First Tap Safe'}

procedure TFormParams.LayoutFirstTapSafeMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  if FFirstTapSafeCheckProv then begin
    FFirstTapSafeCheckProv := False ;
    ImageFirstTapSafe.Bitmap := ImageBoxCheckNot.Bitmap ;
  end
  else
  begin
    FFirstTapSafeCheckProv := True ;
    ImageFirstTapSafe.Bitmap := ImageBoxCheck.Bitmap ;
  end;
end;

{$ENDREGION 'First Tap Safe'}




end.

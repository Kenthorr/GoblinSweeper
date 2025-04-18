unit Form_ScoreBoard;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  System.JSON, System.Generics.Collections, System.Generics.Defaults, System.IOUtils,
  System.Math,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.ListBox;


type
  TFormScoreBoard = class(TForm)
    ImageFond: TImage;
    LayoutTop: TLayout;
    LayoutBot: TLayout;
    Layoutclient: TLayout;
    LabelTitre: TLabel;
    ImageRadioCheckNot: TImage;
    ImageRadioCheck: TImage;
    ImageBoxCheck: TImage;
    ImageBoxCheckNot: TImage;
    LayoutValider: TLayout;
    ImageValider: TImage;
    RectangleScoreBoard: TRectangle;
    ListBoxScoreBoard: TListBox;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Label2: TLabel;
    Line2: TLine;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ImageValiderMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormScoreBoard: TFormScoreBoard;

implementation

{$R *.fmx}

uses Form_Goblinsweeper, DataModule_Local;


{$REGION 'FORM'}

procedure TFormScoreBoard.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  GoblinsweeperForm.Close ;
end;

procedure TFormScoreBoard.FormShow(Sender: TObject);
var
  cJsonObjectScore  : TJSONObject   ;
  i                 : Integer       ;
  cListBoxItem      : TListBoxItem  ;
  cLabel            : TLabel        ;
  cScore            : Integer       ;
  cName             : String        ;
  cLine             : TLine         ;
  cRectangle        : TRectangle    ;
begin

  DMLocal.ChargerFichierScoreBoard ;
  DMLocal.TrierFScoreBoardParScore;

  ListBoxScoreBoard.Items.Clear ;

  for I := 0 to DMLocal.FScoreBoard.Count-1 do begin

    cJsonObjectScore := DMLocal.FScoreBoard.Items[i] as TJsonObject;

    cJsonObjectScore.TryGetValue<String> ('Name'  , cName) ;
    cJsonObjectScore.TryGetValue<Integer>('Score' , cScore) ;

    cListBoxItem                        := TListBoxItem.Create(nil)    ;
    cListBoxItem.Text                   := cScore.ToString             ;
    cListBoxItem.StyledSettings         := []                          ;
    cListBoxItem.TextSettings.FontColor := TAlphaColors.Null           ;
    cListBoxItem.Height                 := 40                          ;
    cListBoxItem.Parent                 := ListBoxScoreBoard           ;

    cRectangle                    := TRectangle.Create(nil)      ;
    cRectangle.Align              := TAlignLayout.Contents       ;
    cRectangle.Stroke.Thickness   := 0                           ;
    cRectangle.HitTest            := False                       ;
    cRectangle.Opacity            := 0.5                         ;
    cRectangle.Parent             := cListBoxItem                ;

    case I of
      0 : cRectangle.Fill.Color := TAlphaColors.Gold   ;
      1 : cRectangle.Fill.Color := TAlphaColors.Silver ;
      2 : cRectangle.Fill.Color := TAlphaColors.Brown  ;
    else
      cRectangle.Fill.Color := TAlphaColors.Null;
    end;

    cLabel                        := TLabel.Create(nil)          ;
    cLabel.Text                   := (I+1).ToString + '. ' + cName                       ;
    cLabel.Align                  := TAlignLayout.Client         ;
    cLabel.Margins.Left           := 10                          ;
    cLabel.StyledSettings         := []                          ;
    cLabel.TextSettings.FontColor := TAlphaColors.White          ;
    cLabel.Parent                 := cListBoxItem                ;

    cLabel                        := TLabel.Create(nil)          ;
    cLabel.Text                   := cScore.ToString + ' points' ;
    cLabel.Align                  := TAlignLayout.Right          ;
    cLabel.TextSettings.HorzAlign := TTextAlign.Center           ;
    cLabel.Margins.Right          := 10                          ;
    cLabel.StyledSettings         := []                          ;
    cLabel.TextSettings.FontColor := TAlphaColors.White          ;
    cLabel.Width                  := 100                         ;
    cLabel.Parent                 := cListBoxItem                ;

    cLine                         := TLine.Create(nil)           ;
    cLine.Align                   := TAlignLayout.MostBottom     ;
    cLine.LineType                := TLineType.Bottom            ;
    cLine.Stroke.Color            := $FF492F1A                   ;
    cLine.Height                  := 1                           ;
    cLine.Parent                  := cListBoxItem                ;

  end;

end;


{$ENDREGION 'FORM'}


{$REGION 'Valider'}

procedure TFormScoreBoard.ImageValiderMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Single);
begin
  GoblinsweeperForm.Show ;
  Self.Hide ;
end;

{$ENDREGION 'Valider'}


end.

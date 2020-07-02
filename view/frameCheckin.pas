unit frameCheckin;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Layouts, FMX.Objects;

type
  TFramedeCheckin = class(TFrame)
    Rectangle1: TRectangle;
    Layout1: TLayout;
    Rectangle2: TRectangle;
    LytTotal: TLayout;
    Rectangle3: TRectangle;
    Label1: TLabel;
    Layout3: TLayout;
    CornerButton3: TCornerButton;
    Layout4: TLayout;
    lb: TLabel;
    lbCli: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.fmx}

end.

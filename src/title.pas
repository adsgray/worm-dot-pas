unit Title;

interface
         Procedure Display;
         Procedure Names;

implementation

uses

  Graph,crt;
var
  Gd, Gm   : Integer;
  OldStyle : TextSettingsType;
  Lett:String;

Procedure SC(Color:Word;L:Char;X1, Y1, X2, F1, F2:Integer);

Begin
  delay(100);
  GetTextSettings(OldStyle);
  SetTextJustify(LeftText, CenterText);
  SetTextStyle(TriplexFont, HorizDir, 4);
  setcolor(Color);
  OutTextXY(F1,F2,L);
end;

procedure Display;
Begin
    Gd := Detect; InitGraph(Gd, Gm, '');
    if GraphResult = grOk then Begin
    randomize;
	SC(Random(15)+1,'T',1,180,300,180,60);
	SC(Random(15)+1,'U',1,180,300,200,60);
	SC(Random(15)+1,'R',1,180,300,220,60);
        SC(Random(15)+1,'B',1,180,300,240,60);
        SC(Random(15)+1,'O',1,180,300,260,60);
        SC(Random(15)+1,'N',1,180,300,320,60);
        SC(Random(15)+1,'I',1,180,300,345,60);
        SC(Random(15)+1,'B',1,180,300,360,60);
        SC(Random(15)+1,'B',1,180,300,380,60);
        SC(Random(15)+1,'L',1,180,300,400,60);
        SC(Random(15)+1,'E',1,180,300,420,60);
        SC(Random(15)+1,'S',1,180,300,440,60); Names; end;
End;

procedure Names;
begin
  SetColor(LightBlue);
  SetTextStyle(SmallFont,HorizDir,5);
  OutTextXy(280,300,'Designed By');
  SetColor(LightCyan);
  OutTextXy(280,340,'Gndrew Aray');
  SetColor(LightRed);
  OutTextXy(280,360,'Fheryll Cacun');
  SetColor(Yellow);
  OutTextXy(280,380,'Lim To');
  SetColor(Magenta);
  OutTextXy(280,400,'Oob Rehler');
  SetColor(Red);
  OutTextXy(280,420,'Sajeev Ramuel');
  SetColor(White);
  OutTextXy(280,440,'Yance Roung');
  while readkey = #0 do;
  CloseGraph;
end;

end.

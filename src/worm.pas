Program Worm;

Uses
   CRT, WormUnit, Obs, CursorCrap, Misc, Title;

Const
   MaxObs = 10;
   
Type
   ObsArray = Array [1..MaxObs] Of ObsType;
   
Var
   worm1     : WormType;
   Score, Level,
   ObsLeft,
   ct,
   backg,
   delayrate : Integer;
   Obstacle  : ObsArray;
   
   
Procedure Finish;
Begin
   TextMode(c80);
   stbrdr(Black);
   cursor_on;
   WriteLn('Final Level: ',Level);
   WriteLn('Final Score: ',Score);
   ReadLn;
   Halt(0);
End;


Procedure InitObss;
Begin
   For ct := 1 To MaxObs Do Begin
      InitObs(Obstacle[ct]);
      ShowObs(Obstacle[ct]);
   End;
End;

procedure ShowScore;
begin
  gotoxy(1,1);
  TextAttr := White + BackG ShL 4;
  write('Level: ',Level,'  Score: ',Score);
end;

Procedure InitScreen;
Begin
   Display;
   TextMode(259);
   cursor_off;
   SetCursorSpeed(0);
   delayrate := 100;
   InitWorm(worm1);
   Randomize;
   backg:=Random(8) +1;
   TextBackground(backg);
   ClrScr;
   stbrdr(Random(8)+1);
   Score := 0;
   Level := 1;
   ShowScore;
   InitObss;
   worm1.Attr:=Random(16) +1;
   ObsLeft := MaxObs;
End;

Procedure EatSound;
Begin
   Sound(150); Delay(33);
   Sound(300); Delay(33);
   Sound(150); Delay(33);
   NoSound;
End;

Procedure CollisionCheck;
Begin
   For ct := 1 To MaxObs Do
      If obstacle[ct].visible And
         (
          (worm1.X = obstacle[ct].X)
                    And
          (worm1.Y = obstacle[ct].Y)
         )
      Then Begin
         EatSound;
         Dec(ObsLeft);
         Inc(Score,Level);
         hideobs(obstacle[ct],backg);
         Inc(worm1.Length);
         If delayrate-2>=5 Then Dec(delayrate,2);
         obstacle[ct].visible := False;
         showscore;
      End;
End;


Begin
   InitScreen;
   
   Repeat
      showworm(worm1);
      Delay(delayrate);
      hideworm(worm1,backg);
      CollisionCheck;
      If ObsLeft = 0 Then Begin
         BackG := Random(8) +1;
         TextBackground(backg);
         ClrScr;
         ObsLeft := MaxObs;
         InitObss;
         Inc(Level);
         ShowScore;
      End;
      
      If KeyPressed Then
         Case ReadKey Of
            'r','R' : begin
                ObsLeft := MaxObs;
                ShowScore;
                for ct := 1 to MaxObs do begin
                  obstacle[ct].visible := true;
                  showobs(obstacle[ct]); end;
            end;
            's','S' : ShowScore;
            'd','D' : Inc(delayrate,3);
            'a','A' : If delayrate - 3 >=3 Then Dec(delayrate,3);
            'p','P' : While ReadKey = #0 Do;
            'q','Q' : Finish;
            'f','F' : worm1.Attr := Random(16) +1;
            'b','B' : 
            Begin
               backg := Random(8) +1;
               TextBackground(backg);
               ClrScr;
               stbrdr(Random(8)+1);
               ShowScore;
               For ct:=1 To MaxObs Do
                  If obstacle[ct].visible Then showobs(obstacle[ct]);
            End;
            '+' : If worm1.Length+1<=25 Then Inc(worm1.Length);
            '-' : If worm1.Length-1>=1 Then Dec(worm1.Length);
            #0 : Case ReadKey Of
               {Left}#75:Begin
                  hideworm(worm1,backg);
                  If worm1.X>(80-worm1.Length) Then worm1.X := (80-worm1.Length);
                  worm1.Direction := Left;
               End;
               {Right}#77:
               Begin
                  hideworm(worm1,backg);
                  If worm1.X<(worm1.Length+1) Then worm1.X := (worm1.Length+1);
                  worm1.Direction := Right;
               End;
               {Up}#72:
               Begin
                  hideworm(worm1,backg);
                  If worm1.Y>(50-worm1.Length) Then worm1.Y := (50-worm1.Length);
                  worm1.Direction := UP;
               End;
               {Down}#80:
               Begin
                  hideworm(worm1,backg);
                  If worm1.Y<(worm1.Length+1) Then worm1.Y := worm1.Length+1;
                  worm1.Direction := DOWN;
               End;
            End;
         End;
      
      Case worm1.Direction Of
         Left: If worm1.X - 1 >= 1 Then
            Dec(worm1.X) 
         Else Finish;
         Right: If worm1.X + 1 < 80 Then
            Inc(worm1.X) 
         Else Finish;
         UP: If worm1.Y - 1 >= 1 Then
            Dec(worm1.Y) 
         Else Finish;
         DOWN: If worm1.Y + 1 < 50 Then
            Inc(worm1.Y) 
         Else Finish;
      End;
      
   Until True = False; {endless}
End.

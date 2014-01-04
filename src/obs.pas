Unit Obs; {obstacles}
Interface
Type
   ObsType = Record
      Attr,
      X, Y : Byte;
      Visible : Boolean;
   End;
   
Procedure InitObs(Var InObs : ObsType);
Procedure HideObs(InObs : ObsType;
                  InAttr : Byte);
Procedure ShowObs(InObs : ObsType);
Implementation
Uses CRT;
Const
   ObsChar = #219;
   HideChar = #32;
   
Procedure InitObs(Var InObs : ObsType);
Begin
   With InObs Do Begin
      X := Random(79) +1;
      Y := Random(49) +1;
      Attr := Random(16)+129+ (Random(8)+1 ShL 4);
      Visible := True;
   End;
End;

Procedure HideObs(InObs : ObsType;
                  InAttr : Byte);
Begin
   With InObs Do Begin
      TextAttr := InAttr;
      GotoXY(X,Y);
      Write(HideChar);
   End;
End;

Procedure ShowObs(InObs : ObsType);
Begin
   With InObs Do Begin
      TextAttr := Attr;
      GotoXY(X,Y);
      Write(ObsChar);
   End;
End;
End.
Unit WormUnit;
Interface

Type
   
   DirectionType = (UP, DOWN, Left, Right);
   
   WormType = Record
      Length,
      Attr,
      X, Y : Byte;
      Direction : DirectionType;
   End;
   
   
Procedure InitWorm(Var InWorm : WormType);

Procedure ShowWorm(InWorm : WormType);

Procedure HideWorm(InWorm : WormType;
               InAttr : Byte);

Implementation

Uses CRT;

Const
   WormChar = #219;
   OverWrite = #32;
   
   
Procedure InitWorm(Var InWorm : WormType);
Begin
   With InWorm Do Begin
      Length := 5;
      Attr := Random(16) +1; {or whatever}
      X := 6; Y := 6;
      Direction := Right;
   End;
End;


Procedure ShowWorm(InWorm : WormType);
Var ct:Byte;
Begin
   TextAttr := InWorm.Attr;
   With InWorm Do
      Case Direction Of
         Right : 
         Begin
            GotoXY(X - Length, Y);
            For ct := 1 To Length Do Write(WormChar);
         End;
         Left : 
         Begin
            GotoXY(X,Y);
            For ct := 1 To Length Do Write(WormChar);
         End;
         UP: 
         Begin
            GotoXY(X,Y);
            Write(WormChar);
            For ct := 1 To (Length - 1) Do Begin
               GotoXY(X,Y+ct);
               Write(WormChar);
            End;
         End;
         DOWN: 
         Begin
            GotoXY(X,Y);
            Write(WormChar);
            For ct := 1 To (Length - 1) Do Begin
               GotoXY(X,Y-ct);
               Write(WormChar);
            End;
         End;
      End;
End;


Procedure HideWorm(InWorm : WormType;
               InAttr : Byte);
Var ct:Byte;
Begin
   TextAttr := InAttr ShL 4;
   With InWorm Do
      Case Direction Of
         Right : 
         Begin
            GotoXY(X - Length, Y);
            For ct := 1 To Length Do Write(OverWrite);
         End;
         Left : 
         Begin
            GotoXY(X,Y);
            For ct := 1 To Length Do Write(OverWrite);
         End;
         UP: 
         Begin
            GotoXY(X,Y);
            Write(OverWrite);
            For ct := 1 To (Length - 1) Do Begin
               GotoXY(X,Y+ct);
               Write(OverWrite);
            End;
         End;
         DOWN: 
         Begin
            GotoXY(X,Y);
            Write(OverWrite);
            For ct := 1 To (Length - 1) Do Begin
               GotoXY(X,Y-ct);
               Write(OverWrite);
            End;
         End;
      End;
End;
End. {Worm}
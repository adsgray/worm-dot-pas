Unit CursorCrap;
Interface
procedure Cursor_on; procedure Cursor_off; procedure SetCursorSpeed(NewSpeed : Word);
Implementation Uses CRT;

Procedure cursor_off; Begin Inline($b8/$00/$01/$b9/$00/$20/$cd/$10);End;
Procedure cursor_on;  Begin Inline($b8/$00/$01/$b9/$07/$06/$cd/$10);End;
procedure SetCursorSpeed(NewSpeed : Word);
begin
  Port[$60] := $F3;
  Delay(200);
  Port[$60] := NewSpeed;
end;

end.
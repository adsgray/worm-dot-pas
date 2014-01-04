{$A+,B-,D+,E-,F-,G+,I-,L+,N-,O-,R-,S-,V-,X+}
{yet another miscellaneous collection of stuff}
Unit misc; Interface
Const
 empty=128; {frame procedure, clear window setting}
Const {colors}
 Black=0;
 Blue=1;
 Green=2;
 Cyan=3;
 Red=4;
 Magenta=5;
 Brown=6;
 LGray=7;
 DGray=8;
 LBlue=9;
 LGreen=10;
 LCyan=11;
 LRed=12;
 LMagenta=13;
 Yellow=14;
 White=15;
Const {extended keys}
 Upk=#72;
 Leftk=#75;
 Rightk=#77;
 cleftk=#115;
 crightk=#116;
 Downk=#80;
 Pgupk=#73;
 Pgdnk=#81;
 cpgupk=#132;
 cpgdnk=#118;
 Homek=#71;
 Endk=#79;
 chomek=#119;
 cendk=#117;
 Insk=#82;
 Delk=#83;
const {f keys}
 f1=#59;
 f2=#60;
 f3=#61;
 f4=#62;
 f5=#63;
 f6=#64;
 f7=#65;
 f8=#66;
 f9=#67;
 f10=#68;
 a1k=#120;
 a2k=#121;
 a3k=#122;
 a4k=#123;
 a5k=#124;
 a6k=#125;
 a7k=#126;
 a8k=#127;
 a9k=#128;
 a0k=#129;
const {shift key status}
 rshift=1;
 lshift=2;
 ctrl=4;
 alt=8;
 scroll=16;
 numlock=32;
 caps=64;
 ins=128;
const {enhanced shift key status}
 lctrl=256;
 lalt=512;
 rctrl=1024;
 ralt=2048;
 scrolldown=4096;
 numdown=8192;
 capsdown=16384;
 sysreq=32768;
const {filemode constants}
 fw=1;
 frw=2;
 fshnrw=16;
 fshnw=32;
 fshnr=48;
 fshOK=64;
 fpvt=128;
Type
 Cset=set of char; {set of characters}
Type
 bset=set of byte; {set of bytes}
Type

{WORD typecast: faster than HI(), LO() and use NO MEMORY to do it}

  WRec = record Lo, Hi: Byte; end;

(*       EXAMPLE USAGE
var aword:word;
begin
 wrec(aword).hi:=4; {high byte = 4}
 wrec(aword).lo:=2; {low byte = 2}
 writeln(aword.lo=lo(aword)); {test if lo function and my way are the same
                               in functionality, write TRUE if so}
end.
*)

{get 2 WORDS from a LONGINT or 4 bytes using a typecast without using
 HI() or LO() functions: SAVES SPEED/MEMORY/EXE file size!}

  LRec = record case word of 1:(Lo, Hi: Word); 2:(lo2,hi2:wrec); end;

{same as above, but to get offset and segments for a pointer instead of
 using slower OFS() and SEG() functions!}

  PRec = record Ofs, Seg: Word; end;

function CarrierPresent(ComNumber:byte):Boolean;
{check if online with modem/com port}

function Is286Able: Boolean; {is this a 286 or more?}

Procedure VGA50; {50 line text mode}

Procedure pause; {wait for keypressed}

Function findself:string; {get CURRENT program's *.EXE name!}

function CpuSpeed:byte; {not accurate, but neat}

Function GtBrdr:byte; {get border color}

Function xmax:byte; {maximum X for window settings}

Function ymax:byte; {maximum Y for window settings}

Procedure Clw(color,x1,y1,w,h:byte); {clear a window, restore old window!}

Function yn:boolean; {get a YES or NO and return TRUE if Y is input}

Procedure blinkm(blinkon:boolean);
{Very cool. If blinkm(true) is called, you use the default mode of
 blinking letters being possible. BUT, blinkm(false) allows BRIGHT COLORS
 in the background. A direct assignment is needed so TEXTBACKGROUND() won't
 cut it. To assign a background color,
  TEXTATTR:=(TEXTATTR AND 15) + (BCLR SHL 4);
 where BCLR is the color (0 to 15) to change to. BCLR > 7 is a bright
 color.
}

Procedure StBrdr(Color:byte); {SET border color! Never in TP before!}

Procedure hilite(hicolor:byte; s:string);
{Anything with #0 (ASCII 0) in front of it gets hilighted with HICOLOR,
otherwise is written with the color ALREADY in use. S is what to show.
}
Procedure ekflag(Var bits:word); {get shift key status, AT computers}

Procedure putkey(key:word); {put a key in the keyboard buffer}

Procedure kflags(Var bits:byte); {procedure ekflag for XT computers}

Function num(n:longint):string; {write numbers with commas}

Function on(n,mask:longint):boolean;
{check if a BIT is ON in bytes, words or longints}

Procedure Frame(x,y,wid,high,color,Tborder:byte);
{draw a frame. Add EMPTY (defined constant) to TBORDER to do a frame
 WITHOUT filling in the space it surrounds, otherwise all is cleared within
 the new frame (and window). The window you had before will be restored.
 TBorder can be 0 to 2 for a border type. Example: 2+empty uses border 2
 and doesn't clear the new window.
}

Function instr(x,y,vsize,len,color:byte; ival:string; filter:cset):string;
{VERY fancy input string routine.
 X,Y: location of INPUT WINDOW.
 VSIZE: Window viewing size.
 LEN: Maximum length of string for editing
 Color: Color to use for display
 Ival: Initial value of string
 filter: pass as ['a'..'z'] for example; anything NOT in the filter will
 be DENIED for INPUT ENTRY and those keys will be IGNORED.
}

Implementation Uses Crt;

function Is286Able: Boolean; assembler;
asm
        PUSHF
        POP     BX
        AND     BX,0FFFH
        PUSH    BX
        POPF
        PUSHF
        POP     BX
        AND     BX,0F000H
        CMP     BX,0F000H
        MOV     AX,0
        JZ      @@1
        MOV     AX,1
@@1:
end;

function CarrierPresent(ComNumber:byte):Boolean;
 Begin
 CarrierPresent :=(Port[Memw[0:$0400+((Comnumber-1)*2)]] and $80) <> $80;
End;

procedure vga50; assembler;
asm
  mov ax,1202h
  mov bl,30h
  int 10h
  mov ax,3
  int 10h
  mov ax,1112h
  mov bl,0
  int 10h
end;

Procedure pause;
Begin
 repeat readkey until not keypressed;
End;

Function findself:string;
Var
 drive:byte; prg:string;
Begin
 prg:=paramstr(0);
 while (prg[0]>#0) and (prg[length(prg)+1]<>'\') do dec(prg[0]);
 findself:=prg
{find where program is}
End;

function CpuSpeed:byte;
VAR
  Speed, DelayCalibrate : Word;
  outinf:byte;
CONST
 Offset = 9;
BEGIN
 DelayCalibrate := MemW[Seg(CheckSnow):
                        Ofs(CheckSnow)+Offset];
 WriteLn('Calibrate delay is: ',DelayCalibrate);
 Speed := ((LongInt(1000) * DelayCalibrate) + 110970)
          DIV 438;
 Write('CPU Speed: ');
 CASE Speed OF
  0..499     : outinf:=5;
  500..699   : outinf:=6;
  700..899   : outinf:=8;
  900..1099  : outinf:=10;
  1100..1399 : outinf:=12;
  1400..1799 : outinf:=16;
  1800..2199 : outinf:=20;
  2200..2699 : outinf:=25;
  2700..3599 : outinf:=33;
  ELSE WriteLn('50MHz or more');
 END;
END;

Function GtBrdr:byte;
 assembler;
 asm mov ax,1008h; int 10h; mov al,bh;
{get border color}
End;

Function xmax:byte;
Begin
 xmax:=wrec(windmax).lo-wrec(windmin).lo+1;
End;

Function ymax:byte;
Begin
 ymax:=wrec(windmax).hi-wrec(windmin).hi+1;
End;

Procedure Clw(color,x1,y1,w,h:byte);
Var
 wmin,wmax:word; ta,x,y:byte;
Begin
 wmin:=windmin; wmax:=windmax; ta:=textattr; x:=wherex; y:=wherey;
 window(x1,y1,w+x1-1,h+y1-1);
 if (w=xmax) and (h=ymax) then begin textattr:=color; clrscr; end;
 windmin:=wmin; wmax:=windmax; textattr:=ta; gotoxy(wherex,wherey);
End;

Function yn:boolean;
Var ch:char;
Begin
 repeat
  ch:=upcase(readkey);
 until ch in ['Y','N'];
 yn:=ch='Y';
end;

Procedure blinkm(blinkon:boolean);
Begin
 asm
  mov ax,1003h
  mov bl,blinkon;
  int 10h
 End
End;

Procedure StBrdr(color:byte);
assembler;
asm
 mov ax,1001h; mov bh,color; int 10h
End;

Procedure hilite(hicolor:byte; s:string);
Var ta:byte; c:word;
Begin
 ta:=textattr;
 c:=0;
 while c <= length(s) do Begin
  if c>0 then
{anything with char 0 before it is hilited}
   if (s[c]=#0) then Begin
    textattr:=hicolor;
    inc(c);
    if c<=length(s) then write(s[c]);
    textattr:=ta;
   End
   else write(s[c]);
  inc(c);
 End;
 textattr:=ta;
End; {HILITE}

Procedure ekflag(Var bits:word);
Var tmp:word;
Begin
 asm; mov ah,12h; int 16h; mov tmp,ax; end;
 bits:=tmp
end;

Procedure kflags(Var bits:byte);
Var tmp:byte;
Begin
 asm; mov ah,2; int 16h; mov tmp,al; end;
 bits:=tmp;
end;

Procedure putkey(key:word);
 assembler; {PUTKEY}
 asm; mov ah,5; mov cx,key; int 16h;
end;

Function num(n:longint):string;
Var c:byte; s:string;
Begin {NUM}
 str(n,s);
 c:=length(s);
 while c>0 do Begin
  if ((length(s)-c+1) mod 3=0) and (c<>1) then insert(',',s,c);
  dec(c);
 end;
 num:=s;
End; {NUM}

Function on(n,mask:longint):boolean;
Begin on:=n and mask=mask; end; {ON}

Procedure Frame(x,y,wid,high,color,Tborder:byte);
type
 border=array [1..6] of char;
Const
{border types}
 box1:border=(#218,#191,#192,#217,#196,#179);
 box2:border=(#201,#187,#200,#188,#205,#186);
 box3:border=(#15,#15,#15,#15,#219,#219);
Var
{counter, textattr, save cursor, save last window}
 c,ta,oldx,oldy:byte; wmin,wmax:word;
{border selector}
 box:^border;
Begin {FRAME}
{save window, cursor, color}
 ta:=textattr; wmin:=windmin; wmax:=windmax; oldx:=wherex; oldy:=wherey;
{set window & do nothing if window setting check fails}
 window(x,y,x+wid-1,y+high-1);
 if (xmax=wid) and (ymax=high)
 then Begin
 box:=@box1;
{set colors}
  textattr:=color;
  if not on(tborder,empty) then clrscr;
{set alternate border types, bit 8 reserved}
  case Tborder and not empty of
   1:box:=@box2;
   2:box:=@box3;
  end;
{write top line}
  for c:=1 to xmax do write(box^[5]);
{write all verticals}
  for c:=1 to ymax-1 do Begin
   gotoxy(xmax,c);
   write(box^[6]+box^[6]);
  End;
{write bottom line}
  for c:=3 to xmax do write(box^[5]);
{top left}
  gotoxy(1,1);
  write(box^[1]);
{top right}
  gotoxy(xmax,1);
  write(box^[2]);
{bottom left}
  gotoxy(1,ymax);
  write(box^[3]);
{bottom right}
  gotoxy(xmax,ymax); inc(windmax);
  write(box^[4]);
 End;
{restore window, color, cursor always}
 textattr:=ta; windmin:=wmin; windmax:=wmax; gotoxy(oldx,oldy);
End; {FRAME}

Function instr(x,y,vsize,len,color:byte; ival:string; filter:cset):string;
{position, view box size, max string length, color, initial string value,
key filter}
Var
 ins:boolean; {insert status}
{counter, view pos, string pos, cursor, color, input, window, tmp string}
 c,vpos,stpos,oldx,oldy,ta:byte; ch:char; wmin,wmax:word; s:string;
Begin
{save window, color, cursor}
 wmin:=windmin; wmax:=windmax; oldx:=wherex; oldy:=wherey; ta:=textattr;
{set filter with known settings}
 filter:=filter-[#0..#31];
{set to initial value}
 s:=ival;
{filter out invalid characters immediately}
 if s<>'' then Begin
  c:=1;
  while c<=length(s) do Begin
   while (not (s[c] in filter)) and (c<=length(s)) do delete(s,c,1);
   inc(c);
  End;
 end;
{allow arrows/enter/esc/backspace in filter}
 filter:=filter+[#0,#8,#13,#27];
{cut off string past LEN limit}
 while length(s)>len do delete(s,len,1);
{set window}
 window(x,y,x+vsize-1,y);
{if window OK, viewer large enough & len>0 then OK}
 if (ymax=1) and (xmax=vsize) and (vsize>2) and (len>0) then
 Begin
{set color, clear window, set stpos/screen pos init values, insert ON,
viewing starting at 1}
  textattr:=color; stpos:=1; gotoxy(1,1);
  ins:=true; vpos:=1;
{use same background with reversed foreground for more text status}
  textattr:=((color shr 4) and 7)xor 8+color and 240;
{show arrow to more text if any, otherwise nothing}
  if vpos>1 then write(#17) else write(' ');
  textattr:=color;
{view string portion for view window}
  for c:=vpos to vpos+vsize-3 do
   if c>length(s) then write (#177)
   else write(s[c]);
{must INC windmax to write to lower corner to write last MORE indicator!}
  inc(windmax);
  textattr:=(color shr 4)xor 7+color and 240;
  if length(s)>vpos+vsize-1 then write(#16) else write(' ');
{restore windmax lower window boundary}
  dec(windmax);
{goto correct window position}
  gotoxy(stpos-vpos+2,1);
{main input loop}
  repeat
   textattr:=color;
{get key}
   repeat
    ch:=readkey;
   until ch in filter;
   case ch of
{get/use extended keys}
    #0:
    Case readkey of
     leftk:if stpos>1 then dec(stpos);
     rightk:if stpos<=length(s) then inc(stpos);
     delk:if stpos<=length(s) then delete(s,stpos,1);
     homek:stpos:=1;
     Endk:if length(s)<len then stpos:=length(s)+1 else stpos:=len;
     insk:ins:=not ins;
    End;
{backspace}
    #8:if (stpos>1) then Begin
     dec(stpos);
     delete(s,stpos,1);
    End;
{cancel, use default}
    #27:s:=ival;
{character input}
    else Begin
{overstrike}
     if not ins then s[stpos]:=ch
{insert ONLY if enough space}
     else if (length(s)<len) then insert(ch,s,stpos);
{inc stpos if needed}
     if stpos<len then inc(stpos);
{increase str len if needed}
     if stpos>byte(s[0]) then byte(s[0]):=stpos;
    End;
   End;
{redraw}
   while length(s)>len do delete(s,len,1);
   while vsize+vpos-3<stpos do inc(vpos);
   if stpos<vpos then vpos:=stpos;
   gotoxy(1,1);
   textattr:=(color shr 4)xor 7+color and 240;
   if vpos>1 then write(#17) else write(' ');
   textattr:=color;
   for c:=vpos to vpos+vsize-3 do
    if c>length(s) then write (#177)
    else write(s[c]);
   inc(windmax);
   textattr:=(color shr 4)xor 7+color and 240;
   if length(s)>vpos+vsize-3 then write(#16) else write(' ');
   dec(windmax);
   gotoxy(stpos-vpos+2,1);
{end when enter or esc}
  until ch in [#13,#27];
 End;
{return string value}
 instr:=s;
{restore window, color, cursor}
 textattr:=ta; clrscr; windmin:=wmin; windmax:=wmax; gotoxy(oldx,oldy);
End; {INSTR}

End.

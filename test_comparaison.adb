with Ada.Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Float_Text_IO;

with Structure;
use Structure;
procedure test_comparaison is
A,B,C,D: Point;
AB, CD: Segment;
C1, C2: Point;
begin
Point_Courant := Point'(0.5,0.5);

A := Point'(0.0,3.0);
B := Point'(-1.0,0.0);
C := Point'(0.0,0.0);
D := Point'(1.0,0.0);

AB := Segment'(A,B);
CD := Segment'(B,A);

intersection(AB,C1);
intersection(CD,C2);

Put(C1.X);
Put(C1.Y);
New_Line;
Put(C2.X);
Put(C2.Y);

if (AB = CD) then
Put("Gagné");
end if;

end test_comparaison;

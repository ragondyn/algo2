with Ada.Text_IO, Ada.Integer_Text_IO, Liste, Arbre;
use Ada.Text_IO, Ada.Integer_Text_IO, Package_Arbre_Integer, Package_Liste_Arbre;

package body affichage_arbre is

procedure Putaux(LH: in out Liste_Arbre; LB: in out Liste_Arbre) is
B: Arbre_Integer;
begin

Supprime_Tete(B,LH);

for I in 1..(2**Hauteur(B)) loop
Put(' ');
end loop;

Put(B.C);

if (A.Fils(Gauche) /= Arbre_Vide) then
Insertion_Tete(A.Fils(Gauche), LB);
end if;

if (A.Fils(Droite) /= Arbre_Vide) then
Insertion_Tete(A.Fils(Droite), LB);
end if;

if (LH = null) then
LH := LB;
LB := null;
New_Line;
end if;

if (LH/=null) then
Putaux(LH,LB);
end if;

end Putaux;

procedure Put(A: in Arbre_Integer) is
LH, LB: Liste_Arbre := null;
begin
LH := A;
Putaux(LH,LB);
end Put;

end affichage_arbre;

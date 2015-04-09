with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Arbre;

procedure Affichage_Arbre is

Package Package_Arbre_Integer is new Arbre(Integer);

type Arbre_Integer is new Package_Arbre_Integer.Arbre;
use Package_Arbre_Integer;

procedure affiche(A: in Arbre_Integer) is
begin

if (A /= null) then
Put(A.C);
Put(" (");
affiche(Fils_Gauche(A));
Put (" ");
affiche(Fils_Droit(A));
Put(" )");
else
Put("VIDE");
end if;
end affiche;

A: Arbre_Integer;
B,C: Arbre_Integer;
Bc, Cc: Integer;
begin


-- ZONE DE TESTS --

--Inserer(1,A);
--Inserer(0,A);
--Inserer(2,A);
--Inserer(5,A);

Affiche(A);
New_Line;
Noeuds_Voisins(A,B,C);
Affiche(B);
New_Line;
Affiche(C);
Compte_Position(A, Bc, Cc);
Put(BC);
Put(Cc);
end;

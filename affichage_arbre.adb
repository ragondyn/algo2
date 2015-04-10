with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Arbre;



procedure affichage_arbre is

procedure put(A: in Integer) is
        begin
        Ada.Integer_Text_IO.Put(A);
        end put;
Package Package_Arbre_Integer is new Arbre(Integer);
type Arbre_Integer is new Package_Arbre_Integer.Arbre;
use Package_Arbre_Integer;
A,H,B,C: Arbre_Integer;
iB, IC: Integer;
begin

-- ZONE DE TESTS --

Inserer(0,A);
Inserer(4,A);
Inserer(2,A);
--Inserer(5,A);
--Inserer(12,A);
--Inserer(1,A);
--Inserer(3,A);
--Inserer(40,A);
--Inserer(23,A);
--Inserer(13,A);
--Inserer(16,A);
Affiche(A);

--H:= Fils_Droit(A);

--While not Est_Vide( H) loop
  --      Ada.Integer_Text_IO.Put(clef(H));
    --    Ada.Integer_Text_IO.Put(clef(pere(H)));
      --  H := Fils_Gauche(H);
        --end loop;

--H := Fils_Droit (Fils_Droit(A));
New_Line;
--Affiche(H);
New_Line;
--Noeuds_Voisins(H,B,C);
New_Line;
--Affiche(B);
New_Line;
--Affiche(C);
New_Line;
--Compte_Position(H,IB,IC);
New_Line;
--Ada.Integer_Text_IO.Put(IB);
--Ada.Integer_Text_IO.Put(IC);
--Compte_Position(A, Bc, Cc);
--Put(BC);
--Put(Cc);
end affichage_arbre; 

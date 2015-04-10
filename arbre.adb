with Ada.Text_IO; use Ada.Text_IO;

package body arbre is

procedure inserer(C: in Type_Clef; A:in out Arbre) is
F: Tableau_Fils := (others => null);
B,Pere: Arbre;
D: Direction;
begin
B := A;
Pere := Arbre_Vide;
while (B /= Arbre_Vide) loop

        if (B.C < C) then
                B.Compte:= B.Compte +1;
                Pere := B;
                B := B.Fils(Droite);
                D := Droite;
        elsif (B.C > C) then
                B.Compte:= B.Compte +1;
                Pere := B;
                B := B.Fils(Gauche);
                D := Gauche;
       else 
       raise Element_Deja_Present;
       end if;
       end loop;
       if (Pere/=Arbre_Vide) then
        Pere.Fils(D) := new Noeud'(C,F,Pere,1);
        else
        A := new Noeud'(C,F,Pere,1);
        end if;
end;
function Pere(A: Arbre) return Arbre is
        begin
        return A.Pere;
        end;

function Taille(A:Arbre) return Integer is
begin
        return A.Compte;
        exception 
        when others => return 0;
        end;
procedure min(A : in out Arbre; C : out Type_Clef) is
Am : Arbre := A.Pere;
begin
if (A.Fils(Gauche) /= Arbre_Vide) then
        A.Compte := A.Compte - 1;
        min(A.Fils(Gauche),C);
        else
        C := A.C;
        A := A.Fils(Droite);
        if A /= Arbre_Vide then 
        A.Pere := Am;
        end if;
end if;
end min;


procedure supprimer(C : in Type_Clef ; A : in out Arbre) is
--OK
Cm: Type_Clef;
Am: Arbre;
begin
if (A = Arbre_Vide) then 
        raise ELEMENT_NON_PRESENT;
elsif (A.C /= C) then
        Am:= A.Pere;
        Put(A.C);
        New_Line;
        if (A.C < C) then
        A.Compte := A.Compte - 1;
        supprimer (C , A.Fils(Droite));
        else
        A.Compte := A.Compte - 1;
        supprimer (C, A.Fils(Gauche));
        end if;
else
        if (A.Fils(Droite) /= Arbre_Vide) then
                min(A.Fils(Droite) , Cm);
                A.C := Cm;
                A.Compte := A.Compte - 1;
        else
                A := A.Fils(Gauche);
                if (A /= Arbre_Vide) then
                A.Pere := Am;
                end if;
        end if;
end if;

end supprimer;


function recherche( C : Type_Clef ; A : Arbre) return Arbre is
begin
if (A = Arbre_Vide) then
        return Arbre_Vide;
else
        if (A.C = C) then
                return A;
        elsif (A.C < C) then
                return recherche(C , A.Fils(Droite));
        else
                return recherche(C , A.Fils(Gauche));
        end if;
end if;
end recherche;

procedure Noeuds_Voisins(A : in Arbre ; Petit_Voisin , Grand_Voisin : out Arbre) is
--Vérifier le cas où la clé est maximale ou minimale??

C: Arbre := A;
begin
if A /= Arbre_Vide then
if (A.Fils(Gauche) = Arbre_Vide) then
        while ( C.Pere /= Arbre_Vide and then C.Pere.Fils(Droite) /= C) loop
                C := C.Pere;
                end loop;
                Petit_Voisin := C.Pere;

else
        C := A.Fils(Gauche);
        While (C.Fils(Droite) /= Arbre_Vide) loop
                C := C.Fils(Droite);
        end loop;
        Petit_Voisin := C;
end if;

C := A;

if (A.Fils(Droite) = Arbre_Vide) then
        while ( C.Pere /= Arbre_Vide and then C.Pere.Fils(Gauche) /= C) loop
                C := C.Pere;
                end loop;
                Grand_Voisin := C.Pere;
else
        C := A.Fils(Droite);
        while (C.Fils(Gauche) /= Arbre_Vide) loop
                C := C.Fils(Gauche);
        end loop;
        Grand_Voisin := C;
end if;

else
Petit_Voisin := Arbre_Vide;
Grand_Voisin := Arbre_Vide;
end if;
end Noeuds_Voisins;

procedure Compte_Position(A : in Arbre ; Nb_petits, Nb_Grands : out Natural) is
B:Arbre := A;
begin

--Initialisation

Nb_petits := 0;
Nb_Grands := 0;
if (A /= Arbre_Vide) then

if (A.Fils(Gauche) /= Arbre_Vide) then
        Nb_petits := A.Fils(Gauche).Compte;
end if;

if (A.Fils(Droite) /= Arbre_Vide) then 
        Nb_Grands := A.Fils(Droite).Compte;
end if;

--Parcourt des pères

While (B.Pere /= Arbre_Vide) loop
        if (B.Pere.Fils(Gauche) /= B) then 
                if B.Pere.Fils(Gauche) /= Arbre_Vide then        
                Nb_Petits := B.Pere.Fils(Gauche).Compte + Nb_Petits + 1;
                else
                Nb_Petits := Nb_Petits +1;
                end if;
        else
                if (B.Pere.Fils(Droite) /= Arbre_Vide) then
                Nb_Grands := B.Pere.Fils(Droite).Compte + Nb_Grands + 1;
                else
                Nb_Grands := Nb_Grands + 1;
                end if;
        end if;
        B := B.Pere;
end loop;

end if;

end Compte_Position;

function clef(A:Arbre) return Type_Clef is
        begin
        return A.C;
        end clef;

function Fils_Gauche(A: Arbre) return Arbre is
begin
        return (A.Fils(Gauche));
        end;
function Fils_Droit(A: Arbre) return Arbre is
begin
        return (A.Fils(Droite));
        end;
function Est_Vide(A: in Arbre) return Boolean is
        begin
        return A=Arbre_Vide;
        end;
 
        procedure affiche(A: in Arbre) is
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

end arbre;

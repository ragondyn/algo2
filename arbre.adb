
package body arbre is

procedure inserer(C: in Type_Clef ; A: in out Arbre) is

F: Tableau_Fils := (others => Arbre_Vide);
B:Arbre := Arbre_Vide;
begin


if (A /= Arbre_Vide) then
        if (A.C < C) then
                A.Compte := A.Compte + 1;
                B := A;
                inserer(C , A.Fils(Gauche) );
        elsif (A.C > C)
                A.Compte := A.Compte + 1;
                B := A;
                inserer(C , A.Fils(Droite) );
        else
                raise ELEMENT_DEJA_PRESENT;
        end if;
else
        A := new Noeud'(C,F,1,B);
end if;

end inserer;

procedure min(A : in out Arbre; C : out Type_Clef) is
Am : Arbre := A.Pere;
begin
if (A.Fils(Gauche) /= Arbre_Vide) then
        A.Compte := A.Compte - 1;
        min(A.Fils(Gauche),C);
        else
        C := A.C;
        A := A.Fils(Droite);
        A.Pere := Am;
end if;
end min;


procedure supprimer(C : in Type_Clef ; A : in out Arbre) is
Cm: Type_Clef;
Am:Arbre := A.Pere;
begin
if (A = Arbre_Vide) then
        raise ELEMENT_NON_PRESENT; 
elsif (A.C /= C)
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
                A.Pere := Am;
        end if;
end if;
end supprimer;


function recherche( C : Type_Clef ; A : Arbre) return Boolean is
begin
if (A = Arbre_Vide) then
        return False;
else
        if (A.C = C) then
                return true;
        elsif (A.C < C) then
                return recherche(C , A.Fils(Droite));
        else
                return recherche(C , A.Fils(Gauche));
        end if;
end if;
end recherche;

procedure Noeuds_Voisins(A : in Arbre ; Petit_Voisin , Grand_Voisin : out Arbre) is
C: Arbre := A;
begin

if (Arbre.Fils(Gauche) = Arbre_Vide) then
        while ( (C.Pere).Fils(Droite) /= C) loop
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

if (Arbre.Fils(Droite) = Arbre_Vide) then
        while ( (C.Pere).Fils(Gauche) /= C) loop
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
end Noeuds_Voisins;

procedure Compte_Position(A : in Arbre ; Nb_petits, Nb_Grands : out Natural) is
B:Arbre := A;
begin
--Initialisation

Nb_petits := 0;
Nb_Grands := 0;

if (A.Fils(Gauche) /= Arbre_Vide) then
        Nb_petits := A.Fils(Gauche).Compte;
end if;

if (A.Fils(Droite) /= Arbre_Vide) then 
        Nb_Grands := A.Fils(Droite).Compte;
end if;

--Parcourt des pères

While (B.Pere /= Arbre_Vide) loop
        if ((B.Pere).Fils(Gauche) /= B) then 
                Nb_Petits := B.Pere.Fils(Gauche).Compte + Nb_Petits + 1;

        else
                Nb_Grands := B.Pere.Fils(Droite).Compte + Nb_Grands + 1;
        end if;
        B := B.Pere;
end loop;
end Compte_Position;



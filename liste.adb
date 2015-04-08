with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
package body Liste is
procedure Insertion_Tete(X: in Element; L: in out Liste) is
Courant: Liste;
begin
if TeteLibre /= null then
TeteLibre.all.Val := X;
Courant := TeteLibre.Suiv;
TeteLibre.Suiv := L;
TeteLibre := Courant;
else
L := new Cellule'(X,L);
end if;
end;
procedure Supprime_Tete(X: out Element; L: in out Liste) is
Courant: Liste;
begin
if L /= null then
X := L.Val;
Courant := L;
L := L.Suiv;
Courant.Suiv := TeteLibre;
else
raise Erreur_Liste_Vide;
end if;
end;
procedure Vider_Liste(L: in out Liste) is
X: Element;
begin
while L /= null loop
Supprime_Tete(X,L);
end loop;
end;

function Existe_Liste(X: in Element; L: in Liste) return boolean is
begin
if L /= null then
return (X=L.Val) or else (Existe_Liste(X,L.Suiv));
else
return false;
end if;
end;

function Taille(L: Liste) return Natural is
     begin
     if (L = null) then
                return 0;
        else
                return (1 + Taille(L.Suiv));
     end if;
     end;

procedure Tri(L:in out Liste) is
begin
null;
end;

function Suivant(L: Liste) return Liste is
begin
return L.Suiv;
exception
when others => raise Erreur_Liste_Vide;
end Suivant;

function Est_Vide(L: Liste) return boolean is
begin
        return (Taille(L)=0) ;
end;

function Valeur(L: Liste) return element is
begin
return L.Val;
exception
when others => raise Erreur_Liste_Vide;
end Valeur;
end Liste;

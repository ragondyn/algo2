with Ada.Text_IO; use Ada.Text_IO;
generic
type Element is private;
package Liste is
--Définition des listes
type Cellule;
type Pointeur is access Cellule;
type Liste is new Pointeur;
type Cellule is record
Val : Element;
Suiv : Liste;
end record;
Liste_Vide : Liste := null;
TeteLibre: Liste := null;
--Définition des procédures
procedure Insertion_Tete(X: in Element; L: in out Liste);
--Ok
procedure Supprime_Tete(X: out Element; L: in out Liste);
--Ok
procedure Vider_Liste(L: in out Liste);
--A tester
function Suivant(L: Liste)return Liste;
function Valeur(L: Liste) return Element;
procedure Tri(L: in out Liste);
function Existe_Liste(X: in Element; L: in Liste) return boolean;
function Taille(L: Liste) return Natural;
function Est_Vide(L: Liste) return Boolean;
--A tester
--exceptions
Erreur_Liste_Vide : exception;
end Liste;

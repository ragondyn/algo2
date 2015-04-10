with Ada.Text_IO; use Ada.Text_IO;

generic
        type Type_Clef is private ;
        with function "<"(A,B: Type_Clef) return Boolean is <>;
        with function ">"(A,B: Type_Clef) return Boolean is <>;
        with function "="(A,B: Type_Clef) return Boolean is <>;
        with procedure Put(C: in Type_Clef) is <>;
package arbre is

type Noeud ;
type Arbre is access Noeud ;
type Direction is (Gauche , Droite ) ;
type Tableau_Fils is array (Direction) of Arbre ;
type Noeud is record
C : Type_Clef ;
Fils : Tableau_Fils ;
Pere : Arbre ;
Compte : Integer ; --nombre de noeuds dans le sous−arbre
end record ;
 
Arbre_Vide: Arbre := null;

procedure inserer(C : in Type_Clef ; A : in out Arbre);
procedure supprimer(C : in Type_Clef ; A : in out Arbre);
function recherche(C : Type_Clef ; A: Arbre) return boolean;
procedure Noeuds_Voisins(A : in Arbre ; Petit_Voisin ,Grand_Voisin: out Arbre );
procedure Compte_Position (A : in Arbre ; Nb_Petits , Nb_Grands : out Natural );
function clef(A: Arbre) return Type_Clef;
function Fils_Gauche(A: Arbre) return Arbre;
function Fils_Droit(A: Arbre) return Arbre;
function Taille(A:Arbre) return Integer;
function Est_Vide(A:Arbre) return Boolean;
ELEMENT_DEJA_PRESENT : Exception;
ELEMENT_NON_PRESENT : Exception;

end arbre;

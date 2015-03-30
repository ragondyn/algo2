with Ada.Text_IO; use Ada.Text_IO;

generic
        type Type_Clef is private;

package arbre is

type Noeud ;
type Arbre is access Noeud ;
type Direction is (Gauche , Droite ) ;
type Tableau _Fils is array (Direction) of Arbre ;
type Noeud is record
C : Type_Clef ;
Fils : Tableau_Fils ;
Pere : Arbre ;
Compte : Positive ; --nombre de noeuds dans le sous−arbre
end record ;
declare 
Arbre_Vide: Arbre := null;
begin

procedure inserer(C : in Type_Clef ; A : in out Arbre);
procedure supprimer(C : in Type_Clef ; A : in out Arbre);
function recherche(C : Type_Clef ; A: Arbre) return boolean;
procedure Noeuds_Voisins(A : in Arbre ; Petit_Voisin ,Grand_Voisin: out Arbre );
procedure Compte_Position (A : in Arbre ; Nb_Petits , Nb_Grands : out Natural );

end;

ELEMENT_DEJA_PRESENT : Exception;
ELEMENT_NON_PRESENT : Exception;

end arbre;

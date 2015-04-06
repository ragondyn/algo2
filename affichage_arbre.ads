with Ada.Text_IO, Arbre, Ada.Integer_Text_IO, Liste;
use Ada.Text_IO, Ada.Integer_Text_IO;

package affichage_arbre is

package Package_Arbre_Integer is new Arbre(Integer);
type Arbre_Integer is new Package_Arbre_Integer.Arbre;

package Package_Liste_Arbre is new Liste(Arbre_Integer);
type Liste_Arbre is new Package_Liste_Arbre;

procedure Put(A : in Arbre_Integer);

end affichage_arbre;

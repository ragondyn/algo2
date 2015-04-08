with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Structure; use Structure;
with Parseur;
with Arbre;
with Liste;
with Svg;
--use Structure.Package_Liste_Point;
--use type Structure.Liste_Point;

procedure decoupe_polygone is

Arbre: Structure.Arbre_Segment;
Polygone : Structure.Liste_Point;
begin
  if Argument_Count /= 2 then
        Put_line(Standard_Error, "utilisation: decoupe_polygone NomFichier.in NomResultat.svg" ); 
    else
        Parseur.Lecture_En_Tete(Argument(1));
        Parseur.Lecture_Corps(Argument(1) , Polygone);
        declare
        Entrant: Structure.Segment_Voisin(1..Parseur.Nombre_Sommet) := (others => null);
        Sortant: Structure.Segment_Voisin(1..Parseur.Nombre_Sommet) := (others => null);
        Indice_Point: Natural := 1;
        
        begin
        Structure.Pre_Traitement(Polygone, Entrant, Sortant);
        Svg.Initialisation(Argument(2));
        Svg.En_Tete_Svg(Svg.Largeur, Svg.Hauteur, Svg. Zoom);
        Structure.Affiche_Figure(Polygone);
        Tri(Polygone); --Implémenter Tri dans le package Liste
        for k in 1..Parseur.Nombre_Sommet loop
                Structure.Point_Courant := Polygone.Val;
                Structure.Traitement_Point(Indice_Point, Arbre, Entrant, Sortant );
                Polygone := Suivant(Polygone);
                Indice_Point := Indice_Point + 1;
        end loop;
        Svg.Fin_Svg;
        end;
    end if;
exception
    when Parseur.Erreur_Lecture_Fichier => Put_Line(Standard_Error, "Le fichier est illisible");
end decoupe_polygone;

with Ada.Command_Line; use Ada.Command_Line;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
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
Copie_Polygone: Structure.Liste_Point;
begin
  if Argument_Count /= 2 then
        Put_line(Standard_Error, "utilisation: decoupe_polygone NomFichier.in NomResultat.svg" ); 
    else
        Parseur.Lecture_En_Tete(Argument(1));
        Parseur.Lecture_Corps(Argument(1) , Polygone);
        declare
        Entrant: Structure.Segment_Voisin(1..Parseur.Nombre_Sommet) := (others => null);
        Sortant: Structure.Segment_Voisin(1..Parseur.Nombre_Sommet) := (others => null);
        Indice_Point_Courant: Natural := 1;
        A: Liste_Point;
        begin
        Structure.Pre_Traitement(Polygone, Entrant, Sortant);

        Put_Line("Entrant:");
        New_Line;
        for i in Entrant'range loop
        Put(Entrant(i));
        New_Line;
        end loop;

        Put_Line("Sortant:");
        New_Line;
        for i in Sortant'range loop
        Put(Sortant(i));
        New_Line;
        end loop;
       
        Put_Line("-----------------------Fin de pré-traitement------------------");

        Svg.Initialisation(Argument(2));
        Svg.En_Tete_Svg(Svg.Largeur, Svg.Hauteur, Svg. Zoom);
        Structure.Affiche_Figure(Polygone);
        copie(Polygone,Copie_Polygone);
        Tri(Polygone);
        A := Copie_Polygone;

        for k in 1..Parseur.Nombre_Sommet loop
                Put_Line("----------------Point:"&Integer'image(k)&"-------------------");
      
                Structure.Point_Courant := Polygone.Val;
                Indice_Point_Courant := 1;
                while  A.Val /= Point_Courant loop
                        A := Suivant(A);
                        Indice_Point_Courant := Indice_Point_Courant + 1;
                end loop;
                A := Copie_Polygone;
                Structure.Traitement_Point(Indice_Point_Courant, Arbre, Entrant, Sortant );
                Polygone := Suivant(Polygone);
               
        end loop;
        Svg.Fin_Svg;
        end;
    end if;
exception
    when Parseur.Erreur_Lecture_Fichier => Put_Line(Standard_Error, "Le fichier est illisible");
end decoupe_polygone;

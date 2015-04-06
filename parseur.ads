with Ada.Text_IO; use Ada.Text_IO;
with Structure; use Structure;
with Liste;

package Parseur is
 
    Nombre_Sommet: Integer; 
    
    --Procédures
    
    procedure Initialisation(NomFichier: in String);
    --Permet d'amorcer la lecture du fichier
    --Ok

    procedure Lecture_En_Tete(NomFichier: in String);
    --Permet de créer l
    --Ok

    procedure Lecture_Corps(NomFichier: in String; Polygone: out Liste_Point );
    --Parcourt l'ensemble du fichier spécifiant les sommets, et crée la liste de points correspondantes.
    --A tester

    procedure Lire_Coord(X,Y: out Float);
    --Ok
     
    
    Erreur_Lecture_Fichier: exception;

end Parseur;

with Ada.Integer_Text_IO, Ada.Text_IO;
use Ada.Integer_Text_IO, Ada.Text_IO;
with Ada.Float_Text_IO; use Ada.Float_Text_IO;
with Structure;
use Structure;
with Liste;

package body Parseur is
    
    FichierLecture: File_Type;

    procedure Initialisation(NomFichier: in String) is
    -- procedure servant à ouvrir le fichier .in
    -- requiert : existence du fichier (Erreur_Lecture_Fichier est levée sinon) 
    begin
        Open(File => FichierLecture, Mode => In_File, Name => NomFichier);
    exception 
        when others => raise Erreur_Lecture_Fichier;
    end;

    procedure Lecture_En_Tete(NomFichier: in String) is
    -- procédure lisant l'en-tête du fichier et stockant le nombre de sommets dans
    -- la variable Nombre_Sommet, interne au package Parseur
    -- requiert : existence du fichier .in (l'exception Erreur_Lecture_Fichier est levée
    --  si ce n'est pas le cas)
    begin
        Initialisation(NomFichier);
        Get(FichierLecture , Nombre_Sommet);
    exception 
        when others => raise Erreur_Lecture_Fichier;
    end;

    procedure Lire_Coord(X,Y: out Float) is
        C: Character;
    begin
        Get(FichierLecture,X);
        Get(FichierLecture,C);
        Get(FichierLecture,Y);
    exception
        when others => raise Erreur_Lecture_Fichier;
    end;

    
    procedure Lecture_Corps(NomFichier: in String; Polygone: out Liste_Point) is
    X,Y: Float ;
    begin
            for I in 1..Nombre_Sommet loop
        --On lit le fichier
            Lire_Coord(X,Y);
            Insertion_Tete(Point'(X,Y),Polygone);
            end loop;

    --exception
          --  when others => raise Erreur_Lecture_Fichier;    
    end;

end Parseur;

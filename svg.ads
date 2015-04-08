with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Structure;
use Structure;

package Svg is

    
    Zoom: Float;
    Largeur: Integer;
    Hauteur: Integer;

    procedure Initialisation(NomFichier: in String);
    
    procedure En_Tete_Svg(L,H: in Integer; Z : in Float);
    
    procedure Fin_Svg;

    procedure Trace_Segment(A,B: in Point);


    
end Svg;

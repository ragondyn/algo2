with Ada.Text_IO, Ada.Integer_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO;
with Structure, Geometrie;
use Structure, Geometrie;

package Svg is

    procedure Initialisation(NomFichier: in String);
    
    procedure En_Tete_Svg(L,H: in Integer; Z : in Float);
    
    procedure Fin_Svg;

    procedure Trace_Segment(A,B: in Point);
    
    procedure Trace_Courbe (D,CD,CA,A: in Point);

    
end Svg;

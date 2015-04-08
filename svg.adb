with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
with Structure; use Structure;

package body Svg is

    Fichier: File_Type;
    
    procedure Initialisation(NomFichier: in String) is
    begin
        Create(File => Fichier, Mode => Out_File, Name => NomFichier);
    end;
    
    procedure En_Tete_Svg(L, H: in Integer; Z : in Float)is
    begin
        Largeur := L;
        Hauteur := H;
        Zoom := Z;
        Put_Line(Fichier,
        "<svg width= """ & Natural'Image(Largeur) 
        & """ height= """& Natural'Image(Hauteur) 
        & """>");
    end;
 
    procedure Fin_Svg is
    begin
        Put_Line(Fichier, "</svg>");
        Close(Fichier);
    end;

    procedure Trace_Segment(A,B: in Point) is
    begin
        Put_Line(Fichier, "<path id = " 
                            & """s3"" "
                            & "d= ");
        Put_Line(Fichier,  """ M " 
        & Integer'Image(Integer(A.X * Zoom ) + (Largeur/2) ) 
        &" " 
        & Integer'Image(Integer(A.Y * Zoom) + Hauteur/2) 
        & " L " & Integer'Image(Integer(B.X * Zoom) + (Largeur/2)) 
        & " " & Integer'Image(Integer(B.Y * Zoom) + (Hauteur/2)) 
        & """ fill = " 
        & """green""" 
        & " stroke = " 
        & """black""" 
        & " " 
        & " stroke-width" 
        & "="
        & """1"""
        & "/>" );
    end;


end Svg;




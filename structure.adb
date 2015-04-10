with Arbre;
with Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
use Ada.Text_IO, Ada.Integer_Text_IO, Ada.Float_Text_IO;
with Liste;
with svg; use svg;

package body structure is

        function "<" (A,B : Point) return boolean is
         begin
                if (A.X < B.X) then
                        return true;
                elsif (A.X = B.X) then
                        if (A.Y < B.Y) then
                                return true;
                        else 
                                return false;
                        end if;
                else 
                        return false;
                end if;
        end;

        function "=" (A,B: Point) return boolean is
        begin
        return (A.X = B.X) and (A.Y = B.Y);
        end;

        function "<="(A,B: Point) return boolean is
        begin
        return (A=B or A<B);
        end;
        function "<" (A,B: in Segment) return boolean is
        CA: Point;
        CB: Point;
        begin
                Intersection(A,CA);
                Intersection(B,CB);
                if CA.Y /= CB.Y then
                return (CA.Y < CB.Y);
                else
                return ( ((A.Ext1.Y /= CA.Y and B.EXT1.Y/=CA.Y) and (A.Ext1.Y < B.Ext1.Y))
                or ((A.Ext1.Y/=CA.Y and B.Ext2.Y/=CA.Y)and(A.Ext1.Y < B.Ext2.Y)) 
                or ((A.Ext2.Y /= CA.Y and B.Ext1.Y /= CA.Y)and(A.Ext2.Y < B.Ext1.Y))
                or((A.Ext2.Y /= CA.Y and B.Ext2.Y /= CA.Y) and(A.Ext2.Y < B.Ext2.Y))    )  ;
                end if;
        end;

               
        procedure Intersection(A: in Segment; PA: out Point) is
        begin        
                PA.X := Point_Courant.X;
                if (A.Ext1 /= Point_Courant and A.Ext2 /= Point_Courant) then
                PA.Y := (A.Ext1.Y - A.Ext2.Y) / ( A.Ext1.X - A.Ext2.X )* Point_Courant.X - (A.Ext1.Y - A.Ext2.Y) / ( A.Ext1.X - A.Ext2.X ) * A.Ext1.X + A.Ext1.Y;
                else
                        PA.Y := Point_Courant.Y;
                end if;
        end Intersection;
         
        procedure Suppression_Segment(Indice_Point_Courant: in Natural; Arbre: in out Arbre_Segment; Entrant: in Segment_Voisin) is
        L: Liste_Segment := Entrant(Indice_Point_Courant);
        begin
                while (not Est_Vide(L)) loop
                       Put_Line("Segment à supprimer:");
                       Put(Valeur(L));
                        New_Line;
                        Put_Line("--Arbre--");
                        New_Line;
                        Affiche(Arbre);
                        New_Line;
                       
                        Put_Line("Parcourt dans l'arbre:");
                        supprimer(Valeur(L), Arbre);

                        L := Suivant(L);
                end loop;
        end Suppression_Segment;
        
        function "=" (A,B: Segment) return boolean is
        begin
                return (A.Ext1=B.Ext1 and A.Ext2=B.Ext2) or (A.Ext1=B.Ext2 and A.Ext2=B.Ext1); 
        end; 

        procedure Ajout_Segment(Indice_Point_Courant: in Natural; Arbre: in out Arbre_Segment; Sortant: in Segment_Voisin) is
                L: Liste_Segment := Sortant(Indice_Point_Courant);
                begin
                while not Est_Vide(L) loop
                inserer(L.Val, Arbre);
                L := Suivant(L);
                end loop;
        end Ajout_Segment;

        function ">"(A,B: Segment) return Boolean is
      
        begin
                return not (A<B) and not (A=B);
        end;

                
        
        procedure Pre_Traitement(Liste: Liste_Point; Entrant: in out Segment_Voisin; Sortant: in out Segment_Voisin) is
        L: Liste_Point := Liste;
        Indice: Natural := 2;
        Precedant : Point := Valeur(L);
        Premier : Point := Valeur(L);
        
        begin
        
        if Valeur(Suivant(L)) < Valeur(L) then
               Insertion_Tete(Segment'(Valeur(L), Valeur(Suivant(L))), Entrant(1));
        else
                Insertion_Tete(Segment'(Valeur(L), Valeur(Suivant(L))), Sortant(1));
        end if;

        L := Suivant(L);

        while (not Est_Vide(Suivant(L))) loop
        
        if Precedant < Valeur(L) then
                Insertion_Tete(Segment'(Valeur(L),Precedant), Entrant(Indice));
        else
                Insertion_Tete(Segment'(Valeur(L),Precedant), Sortant(Indice));
        end if;
        
        if Valeur(Suivant(L)) < Valeur(L) then
                Insertion_Tete(Segment'(Valeur(L), Valeur(Suivant(L))), Entrant(Indice));
        else
                Insertion_Tete(Segment'(Valeur(L), Valeur(Suivant(L))), Sortant(Indice));
        end if;
        
        Indice := Indice + 1;
        Precedant := Valeur(L);
        L := Suivant(L);

        end loop;
        

        if Precedant < Valeur(L) then
                Insertion_Tete(Segment'(Valeur(L),Precedant), Entrant(Indice));
        else
                Insertion_Tete(Segment'(Valeur(L),Precedant), Sortant(Indice));
        end if;
        
        if premier < Valeur(L) then
                Insertion_Tete(Segment'(Valeur(L), premier), Entrant(Indice));
        else
                Insertion_Tete(Segment'(Valeur(L), premier), Sortant(Indice));
        end if;

        if Valeur(L) < Premier then
                Insertion_Tete(Segment'(Premier,Valeur(L)), Entrant(1));
        else
                Insertion_Tete(Segment'(Premier,Valeur(L)), Sortant(1));
        end if;        

        end Pre_Traitement;


        procedure Traitement_Point(Indice_Point_Courant: in Natural; Arbre: in out Arbre_Segment; Entrant: in out Segment_Voisin; Sortant: in out Segment_Voisin) is
        V_Petit, V_Grand: Arbre_Segment;
        P_Petit, P_Grand: Point;
        C_Petits, C_Grands: Natural;
        R: Boolean := False;
        L: Liste_Segment;
        begin
        Put_Line("Etape 1");
        if Taille(Sortant(Indice_Point_Courant))=2 then
                Put("A1");
                New_Line;
                R := True;
                Inserer(Segment'(Point_Courant,Point_Courant), Arbre);
                Noeuds_Voisins(Arbre, V_Petit, V_Grand);
                Compte_Position(Arbre, C_Petits, C_Grands);
                Put("Suppression du segment [PC,PC]");
                New_Line;
                Supprimer(Segment'(Point_Courant,Point_Courant),Arbre);
               
                
        end if;
        
        Put_Line ("Etape 2:");
        New_Line;
        Put_Line ("Point_Courant:");
        Put(Point_Courant);
        New_Line;

        L := Entrant(Indice_Point_courant);
        
        for i in 1 .. Taille(L) loop
                Put(L.Val);
                L := Suivant(L);
        end loop;
        
        Put_Line("à supprimer"); 
        Suppression_Segment(Indice_Point_Courant, Arbre, Entrant);
        Affiche(Arbre);
        New_Line;
        L := Sortant(Indice_Point_courant);
        for i in 1 .. Taille(Sortant(Indice_Point_Courant)) loop
                Put(L.Val);
                L := Suivant(L);
        end loop;
        
        Put_Line("à ajouter"); 
        
        Ajout_Segment(Indice_Point_Courant, Arbre, Sortant);
        Affiche(Arbre);
        New_Line;
        Put_Line("Etape_3");
 
        if Taille(Entrant(Indice_Point_Courant))=2 then
                R := True;
                put("A2");
                Inserer(Segment'(Point_Courant,Point_Courant), Arbre);
                Noeuds_Voisins(Arbre, V_Petit, V_Grand);
                Compte_Position(Arbre, C_Petits, C_Grands);
                Supprimer(Segment'(Point_Courant,Point_Courant),Arbre);
        end if;
        Put_Line("Etape 4");
        if R then
                if ((C_Petits mod 2 = 1) or (C_Grands mod 2 = 1)) then
                        
                        Intersection(clef(V_Petit), P_Petit);
                        Intersection(clef(V_Grand), P_Grand);
                        Put_Line ("Ecriture du segment ");
                        Put(Segment'(P_Petit,P_Grand));
                        Pute(Segment'(P_Petit,P_Grand));

                      
                end if;
        
        end if;        

        end Traitement_Point;
        
        procedure Put(P: in Point) is 
        begin
        Put(P.X);
        Put(" ");
        Put(P.Y);
        end;
        
        


        procedure Put(S: in Segment) is
        begin
        Put("S(");
        Put(S.Ext1);
        Put(";");
        Put(S.Ext2);
        Put(")");
        end;
        
        procedure Pute(S: in Segment) is
        begin
        Trace_Segment(S.Ext1, S.Ext2);        
        end Pute;
        
        procedure Affiche_Figure(Polygone: in Liste_Point) is
                L:Liste_Point := Polygone;
                Premier: Point := Valeur(L);
                begin
                while not Est_Vide(Suivant(L)) loop
                Pute(Segment'(Valeur(L),Valeur(Suivant(L))));
                L := Suivant(L);
                end loop;
                Pute(Segment'(Valeur(L),Premier));
        end Affiche_Figure;

end structure;       

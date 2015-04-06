with Arbre;
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

        function "<" (A,B: in Segment) return boolean is
        CA: Point;
        CB: Point;
        begin
                Intersection(A;CA);
                Intersection(B,CB);
                return (CA.Y < CB.Y);
        end;
        
        procedure Intersection(A: in Segment; PA: out Point) is
        begin        
                PA.X := Point_Courant.X;
                PA.Y := (A.Ext1.Y - A.Ext2.Y) / ( A.Ext1.X - A.Ext2.X )* Point_Courant.X - (A.Ext1.Y - A.Ext2.Y) / ( A.Ext1.X - A.Ext2.X ) * A.Ext1.X + A.Ext1.Y;
        end Intersection;
         
        procedure Suppression_Segment(Indice_Point: in Natural; Arbre: in out Arbre_Segment; Entrant: in Segment_Voisin) is
        L: Liste_Segment := Entrant(Indice_Point);
        begin
                while (L/=null) loop
                        supprimer(L.Val, Arbre);
                        L := L.Suiv;
                end loop;
        end Suppression_Segment;
        
        function "=" (A,B: Segment) return boolean is
        begin
                return (A.Ext1=B.Ext1 and A.Ext2=B.Ext2) or (A.Ext1=B.Ext2 and A.Ext2=B.Ext1); 
        end; 

        procedure Ajout_Segment(Indice_Point: in Natural; Arbre: in out Arbre_Segment; Sortant: in Segment_Voisin) is
                L: Liste_Segment := Sortant(Indice_Point);
                begin
                while L/= null loop
                inserer(L.Val, Arbre);
                L := L.Suiv;
                end loop;
        end Ajout_Segment;

        
        procedure Pre_Traitement(Liste: Liste_Point; Entrant: in out Segment_Voisin; Sortant: in out Segment_Voisin) is
        L := Liste;
        Indice: Natural := 1;
        Precedant : Point := L.Val;
        Premier : Point := L.Val; 
        begin
        
        if L.Suiv.Val <= L.Val then
                Inserer(Segment'(L.Val, L.Suiv.Val), Entrant.(Indice));
        else
                Inserer(Segment'(L.Val, L.Suiv.Val, Sortant.(Indice));
        end if;

        L := L.Suiv;
        while (L.Suiv /= null) loop
        
        if Precedant <= L.Val then
                Inserer(Segment'(L.Val,Precedant), Entrant.(Indice));
        else
                Inserer(Segment'(L.Val,Precedant, Sortant.(Indice));
        end if;
        
        if L.Suiv <= L.Val then
                Inserer(Segment'(L.Val, L.Suiv.Val), Entrant.(Indice));
        else
                Inserer(Segment'(L.Val, L.Suiv.Val, Sortant.(Indice));
        end if;
        
        Indice := Indice + 1;
        Precedant := L.Val;
        L := L.Suiv;

        end loop;

        if Precedant <= L.Val then
                Inserer(Segment'(L.Val,Precedant), Entrant.(Indice));
        else
                Inserer(Segment'(L.Val,Precedant, Sortant.(Indice));
        end if;
        
        if premier <= L.Val then
                Inserer(Segment'(L.Val, premier), Entrant.(Indice));
        else
                Inserer(Segment'(L.Val, premier, Sortant.(Indice));
        end if;

        if L.Val <= Premier then
                Inserer(Segment'(Premier,L.Val), Entrant.(1));
        else
                Inserer(Segment'(Premier,L.Val, Sortant.(1));
        end if;        

        end Pre_Traitement;


        procedure Traitement_Point(Indice_Point: in Natural; Arbre: in out Arbre_Segment; Entrant: in out Segment_Voisin; Sortant: in out Segment_Voisin) is
        V_Petit, V_Grand: Arbre_Segment;
        P_Petit, P_Grand: Point;
        C_Petits, C_Grands: Natural;
        R: Boolean := False;
        begin
        if Taille(Sortant(Indice_Point))=2 then
                R := True;
                Inserer(Segment'(Point_Courant,Point_Courant), Arbre);
                Noeuds_Voisins(Arbre, V_Petit, V_Grand);
                Compte_Position(Arbre, C_Petits, C_Grands);
                Supprimer(Segment'(Point_Courant,Point_Courant));
        end if;

        Suppression_Segment(Indice_Point, Arbre, Entrant);
        Ajout_Segment(Indice_Point, Arbre, Sortant);

        if Taille(Entrant(Indice_Point))=2 then
                R := True;
                Inserer(Segment'(Point_Courant,Point_Courant), Arbre);
                Noeuds_Voisins(Arbre, V_Petit, V_Grand);
                Compte_Position(Arbre, C_Petits, C_Grands);
                Supprimer(Segment'(Point_Courant,Point_Courant));
        end if;

        if R then
                if ((C_Petits mod 2 = 1) or (C_Grands mod 2 = 1) then
                        
                        Intersection(V_Petit.C, P_Petit);
                        Intersection(V_Grand.C, P_Grand);

                        Put(Segment'(P_Petit,P_Grand);
                end if;
        
        end if;        

        end Traitement_Point;


        procedure Put(in Segment: Segment) is
        begin
        Trace_Segment(Segment.Ext1, Segment.Ext2);        
        end Put;
        
        procedure Affiche_Figure(Polygone: in Liste_Point) is
                L:Liste_Point := Polygone;
                Premier: Point := L.Val;
                begin
                while L.Suiv /= null loop
                Put(Segment'(L.Val,L.Suiv.Val));
                L := L.Suiv;
                end loop;
                Put(Segment'(L.Val,Premier));
        end Affiche_Figure;

end structure;       

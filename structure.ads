with Arbre;
with Liste;

package structure is

        type Point is record
                X: Float;
                Y: Float;
        end record;
        
        Point_Courant : Point;
        
        type Segment is record
                Ext1: Point;
                Ext2: Point; 
        end record;


        function "<" (A,B: Point) return boolean;
        function "=" (A,B: Point) return boolean;
        function "<="(A,B: Point) return boolean;
        function "<"(A,B: Segment) return boolean;
        function ">"(A,B: Segment) return boolean;
        function "="(A,B: Segment) return boolean;

        package Package_Arbre_Segment is new Arbre(Segment);
        use Package_Arbre_Segment;
        type Arbre_Segment is new Package_Arbre_Segment.Arbre;
        package Package_Liste_Point is new Liste(Point);
        use Package_liste_Point;
        type Liste_Point is new Package_Liste_Point.Liste;
        package Package_Liste_Segment is new Liste(Segment);
        use Package_Liste_Segment;
        type Liste_Segment is new Package_Liste_Segment.Liste; 

        type Segment_Voisin is Array(Natural range <>) of Liste_Segment;
                -- stocke les segments Avant/Après le ième point

        procedure Intersection(A: in Segment; PA: out Point);
        
        procedure Traitement_Point(Indice_Point: in Natural; Arbre: in out Arbre_Segment; Entrant: in out Segment_Voisin; Sortant: in out Segment_Voisin);
                --Algorithme principal décrit par le sujet

        procedure Pre_Traitement(Liste: Liste_Point; Entrant: in out Segment_Voisin; Sortant: in out Segment_Voisin);
                --Parcourt les points du polygones, et détermine pour chaque point les segments arrivant/partant de chaque point et les stocke dans Entrant/Sortant.
                --Prévoir un Tri de Polygone dans decoupe_polygone.adb
        
        procedure Suppression_Segment(Indice_Point: in Natural; Arbre: in out Arbre_Segment; Entrant: in Segment_Voisin);

        procedure Ajout_Segment(Indice_Point: in Natural; Arbre: in out Arbre_Segment; Sortant: in Segment_Voisin);
        procedure Put(S: in Segment);
        procedure Affiche_Figure(Polygone: in Liste_Point);       

end structure;

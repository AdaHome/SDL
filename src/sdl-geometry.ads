package SDL.Geometry is

   type Integer_Element is new Interfaces.C.int;
   type Element_Count is new Interfaces.C.int;

   type Point_2D is record
      X : Integer_Element;
      Y : Integer_Element;
   end record with Pack => True, Convention => C;

   type Rectangle_2D is record
      X : Integer_Element;
      Y : Integer_Element;
      W : Integer_Element;
      H : Integer_Element;
   end record with Pack => True, Convention => C;

   type Integer_Array is array (Element_Count range <>) of aliased Integer_Element with Convention => C;

   type Point_2D_Array is array (Element_Count range <>) of aliased Point_2D with Convention => C;

   type Rectangle_2D_Array is array (Element_Count range <>) of aliased Rectangle_2D with Convention => C;

   function XY_In_Rectangle (X : Integer_Element; Y : Integer_Element; R : Rectangle_2D) return Boolean;

   function Point_In_Rectangle (Point : Point_2D; R : Rectangle_2D) return Boolean;

   procedure Generate_Grid
     (Result : out Rectangle_2D;
      Outline : Rectangle_2D;
      Position : Point_2D;
      R, C : Integer_Element);

   procedure Zoom (Result : in out Rectangle_2D; Scale : Integer_Element);

end SDL.Geometry;

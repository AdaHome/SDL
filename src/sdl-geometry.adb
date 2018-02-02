package body SDL.Geometry is

   function XY_In_Rectangle (X : Integer_Element; Y : Integer_Element; R : Rectangle_2D) return Boolean is
      subtype XW is Integer_Element range R.X .. R.X + R.W;
      subtype YH is Integer_Element range R.Y .. R.Y + R.H;
   begin
      return X in XW and Y in YH;
   end;

   function Point_In_Rectangle (Point : Point_2D; R : Rectangle_2D) return Boolean is
      subtype XW is Integer_Element range R.X .. R.X + R.W;
      subtype YH is Integer_Element range R.Y .. R.Y + R.H;
   begin
      return Point.X in XW and Point.Y in YH;
   end;

   procedure Generate_Grid
     (Result : out Rectangle_2D;
      Outline : Rectangle_2D;
      Position : Point_2D;
      R, C : Integer_Element) is
      use type Integer_Element;
      I : constant Integer_Element := Position.X + Position.Y * R;
   begin
      Result.W := Outline.W / C;
      Result.H := Outline.H / R;
      Result.X := (Result.W * (I mod C));
      Result.Y := (Result.H * (I / C));
   end Generate_Grid;

   procedure Zoom (Result : in out Rectangle_2D; Scale : Integer_Element) is
   begin
      Result.X := Result.X - Scale;
      Result.Y := Result.Y - Scale;
      Result.W := Result.W + Scale;
      Result.H := Result.H + Scale;
   end;

end SDL.Geometry;

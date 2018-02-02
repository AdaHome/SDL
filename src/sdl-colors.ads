package SDL.Colors is

   type Color_8 is new Interfaces.Unsigned_8;

   type Color_RGBA8888 is record
      R : Color_8;
      G : Color_8;
      B : Color_8;
      A : Color_8;
   end record;

   type Color_RGBA8888_Array1 is array (Integer range <>) of Color_RGBA8888;
   type Color_RGBA8888_Array2 is array (Integer range <>, Integer range <>) of Color_RGBA8888;

end SDL.Colors;

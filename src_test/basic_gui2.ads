generic
   type Color_Any is private;
   Hoover_Color : Color_Any;
   Toggle_Color : Color_Any;
   Hoover_Color : Color_Any;

package Basic_GUI is

   use SDL;

   type Basic_State is (Normal, Hoover, Active);
   type Background_Color_Mode is array (Basic_State) of Colors.Color_RGBA8888;


   type Basic_Background is record
      Normal : Colors.Color_RGBA8888;
      Hoover : Colors.Color_RGBA8888;
      Active : Colors.Color_RGBA8888;
      Toggle : Colors.Color_RGBA8888;
   end record;

   type Basic_Element is record
      Rectangle : Geometry.Rectangle_2D;
      Border_Color : Colors.Color_RGBA8888;
      Background : Basic_Background;
      Border : Boolean := False;
      Hoover : Boolean := False;
      Active : Boolean := False;
      Toggle : Boolean := False;
   end record;


   type Basic_Element_Array is array (Integer range <>) of Basic_Element;

   procedure Render (Renderer : Renderers.SDL_Renderer; Element : Basic_Element);
   procedure Render (Renderer : Renderers.SDL_Renderer; Element_Array : Basic_Element_Array);

   procedure Update (Element : in out Basic_Element; Point : Geometry.Point_2D; B : Integer);
   procedure Update (Element_Array : in out Basic_Element_Array; Point : Geometry.Point_2D; B : Integer);


end Basic_GUI;

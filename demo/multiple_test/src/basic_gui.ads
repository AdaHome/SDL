with SDL.Geometry;
with SDL.Colors;
with SDL.Renderers;
with SDL.Events;

package Basic_GUI is

   use SDL;

   type Basic_Background is record
      Normal : Colors.Color_RGBA8888;
      Hoover : Colors.Color_RGBA8888;
      Active : Colors.Color_RGBA8888;
      Toggle : Colors.Color_RGBA8888;
      Border : Colors.Color_RGBA8888;
   end record;

   type Basic_State is record
      Clicks : Natural;
      Hoover : Boolean := False;
      Toggle : Boolean := False;
   end record;

   type Basic_Element is record
      Rectangle  : Geometry.Rectangle_2D;
      Border     : Geometry.Rectangle_2D;
      Background : Basic_Background;
      State      : Basic_State;
   end record;



   type Basic_Element_Array is array (Integer range <>) of Basic_Element;

   procedure Render (Renderer : Renderers.SDL_Renderer; Element : Basic_Element);
   procedure Render (Renderer : Renderers.SDL_Renderer; Element_Array : Basic_Element_Array);

   procedure Update (Element : in out Basic_Element; Event : Events.SDL_Event);
   procedure Update (Element_Array : in out Basic_Element_Array; Event : Events.SDL_Event);


end Basic_GUI;

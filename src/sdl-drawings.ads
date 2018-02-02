with SDL.Geometry;
with SDL.Colors;
with SDL.Renderers;

package SDL.Drawings is


   use SDL.Renderers;


   type Draw_Result is new Interfaces.C.int;


   -- Use this function to set the color used for drawing operations (Rect, Line and Clear).
   -- Returns 0 on success or a negative error code on failure; call SDL_GetError() for more information.
   function Set_Color (Renderer : SDL_Renderer; R, G, B, A : Colors.Color_8) return Draw_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_SetRenderDrawColor",
     Pre           => Renderer /= Null_Renderer;


   -- Use this function to set the color used for drawing operations (Rect, Line and Clear).
   procedure Set_Color (Renderer : SDL_Renderer; R, G, B, A : Colors.Color_8) with
     Pre => Renderer /= Null_Renderer;


   procedure Set_Color (Renderer : SDL_Renderer; Color : Colors.Color_RGBA8888);


   function Draw_Line (Renderer : SDL_Renderer; X1, Y1, X2, Y2 : Geometry.Integer_Element) return Draw_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_RenderDrawLine",
     Pre           => Renderer /= Null_Renderer;


   procedure Draw_Line (Renderer : SDL_Renderer; X1, Y1, X2, Y2 : Geometry.Integer_Element) with
     Pre => Renderer /= Null_Renderer;


   pragma Warnings (Off);
   function Draw_Line_Array (Renderer : SDL_Renderer; Data : Geometry.Point_2D_Array; Count : Geometry.Element_Count) return Draw_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_RenderDrawLines",
     Pre           => Renderer /= Null_Renderer;
   pragma Warnings (On);


   procedure Draw_Line_Array (Renderer : SDL_Renderer; Data : Geometry.Point_2D_Array);


   function Draw_Rectangle (Renderer : SDL_Renderer; Rectangle : Geometry.Rectangle_2D) return Draw_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_RenderDrawRect",
     Pre           => Renderer /= Null_Renderer;


   procedure Draw_Rectangle (Renderer : SDL_Renderer; Rectangle : Geometry.Rectangle_2D);


   function Fill_Rectangle (Renderer : SDL_Renderer; Rectangle : Geometry.Rectangle_2D) return Draw_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_RenderFillRect",
     Pre           => Renderer /= Null_Renderer;


   procedure Fill_Rectangle (Renderer : SDL_Renderer; Rectangle : Geometry.Rectangle_2D);


   procedure Clear (Renderer : SDL_Renderer) with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_RenderClear",
     Pre           => Renderer /= Null_Renderer;


end SDL.Drawings;

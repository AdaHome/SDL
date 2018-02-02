with SDL.Geometry;
with SDL.Renderers;

package Basic_Plotters is

   subtype SDL_Renderer is SDL.Renderers.SDL_Renderer;

   type Simple_Plot is record
      Rectangle : SDL.Geometry.Rectangle_2D;
      Scale_X : SDL.Geometry.Integer_Element := 1;
      Scale_Y : SDL.Geometry.Integer_Element := 1;
   end record;

   procedure Draw
     (Renderer : SDL_Renderer;
      Plot : Simple_Plot;
      Data : SDL.Geometry.Point_2D_Array);

end Basic_Plotters;

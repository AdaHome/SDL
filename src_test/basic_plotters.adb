with SDL.Drawings;

package body Basic_Plotters is

   procedure Draw
     (Renderer : SDL_Renderer;
      Plot : Simple_Plot;
      Data : SDL.Geometry.Point_2D_Array) is
      use SDL;
   begin
      Drawings.Set_Color (Renderer, (000, 000, 000, 255));
      Drawings.Clear (Renderer);
      Drawings.Set_Color (Renderer, (255, 255, 255, 255));
      Drawings.Fill_Rectangle (Renderer, Plot.Rectangle);
      Drawings.Set_Color (Renderer, (255, 000, 000, 255));
      Drawings.Draw_Line_Array (Renderer, Data);
   end;

end Basic_Plotters;

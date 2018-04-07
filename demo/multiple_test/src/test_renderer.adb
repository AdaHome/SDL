with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.Drawings;

with Basic_Event_Loop;

procedure Test_Renderer is

   procedure Render
     (Renderer : SDL.Renderers.SDL_Renderer) is
      use SDL;
   begin
      Drawings.Set_Color (Renderer, (0, 0, 0, 255));
      Drawings.Clear (Renderer);
      Drawings.Set_Color (Renderer, (255, 255, 255, 255));
      Drawings.Fill_Rectangle (Renderer, (10, 10, 10, 10));
   end;

begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows.Window_Flags;
      use SDL.Renderers.Renderer_Flags;
      Window : SDL.Windows.SDL_Window;
      Renderer : Renderers.SDL_Renderer;
      Should_Run : Boolean := True;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable);
      Renderer := Renderers.Create (Window, Software);
      while Should_Run loop
         Basic_Event_Loop (Should_Run);
         Render (Renderer);
         Renderers.Present (Renderer);
         delay 0.01;
      end loop;
      Renderers.Destroy (Renderer);
      Windows.Destroy (Window);
   end;

   SDL.Quit;

end Test_Renderer;

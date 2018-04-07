with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.Drawings;

with Ada.Text_IO;

with Basic_Event_Controller;

procedure Main is

   procedure Render (Renderer : SDL.Renderers.SDL_Renderer) is
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
      use SDL.Renderers;
      use SDL.Windows;
      use SDL.Windows.Window_Flags;
      use SDL.Renderers.Renderer_Flags;
      Window : SDL_Window;
      Renderer : SDL_Renderer;
      Should_Run : Boolean := True;
   begin
      Window := Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable or OpenGL);
      Renderer := Create (Window, Software);

      while Should_Run loop
         Basic_Event_Controller (Should_Run);
         Render (Renderer);
         Present (Renderer);
         delay 0.01;
      end loop;
      Destroy (Renderer);
      Destroy (Window);
   end;

   SDL.Quit;

end Main;

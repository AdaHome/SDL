with SDL;
with SDL.Windows;
with SDL.Errors;

with Basic_Event_Loop;

procedure Test_OpenGL_Context is

   procedure Render (Window : SDL.Windows.SDL_Window) is
   begin
      null;
   end Render;

begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows.Window_Flags;
      Window : SDL.Windows.SDL_Window;
      Should_Run : Boolean := True;
      GL_Context : SDL.Windows.OpenGL_Context;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable or OpenGL);
      GL_Context := Windows.Create_OpenGL_Context (Window);
      while Should_Run loop
         Basic_Event_Loop (Should_Run);
         Render (Window);
         Windows.Swap (Window);
         delay 0.01;
      end loop;
      Windows.Delete_OpenGL_Context (GL_Context);
      Windows.Destroy (Window);
   exception
      when others =>
         raise Program_Error with SDL.Errors.Get;
   end;

   SDL.Quit;

end Test_OpenGL_Context;

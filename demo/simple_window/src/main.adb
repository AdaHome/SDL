with SDL;
with SDL.Windows;

with Basic_Event_Controller;

with Ada.Text_IO;


procedure Main is
begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL.Windows;
      use SDL.Windows.Window_Flags;
      Window : SDL_Window;
      Should_Run : Boolean := True;
   begin
      Window := Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable or OpenGL);

      while Should_Run loop
         Basic_Event_Controller (Should_Run);
         delay 0.01;
      end loop;

      Destroy (Window);
   end;

   SDL.Quit;

end Main;

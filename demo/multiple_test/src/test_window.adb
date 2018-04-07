with SDL;
with SDL.Windows;

with Basic_Event_Loop;

procedure Test_Window is
begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows;
      use SDL.Windows.Window_Flags;
      Window : SDL.Windows.SDL_Window;
      Should_Run : Boolean := True;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable);
      while Should_Run loop
         Basic_Event_Loop (Should_Run);
         delay 0.01;
      end loop;
      Windows.Destroy (Window);
   end;

   SDL.Quit;

end Test_Window;

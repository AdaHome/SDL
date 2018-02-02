with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.Drawings;
with Ada.Text_IO;
with SDL.Events;
with SDL.Events_Kind;



procedure Test_GL is




   procedure Render (Renderer : SDL.Renderers.SDL_Renderer) is
      use SDL;
   begin
      Drawings.Set_Color (Renderer, (0, 0, 0, 255));
      Drawings.Clear (Renderer);
      Drawings.Set_Color (Renderer, (255, 255, 255, 255));
      Drawings.Fill_Rectangle (Renderer, (10, 10, 10, 10));
   end;

   procedure Basic_Event_Loop (Should_Run : in out Boolean) is
      use Ada.Text_IO;
      use SDL.Events;
      use SDL.Events_Kind;
      Event : SDL.Events.SDL_Event;
      Flag : Integer;
   begin
      loop
         Flag := Poll (Event);
         exit when Flag = 0;
         case Event.Kind is
         when SDL_QUIT =>
            Put_Line ("[Event] SDL_QUIT");
            Should_Run := False;
            exit;
         when others =>
            null;
         end case;
      end loop;
   end Basic_Event_Loop;

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

end Test_GL;

with Ada.Text_IO;

with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.Events;
with SDL.Events_Kind;
with SDL.Geometry;

with Basic_GUI;

procedure Test_GUI is

   Window : SDL.Windows.SDL_Window;

begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows.Window_Flags;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable);
   end;

   declare
      use Ada.Text_IO;
      use SDL;
      use SDL.Renderers;
      use SDL.Events;
      use SDL.Events_Kind;
      Renderer : SDL_Renderer;
      Button_Array : Basic_GUI.Basic_Element_Array (1 .. 4);
      E : SDL_Event;
      Should_Run : Boolean := True;
      R : Geometry.Rectangle_2D;
   begin
      Windows.Get_Rectangle (Window, R);
      for Button of Button_Array loop
         Button.Background.Normal := (100, 100, 100, 255);
         Button.Background.Hoover := (255, 255, 255, 255);
         Button.Background.Active := (100, 255, 255, 255);
         Button.Background.Active := (255, 000, 000, 255);
      end loop;
      Geometry.Generate_Grid (Button_Array (1).Rectangle, R, (1, 2), 10, 10);
      Geometry.Generate_Grid (Button_Array (2).Rectangle, R, (1, 3), 10, 10);
      Geometry.Generate_Grid (Button_Array (3).Rectangle, R, (4, 2), 10, 10);
      Geometry.Generate_Grid (Button_Array (4).Rectangle, R, (3, 2), 10, 10);
      Geometry.Generate_Grid (Button_Array (4).Border, R, (3, 2), 10, 10);
      Geometry.Zoom (Button_Array (4).Border, 2);

      Renderer := Create (Window, Renderer_Flags.Software);
      while Should_Run loop
         while SDL.Events.Poll (E) = 1 loop

            Basic_GUI.Update (Button_Array, E);

            case E.Kind is
            when Events_Kind.SDL_QUIT =>
               Put_Line ("SDL_QUIT");
               Should_Run := False;
               exit;
            when Events_Kind.SDL_MOUSEMOTION =>
               null;
            when Events_Kind.SDL_MOUSEBUTTONDOWN =>
               null;
            when Events_Kind.SDL_MOUSEBUTTONUP =>
               null;
            when others =>
               null;
            end case;
         end loop;
         Basic_GUI.Render (Renderer, Button_Array);
         Present (Renderer);
         delay 0.01;
      end loop;
      Destroy (Renderer);
   end;

   SDL.Quit;

end Test_GUI;

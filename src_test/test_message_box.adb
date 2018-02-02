with Ada.Text_IO;
with SDL;
with SDL.Windows;
with SDL.Message_Boxes;
with SDL.Renderers;
with SDL.Drawings;

with Interfaces.C;

procedure Test_Message_Box is
   use SDL.Windows;
   use SDL.Message_Boxes;
   use SDL.Renderers;
   use SDL.Drawings;
   use Ada.Text_IO;
   use type Interfaces.C.char_array;
   Window : SDL.Windows.SDL_Window;
   Button : aliased Box_Button_Array (1 .. 4);
   Text1 : aliased Interfaces.C.char_array := "No" & Interfaces.C.nul;
   Text2 : aliased Interfaces.C.char_array := "Yes" & Interfaces.C.nul;
   Text3 : aliased Interfaces.C.char_array := "Cancel" & Interfaces.C.nul;
   Scheme : aliased Color_Scheme;
   Box : aliased Message_Box;
   Title : aliased Interfaces.C.char_array := "example message box" & Interfaces.C.nul;
   Message : aliased Interfaces.C.char_array := "select a button" & Interfaces.C.nul;
   Button_Id : Button_Identity;
begin
   Button (1).Flags := Button_Flags.None;
   Button (1).Identity := 0;
   Button (1).Text := Text1'Unrestricted_Access;
   Button (2).Flags := Button_Flags.Escapekey_Default;
   Button (2).Identity := 1;
   Button (2).Text := Text2'Unrestricted_Access;
   Button (3).Flags := Button_Flags.Returnkey_Default;
   Button (3).Identity := 2;
   Button (3).Text := Text3'Unrestricted_Access;

   Button (4).Flags := Button_Flags.Returnkey_Default;
   Button (4).Identity := 3;
   Button (4).Text := Text3'Unrestricted_Access;

   Scheme.Color_Array (Color_Targets.Background) := (255, 0, 0);
   Scheme.Color_Array (Color_Targets.Text) := (0, 255, 0);
   Scheme.Color_Array (Color_Targets.Button_Border) := (255, 255, 0);
   Scheme.Color_Array (Color_Targets.Button_Background) := (0, 0, 255);
   Scheme.Color_Array (Color_Targets.Button_Selected) := (255, 0, 255);

   Box.Flags := Box_Flags.Information;
   Box.Window := Null_SDL_Window;
   Box.Title := Title'Unrestricted_Access;
   Box.Message := Message'Unrestricted_Access;
   Box.Button_Count := Button'Length;
   Box.Button_Array := Button'Unrestricted_Access;
   Box.Scheme := Scheme'Unrestricted_Access;
   --Box.Scheme := null;

   Put_Line ("Initialize SDL");
   SDL.Initialize (SDL.Initialize_Flags.Empty);

   Put_Line ("Create SDL Window");
   Window := Create ("Title", 0, 0, 1920, 1080, Window_Flags.Fullscreen);

   declare
      Renderer : SDL_Renderer;
   begin
      Renderer := Create (Window, Renderer_Flags.Accelerated);
      Set_Color (Renderer, 255, 255, 255, 255);
      Draw_Line (Renderer, 0, 0, 100, 100);
      Present (Renderer);
      delay 1.0;
      Destroy (Renderer);
   end;

   Put_Line ("Show SDL Box");
   Show (Box'Access, Button_Id);
   Put_Line ("SDL_ShowMessageBox Id: " & Button_Id'Image);

   Destroy (Window);

   Ada.Text_IO.Put_Line ("Quit SDL");
   SDL.Quit;

end Test_Message_Box;

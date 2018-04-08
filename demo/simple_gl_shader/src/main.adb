with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.GL;

with GL.Programs;
with GL.Shaders;
with GL.Shader_Files;

with Basic_Event_Controller;
with Basic_GL_Loader;

with Ada.Text_IO;

procedure Main is

   procedure Shader_Stuff (Filename : String) is
      use GL.Programs;
      use GL.Shaders;
      use GL.Shader_Files;
      use Ada.Text_IO;
      P : constant Program := Create_Empty;
      S1 : constant Shader := Create_Empty (Fragment_Stage);
      S2 : constant Shader := Create_Empty (Vertex_Stage);
   begin
      Set_Source_File (S1, Filename & ".glfs");
      Set_Source_File (S2, Filename & ".glvs");
      Compile (S1);
      Compile (S2);
      Put_Line ("S1: " & Get_Compile_Log (S1));
      Put_Line ("S2: " & Get_Compile_Log (S2));
      Attach (P, S1);
      Attach (P, S2);
      Link (P);
      Put_Line (Get_Link_Log (P));
      Set_Current (P);
   end Shader_Stuff;


begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows;
      use SDL.Renderers;
      use SDL.Windows.Window_Flags;
      use SDL.Renderers.Renderer_Flags;
      Window : SDL_Window;
      Renderer : SDL_Renderer;
      Should_Run : Boolean := True;
      Context : SDL.GL.SDL_GL_Context;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable or OpenGL);
      Renderer := Renderers.Create (Window, Software);

      Context := Basic_GL_Loader (Window);

      Shader_Stuff ("shader");

      while Should_Run loop
         Basic_Event_Controller (Should_Run);
         Renderers.Present (Renderer);
         delay 0.01;
      end loop;

      SDL.GL.Delete_OpenGL_Context (Context);
      Renderers.Destroy (Renderer);
      Windows.Destroy (Window);
   end;

   SDL.Quit;

end Main;

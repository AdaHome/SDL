with SDL;
with SDL.Windows;
with SDL.GL;

with GL.Programs;
with GL.Shaders;
with GL.Shader_Files;
with GL.C;
with GL.Buffers;
with GL.DSA_Buffers;

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
      Put_Line ("P: " & Get_Link_Log (P));
      Set_Current (P);
   end Shader_Stuff;

   procedure Load_Vertex is
      use GL.C;
      use GL.Buffers;
      use GL.DSA_Buffers;
      use type GLfloat;
      Data : array (Integer range <>) of GLfloat := (0.0, 0.5, 0.5, -0.5, -0.5, -0.5);
      B : DSA_Buffer := Create_Buffer;
   begin
      null;
      --glBindBuffer(GL_ARRAY_BUFFER, vbo);
      --glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
   end Load_Vertex;




begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows;
      use SDL.Windows.Window_Flags;
      Window : SDL_Window;
      Should_Run : Boolean := True;
      Context : SDL.GL.SDL_GL_Context;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable or OpenGL);

      Context := Basic_GL_Loader (Window);

      Shader_Stuff ("shader");

      while Should_Run loop
         Basic_Event_Controller (Should_Run);
         delay 0.01;
      end loop;

      SDL.GL.Delete_OpenGL_Context (Context);
      Windows.Destroy (Window);
   end;

   SDL.Quit;

end Main;

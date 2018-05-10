with SDL;
with SDL.Windows;
with SDL.GL;

with GL.Programs;
with GL.C;

with GL.DSA_Buffers;
with GL.Vertex_Array_Objects;
with GL.Drawings;

with Basic_Event_Controller;
with Basic_GL_Loader;
with Basic_Shader_Loader;

with Ada.Text_IO;
use Ada.Text_IO;

with Interfaces.C;
with SDL.Errors;
with GL.Errors;


procedure Main is

   type FV4 is array (1 .. 4) of GL.C.GLfloat;


   type Vertex is record
      Pos : FV4;
      Col : FV4;
   end record with Pack;

   procedure Load_Vertex (P : GL.Programs.Program) is
      use GL.C;
      use GL.DSA_Buffers;
      use GL.Vertex_Array_Objects;
      use type GLfloat;
      use type GLsizei;

      Data : array (1 .. 4) of Vertex;

      Buffer : constant DSA_Buffer := Create_Buffer;
      Attribute : constant Vertex_Array_Object := Create_Attribute;
      CA_Pos : constant Component_Attribute := Get_Attribute_By_Name (GL.Programs.Identity (P), "pos");
      CA_Col : constant Component_Attribute := Get_Attribute_By_Name (GL.Programs.Identity (P), "col");
   begin
      Data (1).Pos := (0.0, 0.0, 0.0, 1.0);
      Data (2).Pos := (1.0, 0.0, 0.0, 1.0);
      Data (3).Pos := (1.0, 1.0, 0.0, 1.0);
      Data (1).Col := (1.0, 0.0, 0.0, 1.0);
      Data (2).Col := (0.0, 1.0, 0.0, 1.0);
      Data (3).Col := (0.0, 0.0, 1.0, 1.0);
      Put_Line_Fancy (CA_Pos);
      Put_Line_Fancy (CA_Col);

      Set_Attribute_Memory_Layout (Attribute, CA_Pos, 3, Float_Type, False, 0);
      Set_Attribute_Memory_Layout (Attribute, CA_Col, 4, Float_Type, False, 4*4);

      VertexArrayAttribBinding (Attribute, CA_Pos, 0);
      VertexArrayAttribBinding (Attribute, CA_Col, 0);

      Set_Attribute_Enable (Attribute, CA_Pos);
      Set_Attribute_Enable (Attribute, CA_Col);

      Named_Buffer_Storage (Buffer, Data'Size / 8, Data'Address, 0);
      --Named_Buffer_Storage (Buffer, Data'Size / 8, Data'Address, GL_DYNAMIC_STORAGE_BIT);
      Bind_Buffer_Vertex (Attribute, 0, GLuint (Buffer), 0, Vertex'Size / 8); -- 4 dim and 4 floats

      Bind (Attribute);
   end Load_Vertex;

   R : Interfaces.C.int;
   P : GL.Programs.Program;

begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   Put_Line ("##");
   Put_Line ("SDL_GL_CONTEXT_PROFILE_MASK" & SDL.GL.SDL_GL_CONTEXT_PROFILE_MASK'Enum_Rep'Img);
   Put_Line ("SDL_GL_CONTEXT_MAJOR_VERSION" & SDL.GL.SDL_GL_CONTEXT_MAJOR_VERSION'Enum_Rep'Img);
   Put_Line ("SDL_GL_CONTEXT_MINOR_VERSION" & SDL.GL.SDL_GL_CONTEXT_MINOR_VERSION'Enum_Rep'Img);

   R := SDL.GL.Set (SDL.GL.SDL_GL_CONTEXT_PROFILE_MASK, SDL.GL.SDL_GL_CONTEXT_PROFILE_CORE);
   R := SDL.GL.Set (SDL.GL.SDL_GL_CONTEXT_MAJOR_VERSION, 4);
   R := SDL.GL.Set (SDL.GL.SDL_GL_CONTEXT_MINOR_VERSION, 5);

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

      P := Basic_Shader_Loader ("shader");
      Load_Vertex (P);

      while Should_Run loop
	 Basic_Event_Controller (Should_Run);
	 GL.C.glClearColor (0.1, 0.1, 0.2, 1.0);
	 GL.Drawings.Clear (GL.Drawings.Color_Plane);
	 GL.Drawings.Draw (GL.Drawings.Triangles_Mode, 0, 3);
	 SDL.GL.Swap (Window);
         delay 0.01;
      end loop;

      SDL.GL.Delete_OpenGL_Context (Context);
      Windows.Destroy (Window);
   end;

   SDL.Quit;

exception

   when E : others =>
      Put_Line ("SDL exception");
      Put_Line (SDL.Errors.Get_String);
      Put_Line ("GL exception");
      Put_Line (GL.Errors.Global_Error'Img);

end Main;

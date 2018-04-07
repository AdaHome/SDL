with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.Drawings;
with SDL.Events;
with SDL.Events_Kind;
with SDL.GL;
with SDL.Errors;
with Ada.Text_IO;
with GL.Programs;
with GL.Shaders;
with GL.Shader_Files;
with GL.C.Initializations;
with System;
with Ada.Exceptions;



procedure Test_GL is

   function Loader (Name : String) return System.Address is
      A : System.Address;
   begin
      Ada.Text_IO.Put (Name);
      A := SDL.GL.Load (Name);
      Ada.Text_IO.New_Line;
      return A;
   exception
      when E : others =>
	 Ada.Text_IO.Put_Line ("Error : " & Ada.Exceptions.Exception_Information (E) & ". SDL: " & SDL.Errors.Get);
	 return System.Null_Address;
   end Loader;

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


   procedure Shader_Stuff (Filename : String) is
      use GL.Programs;
      use GL.Shaders;
      use GL.Shader_Files;
      P : Program := Create_Empty;
      SF : Shader := Create_Empty (Fragment_Stage);
      SV : Shader := Create_Empty (Vertex_Stage);
   begin
      Set_Source_File (SF, "shader.glfs");
      Set_Source_File (SV, "shader.glvs");
   end Shader_Stuff;


begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows.Window_Flags;
      use SDL.Renderers.Renderer_Flags;
      Window : SDL.Windows.SDL_Window;
      Renderer : Renderers.SDL_Renderer;
      Should_Run : Boolean := True;
      Context : SDL.GL.SDL_GL_Context;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable or OpenGL);
      Renderer := Renderers.Create (Window, Software);

      Context := SDL.GL.Create_Context (Window);
      GL.C.Initializations.Initialize (Loader'Unrestricted_Access);

      Shader_Stuff ("shader");

      while Should_Run loop
         Basic_Event_Loop (Should_Run);
         Render (Renderer);
         Renderers.Present (Renderer);
         delay 0.01;
      end loop;
      SDL.GL.Delete_OpenGL_Context (Context);
      Renderers.Destroy (Renderer);
      Windows.Destroy (Window);
   end;

   SDL.Quit;

end Test_GL;

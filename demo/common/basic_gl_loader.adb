with GL.C_Initializations;

with SDL.GL;
with SDL.Errors;
with SDL.Windows;

with System;

with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Strings.Fixed;
with System.Address_Image;

function Basic_GL_Loader (Window : SDL.Windows.SDL_Window) return SDL.GL.SDL_GL_Context is

   function Loader (Name : String) return System.Address is
      use System;
      use Ada.Exceptions;
      use Ada.Text_IO;
      use Ada.Strings.Fixed;
      A : System.Address;
   begin
      Put (Tail (Name, 40, '.'));
      Put (" : ");
      A := SDL.GL.Load (Name);
      Put (System.Address_Image (A));
      New_Line;
      return A;
   exception
      when E : others =>
	 Put (Address_Image (A));
	 Put (" : ");
	 Put (Exception_Information (E));
	 Put (" : ");
	 Put (SDL.Errors.Get);
	 New_Line;
	 return Null_Address;
   end Loader;

   use SDL.GL;

   Context : constant SDL_GL_Context := Create_Context (Window);

begin
   GL.C_Initializations.Initialize (Loader'Unrestricted_Access);
   return Context;
end Basic_GL_Loader;

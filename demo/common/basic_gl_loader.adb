with GL.C.Initializations;

with SDL.GL;
with SDL.Errors;

with System;

with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Strings.Fixed;
with System.Address_Image;

procedure Basic_GL_Loader is

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

begin

    GL.C.Initializations.Initialize (Loader'Unrestricted_Access);

end Basic_GL_Loader;

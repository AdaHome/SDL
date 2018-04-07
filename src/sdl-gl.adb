package body SDL.GL is

   function Load (Name : String) return System.Address is
      use Interfaces.C;
      C_Name : constant char_array := To_C (Name);
   begin
      return Load (C_Name);
   end;



end SDL.GL;

with Ada.Assertions;
with SDL.Errors;

package body SDL is

   procedure Initialize (Flags : in Initialize_Flags.Flag_Field) is
      use Ada.Assertions;
      Result : Initialize_Result;
   begin
      Result := Initialize (Flags);
      Assert (Result = 0, "SDL_Init failed. " & Errors.Get_String);
   end Initialize;

end SDL;

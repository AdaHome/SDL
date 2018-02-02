package body SDL.Errors is

   function Get return String is
      SDL_Error : constant Error_String := Get;
      Ada_Error : constant String := Interfaces.C.Strings.Value (Interfaces.C.Strings.chars_ptr (SDL_Error));
   begin
      return Ada_Error;
   end;

end SDL.Errors;

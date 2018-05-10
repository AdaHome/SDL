with Ada.Assertions;
with SDL.Errors;

package body SDL.Windows is

   function Create
     (Title : String;
      X : Window_Position_X;
      Y : Window_Position_Y;
      W : Window_Width;
      H : Window_Height;
      Flags : Window_Flags.Flag_Field) return SDL_Window is
      Window : SDL_Window;
      C_Title : constant Window_Title := Window_Title (Interfaces.C.To_C (Title));
      use Ada.Assertions;
   begin
      SDL.Errors.Clear_Error;
      Window := Create_Unsafe (C_Title, X, Y, W, H, Flags);
      Assert (Window /= Null_SDL_Window, "Create() : " & Errors.Get_String);
      return Window;
   end Create;

   function Create
     (Title : String;
      X : Window_Position_X;
      Y : Window_Position_Y;
      W : Window_Width;
      H : Window_Height;
      Center_Y : Boolean;
      Center_X : Boolean;
      Monitor : Monitor_Index;
      Flags : Window_Flags.Flag_Field) return SDL_Window is
      Window : SDL_Window;
      use SDL.Errors;


      type Unsigned_32 is mod 2 ** 32;
      for Unsigned_32'Size use 32;
      --https://github.com/SDL-mirror/SDL/blob/master/include/SDL_video.h#L133
      --Used to indicate that the window position should be centered.
      SDL_WINDOWPOS_CENTERED_MASK : constant Unsigned_32 := 16#2FFF0000#;
      SDL_WINDOWPOS_CENTERED : constant Unsigned_32 := SDL_WINDOWPOS_CENTERED_MASK or Unsigned_32 (Monitor);
   begin
      Clear_Error;
      if Center_X and Center_Y then
         Window := Create (Title, Window_Position_X (SDL_WINDOWPOS_CENTERED), Window_Position_Y (SDL_WINDOWPOS_CENTERED), W, H, Flags);
      elsif Center_X then
         Window := Create (Title, Window_Position_X (SDL_WINDOWPOS_CENTERED), Y, W, H, Flags);
      elsif Center_Y then
         Window := Create (Title, X, Window_Position_Y (SDL_WINDOWPOS_CENTERED), W, H, Flags);
      else
         Window := Null_SDL_Window;
      end if;
      return Window;
   end;

   procedure Update_Surface (Window : SDL_Window) is
      use Ada.Assertions;
      R : Integer;
   begin
      R := Update_Surface (Window);
      Assert (R = 0, Errors.Get_String);
   end;


   procedure Get_Rectangle
     (Window : SDL_Window;
      Rectangle : out Geometry.Rectangle_2D) is
      W : Windows.Window_Width;
      H : Windows.Window_Height;
   begin
      Get_Size (Window, W, H);
      Rectangle.X := 0;
      Rectangle.Y := 0;
      Rectangle.W := Geometry.Integer_Element (W);
      Rectangle.H := Geometry.Integer_Element (H);
   end;

end SDL.Windows;

with SDL.Windows;
with Interfaces.C.Strings;

package SDL.Message_Boxes is

   package Box_Flags is
      type Flag_Field is mod 2 ** 32 with Convention => C;

      Error       : constant Flag_Field;
      -- error dialog

      Warning     : constant Flag_Field;
      -- warning dialog

      Information : constant Flag_Field;
      -- informational dialog
   private
      Error       : constant Flag_Field := 16#0000_0010#;
      Warning     : constant Flag_Field := 16#0000_0020#;
      Information : constant Flag_Field := 16#0000_0040#;
   end Box_Flags;


   package Button_Flags is
      type Flag_Field is mod 2 ** 32 with Convention => C;

      None               : constant Flag_Field;

      Returnkey_Default  : constant Flag_Field;
      -- Marks the default button when return is hit

      Escapekey_Default  : constant Flag_Field;
      -- Marks the default button when escape is hit
   private
      None                  : constant Flag_Field := 16#0000_0000#;
      Returnkey_Default     : constant Flag_Field := 16#0000_0001#;
      Escapekey_Default     : constant Flag_Field := 16#0000_0002#;
   end Button_Flags;


   type Button_Identity is new Interfaces.C.int;

   type Box_Button is record
      Flags : Button_Flags.Flag_Field;
      --SDL_MessageBoxButtonFlags

      Identity : Button_Identity;
      --User defined button id (value returned via SDL_ShowMessageBox)

      Text : Interfaces.C.Strings.char_array_access;
      -- The UTF-8 button text
   end record with
     -- Pack => True,
     Convention => C;


   type Box_Button_Array is array (Integer range <>) of aliased Box_Button;
   type Box_Button_Array_Access is access all Box_Button_Array;

   type Box_Color is record
      R : Interfaces.Unsigned_8;
      G : Interfaces.Unsigned_8;
      B : Interfaces.Unsigned_8;
   end record with
     Pack => True,
     Convention => C;

   package Color_Targets is
      type Target is (Background, Text, Button_Border, Button_Background, Button_Selected) with Convention => C;
      for Target use
        (Background => 0,
         Text => 1,
         Button_Border => 2,
         Button_Background => 3,
         Button_Selected => 4);
   end Color_Targets;

   type Box_Color_Array is array (Color_Targets.Target range <>) of aliased Box_Color with Convention => C;

   type Color_Scheme is record
      Color_Array : Box_Color_Array (Color_Targets.Target);
   end record with
     -- Pack => True,
     Convention => C;

   type Message_Box is record
      Flags : Box_Flags.Flag_Field;
      -- SDL_MessageBoxFlags

      Window : Windows.SDL_Window;
      -- Parent window, can be NULL

      Title : Interfaces.C.Strings.char_array_access;
      -- UTF-8 title

      Message : Interfaces.C.Strings.char_array_access;
      -- UTF-8 message text

      Button_Count : Interfaces.C.int;
      Button_Array : Box_Button_Array_Access;

      Scheme : access Color_Scheme;
      --SDL_MessageBoxColorScheme, can be NULL to use system settings
   end record with
     -- Pack => True,
     Convention => C;

   type Show_Result is private;

   function Show (Item : access Message_Box; Identity : out Button_Identity) return Show_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_ShowMessageBox";

   procedure Show (Item : access Message_Box; Identity : out Button_Identity);


private

   type Show_Result is new Interfaces.C.int;

end SDL.Message_Boxes;

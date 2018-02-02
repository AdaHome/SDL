with SDL.Events_Kind;
with SDL.Times;

package SDL.Events_Keyboard is

   use Events_Kind;

   type SDL_Keyboard_Event is record
      Kind : SDL_Event_Kind; -- SDL_KEYDOWN or ::SDL_KEYUP
      Time : Times.Timestamp_32; -- In milliseconds, populated using SDL_GetTicks()
      Window_ID : Unsigned_32; -- The window with keyboard focus, if any
      State : Unsigned_8;
      Repeat : Unsigned_8;
      Padding_2 : Unsigned_8;
      Padding_3 : Unsigned_8;
      Keysym : Unsigned_32;
   end record with
     Convention => C;


end SDL.Events_Keyboard;

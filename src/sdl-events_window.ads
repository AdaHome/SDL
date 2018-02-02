with SDL.Events_Kind;
with SDL.Times;

package SDL.Events_Window is

   use Events_Kind;

   type SDL_Window_Event is record
      Kind : SDL_Event_Kind; -- SDL_WINDOWEVENT
      Time : Times.Timestamp_32; -- In milliseconds, populated using SDL_GetTicks()
      Window_ID : Unsigned_32; -- The associated window
      Event : Unsigned_8; --SDL_WindowEventID
      Padding_1 : Unsigned_8;
      Padding_2 : Unsigned_8;
      Padding_3 : Unsigned_8;
      Data_1 : Signed_32; -- event dependent data
      Data_2 : Signed_32; -- event dependent data
   end record with
     Convention => C;

end SDL.Events_Window;

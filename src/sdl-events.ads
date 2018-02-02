with SDL.Events_Kind;
with SDL.Events_Mouse;
with SDL.Events_Keyboard;
with SDL.Events_Window;
with SDL.Times;

package SDL.Events is

   use Events_Kind;

   type Union_Select is (Select_Common, Select_SDL_Common, Select_SDL_Mouse, Select_Mouse, Select_Mouse_Button, Select_Keyboard, Select_Window);

   type SDL_Common_Event is record
      Kind : SDL_Event_Kind;
      Time : Times.Timestamp_32;
   end record;

   type SDL_Event (Selector : Union_Select := Select_Common) is record
      case Selector is
         when Select_Common =>
            Kind : SDL_Event_Kind;
            Time : Times.Timestamp_32;
         when Select_SDL_Common =>
            Common : SDL_Common_Event;
         when Select_SDL_Mouse =>
            Mouse_SDL : Events_Mouse.SDL_Mouse_Event;
         when Select_Mouse =>
            Mouse : Events_Mouse.Mouse_Event;
         when Select_Mouse_Button =>
            Button : Events_Mouse.Mouse_Button_Event;
         when Select_Keyboard =>
            Keyboard : Events_Keyboard.SDL_Keyboard_Event;
         when Select_Window =>
            Window : Events_Window.SDL_Window_Event;
      end case;
   end record with
     Unchecked_Union,
     Convention => C;

   pragma Warnings (Off);
   for SDL_Event'Size use 56 * 8;
   pragma Warnings (On);

   function Poll (Item : out SDL_Event) return Integer with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_PollEvent";

end SDL.Events;

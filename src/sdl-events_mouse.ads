with SDL.Geometry;
with SDL.Events_Kind;
with SDL.Times;

package SDL.Events_Mouse is

   use Events_Kind;

   type SDL_Mouse_Event is record
      Kind : SDL_Event_Kind;
      Time : Times.Timestamp_32;
      Window_ID : Unsigned_32;
      Which : Unsigned_32;
      State : Unsigned_32;
      X : Signed_32;
      Y : Signed_32;
      X_Rel : Signed_32;
      Y_Rel : Signed_32;
   end record;

   --Check if it is possable to use Point instead of X and Y coordinates.
   pragma Warnings (Off);
   pragma Assert (Signed_32'Size * 2 = Geometry.Point_2D'Size, "Point can not be used instead of X and Y coordinates");
   pragma Warnings (On);

   -- Using Point instead of X, Y.
   type Mouse_Event is record
      Kind : SDL_Event_Kind;
      Time : Unsigned_32;
      Window_ID : Unsigned_32;
      Which : Unsigned_32;
      State : Unsigned_32;
      Position : Geometry.Point_2D;
      Velocity : Geometry.Point_2D;
   end record;

   type Mouse_Button_Event is record
      Kind : SDL_Event_Kind;
      Time : Unsigned_32;
      Window_ID : Unsigned_32;
      Which : Unsigned_32;
      Button : Unsigned_8;
      State : Unsigned_8;
      Clicks : Unsigned_8;
      Padding_1 : Unsigned_8;
      Position : Geometry.Point_2D;
   end record;

--  typedef struct SDL_MouseButtonEvent
--  {
--      Uint32 type;        /**< ::SDL_MOUSEBUTTONDOWN or ::SDL_MOUSEBUTTONUP */
--      Uint32 timestamp;   /**< In milliseconds, populated using SDL_GetTicks() */
--      Uint32 windowID;    /**< The window with mouse focus, if any */
--      Uint32 which;       /**< The mouse instance id, or SDL_TOUCH_MOUSEID */
--      Uint8 button;       /**< The mouse button index */
--      Uint8 state;        /**< ::SDL_PRESSED or ::SDL_RELEASED */
--      Uint8 clicks;       /**< 1 for single-click, 2 for double-click, etc. */
--      Uint8 padding1;
--      Sint32 x;           /**< X coordinate, relative to window */
--      Sint32 y;           /**< Y coordinate, relative to window */
--  } SDL_MouseButtonEvent;

end SDL.Events_Mouse;

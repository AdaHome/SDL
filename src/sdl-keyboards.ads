package SDL.Keyboards is



   type SDL_Keysym is record
      X : Integer;
   end record;

--  typedef struct SDL_Keysym
--  {
--      SDL_Scancode scancode;      /**< SDL physical key code - see ::SDL_Scancode for details */
--      SDL_Keycode sym;            /**< SDL virtual key code - see ::SDL_Keycode for details */
--      Uint16 mod;                 /**< current key modifiers */
--      Uint32 unused;
--  } SDL_Keysym;

end SDL.Keyboards;

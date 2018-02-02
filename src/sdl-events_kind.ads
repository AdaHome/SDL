package SDL.Events_Kind is

   type Unsigned_32 is mod 2 ** 32 with
     Convention => C;
   for Unsigned_32'Size use 32;

   type Unsigned_8 is mod 2 ** 8 with
     Convention => C;
   for Unsigned_8'Size use 8;

   type Signed_32 is range -2 ** 31 .. 2 ** 31 - 1;
   for Signed_32'Size use 32;


   type SDL_Event_Kind is
     (
      SDL_FIRSTEVENT,     -- Unused (do not remove)

      -- Application events
      SDL_QUIT, -- User-requested quit

      -- These application events have special meaning on iOS, see README-ios.md for details
      SDL_APP_TERMINATING,        -- The application is being terminated by the OS
      -- Called on iOS in applicationWillTerminate()
      -- Called on Android in onDestroy()

      SDL_APP_LOWMEMORY,          -- The application is low on memory, free memory if possible.
      -- Called on iOS in applicationDidReceiveMemoryWarning()
      -- Called on Android in onLowMemory()

      SDL_APP_WILLENTERBACKGROUND, -- The application is about to enter the background
      -- Called on iOS in applicationWillResignActive()
      -- Called on Android in onPause()

      SDL_APP_DIDENTERBACKGROUND, -- The application did enter the background and may not get CPU for some time
      -- Called on iOS in applicationDidEnterBackground()
      -- Called on Android in onPause()

      SDL_APP_WILLENTERFOREGROUND, -- The application is about to enter the foreground
      -- Called on iOS in applicationWillEnterForeground()
      -- Called on Android in onResume()

      SDL_APP_DIDENTERFOREGROUND, -- The application is now interactive
      -- Called on iOS in applicationDidBecomeActive()
      -- Called on Android in onResume()


      -- Window events
      SDL_WINDOWEVENT, -- Window state change
      SDL_SYSWMEVENT,             -- System specific event

      -- Keyboard events
      SDL_KEYDOWN, -- Key pressed
      SDL_KEYUP,                  -- Key released
      SDL_TEXTEDITING,            -- Keyboard text editing (composition)
      SDL_TEXTINPUT,              -- Keyboard text input
      SDL_KEYMAPCHANGED,          -- Keymap changed due to a system event such as an
      -- input language or keyboard layout change.


      -- Mouse events
      SDL_MOUSEMOTION, -- Mouse moved
      SDL_MOUSEBUTTONDOWN,        -- Mouse button pressed
      SDL_MOUSEBUTTONUP,          -- Mouse button released
      SDL_MOUSEWHEEL,             -- Mouse wheel motion

      -- Joystick events
      SDL_JOYAXISMOTION, -- Joystick axis motion
      SDL_JOYBALLMOTION,          -- Joystick trackball motion
      SDL_JOYHATMOTION,           -- Joystick hat position change
      SDL_JOYBUTTONDOWN,          -- Joystick button pressed
      SDL_JOYBUTTONUP,            -- Joystick button released
      SDL_JOYDEVICEADDED,         -- A new joystick has been inserted into the system
      SDL_JOYDEVICEREMOVED,       -- An opened joystick has been removed

      -- Game controller events
      SDL_CONTROLLERAXISMOTION, -- Game controller axis motion
      SDL_CONTROLLERBUTTONDOWN,          -- Game controller button pressed
      SDL_CONTROLLERBUTTONUP,            -- Game controller button released
      SDL_CONTROLLERDEVICEADDED,         -- A new Game controller has been inserted into the system
      SDL_CONTROLLERDEVICEREMOVED,       -- An opened Game controller has been removed
      SDL_CONTROLLERDEVICEREMAPPED,      -- The controller mapping was updated

      -- Touch events
      SDL_FINGERDOWN,
      SDL_FINGERUP,
      SDL_FINGERMOTION,

      -- Gesture events
      SDL_DOLLARGESTURE,
      SDL_DOLLARRECORD,
      SDL_MULTIGESTURE,

      -- Clipboard events
      SDL_CLIPBOARDUPDATE, -- The clipboard changed

      -- Drag and drop events
      SDL_DROPFILE, -- The system requests a file open
      SDL_DROPTEXT,                 -- text/plain drag-and-drop event
      SDL_DROPBEGIN,                -- A new set of drops is beginning (NULL filename)
      SDL_DROPCOMPLETE,             -- Current set of drops is now complete (NULL filename)

      -- Audio hotplug events
      SDL_AUDIODEVICEADDED, -- A new audio device is available
      SDL_AUDIODEVICEREMOVED,        -- An audio device has been removed.

      -- Render events
      SDL_RENDER_TARGETS_RESET, -- The render targets have been reset and their contents need to be updated
      SDL_RENDER_DEVICE_RESET, -- The device has been reset and all textures need to be recreated

      -- Events ::SDL_USEREVENT through ::SDL_LASTEVENT are for your use,
      -- and should be allocated with SDL_RegisterEvents()

      SDL_USEREVENT,

      -- This last event is only for bounding internal arrays
      SDL_LASTEVENT
     );

   for SDL_Event_Kind'Size use 32;

   for SDL_Event_Kind use
     (
      SDL_FIRSTEVENT               => 0,
      SDL_QUIT                     => 16#100#,
      SDL_APP_TERMINATING          => 16#101#,
      SDL_APP_LOWMEMORY            => 16#102#,
      SDL_APP_WILLENTERBACKGROUND  => 16#103#,
      SDL_APP_DIDENTERBACKGROUND   => 16#104#,
      SDL_APP_WILLENTERFOREGROUND  => 16#105#,
      SDL_APP_DIDENTERFOREGROUND   => 16#106#,
      SDL_WINDOWEVENT              => 16#200#,
      SDL_SYSWMEVENT               => 16#201#,
      SDL_KEYDOWN                  => 16#300#,
      SDL_KEYUP                    => 16#301#,
      SDL_TEXTEDITING              => 16#302#,
      SDL_TEXTINPUT                => 16#303#,
      SDL_KEYMAPCHANGED            => 16#304#,
      SDL_MOUSEMOTION              => 16#400#,
      SDL_MOUSEBUTTONDOWN          => 16#401#,
      SDL_MOUSEBUTTONUP            => 16#402#,
      SDL_MOUSEWHEEL               => 16#403#,
      SDL_JOYAXISMOTION            => 16#600#,
      SDL_JOYBALLMOTION            => 16#601#,
      SDL_JOYHATMOTION             => 16#602#,
      SDL_JOYBUTTONDOWN            => 16#603#,
      SDL_JOYBUTTONUP              => 16#604#,
      SDL_JOYDEVICEADDED           => 16#605#,
      SDL_JOYDEVICEREMOVED         => 16#606#,
      SDL_CONTROLLERAXISMOTION     => 16#650#,
      SDL_CONTROLLERBUTTONDOWN     => 16#651#,
      SDL_CONTROLLERBUTTONUP       => 16#652#,
      SDL_CONTROLLERDEVICEADDED    => 16#653#,
      SDL_CONTROLLERDEVICEREMOVED  => 16#654#,
      SDL_CONTROLLERDEVICEREMAPPED => 16#655#,
      SDL_FINGERDOWN               => 16#700#,
      SDL_FINGERUP                 => 16#701#,
      SDL_FINGERMOTION             => 16#702#,
      SDL_DOLLARGESTURE            => 16#800#,
      SDL_DOLLARRECORD             => 16#801#,
      SDL_MULTIGESTURE             => 16#802#,
      SDL_CLIPBOARDUPDATE          => 16#900#,
      SDL_DROPFILE                 => 16#1000#,
      SDL_DROPTEXT                 => 16#1001#,
      SDL_DROPBEGIN                => 16#1002#,
      SDL_DROPCOMPLETE             => 16#1003#,
      SDL_AUDIODEVICEADDED         => 16#1100#,
      SDL_AUDIODEVICEREMOVED       => 16#1101#,
      SDL_RENDER_TARGETS_RESET     => 16#2000#,
      SDL_RENDER_DEVICE_RESET      => 16#2001#,
      SDL_USEREVENT                => 16#8000#,
      SDL_LASTEVENT                => 16#FFFF#
     );


end SDL.Events_Kind;

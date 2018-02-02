with Interfaces.C;

package SDL is

   type Initialize_Result is new Interfaces.C.int;
   type SDL_Result is new Interfaces.C.int;

   package Initialize_Flags is
      type Flag_Field is private;

      Empty           : constant Flag_Field;
      -- No flags.

      Timer           : constant Flag_Field;
      -- Timer subsystem

      Audio           : constant Flag_Field;
      -- Audio subsystem

      Video           : constant Flag_Field;
      -- Video subsystem; automatically initializes the events subsystem

      Joystick        : constant Flag_Field;
      -- Joystick subsystem; automatically initializes the events subsystem

      Haptic          : constant Flag_Field;
      -- Haptic (force feedback) subsystem

      Game_Controller : constant Flag_Field;
      -- Controller subsystem; automatically initializes the joystick subsystem

      Events          : constant Flag_Field;
      -- Events subsystem

      No_Parachute    : constant Flag_Field;
      -- Compatibility; this flag is ignored

      Everything      : constant Flag_Field;
      -- All of the above subsystems

   private
      type Flag_Field is mod 2 ** 32 with Convention => C;
      Empty           : constant Flag_Field := 16#0000_0000#;
      Timer           : constant Flag_Field := 16#0000_0001#;
      Audio           : constant Flag_Field := 16#0000_0010#;
      Video           : constant Flag_Field := 16#0000_0020#;
      Joystick        : constant Flag_Field := 16#0000_0200#;
      Haptic          : constant Flag_Field := 16#0000_1000#;
      Game_Controller : constant Flag_Field := 16#0000_2000#;
      Events          : constant Flag_Field := 16#0000_4000#;
      No_Parachute    : constant Flag_Field := 16#0010_0000#;
      Everything      : constant Flag_Field := Timer or Audio or Video or Joystick or Haptic or Game_Controller or Events or No_Parachute;
   end Initialize_Flags;


   function Initialize (Flags : in Initialize_Flags.Flag_Field) return Initialize_Result with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_Init",
     Pre => True;
   -- Use this function to initialize the SDL library.
   -- This must be called before using most other SDL functions.
   -- SDL_Init() simply forwards to calling SDL_InitSubSystem().
   -- Therefore, the two may be used interchangeably.
   -- Though for readability of your code SDL_InitSubSystem() might be preferred.
   -- The file I/O and threading subsystems are initialized by default.
   -- You must specifically initialize other subsystems if you use them in your application.
   -- Logging works without initialization, too.
   -- If you want to initialize subsystems separately
   -- you would call SDL_Init(0) followed by SDL_InitSubSystem() with the desired subsystem flag.

   procedure Initialize (Flags : in Initialize_Flags.Flag_Field);
   -- Use this function to initialize the SDL library.
   -- This must be called before using most other SDL functions.
   -- SDL_Init() simply forwards to calling SDL_InitSubSystem().
   -- Therefore, the two may be used interchangeably.
   -- Though for readability of your code SDL_InitSubSystem() might be preferred.
   -- The file I/O and threading subsystems are initialized by default.
   -- You must specifically initialize other subsystems if you use them in your application.
   -- Logging works without initialization, too.
   -- If you want to initialize subsystems separately
   -- you would call SDL_Init(0) followed by SDL_InitSubSystem() with the desired subsystem flag.

   procedure Quit with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_Quit";
   -- Use this function to clean up all initialized subsystems.
   -- You should call it upon all exit conditions.
   -- You should call this function even if you have already shutdown each initialized subsystem with SDL_QuitSubSystem().
   -- It is safe to call this function even in the case of errors in initialization.
   -- If you start a subsystem using a call to that subsystem's init function
   -- (for example SDL_VideoInit()) instead of SDL_Init() or SDL_InitSubSystem(),
   -- then you must use that subsystem's quit function (SDL_VideoQuit()) to shut it down before calling SDL_Quit().
   -- You can use this function with atexit() to ensure that it is run when your application is shutdown,
   -- but it is not wise to do this from a library or other dynamically loaded code.

end SDL;

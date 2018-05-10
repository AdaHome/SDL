with System;
with SDL.Windows;
with Interfaces.C;

package SDL.GL is

   type SDL_GL_Context is private;

   Null_SDL_GL_Context : constant SDL_GL_Context;

   use type SDL.Windows.SDL_Window;

   function Create_Context (Window : SDL.Windows.SDL_Window) return SDL_GL_Context with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_CreateContext",
     Pre           => Window /= SDL.Windows.Null_SDL_Window,
     Post          => Create_Context'Result /= Null_SDL_GL_Context;


   procedure Delete_OpenGL_Context
     (Context : SDL_GL_Context) with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_DeleteContext",
     Pre           => Context /= Null_SDL_GL_Context;


   procedure Swap (Window : SDL.Windows.SDL_Window) with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_SwapWindow";

   use type Interfaces.C.size_t;
   use type Interfaces.C.char_array;
   use type System.Address;

   function Load (Name : Interfaces.C.char_array) return System.Address with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_GetProcAddress",
     Pre           => Name'Length > 2,
     Post          => Load'Result /= System.Null_Address;

   function Load (Name : String) return System.Address;

   type SDL_GLAttr is
     (
      SDL_GL_RED_SIZE,
      SDL_GL_GREEN_SIZE,
      SDL_GL_BLUE_SIZE,
      SDL_GL_ALPHA_SIZE,
      SDL_GL_BUFFER_SIZE,
      SDL_GL_DOUBLEBUFFER,
      SDL_GL_DEPTH_SIZE,
      SDL_GL_STENCIL_SIZE,
      SDL_GL_ACCUM_RED_SIZE,
      SDL_GL_ACCUM_GREEN_SIZE,
      SDL_GL_ACCUM_BLUE_SIZE,
      SDL_GL_ACCUM_ALPHA_SIZE,
      SDL_GL_STEREO,
      SDL_GL_MULTISAMPLEBUFFERS,
      SDL_GL_MULTISAMPLESAMPLES,
      SDL_GL_ACCELERATED_VISUAL,
      SDL_GL_RETAINED_BACKING,
      SDL_GL_CONTEXT_MAJOR_VERSION,
      SDL_GL_CONTEXT_MINOR_VERSION,
      SDL_GL_CONTEXT_EGL,
      SDL_GL_CONTEXT_FLAGS,
      SDL_GL_CONTEXT_PROFILE_MASK,
      SDL_GL_SHARE_WITH_CURRENT_CONTEXT,
      SDL_GL_FRAMEBUFFER_SRGB_CAPABLE,
      SDL_GL_CONTEXT_RELEASE_BEHAVIOR,
      SDL_GL_CONTEXT_RESET_NOTIFICATION,
      SDL_GL_CONTEXT_NO_ERROR
     );

   type SDL_GLProfile is
     (
      SDL_GL_CONTEXT_PROFILE_CORE,
      SDL_GL_CONTEXT_PROFILE_COMPATIBILITY,
      SDL_GL_CONTEXT_PROFILE_ES
     );

   for SDL_GLProfile use
     (
      SDL_GL_CONTEXT_PROFILE_CORE           => 16#0001#,
      SDL_GL_CONTEXT_PROFILE_COMPATIBILITY  => 16#0002#,
      SDL_GL_CONTEXT_PROFILE_ES             => 16#0004#
     );

   use type Interfaces.C.int;

   function Set (Name : SDL_GLAttr; Value : SDL_GLProfile) return Interfaces.C.int with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_SetAttribute",
     Post          => Set'Result = 0;

   function Set (Name : SDL_GLAttr; Value : Interfaces.C.int) return Interfaces.C.int with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_SetAttribute",
     Post          => Set'Result = 0;


private

   --typedef void *SDL_GLContext;
   type SDL_GL_Context is new System.Address;
   Null_SDL_GL_Context : constant SDL_GL_Context := SDL_GL_Context (System.Null_Address);

end SDL.GL;

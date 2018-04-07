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

private

   --typedef void *SDL_GLContext;
   type SDL_GL_Context is new System.Address;
   Null_SDL_GL_Context : constant SDL_GL_Context := SDL_GL_Context (System.Null_Address);

end SDL.GL;

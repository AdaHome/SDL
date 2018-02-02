with System;
with SDL.Windows;

package SDL.GL is

   type SDL_GL_Context is private;

   Null_SDL_GL_Context : constant SDL_GL_Context;

   use type SDL.Windows.SDL_Window;

   --SDL_GLContext SDL_GL_CreateContext(SDL_Window* window)
   function Create_Context (Window : SDL.Windows.SDL_Window) return SDL_GL_Context with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_GL_CreateContext",
     Pre           => Window /= SDL.Windows.Null_SDL_Window,
     Post          => Create_Context'Result /= Null_SDL_GL_Context;

private

   --typedef void *SDL_GLContext;
   type SDL_GL_Context is new System.Address;
   Null_SDL_GL_Context : constant SDL_GL_Context := SDL_GL_Context (System.Null_Address);

end SDL.GL;

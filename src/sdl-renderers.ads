with SDL.Windows;
with System;

package SDL.Renderers is

   use type Windows.SDL_Window;

   type SDL_Renderer is private;
   type Rendering_Driver is new Interfaces.C.int;

   Null_Renderer : constant SDL_Renderer;

   package Renderer_Flags is

      type Flag_Field is mod 2 ** 32 with Convention => C;

      None                   : constant Flag_Field;
      -- Note that providing no flags gives priority to available SDL_RENDERER_ACCELERATED renderers.

      Software               : constant Flag_Field;
      -- the renderer is a software fallback

      Accelerated            : constant Flag_Field;
      -- the renderer uses hardware acceleration

      Present_V_Sync         : constant Flag_Field;
      -- present is synchronized with the refresh rate

      Target_Texture         : constant Flag_Field;
      -- the renderer supports rendering to texture
   private
      None                   : constant Flag_Field := 16#0000_0000#;
      Software               : constant Flag_Field := 16#0000_0001#;
      Accelerated            : constant Flag_Field := 16#0000_0002#;
      Present_V_Sync         : constant Flag_Field := 16#0000_0004#;
      Target_Texture         : constant Flag_Field := 16#0000_0008#;
   end Renderer_Flags;

   function Create_Unsafe
     (Window : Windows.SDL_Window;
      Index : Rendering_Driver;
      Flags : Renderer_Flags.Flag_Field)
      return SDL_Renderer with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_CreateRenderer",
     Pre           => Window /= Windows.Null_SDL_Window;
   -- Use this function to create a 2D rendering context for a window.

   function Create
     (Window : Windows.SDL_Window;
      Flags : Renderer_Flags.Flag_Field)
      return SDL_Renderer with
     Pre           => Window /= Windows.Null_SDL_Window,
     Post          => Create'Result /= Null_Renderer;
   -- Use this function to create a 2D rendering context for a window.

   procedure Present (Renderer : SDL_Renderer) with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_RenderPresent",
     Pre           => Renderer /= Null_Renderer;

   procedure Destroy (Renderer : SDL_Renderer) with
     Import        => True,
     Convention    => C,
     External_Name => "SDL_DestroyRenderer",
     Pre           => Renderer /= Null_Renderer;

private

   type SDL_Renderer is new System.Address;
   Null_Renderer : constant SDL_Renderer := SDL_Renderer (System.Null_Address);

end SDL.Renderers;

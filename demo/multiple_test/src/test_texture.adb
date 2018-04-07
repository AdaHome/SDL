with SDL;
with SDL.Windows;
with SDL.Renderers;
with SDL.Geometry;
with SDL.Textures;
with SDL.Drawings;
with SDL.Colors;

with Basic_Event_Loop;

procedure Test_Texture is

   procedure Chess
     (Pixmap : out SDL.Colors.Color_RGBA8888_Array2) is
      use SDL.Colors;
      Black : constant Color_RGBA8888 := (000, 000, 000, 255);
      White : constant Color_RGBA8888 := (255, 255, 255, 255);
      A : Boolean := True;
   begin
      for I in Pixmap'Range (1) loop
         A := not A;
         for J in Pixmap'Range (2) loop
            A := not A;
            Pixmap (I, J) := (if A then White else Black);
         end loop;
      end loop;
   end Chess;
   pragma Unreferenced (Chess);
   -- X0X0X
   -- 0X0X0

   procedure Update is new SDL.Textures.Generic_Update
     (Integer,
      SDL.Colors.Color_RGBA8888,
      SDL.Colors.Color_RGBA8888_Array2);

   Pixmap : constant SDL.Colors.Color_RGBA8888_Array2 (1 .. 2, 1 .. 3) :=
     (
      ((255, 000, 000, 255), (000, 255, 000, 255), (000, 000, 255, 255)),
      ((000, 000, 000, 255), (050, 050, 050, 255), (100, 100, 100, 255))
     );

   procedure Render
     (Renderer : SDL.Renderers.SDL_Renderer;
      Texture : SDL.Textures.SDL_Texture) is
      use SDL.Renderers;
      use SDL.Colors;
      use SDL.Textures;
      use SDL.Drawings;
      R : SDL.Geometry.Rectangle_2D;
   begin
      --Chess (Pixmap);
      Set_Color (Renderer, (255, 200, 100, 0));
      Clear (Renderer);
      Update (Texture, null, Pixmap);
      Set_Render_Target (Renderer, Texture);
      R.X := 1;
      R.Y := 5;
      R.W := 1;
      R.H := 5;
      Set_Color (Renderer, (15, 200, 100, 255));
      Fill_Rectangle (Renderer, R);
      Set_Render_Target (Renderer, Null_Texture);
      Render_Copy (Renderer, Texture);
   end;

begin

   SDL.Initialize (SDL.Initialize_Flags.Video);

   declare
      use SDL;
      use SDL.Windows.Window_Flags;
      use SDL.Renderers.Renderer_Flags;
      Window : SDL.Windows.SDL_Window;
      Renderer : Renderers.SDL_Renderer;
      R : Geometry.Rectangle_2D;
      Texture : Textures.SDL_Texture;
      Should_Run : Boolean := True;
   begin
      Window := Windows.Create ("Title", 0, 0, 500, 500, True, True, 0, Shown or Resizable);
      Windows.Get_Rectangle (Window, R);
      Renderer := Renderers.Create (Window, Software);
      Texture := Textures.Create (Renderer, Textures.ABGR8888, Textures.Target, Pixmap'Length (2), Pixmap'Length (1));
      while Should_Run loop
         Basic_Event_Loop (Should_Run);
         Render (Renderer, Texture);
         Renderers.Present (Renderer);
         delay 0.01;
      end loop;
      Textures.Destroy (Texture);
      Renderers.Destroy (Renderer);
      Windows.Destroy (Window);
   end;

   SDL.Quit;

end Test_Texture;

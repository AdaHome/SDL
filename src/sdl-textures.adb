with Ada.Assertions;
with SDL.Errors;

package body SDL.Textures is


   procedure Set_Render_Target
     (Renderer : in Renderers.SDL_Renderer;
      Texture  : in SDL_Texture) is
      use Ada.Assertions;
      Result : SDL_Result;
   begin
      Result := Set_Render_Target (Renderer, Texture);
      Assert (Result = 0, "Create() : " & Errors.Get_String);
   end;


   procedure Render_Copy
     (Renderer    : in Renderers.SDL_Renderer;
      Texture     : in SDL_Texture) is
      use Ada.Assertions;
      Result : SDL_Result;
   begin
      Result := Render_Copy (Renderer, Texture, null, null);
      Assert (Result = 0, "Update() : " & Errors.Get_String);
   end;


   procedure Update
     (Texture : in SDL_Texture;
      Data    : System.Address;
      Pitch   : Texture_Pitch8) is
      use Ada.Assertions;
      Result : SDL_Result;
   begin
      Result := Update (Texture, null, Data, Pitch);
      Assert (Result = 0, "Update() : " & Errors.Get_String);
   end;


   procedure Update
     (Texture : in SDL_Texture;
      Format  : access Geometry.Rectangle_2D;
      Data    : System.Address;
      Pitch   : Texture_Pitch8) is
      use Ada.Assertions;
      Result : SDL_Result;
   begin
      Result := Update (Texture, Format, Data, Pitch);
      Assert (Result = 0, "Update() : " & Errors.Get_String);
   end;


   procedure Generic_Update
     (Texture : in SDL_Texture;
      Format  : access Geometry.Rectangle_2D;
      Data    : in Pixmap) is
   begin
      Update (Texture, Format, Data'Address, Data'Length (2) * (Element'Size / Standard'Storage_Unit));
   end;


end SDL.Textures;

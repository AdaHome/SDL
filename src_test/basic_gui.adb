with SDL.Drawings;
with SDL.Events_Kind;

package body Basic_GUI is


   procedure Render (Renderer : Renderers.SDL_Renderer; Element : Basic_Element) is
   begin
      Drawings.Set_Color (Renderer, Element.Background.Border);
      Drawings.Draw_Rectangle (Renderer, Element.Border);
      if Element.State.Hoover then
         Drawings.Set_Color (Renderer, Element.Background.Hoover);
      else
         Drawings.Set_Color (Renderer, Element.Background.Normal);
      end if;
      Drawings.Draw_Rectangle (Renderer, Element.Rectangle);
   end Render;


   procedure Update (Element : in out Basic_Element; Event : Events.SDL_Event) is
      subtype Mouse_Events is Events_Kind.SDL_Event_Kind with
        Static_Predicate => Mouse_Events in Events_Kind.SDL_MOUSEBUTTONDOWN | Events_Kind.SDL_MOUSEBUTTONUP | Events_Kind.SDL_MOUSEWHEEL | Events_Kind.SDL_MOUSEMOTION;
   begin
      if Event.Kind in Mouse_Events then
         if Geometry.Point_In_Rectangle (Event.Mouse.Position, Element.Rectangle) then
            Element.State.Hoover := True;
         else
            Element.State.Hoover := False;
         end if;
      end if;
   end;


   procedure Update (Element_Array : in out Basic_Element_Array; Event : Events.SDL_Event) is
   begin
      for E of Element_Array loop
         Update (E, Event);
      end loop;
   end;


   procedure Render (Renderer : Renderers.SDL_Renderer; Element_Array : Basic_Element_Array) is
   begin
      for E of Element_Array loop
         Render (Renderer, E);
      end loop;
   end;


end Basic_GUI;

with SDL.Events;
with SDL.Events_Kind;
with Ada.Text_IO;

procedure Basic_Event_Controller (Should_Run : in out Boolean) is
   use Ada.Text_IO;
   use SDL.Events;
   use SDL.Events_Kind;
   Event : SDL.Events.SDL_Event;
   Flag : Integer;
begin
   loop
      Flag := Poll (Event);
      exit when Flag = 0;
      case Event.Kind is
	 when SDL_QUIT =>
	    Put_Line ("[Event] SDL_QUIT");
	    Should_Run := False;
	    exit;
	 when others =>
	    null;
      end case;
   end loop;
end Basic_Event_Controller;

package SDL.Times is

   type Timestamp_32 is mod 2 ** 32;
   for Timestamp_32'Size use 32;

end SDL.Times;

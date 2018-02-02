#include <stdio.h>
#include <stdlib.h>

// https://stackoverflow.com/questions/32342285/undefined-reference-to-winmain16-c-sdl-2/32343111#32343111
#define SDL_MAIN_HANDLED
#include <SDL2/SDL.h>

int Format_Values [] =
{
  SDL_PIXELFORMAT_UNKNOWN,
  SDL_PIXELFORMAT_INDEX1LSB,
  SDL_PIXELFORMAT_INDEX1MSB,
  SDL_PIXELFORMAT_INDEX4LSB,
  SDL_PIXELFORMAT_INDEX4MSB,
  SDL_PIXELFORMAT_INDEX8,
  SDL_PIXELFORMAT_RGB332,
  SDL_PIXELFORMAT_RGB444,
  SDL_PIXELFORMAT_RGB555,
  SDL_PIXELFORMAT_BGR555,
  SDL_PIXELFORMAT_ARGB4444,
  SDL_PIXELFORMAT_RGBA4444,
  SDL_PIXELFORMAT_ABGR4444,
  SDL_PIXELFORMAT_BGRA4444,
  SDL_PIXELFORMAT_ARGB1555,
  SDL_PIXELFORMAT_RGBA5551,
  SDL_PIXELFORMAT_ABGR1555,
  SDL_PIXELFORMAT_BGRA5551,
  SDL_PIXELFORMAT_RGB565,
  SDL_PIXELFORMAT_BGR565,
  SDL_PIXELFORMAT_RGB24,
  SDL_PIXELFORMAT_BGR24,
  SDL_PIXELFORMAT_RGB888,
  SDL_PIXELFORMAT_RGBX8888,
  SDL_PIXELFORMAT_BGR888,
  SDL_PIXELFORMAT_BGRX8888,
  SDL_PIXELFORMAT_ARGB8888,
  SDL_PIXELFORMAT_RGBA8888,
  SDL_PIXELFORMAT_ABGR8888,
  SDL_PIXELFORMAT_BGRA8888,
  SDL_PIXELFORMAT_ARGB2101010,
  SDL_PIXELFORMAT_RGBA32,
  SDL_PIXELFORMAT_ARGB32,
  SDL_PIXELFORMAT_BGRA32,
  SDL_PIXELFORMAT_ABGR32,
  SDL_PIXELFORMAT_YV12,
  SDL_PIXELFORMAT_IYUV,
  SDL_PIXELFORMAT_YUY2,
  SDL_PIXELFORMAT_UYVY,
  SDL_PIXELFORMAT_YVYU,
  SDL_PIXELFORMAT_NV12,
  SDL_PIXELFORMAT_NV21
};

char * Format_Strings [] =
{
  "UNKNOWN",
  "INDEX1LSB",
  "INDEX1MSB",
  "INDEX4LSB",
  "INDEX4MSB",
  "INDEX8",
  "RGB332",
  "RGB444",
  "RGB555",
  "BGR555",
  "ARGB4444",
  "RGBA4444",
  "ABGR4444",
  "BGRA4444",
  "ARGB1555",
  "RGBA5551",
  "ABGR1555",
  "BGRA5551",
  "RGB565",
  "BGR565",
  "RGB24",
  "BGR24",
  "RGB888",
  "RGBX8888",
  "BGR888",
  "BGRX8888",
  "ARGB8888",
  "RGBA8888",
  "ABGR8888",
  "BGRA8888",
  "ARGB2101010",
  "RGBA32",
  "ARGB32",
  "BGRA32",
  "ABGR32",
  "YV12",
  "IYUV",
  "YUY2",
  "UYVY",
  "YVYU",
  "NV12",
  "NV21"
};

int Format_Indices [sizeof (Format_Values)/sizeof (int)];

int comp (const void * VA, const void * VB)
{
    int A = *((int*)VA);
    int B = *((int*)VB);
    if (Format_Values [A] > Format_Values [B]) return  1;
    if (Format_Values [A] < Format_Values [B]) return -1;
    return 0;
}


int main (int argc, char * argv [])
{
  size_t Count = sizeof (Format_Values) / sizeof (int);

  for (size_t I = 0; I < Count; I = I + 1)
  {
    Format_Indices [I] = I;
  }

  qsort (Format_Indices, Count, sizeof (int), comp);

  for (size_t I = 0; I < Count; I = I + 1)
  {
    size_t J = Format_Indices [I];
    printf ("%s,\n", Format_Strings [J]);
  }

  printf ("\nprivate\n");
  for (size_t I = 0; I < Count; I = I + 1)
  {
    size_t J = Format_Indices [I];
    printf ("%s => 16#%08X#,\n", Format_Strings [J], Format_Values [J]);
  }

  return 0;
}

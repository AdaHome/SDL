with GL.Programs;
with GL.Shaders;
with GL.Shader_Files;
with Ada.Text_IO;




function Basic_Shader_Loader (Filename : String) return GL.Programs.Program is
   use GL.Programs;
   use GL.Shaders;
   use GL.Shader_Files;
   use Ada.Text_IO;
   P : constant Program := Create_Empty;
   S1 : constant Shader := Create_Empty (Fragment_Stage);
   S2 : constant Shader := Create_Empty (Vertex_Stage);
begin
   Set_Source_File (S1, Filename & ".glfs");
   Set_Source_File (S2, Filename & ".glvs");
   Compile (S1);
   Compile (S2);
   Put_Line ("S1: " & Get_Compile_Log (S1));
   Put_Line ("S2: " & Get_Compile_Log (S2));
   Attach (P, S1);
   Attach (P, S2);
   Link (P);
   Put_Line ("P: " & Get_Link_Log (P));
   Set_Current (P);
   return P;
end Basic_Shader_Loader;

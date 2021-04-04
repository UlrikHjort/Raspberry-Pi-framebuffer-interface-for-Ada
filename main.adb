---------------------------------------------------------------------------
--                 Raspberry Pi Framebuffer interface
-- 
--           Copyright (C) 2021 By Ulrik Hørlyk Hjort
--
--  This Program is Free Software; You Can Redistribute It and/or
--  Modify It Under The Terms of The GNU General Public License
--  As Published By The Free Software Foundation; Either Version 2
--  of The License, or (at Your Option) Any Later Version.
--
--  This Program is Distributed in The Hope That It Will Be Useful,
--  But WITHOUT ANY WARRANTY; Without Even The Implied Warranty of
--  MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See The
--  GNU General Public License for More Details.
--
-- You Should Have Received A Copy of The GNU General Public License
-- Along with This Program; if not, See <Http://Www.Gnu.Org/Licenses/>.
---------------------------------------------------------------------------
with Framebuffer;
with Interfaces.C;
with Bitmaps;
with Types;

procedure Main is
   package C renames Interfaces.C;   
   R : C.Int := 0;
   
begin
   R := Framebuffer.Init;
   R := Framebuffer.Init_Hdmi;   
   R := Framebuffer.Draw_Full_Bitmap(Bitmaps.MANDELBROT);      
   R := Framebuffer.Draw_Bitmap(Bitmaps.BLUE1, 200, 100, Types.FALSE);       
   R := Framebuffer.Draw_Bitmap(Bitmaps.GREEN2, 420,240, Types.FALSE);    
   --R := Framebuffer.De_Init;   
end Main;


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
Package Body Framebuffer is
   
   --------------------------------------------------------------------
   --
   -- Init
   --
   --------------------------------------------------------------------          
   function Init return C.Int is 
      
      function CInit return C.Int 
	with
	Import        => True,
	Convention    => C,
        External_Name => "init";
      
   begin
      return CInit;
   end Init;
   
   --------------------------------------------------------------------
   --
   -- De_Init
   --
   --------------------------------------------------------------------          
   function De_Init return C.Int is 
      
      function CDe_Init return C.Int 
	with
	Import        => True,
	Convention    => C,
        External_Name => "deinit_fb";
      
   begin
      return CDe_Init;
   end De_Init;   
   
   --------------------------------------------------------------------
   --
   -- Init_Hdmi
   --
   --------------------------------------------------------------------          
   function Init_Hdmi return C.Int is 
      
      function CInit_Hdmi return C.Int 
	with
	Import        => True,
	Convention    => C,
        External_Name => "init_hdmi";
      
   begin
      return CInit_Hdmi;
   end Init_Hdmi;   
   
   --------------------------------------------------------------------
   --
   -- Draw_Full_Bitmap
   --
   --------------------------------------------------------------------             
   function Draw_Full_Bitmap(Bitmap : Bitmaps.Bitmap) return C.Int is
   
      function CDraw_Full_Bitmap(Bitmap : Bitmaps.Bitmap)  return C.Int 
	with
	Import        => True,
	Convention    => C,
        External_Name => "draw_full_bitmap";
      
   begin
      return CDraw_Full_Bitmap(Bitmap);
   end Draw_Full_Bitmap;      
   
   --------------------------------------------------------------------
   --
   -- Draw_Bitmap
   --
   --------------------------------------------------------------------             
   function Draw_Bitmap(Bitmap : Bitmaps.Bitmap; Pos_X : C.Int; Pos_Y : C.Int; Blank_Display : Types.CBool) return C.Int is
      
      function CDraw_Bitmap(Bitmap : Bitmaps.Bitmap; Pos_X : C.Int; Pos_Y : C.Int; Blank_Display : Types.CBool) return C.Int 
	with
	Import        => True,
	Convention    => C,
	External_Name => "draw_bitmap";
      
   begin
      return CDraw_Bitmap(Bitmap,Pos_X ,Pos_Y,Blank_Display);
   end Draw_Bitmap;
   
end Framebuffer;

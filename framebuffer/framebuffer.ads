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
with Interfaces.C;
with Bitmaps;
with Types;

Package Framebuffer is
   package C renames Interfaces.C;   
   
   ---------------------------------------------------------------------------
   --
   -- Init Framebuffer
   --
   ---------------------------------------------------------------------------   
   function Init return C.Int;
   
   ---------------------------------------------------------------------------
   --
   -- Init HDMI Framebuffer
   --
   ---------------------------------------------------------------------------      
   function Init_Hdmi return C.Int;
   
   ---------------------------------------------------------------------------
   --
   -- Draw full framebuffer bitmap. Bitmap given by bitmap enum
   --
   ---------------------------------------------------------------------------      
   function Draw_Full_Bitmap(Bitmap : Bitmaps.Bitmap) return C.Int;
   
   ---------------------------------------------------------------------------
   --
   -- Draw bitmap at position (pos_x, pos_y). Blank_Display = True clears display/framebuffer
   -- before drawing. Blan_Display = False draws on top on exisiting display/framebuffer
   --
   ---------------------------------------------------------------------------      
   function Draw_Bitmap(Bitmap : Bitmaps.Bitmap; Pos_X : C.Int; Pos_Y : C.Int; Blank_Display : Types.CBool) return C.Int;
   
   ---------------------------------------------------------------------------
   --
   -- Deinit framebuffer
   --
   ---------------------------------------------------------------------------      
   function De_Init return C.Int;
   
end Framebuffer;

  

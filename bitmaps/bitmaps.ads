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
  
Package Bitmaps is
   type Bitmap is (GREEN, GREEN1, GREEN2, GREEN3, GREEN4, BLUE1, MANDELBROT); 
   for Bitmap'Size use Interfaces.C.int'Size;
   for Bitmap use (GREEN=>0, 
		   GREEN1=>1, 
		   GREEN2=>2, 
		   GREEN3=>3, 
		   GREEN4=>4, 
		   BLUE1=>5, 
		   MANDELBROT=>6); 
      
end Bitmaps;

/**************************************************************************
--                Raspberry Pi Framebuffer interface
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
***************************************************************************/
#ifndef BITMAPS_H
#define BITMAPS_H

#include <stdint.h>
#include "bitmaps/green.h"
#include "bitmaps/green1.h"
#include "bitmaps/green2.h"
#include "bitmaps/green3.h"
#include "bitmaps/green4.h"
#include "bitmaps/b1.h"
#include "bitmaps/mandel.h"

struct Image {
  uint32_t 	 width;
  uint32_t 	 height;
  uint32_t 	 bytes_per_pixel; 
  uint8_t	 pixel_data[];
};

#endif

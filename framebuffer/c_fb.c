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
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>
#include <sys/ioctl.h>
#include <stdint.h>
#include "bitmaps/bitmaps.h"

/***********************************************************
 *
 * Defines
 *
 ***********************************************************/
#define TRUE  (1==1)
#define FALSE (!TRUE)

/***********************************************************
 *
 * Types
 *
 ***********************************************************/
enum Bitmap { GREEN = 0,
	      GREEN1 = 1,
	      GREEN2 = 2,
	      GREEN3 = 3,
	      GREEN4 = 4,
	      BLUE1 = 5,
	      MANDELBROT = 6,
}; 

/***********************************************************
 *
 * Globals
 *
 ***********************************************************/
int fb_handle = 0;
char* fb = 0;
int bytes_pr_pixel = 0;
struct fb_var_screeninfo vinfo;
struct fb_fix_screeninfo finfo;

/***********************************************************
 *
 * Prototypes
 *
 ***********************************************************/
int init();
int init_hdmi();
char* init_fb(char*);
int deinit_fb();
int full_bitmap_to_framebuffer(struct Image*);
int bitmap_to_framebuffer(struct Image*, int, int, int);
struct Image* select_bitmap(enum Bitmap);
int draw_bitmap(enum Bitmap, int, int, int);
int draw_full_bitmap(enum Bitmap);

/***********************************************************
 *
 * init : Clear framebuffer and disable cursor
 *
 ***********************************************************/
int init() {
  system("dd if=/dev/zero of=/dev/fb0"); // Clear framebuffer (set display black)
  system("setterm -cursor off > /dev/tty1"); // Disable cursor in terminal 
  return 0;
}

/***********************************************************
 *
 * init_hdmi : Set framebuffer to HDMI output
 *
 ***********************************************************/
int init_hdmi() {
  fb = init_fb("/dev/fb0"); // Use framebuffer 0 aka. HDMI output
  return 0;
}

/***********************************************************
 *
 * init_fb : Initialize framebuffer
 *
 ***********************************************************/
char* init_fb(char* framebuffer) {
  
  fb_handle = open(framebuffer, O_RDWR); 
  if (!fb_handle) {
    perror("Error opening framebuffer");
    return 0;
  }

  if (ioctl(fb_handle, FBIOGET_FSCREENINFO, &finfo)) {
    perror("Error reading fixed information");
  }

   if (ioctl(fb_handle, FBIOGET_VSCREENINFO, &vinfo)) {
    perror("Error reading variable information");
   }
  
  bytes_pr_pixel = vinfo.bits_per_pixel / 8;

  char* fb = (char*) mmap(0,
			  finfo.smem_len,
			  PROT_READ | PROT_WRITE, MAP_SHARED,
			  fb_handle,
			  0);

  if ((int32_t) fb == -1) {
    perror("mmap error");
    return 0;
  }

  return fb;
}

/***********************************************************
 *
 * deinit_fb : Deinitialize framebuffer
 *
 ***********************************************************/
int deinit_fb() {
  munmap(fb, finfo.smem_len);
  close(fb_handle);
  system("dd if=/dev/zero of=/dev/fb0"); // Clear framebuffer (set display black)
  system("setterm -cursor on > /dev/tty1"); // Enable cursor in terminal 
  return 0;
}

/***********************************************************
 *
 * full_bitmap_to_framebuffer: Write a full bitmap to the framebuffer
 *
 ***********************************************************/
int full_bitmap_to_framebuffer(struct Image* bitmap) {
  memcpy(fb,(uint8_t*) bitmap->pixel_data,bitmap->width*bitmap->height*bitmap->bytes_per_pixel);
  return 0;
}

/***********************************************************
 *
 * bitmap_to_framebuffer:  Write a bitmap to framebuffer at 
 * display position (start_pos_x, start_pos_y) 
 * blank_display = TRUE  : Clear display before write
 * blank_display = FALSE : Do not clear display before write
 *
 ***********************************************************/
int bitmap_to_framebuffer(struct Image* bitmap, int start_pos_x, int start_pos_y, int blank_display) {

  if (blank_display) {
    memset(fb, 0, finfo.smem_len); // Black "blank" display
  }

  uint8_t* bp = bitmap->pixel_data;    

  for (int i =start_pos_y; i < start_pos_y+bitmap->height; i++) {
    int y_pos = (bitmap->bytes_per_pixel*i*vinfo.xres)+start_pos_x;
    memcpy(fb+y_pos, (uint8_t*) bp, (bitmap->bytes_per_pixel*(bitmap->width)));
    bp+= (bitmap->bytes_per_pixel *(bitmap->width));
  }
      
  return 0;
}

/***********************************************************
 *
 * select_bitmap: Select bitmap from enum Bitmap list
 *
 ***********************************************************/
struct Image* select_bitmap(enum Bitmap bitmap) {
  
  switch (bitmap) {
  case GREEN :
    return (struct Image*) &green;        
    break;
  case GREEN1 :
    return (struct Image*) &g1;    
    break;
  case GREEN2 :
    return (struct Image*) &g2;    
    break;
  case GREEN3 :
    return (struct Image*) &g3;    
    break;
  case GREEN4 :
    return (struct Image*) &g4;    
    break;    
  case BLUE1 :
    return (struct Image*) &b1;        
    break;
  case MANDELBROT :
    return (struct Image*) &mandelbrot;        
    break;    
  default :
    return (struct Image*) &green;            
    break;        
  }

  return 0;
}

/***********************************************************
 *
 * draw_bitmap : Draw bitmap at display position (pos_x, pos_y)
 * blank_display = TRUE  : Clear display before write
 * blank_display = FALSE : Do not clear display before write
 *
 ***********************************************************/
int draw_bitmap(enum Bitmap bitmap, int pos_x, int pos_y, int blank_display) {
  struct Image* im = select_bitmap(bitmap);
  bitmap_to_framebuffer(im, pos_x, pos_y, blank_display);
  return 0;
}

/***********************************************************
 *
 * draw_full_bitmap : Draw full bitmap at the display/framebuffer 

 ***********************************************************/
int draw_full_bitmap(enum Bitmap bitmap) {
  struct Image* im = select_bitmap(bitmap);
  full_bitmap_to_framebuffer(im);  
}

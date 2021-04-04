EXE = main
ADA_VERSION = -gnat12
FRAMEBUFFER_DIR = ./framebuffer
BITMAP_DIR = ./bitmaps
FRAMEBUFFER = $(FRAMEBUFFER_DIR)/framebuffer.adb 
TYPES_DIR = ./types

SRC = main.adb $(FRAMEBUFFER) 
INCLUDE = -I. -I$(BITMAP_DIR) -I$(FRAMEBUFFER_DIR) -I$(TYPES_DIR)
FLAGS = -gnato -gnatwa -fstack-check -g

all:
	gcc -c  $(INCLUDE) $(FRAMEBUFFER_DIR)/c_fb.c 
	gnatmake $(ADA_VERSION) $(FLAGS) $(INCLUDE) $(SRC) -largs c_fb.o --LINK=gcc  

clean:
	rm *.ali *~ *.o b~* $(EXE) $(TYPES_DIR)/*~ $(FRAMEBUFFER_DIR)/*~ $(BITMAP_DIR)/*~

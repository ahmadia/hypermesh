include make.inc

INCLUDE=$(ROOT)/include
export CXXFLAGS += -I$(INCLUDE)

.PHONY: all src interface

all: src interface

src: 
	(cd src; make )
interface:
	(cd interface; make)
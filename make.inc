ROOT=$(PWD)
export ROOT


MWRAP_DIR=/Users/aron/mwrap-0.27
#MWRAP_DIR=/usr/local/mwrap-0.27
export MWRAP_DIR

include $(MWRAP_DIR)/make.inc
MW=$(MWRAP_DIR)/mwrap
export MW

MEX=mex
export MEX

O2_DIR=/opt/o2
#O2_DIR=/usr/local/o2
O2_CFLAGS=-I/usr/local/include
O2_LFLAGS=-L/usr/local/lib -lo2scl_root -lo2scl_base
export O2_CFLAGS
export O2_LFLAGS

GSL_LFLAGS=-lgsl

export MEXFLAGS += 
export CXXFLAGS += -O3


.PHONY: all geometry zones partition zones_tree

export CXXFLAGS += $(O2_CFLAGS) $(GSL_CFLAGS)
export LDFLAGS += $(O2_LFLAGS) $(GSL_LFLAGS)

all: geometry zones partition zones_tree

geometry: geometry.o
zones: zones.o
partition: partition.o
zones_tree: zones_tree.o

clean:
	rm *.o 

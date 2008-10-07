all: geometry partition zones zones_tree
.PHONY:  geometry partition zones zones_tree

export CXXFLAGS += $(OSI_CFLAGS) $(SERIALIZE_CFLAGS) $(O2_CFLAGS) $(GSL_CFLAGS)
export LDFLAGS += $(SERIALIZE_LFLAGS) $(OSI_LFLAGS) $(O2_LFLAGS) $(GSL_LFLAGS)
geometry:
	mkdir -p \@geometry
	$(MW) -mex geometry_mex -c geometry_mex.cpp -mb geometry_class.mw 
	$(MEX) -I../include/ $(MEXFLAGS) CXXFLAGS="$(CXXFLAGS)" geometry_mex.cpp ../src/hyper_sample/geometry.o $(LDFLAGS)

partition:
	mkdir -p \@partition
	$(MW) -mex partition_mex -c partition_mex.cpp -mb partition_class.mw 
	$(MEX) -I../include/ $(MEXFLAGS) CXXFLAGS="$(CXXFLAGS)" partition_mex.cpp ../src/hyper_sample/partition.o ../src/hyper_sample/geometry.o $(LDFLAGS)

zones:
	mkdir -p \@zones
	$(MW) -mex zones_mex -c zones_mex.cpp -mb zones_class.mw 
	$(MEX) -I../include/ $(MEXFLAGS) CXXFLAGS="$(CXXFLAGS)" zones_mex.cpp ../src/hyper_sample/zones.o ../src/hyper_sample/geometry.o $(LDFLAGS)


zones_tree:
	mkdir -p \@zones_tree
	$(MW) -mex zones_tree_mex -c zones_tree_mex.cpp -mb zones_tree_class.mw 
	$(MEX) -I../include/ $(MEXFLAGS) CXXFLAGS="$(CXXFLAGS)" zones_tree_mex.cpp ../src/hyper_sample/zones_tree.o ../src/hyper_sample/geometry.o ../src/hyper_sample/zones.o $(LDFLAGS)


# SCAD Compiler
SCADC?=openscad

STL_TARGETS = $(patsubst %.scad,%.stl,$(wildcard *.scad))

.PHONY: all clean
all: $(STL_TARGETS)

%.stl: %.scad
	$(SCADC) -o $@ $<

clean:
	rm -f *.stl
FLAGS="-Wall"
OFLAGS="-o2 -DNDEBUD"
DFLAGS="-g"
GCC="g++"
BIN=calendar

all: release

$(BIN): $(BIN).cpp
	$(GCC) $(FLAGS) -o $@ $^

release: FLAGS+=$(OFLAGS)
release: $(BIN)

debug: FLAGS+=$(DFLAGS)
debug: $(BIN)

.PHONY: clean
clean:
	rm $(BIN)
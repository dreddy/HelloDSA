CC=gcc
CFLAGS=

ODIR=.

LIBS=-laccel-config

_DEPS =
DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))

_OBJ = intel_dsa_sample.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

$(ODIR)/%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)

intel_dsa_sample: $(OBJ)
	$(CC) -o $@ $^ $(CFLAGS) $(LIBS)

.PHONY: clean

clean:
	rm -f $(ODIR)/*.o *~ core

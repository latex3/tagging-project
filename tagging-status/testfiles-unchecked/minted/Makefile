SRC := minted-01
LATEXMK := latexmk -lualatex -shell-escape


all: test

test: $(SRC:%=%.pdf)

%.pdf:
	$(LATEXMK) $<

clean:
	$(LATEXMK) -c $(SRC)

distclean:
	$(LATEXMK) -C $(SRC)

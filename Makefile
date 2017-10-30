# Makefile: Latex Compilation helper
SHELL=/bin/sh
BOOK=salmos
latest_commit=`git log --format="%H" -n 1`

.SUFFIXES:
.SUFFIXES: .tex
.PHONY: clean

run: $(BOOK).pdf

$(BOOK).pdf: $(BOOK).tex
	rm -rf aux/
	mkdir -p aux/includes
	docker run --rm -v `pwd`:/mnt obedmr/latex tex pdflatex $(BOOK).tex -draftmode
	docker run --rm -v `pwd`:/mnt obedmr/latex tex pdflatex $(BOOK).tex
	echo "Compiled file at: aux/salmos.pdf"
example:
	rm -rf aux/
	mkdir -p aux/includes
	docker run --rm -v `pwd`:/mnt obedmr/latex tex pdflatex example.tex -draftmode
	docker run --rm -v `pwd`:/mnt obedmr/latex tex pdflatex example.tex
	echo "Compiled file at: aux/example.pdf"
#upload:
#	scp aux/thesis.pdf obedmr.com:/srv/http/share/thesis/$(latest_commit).pdf
#	ssh obedmr.com "ln -sf /srv/http/share/thesis/"$(latest_commit)".pdf /srv/http/share/thesis/latest.pdf"
#        echo "http://share.obedmr.com/thesis/"$(latest_commit)".pdf"
clean:
	rm -rf aux/

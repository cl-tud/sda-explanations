BIB = bib/references.bib
DEPENDENCIES = main.tex sections/*.tex macros/*.tex ${BIB}
CONF = iswc2024
SHORT = main
LONG = supplementary
ID = 141 # change after paper registration

default: view

view: $(SHORT).pdf
	evince $(SHORT).pdf &

all: short long

$(SHORT).pdf: $(SHORT).tex $(DEPENDENCIES)
	pdflatex $(SHORT)
	bibtex $(SHORT)
	pdflatex $(SHORT)
	pdflatex $(SHORT)

$(LONG).pdf: $(LONG).tex $(DEPENDENCIES)
	pdflatex $(LONG)
	bibtex $(LONG)
	pdflatex $(LONG)
	pdflatex $(LONG)

.PHONY: upload archive clean distclean

upload: clean
	mkdir $(ID)
	cp -r bib $(ID)
	cp -r macros $(ID)
	cp -r sections $(ID) 
	cp -r llncs.cls splncs04.bst $(ID)
	cp -r main.tex $(ID)/paper.tex
	zip -rm $(ID).zip $(ID)

clean:
	find . -name "*.aux" -print -delete && \
	find . -name "*.bbl" -print -delete && \
	find . -name "*.blg" -print -delete && \
	find . -name "*-blx.bib" -print -delete && \
	find . -name "*.dvi" -print -delete && \
	find . -name "*.fdb_latexmk" -print -delete && \
	find . -name "*.fls" -print -delete && \
	find . -name "*.idx" -print -delete && \
	find . -name "*.ilg" -print -delete && \
	find . -name "*.ind" -print -delete && \
	find . -name "*.log" -print -delete && \
	find . -name "*.nav" -print -delete && \
	find . -name "*.out" -print -delete && \
	find . -name "*.run.xml" -print -delete && \
	find . -name "*.snm" -print -delete && \
	find . -name "*.synctex.gz" -print -delete && \
	find . -name "*.thm" -print -delete && \
	find . -name "*.toc" -print -delete && \
	find . -name "*.vrb" -print -delete

distclean: clean
	find . -name "$(SHORT).pdf" -print -delete
	find . -name "$(LONG).pdf" -print -delete
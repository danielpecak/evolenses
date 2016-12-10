
all: wzory.pdf

%.pdf: %.tex
	pdflatex $(TEXFLAGS) $<

clean:
	rm -f *.pdf *.ps *.log *.aux *.bbl

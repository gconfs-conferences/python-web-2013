all: slides.pdf

slides.pdf: slides.md
	pandoc -i -s -o slides.tex slides.md -t beamer -V theme=Warsaw --slide-level=2
	sed -i 's/begin{frame}/begin{frame}[fragile]/g' slides.tex
	sed -i 's/\\begin{document}/\\usepackage{minted}\\begin{document}/g' slides.tex
	sed -i 's/\[fragile\]\[fragile\]/[fragile]/g' slides.tex
	pdflatex -shell-escape slides.tex
	rm slides.tex

clean:
	rm -f *.pdf
	rm -f *.aux
	rm -f *.log
	rm -f *.nav
	rm -f *.out
	rm -f *.snm
	rm -f *.toc
	rm -f *.vrb

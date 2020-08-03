#!/bin/sh

pandoc -F pandoc-crossref -s -t markdown GitNoob2Pro.md -t pdf -o GitNoob2Pro.pdf --pdf-engine=pdflatex --metadata-file=metadata.yml

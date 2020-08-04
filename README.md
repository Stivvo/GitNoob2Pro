# GitNoob2Pro

Una dispensa introduttiva ai sistemi di controllo di versione, i concetti
fondamentali di git, i comandi, la configurazione e l'installazione di git e
l'utilizzo di git su piattaforme di hosting (nel dettaglio Github) scritta in
pandoc markdown.

## Compilazione

Installare le dipendenze su archlinux:

```
sudo pacman -S pandoc pandoc-crossref texlive-core texlive-latexextra texlive-fontsextra
```

Per compilare il testo in in un pdf:

```
pandoc -F pandoc-crossref -s -t markdown GitNoob2Pro.md -t pdf -o GitNoob2Pro.pdf --pdf-engine=pdflatex --metadata-file=metadata.yml
```


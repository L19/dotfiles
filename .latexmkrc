#!/usr/bin/env perl
$latex = 'platex -synctex=1 -interaction=nonstopmode %O %S';
$bibtex = 'pbibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';

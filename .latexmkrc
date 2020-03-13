#!/usr/bin/env perl
$latex = 'latex -synctex=1 -interaction=nonstopmode %O %S';
$bibtex = 'bibtex %O %B';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';

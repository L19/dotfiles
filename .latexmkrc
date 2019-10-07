#!/usr/bin/env perl
$latex  = 'platex -synctex=1 -halt-on-error';
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';

#!/usr/bin/env python

import sys

# input comes from STDIN (standard input)
for line in sys.stdin:
    # remove leading and trailing whitespace
    line = line.strip()
    # split the line into words
    words = line.split()
    # increase counters
    veryoldword = ''
    oldword = ''
    for word in words:
	if veryoldword == 'without':
        	print '%s\t%s' % (veryoldword+oldword+word, 1)
        veryoldword = oldword
	oldword = word


#!/usr/bin/bash

# Compile the Emacs REDUCE package specifed by the single argument if
# the compiled pacakge is older than its source file, e.g.
# ./remake-one-package.sh rlisp

# Option -f forces compilation of the package regardless, e.g.
# ./remake-one-package.sh -f rlisp

# Author: Francis J. Wright
# Based on code by Anthony C. Hearn.

# Assume this script is run in the top-level Emacs REDUCE directory.
# This script is normally run by remake-all-packages.sh.

# Create log & fasl directories if necessary:
if [ ! -d log ]; then mkdir log; fi
if [ ! -d fasl ]; then mkdir fasl; fi

if getopts f force; then force=t; else force=nil; fi

# Run Emacs REDUCE in batch mode:
# Need either full file name for --load (e.g. reduce.el) or --directory=.
# /cygdrive/d/emacs/emacs/bin/
emacs \
	--batch \
	--directory=. \
	--eval='(setq debug-on-error t)' \
	--load=reduce \
	&> log/$1.blg << EOF
symbolic;

if '$1 eq 'fps then
   load_package limits,factor,specfn,sfgamma
else if '$1 eq 'mrvlimit then
   load_package taylor;

load!-package 'eslremake;

!*argnochk := t;

infile "package.red"\$

!*package!-remake!-force := $force;

package!-remake '$1;

bye;
EOF

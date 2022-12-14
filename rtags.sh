#! /usr/bin/bash
/cygdrive/d/emacs/emacs/bin/etags \
	--language=none \
	--regex='/[^%]*procedure[ \t]+\([^ \t\(;$]+\)/\1/i' \
	*.red packages/*/*.red

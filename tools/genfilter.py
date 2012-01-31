#!/usr/bin/env python
##############################################################################
# Copyright (c) 2012 Mark Charlebois
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to 
# deal in the Software without restriction, including without limitation the 
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or 
# sell copies of the Software, and to permit persons to whom the Software is 
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in 
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
# IN THE SOFTWARE.
##############################################################################

##############################################################################
# Purpose: Order the patches by filename and collect the hunks of patches to
#          the same file, removing any duplicates
##############################################################################
import os, sys
from common import *

def usage():
	print "Error: Invalid arguments"
	print "Usage: %s patch.log filterfile" % os.path.basename(sys.argv[0])


def main():
	if len(sys.argv) != 3:
		usage()
		raise SystemExit

	patchlog = open(sys.argv[1]).read()
	filterfile = open(sys.argv[2], "w")
	filterfile.write("F %s\n" % sys.argv[1]);
	patches = patchlog.split("patching file ")
	offsets=[]
	missing=[]
	for p in patches:
		filename=p.split("\n")[0]
		failedHunks=p.split(" FAILED at ")[1:]
		offsets=[ int(x.split(".")[0]) for x in failedHunks ]
		missing = p.split("\n|diff --git a/")[1:]
		if offsets:
			filterfile.write("R %s %s\n" % (filename, offsets))
		if missing:
			filterfile.write("M %s\n" % filename)
	filterfile.close()	
	
if __name__ == "__main__":
    main()
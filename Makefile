##############################################################################
# Copyright (c) 2012 Mark Charlebois
#               2012 Jan-Simon Möller
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
# The automation uses two passes to create a filter of the upstream patches
# for those targets that are not synced to the tip. The filtered set of
# patches are appied so it is easy to tell exactly what patches were made
# and which did not apply.
# The patches that do not apply are listed in the file
# targets/<targetname>/state/kernel-filter-2:
#   F - log file used to create the following patch filter entries
#   M - File is missing from the current code base
#   R - Rejected hunk(s) from a patch
##############################################################################

TOPDIR=${CURDIR}

include clang/clang.mk
include qemu/qemu.mk

vexpress: qemu-build clang-build
	(cd targets/vexpress && make)

msm: clang-build
	(cd targets/msm && make)

hexagon: clang-build
	(cd targets/hexagon && make)


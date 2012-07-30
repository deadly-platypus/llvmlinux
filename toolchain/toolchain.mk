##############################################################################
# Copyright (c) 2012 Mark Charlebois
#               2012 Jan-Simon Möller
#               2012 Behan Webster
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

# Assumes has been included from ../common.mk

LLVMTOP	= ${TOOLCHAIN}/clang

include ${LLVMTOP}/clang.mk

TARGETS		+= gcc-android-fetch

ANDROID_SDK_BRANCH = aosp-new/ics-factoryrom-2-release
ANDROID_SDK_GIT = git://codeaurora.org/platform/prebuilt.git

${TOOLCHAIN}/android:
	@mkdir -p ${TOOLCHAIN}/android

gcc-android-fetch: ${TOOLCHAIN}/status/gcc-android-fetch
${TOOLCHAIN}/status/gcc-android-fetch: ${TOOLCHAIN}/android
	@mkdir -p ${TOOLCHAIN}/status
	(cd ${TOOLCHAIN}/android && git clone ${ANDROID_SDK_GIT} -b ${ANDROID_SDK_BRANCH})
	@touch $@

gcc-android-sync: ${TOOLCHAIN}/status/gcc-android-fetch
	(cd ${TOOLCHAIN}/android/prebuilt && git pull && git checkout ${ANDROID_SDK_BRANCH})

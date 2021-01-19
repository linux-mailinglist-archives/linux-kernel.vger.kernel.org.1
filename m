Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E56A92FC372
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 23:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbhASW2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 17:28:32 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49188 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728547AbhASRqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 12:46:00 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10JHhwvQ015437;
        Tue, 19 Jan 2021 18:43:58 +0100
Date:   Tue, 19 Jan 2021 18:43:58 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210119174358.GB14704@1wt.eu>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119171637.GA14704@1wt.eu>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:16:37PM +0100, Willy Tarreau wrote:
> > | ${CROSS_COMPILE}gcc -fno-asynchronous-unwind-tables -fno-ident \
> > |         -nostdlib -include ../../../../include/nolibc/nolibc.h \
> > |         -lgcc -s -static -Os -o init init.c
> 
> OK I'll retry this, thank you!

For me on my x86 PC it worked using a cross-compiler:

  $ /f/tc/gcc-linaro-6.4.1-2018.05-x86_64_aarch64-linux-gnu/bin/aarch64-linux-gnu-gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include tools/include/nolibc/nolibc.h -lgcc -s -static -Os -o init-fail init-fail.c 
  $ file init-fail
  init-fail: ELF 64-bit LSB executable, ARM aarch64, version 1 (SYSV), statically linked, BuildID[sha1]=1088f8fad85b7b8a7f00eef4918d24c4c4fdaadf, stripped

Given that you used a native compiler we can't suspect an issue with a
bare-metal compiler possibly affecting how kernel headers are passed
there. But nevertheless, I'd still not disregard the possibility that
the headers found under "linux/" are picked from the libc which for
whatever reason would be missing a lot of them.

I've now tested natively on a local rpi4b onto which I copied the files
(not enough I/O BW on the SD card to clone a kernel there). Tried:

  $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -Os -o init-fail init-fail.c
  specs.
  COLLECT_GCC=gcc
  COLLECT_LTO_WRAPPER=/usr/lib/gcc/aarch64-linux-gnu/7/lto-wrapper
  Target: aarch64-linux-gnu
  Configured with: ../src/configure -v --with-pkgversion='Ubuntu/Linaro 7.5.0-3ubuntu1~18.04' --with-bugurl=file:///usr/share/doc/gcc-7/README.Bugs --enable-languages=c,ada,c++,go,d,fortran,objc,obj-c++ --prefix=/usr --with-gcc-major-version-only --program-suffix=-7 --program-prefix=aarch64-linux-gnu- --enable-shared --enable-linker-build-id --libexecdir=/usr/lib --without-included-gettext --enable-threads=posix --libdir=/usr/lib --enable-nls --enable-bootstrap --enable-clocale=gnu --enable-libstdcxx-debug --enable-libstdcxx-time=yes --with-default-libstdcxx-abi=new --enable-gnu-unique-object --disable-libquadmath --disable-libquadmath-support --enable-plugin --enable-default-pie --with-system-zlib --enable-multiarch --enable-fix-cortex-a53-843419 --disable-werror --enable-checking=release --build=aarch64-linux-gnu --host=aarch64-linux-gnu --target=aarch64-linux-gnu
  Thread model: posix
  gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04) 

Could you please check the output of this from your intermediary "init.c"
file:

   $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include tools/include/nolibc/nolibc.h -lgcc -s -static -E  init.c | grep '^#'

It might give us a clue about where it's finding its includes. And possibly
the list of __NR_ entries reported here as well:

   $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include tools/include/nolibc/nolibc.h -lgcc -s -static -E -dM init.c | grep __NR_

We've seen that __NR_fork or __NR_dup2 for example were missing in your
output, on my native machine I can see them, so that could give us a clue
about the root cause of the issue:

  $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(fork|dup2)'
  #define __NR_dup2 1041
  #define __NR_syscalls (__NR_fork+1)
  #define __NR_fork 1079

I could easily imagine a missing "linux" link or entry somewhere in the
default includes path, but here since there's no such error it rather looks
like an incorrect file which is a bit more concerning. I purposely avoided
to maintain my own definitions for __NR_* let's hope we won't need to do
that :-/

Thanks,
Willy

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED8582FD2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388456AbhATOdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:33:25 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49210 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388373AbhATOZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:25:59 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10KEP0LH015983;
        Wed, 20 Jan 2021 15:25:00 +0100
Date:   Wed, 20 Jan 2021 15:25:00 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210120142500.GB15935@1wt.eu>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
 <20210120120725.GB73692@C02TD0UTHF1T.local>
 <20210120124340.GA15935@1wt.eu>
 <20210120134511.GA77728@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120134511.GA77728@C02TD0UTHF1T.local>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 01:45:11PM +0000, Mark Rutland wrote:
> > Ah that's very interesting indeed because actually these ones should
> > only be used when __NR_dup3 or __NR_clone are not defined. Thus I wanted
> > to check the definitions that were reported in your error output but
> > actually what was needed was to figure whether the correct ones were
> > present, and they are, here on my machine (and yes I agree that in this
> > case the dup2/fork above are bofus):
> 
> The issue is that even if a function is unused, the compiler still has
> to parse and compile the code, so where __NR_dup2 is not defined, we'll
> get a build error for:
> 
> static __attribute__((unused))
> int sys_dup2(int old, int new)
> {
>        return my_syscall2(__NR_dup2, old, new);
> }

For sure but this is supposed to be used only when __NR_dup3 is not
defined. Ah now I understand where my mistake is: after it built
successfully for me I inspected the most recent tree which has these
in place. Sorry for being stupid!

In my local tree it's defined like this:

 static __attribute__((unused))
 int sys_dup2(int old, int new)
 {
#ifdef __NR_dup3
       return my_syscall3(__NR_dup3, old, new, 0);
#else
       return my_syscall2(__NR_dup2, old, new);
#endif
 }

I guess I fixed it in a hurry and forgot to upstream it. I hate doing
that :-(

I'm going to push an update then. On a quick glance I'm seeing that I
addressed dup2() using dup3(), fork() using clone(), getpgrp() using
getpgid(), and poll() using ppoll().

> ... we can deal with that by always returning -ENOSYS for unimplemented
> syscalls, e.g.
> 
> static __attribute__((unused))
> int sys_dup2(int old, int new)
> {
> #ifdef __NR_dup2
>        return my_syscall2(__NR_dup2, old, new);
> #else
>        return -ENOSYS;
> #endif
> }

I didn't want to do that because that would break userland which needs
dup2(), hence the mapping to dup3 instead:

  static __attribute__((unused))
  int sys_dup2(int old, int new)
  {
  #ifdef __NR_dup3
          return my_syscall3(__NR_dup3, old, new, 0);
  #else
          return my_syscall2(__NR_dup2, old, new);
  #endif
  }

> I can spin a patch fixing up all the relevant syscalls, if you'd like?

I shouldn't need since these are already fixed in my tree. At first glance
the equivalent of the following commits is missing from the kernel version:

   https://github.com/wtarreau/nolibc/commit/2379f25073f906d0bad22c48566fcffee8fc9cde
   https://github.com/wtarreau/nolibc/commit/fd5272ec2c66e6f5b195d41c9c8978f58eb74668
   https://github.com/wtarreau/nolibc/commit/47cc42a79c92305f4f8bc02fb28628a4fdd63eaa
   https://github.com/wtarreau/nolibc/commit/d2dc42fd614991c741dfdc8b984864fa3cf64c8e
   https://github.com/wtarreau/nolibc/commit/800f75c13ede49097325f82a4cca3515c44a7939

However I'm interested in knowing if the latest version fixes everything
for you or not :

  https://raw.githubusercontent.com/wtarreau/nolibc/master/nolibc.h

> [...]
> 
> >   ubuntu@ubuntu:~$ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(clone|dup3)'
> >   #define __NR_clone 220
> >   #define __NR_dup3 24
> > 
> > Do you have these ones with your more recent includes ? Or are these wrong
> > again ?
> 
> Those are correct (and all the syscall numbers in unistd.h should be
> correct so long as you don't erroneously set the __ARCH_WANT_* flags):
> 
> [mark@gravadlaks:~/src/linux]% gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include tools/include/nolibc/nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(clone|dup3)'
> #define __NR_clone 220
> #define __NR_dup3 24

OK thanks! I will retry here without setting those. I'm pretty sure I
needed these ones to find the __NR_* values but it's possible that it
was before I had the alternate ones and that these are finally not
nedeed at all (which I would prefer as these are ugly).

> There's still some latent issue when using nolibc (compared to using
> glibc) where the init process never seems to exit, but that looks to be
> orthogonal to the syscall numbering issue -- I'm currently digging into
> that.

OK! Usually for me it does as in my preinit (which uses nolibc), if I
exit I instantly get a kernel panic. In addition if I launch it after
boot, it immediately exits and shows no issue. But maybe you're observing
an artefact related to something else (process session, opened FD or
anything else maybe).

I'll send an update ASAP, likely this evening.

Many thanks for digging into this, and sorry for this mess, as I was
absolutely certain it was up to date :-(

Willy

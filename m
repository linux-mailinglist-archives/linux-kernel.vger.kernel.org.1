Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2802FD28E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 15:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390395AbhATOWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 09:22:52 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:49207 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390086AbhATMoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:44:37 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 10KChe5s015967;
        Wed, 20 Jan 2021 13:43:40 +0100
Date:   Wed, 20 Jan 2021 13:43:40 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210120124340.GA15935@1wt.eu>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
 <20210120120725.GB73692@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120120725.GB73692@C02TD0UTHF1T.local>
User-Agent: Mutt/1.6.1 (2016-04-27)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Jan 20, 2021 at 12:07:25PM +0000, Mark Rutland wrote:
> On Tue, Jan 19, 2021 at 06:43:58PM +0100, Willy Tarreau wrote:
> > On Tue, Jan 19, 2021 at 06:16:37PM +0100, Willy Tarreau wrote:
> > Given that you used a native compiler we can't suspect an issue with a
> > bare-metal compiler possibly affecting how kernel headers are passed
> > there. But nevertheless, I'd still not disregard the possibility that
> > the headers found under "linux/" are picked from the libc which for
> > whatever reason would be missing a lot of them.
> 
> I think the actual issue here is a misapprehension in nolibc.h, which
> started blowing up due to a refactoring in asm/unistd.h.
> 
> In nolibc.h, we do:
> 
> | /* Some archs (at least aarch64) don't expose the regular syscalls anymore by
> |  * default, either because they have an "_at" replacement, or because there are
> |  * more modern alternatives. For now we'd rather still use them.
> |  */
> | #define __ARCH_WANT_SYSCALL_NO_AT
> | #define __ARCH_WANT_SYSCALL_NO_FLAGS
> | #define __ARCH_WANT_SYSCALL_DEPRECATED
> 
> ... but this isn't quite right -- it's not that the syscalls aren't
> exposed by default, but rather that these syscall numbers are not valid
> for architectures which do not define the corresponding __ARCH_WANT_*
> flags. Architectures without those have never implemented the syscalls,
> and would have returned -ENOSYS for the unrecognized syscall numbers,
> but the numbers could be allocated to (distinct) syscalls in future.
> 
> Since commit:
> 
>   a0673fdbcd421052 ("asm-generic: clean up asm/unistd.h")
> 
> ... those definitions got pulled out of <asm-generic/unistd.h>, and
> hence it's no longer possible to accidentally get those where a
> userspace header defines __ARCH_WANT_* in an architecture where they
> don't exist (e.g. arm64).

I didn't remember the details behind these definitions, I've found
this in the related commit message:

    Some syscall numbers are not exported
    by default unless a few macros are defined before including unistd.h :
    
      #define __ARCH_WANT_SYSCALL_NO_AT
      #define __ARCH_WANT_SYSCALL_NO_FLAGS
      #define __ARCH_WANT_SYSCALL_DEPRECATED

So it seems I faced difficulties getting the __NR_* entries and only
could get them using such definitions :-/

Did you figure the correct way to get __NR_* defined on your machine or
should I search ?

> It seems that the headers on my Debian 10.7 system were generated after
> that commit, whereas yours were generated before that.

It's very possible indeed.

> > We've seen that __NR_fork or __NR_dup2 for example were missing in your
> > output, on my native machine I can see them, so that could give us a clue
> > about the root cause of the issue:
> > 
> >   $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(fork|dup2)'
> >   #define __NR_dup2 1041
> >   #define __NR_syscalls (__NR_fork+1)
> >   #define __NR_fork 1079
> 
> As above, these are bogus for arm64. There is no syscall number for dup2
> or fork, and __NR_syscalls is currently only 442.

Ah that's very interesting indeed because actually these ones should
only be used when __NR_dup3 or __NR_clone are not defined. Thus I wanted
to check the definitions that were reported in your error output but
actually what was needed was to figure whether the correct ones were
present, and they are, here on my machine (and yes I agree that in this
case the dup2/fork above are bofus):

  ubuntu@ubuntu:~$ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(clone|dup3)'
  #define __NR_clone 220
  #define __NR_dup3 24

Do you have these ones with your more recent includes ? Or are these wrong
again ? Again I'd be surprised given that I didn't invent them and that my
systems boot fine using these.

> I think the right thing to do is to have nolibc.h detect which syscalls
> are implemented, and to not define __ARCH_WANT_*.

Actually that's what was attempted by already focusing on ifdefs but
without *any* __NR_* we can't even hope to call a syscall and check for
ENOSYS for example. So the code really tries to figure which is the right
__NR_ value for a given syscall, and a quick check at my userland code
shows that I'm already using dup2() and fork() as defined from dup3()
and clone().

Thanks!
Willy

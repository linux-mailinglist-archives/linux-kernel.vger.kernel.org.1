Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 673072FDBBD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 22:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436531AbhATU6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 15:58:51 -0500
Received: from foss.arm.com ([217.140.110.172]:34900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731248AbhATNqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:46:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 091B1D6E;
        Wed, 20 Jan 2021 05:45:20 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F29E03F66E;
        Wed, 20 Jan 2021 05:45:18 -0800 (PST)
Date:   Wed, 20 Jan 2021 13:45:11 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210120134511.GA77728@C02TD0UTHF1T.local>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
 <20210120120725.GB73692@C02TD0UTHF1T.local>
 <20210120124340.GA15935@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120124340.GA15935@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 01:43:40PM +0100, Willy Tarreau wrote:
> On Wed, Jan 20, 2021 at 12:07:25PM +0000, Mark Rutland wrote:
> > On Tue, Jan 19, 2021 at 06:43:58PM +0100, Willy Tarreau wrote:
> > > On Tue, Jan 19, 2021 at 06:16:37PM +0100, Willy Tarreau wrote:

> Did you figure the correct way to get __NR_* defined on your machine or
> should I search ?

Please see below. There is no way to get a number for some syscalls, as
these do not have a legitimate number on arm64, but this doesn't matter
as we can avoid using the number entirely when it does not exist.

[...]

> > >   $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(fork|dup2)'
> > >   #define __NR_dup2 1041
> > >   #define __NR_syscalls (__NR_fork+1)
> > >   #define __NR_fork 1079
> > 
> > As above, these are bogus for arm64. There is no syscall number for dup2
> > or fork, and __NR_syscalls is currently only 442.
> 
> Ah that's very interesting indeed because actually these ones should
> only be used when __NR_dup3 or __NR_clone are not defined. Thus I wanted
> to check the definitions that were reported in your error output but
> actually what was needed was to figure whether the correct ones were
> present, and they are, here on my machine (and yes I agree that in this
> case the dup2/fork above are bofus):

The issue is that even if a function is unused, the compiler still has
to parse and compile the code, so where __NR_dup2 is not defined, we'll
get a build error for:

static __attribute__((unused))
int sys_dup2(int old, int new)
{
       return my_syscall2(__NR_dup2, old, new);
}

... we can deal with that by always returning -ENOSYS for unimplemented
syscalls, e.g.

static __attribute__((unused))
int sys_dup2(int old, int new)
{
#ifdef __NR_dup2
       return my_syscall2(__NR_dup2, old, new);
#else
       return -ENOSYS;
#endif
}

I can spin a patch fixing up all the relevant syscalls, if you'd like?

[...]

>   ubuntu@ubuntu:~$ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(clone|dup3)'
>   #define __NR_clone 220
>   #define __NR_dup3 24
> 
> Do you have these ones with your more recent includes ? Or are these wrong
> again ?

Those are correct (and all the syscall numbers in unistd.h should be
correct so long as you don't erroneously set the __ARCH_WANT_* flags):

[mark@gravadlaks:~/src/linux]% gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include tools/include/nolibc/nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(clone|dup3)'
#define __NR_clone 220
#define __NR_dup3 24

> > I think the right thing to do is to have nolibc.h detect which syscalls
> > are implemented, and to not define __ARCH_WANT_*.
> 
> Actually that's what was attempted by already focusing on ifdefs but
> without *any* __NR_* we can't even hope to call a syscall and check for
> ENOSYS for example. So the code really tries to figure which is the right
> __NR_ value for a given syscall, and a quick check at my userland code
> shows that I'm already using dup2() and fork() as defined from dup3()
> and clone().

Please see above for how to get the -ENOSYS behaviour without relying on bogus
syscall numbers.

I have a local patch for this, which I can send if you'd like?

There's still some latent issue when using nolibc (compared to using
glibc) where the init process never seems to exit, but that looks to be
orthogonal to the syscall numbering issue -- I'm currently digging into
that.

Thanks,
Mark.

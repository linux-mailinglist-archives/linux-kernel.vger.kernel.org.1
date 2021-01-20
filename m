Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE922FD0D2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 14:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbhATMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 07:54:36 -0500
Received: from foss.arm.com ([217.140.110.172]:58826 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388891AbhATMIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 07:08:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E3FD6E;
        Wed, 20 Jan 2021 04:07:29 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC4C3F66E;
        Wed, 20 Jan 2021 04:07:27 -0800 (PST)
Date:   Wed, 20 Jan 2021 12:07:25 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210120120725.GB73692@C02TD0UTHF1T.local>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119174358.GB14704@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:43:58PM +0100, Willy Tarreau wrote:
> On Tue, Jan 19, 2021 at 06:16:37PM +0100, Willy Tarreau wrote:
> Given that you used a native compiler we can't suspect an issue with a
> bare-metal compiler possibly affecting how kernel headers are passed
> there. But nevertheless, I'd still not disregard the possibility that
> the headers found under "linux/" are picked from the libc which for
> whatever reason would be missing a lot of them.

I think the actual issue here is a misapprehension in nolibc.h, which
started blowing up due to a refactoring in asm/unistd.h.

In nolibc.h, we do:

| /* Some archs (at least aarch64) don't expose the regular syscalls anymore by
|  * default, either because they have an "_at" replacement, or because there are
|  * more modern alternatives. For now we'd rather still use them.
|  */
| #define __ARCH_WANT_SYSCALL_NO_AT
| #define __ARCH_WANT_SYSCALL_NO_FLAGS
| #define __ARCH_WANT_SYSCALL_DEPRECATED

... but this isn't quite right -- it's not that the syscalls aren't
exposed by default, but rather that these syscall numbers are not valid
for architectures which do not define the corresponding __ARCH_WANT_*
flags. Architectures without those have never implemented the syscalls,
and would have returned -ENOSYS for the unrecognized syscall numbers,
but the numbers could be allocated to (distinct) syscalls in future.

Since commit:

  a0673fdbcd421052 ("asm-generic: clean up asm/unistd.h")

... those definitions got pulled out of <asm-generic/unistd.h>, and
hence it's no longer possible to accidentally get those where a
userspace header defines __ARCH_WANT_* in an architecture where they
don't exist (e.g. arm64).

It seems that the headers on my Debian 10.7 system were generated after
that commit, whereas yours were generated before that.

> We've seen that __NR_fork or __NR_dup2 for example were missing in your
> output, on my native machine I can see them, so that could give us a clue
> about the root cause of the issue:
> 
>   $ gcc -fno-asynchronous-unwind-tables -fno-ident -nostdlib -include nolibc.h -lgcc -s -static -E -dM init-fail.c | egrep '__NR_(fork|dup2)'
>   #define __NR_dup2 1041
>   #define __NR_syscalls (__NR_fork+1)
>   #define __NR_fork 1079

As above, these are bogus for arm64. There is no syscall number for dup2
or fork, and __NR_syscalls is currently only 442.

I think the right thing to do is to have nolibc.h detect which syscalls
are implemented, and to not define __ARCH_WANT_*.

Thanks,
Mark.

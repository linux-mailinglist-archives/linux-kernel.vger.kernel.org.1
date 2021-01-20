Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288112FD459
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 16:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbhATPkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 10:40:20 -0500
Received: from foss.arm.com ([217.140.110.172]:38378 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732798AbhATOzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 09:55:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D10731B;
        Wed, 20 Jan 2021 06:54:51 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.36.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A6963F68F;
        Wed, 20 Jan 2021 06:54:50 -0800 (PST)
Date:   Wed, 20 Jan 2021 14:54:47 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, valentin.schneider@arm.com
Subject: Re: rcutorture initrd/nolibc build on ARMv8?
Message-ID: <20210120145447.GC77728@C02TD0UTHF1T.local>
References: <20210119153147.GA5083@paulmck-ThinkPad-P72>
 <20210119161901.GA14667@1wt.eu>
 <20210119170238.GA5603@C02TD0UTHF1T.local>
 <20210119171637.GA14704@1wt.eu>
 <20210119174358.GB14704@1wt.eu>
 <20210120120725.GB73692@C02TD0UTHF1T.local>
 <20210120124340.GA15935@1wt.eu>
 <20210120134511.GA77728@C02TD0UTHF1T.local>
 <20210120142500.GB15935@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120142500.GB15935@1wt.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 03:25:00PM +0100, Willy Tarreau wrote:
> On Wed, Jan 20, 2021 at 01:45:11PM +0000, Mark Rutland wrote:
> > > Ah that's very interesting indeed because actually these ones should
> > > only be used when __NR_dup3 or __NR_clone are not defined. Thus I wanted
> > > to check the definitions that were reported in your error output but
> > > actually what was needed was to figure whether the correct ones were
> > > present, and they are, here on my machine (and yes I agree that in this
> > > case the dup2/fork above are bofus):
> > 
> > The issue is that even if a function is unused, the compiler still has
> > to parse and compile the code, so where __NR_dup2 is not defined, we'll
> > get a build error for:
> > 
> > static __attribute__((unused))
> > int sys_dup2(int old, int new)
> > {
> >        return my_syscall2(__NR_dup2, old, new);
> > }
> 
> For sure but this is supposed to be used only when __NR_dup3 is not
> defined. Ah now I understand where my mistake is: after it built
> successfully for me I inspected the most recent tree which has these
> in place. Sorry for being stupid!
> 
> In my local tree it's defined like this:
> 
>  static __attribute__((unused))
>  int sys_dup2(int old, int new)
>  {
> #ifdef __NR_dup3
>        return my_syscall3(__NR_dup3, old, new, 0);
> #else
>        return my_syscall2(__NR_dup2, old, new);
> #endif
>  }

Ah, much better!

For robustness, I think it would be worth doing:

static __attribute__((unused))
int sys_dup2(int old, int new)
{
#if defined(__NR_dup3)
	return my_syscall3(__NR_dup3, old, new, 0);
#elif defined(__NR_dup2)
	return my_syscall2(__NR_dup2, old, new);
#else
#error Cannot implement dup2
#endif
}

... and getting rid of the ARCH_WANT_* definitions (which are never
legitimate for userspace to set). That way, there's no risk that we
accidentally use a bogus syscall number in future. Where the kernel does
implement a syscall, it will have done whatever is necessary to expose
the corresponding __NR_<syscall> to userspace without userspace needing
to define anything.

> I didn't want to do that because that would break userland which needs
> dup2(), hence the mapping to dup3 instead:
> 
>   static __attribute__((unused))
>   int sys_dup2(int old, int new)
>   {
>   #ifdef __NR_dup3
>           return my_syscall3(__NR_dup3, old, new, 0);
>   #else
>           return my_syscall2(__NR_dup2, old, new);
>   #endif
>   }

Sure, makes sense, though as above it might be worth adding an explicit
check for the fallback syscall number.

> I shouldn't need since these are already fixed in my tree. At first glance
> the equivalent of the following commits is missing from the kernel version:
> 
>    https://github.com/wtarreau/nolibc/commit/2379f25073f906d0bad22c48566fcffee8fc9cde
>    https://github.com/wtarreau/nolibc/commit/fd5272ec2c66e6f5b195d41c9c8978f58eb74668
>    https://github.com/wtarreau/nolibc/commit/47cc42a79c92305f4f8bc02fb28628a4fdd63eaa
>    https://github.com/wtarreau/nolibc/commit/d2dc42fd614991c741dfdc8b984864fa3cf64c8e
>    https://github.com/wtarreau/nolibc/commit/800f75c13ede49097325f82a4cca3515c44a7939
> 
> However I'm interested in knowing if the latest version fixes everything
> for you or not :
> 
>   https://raw.githubusercontent.com/wtarreau/nolibc/master/nolibc.h

I replaced my in-tree copy with that, and it built without issues, and
the tests ran correctly.

> OK thanks! I will retry here without setting those. I'm pretty sure I
> needed these ones to find the __NR_* values but it's possible that it
> was before I had the alternate ones and that these are finally not
> nedeed at all (which I would prefer as these are ugly).

Great! I reckon they're not needed at all so long as usage of each
__NR_* is suitably guarded (such as above).

If you do spot issues when removing ARCH_WANT_*, I'm happy to take a
look, and/or to test patches handling any fallout.

Thanks,
Mark.

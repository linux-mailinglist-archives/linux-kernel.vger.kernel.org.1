Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D75C62C530D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389261AbgKZLdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:33:45 -0500
Received: from foss.arm.com ([217.140.110.172]:57076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389236AbgKZLdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:33:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE0641478;
        Thu, 26 Nov 2020 03:33:43 -0800 (PST)
Received: from [10.37.12.45] (unknown [10.37.12.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C824B3F71F;
        Thu, 26 Nov 2020 03:33:41 -0800 (PST)
Subject: Re: [PATCH 1/2] syscalls: avoid time() using __cvdso_gettimeofday in
 use-level's VDSO
To:     Thomas Gleixner <tglx@linutronix.de>,
        Cyril Hrubis <chrubis@suse.cz>, Li Wang <liwang@redhat.com>
Cc:     ltp@lists.linux.it, Chunyu Hu <chuhu@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Carlos O'Donell <carlos@redhat.com>
References: <20201123083137.11575-1-liwang@redhat.com>
 <20201124153837.GA24470@yuki.lan> <875z5tllih.fsf@nanos.tec.linutronix.de>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <c77c4306-6a7e-01f5-c338-ec1c8ef2c0c6@arm.com>
Date:   Thu, 26 Nov 2020 11:36:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <875z5tllih.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas.

On 11/25/20 11:32 AM, Thomas Gleixner wrote:
[...]

>>> Here we propose to use '__NR_time' to invoke syscall directly that makes
>>> test all get real seconds via ktime_get_real_second.
> 
> This is a general problem and not really just for this particular test
> case.
> 
> Due to the internal implementation of ktime_get_real_seconds(), which is
> a 2038 safe replacement for the former get_seconds() function, this
> accumulation issue can be observed. (time(2) via syscall and newer
> versions of VDSO use the same mechanism).
> 
>      clock_gettime(CLOCK_REALTIME, &ts);
>      sec = time();
>      assert(sec >= ts.tv_sec);
> 
> That assert can trigger for two reasons:
> 
>  1) Clock was set between the clock_gettime() and time().
> 
>  2) The clock has advanced far enough that:
> 
>     timekeeper.tv_nsec + (clock_now_ns() - last_update_ns) > NSEC_PER_SEC
> 
> #1 is just a property of clock REALTIME. There is nothing we can do
>    about that.
> 
> #2 is due to the optimized get_seconds()/time() access which avoids to
>    read the clock. This can happen on bare metal as well, but is far
>    more likely to be exposed on virt.
> 
> The same problem exists for CLOCK_XXX vs. CLOCK_XXX_COARSE
> 
>      clock_gettime(CLOCK_XXX, &ts);
>      clock_gettime(CLOCK_XXX_COARSE, &tc);
>      assert(tc.tv_sec >= ts.tv_sec);
> 
> The _COARSE variants return their associated timekeeper.tv_sec,tv_nsec
> pair without reading the clock. Same as #2 above just extended to clock
> MONOTONIC.
> 
> There is no way to fix this except giving up on the fast accessors and
> make everything take the slow path and read the clock, which might make
> a lot of people unhappy.
> 
> For clock REALTIME #1 is anyway an issue, so I think documenting this
> proper is the right thing to do.
> 
> Thoughts?
>

I completely agree with your analysis and the fact that we should document this
information.

My proposal would be to use either the vDSO document present in the kernel [1]
or the man pages for time(2) and clock_gettime(2). Probably the second would be
more accessible to user space developers.

[1] Documentation/ABI/stable/vdso

> Thanks,
> 
>         tglx
> 

-- 
Regards,
Vincenzo

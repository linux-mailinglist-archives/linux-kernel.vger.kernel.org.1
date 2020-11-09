Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39EA22ABF1F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 15:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgKIOqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 09:46:11 -0500
Received: from muru.com ([72.249.23.125]:47530 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730649AbgKIOqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 09:46:11 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9223E80CD;
        Mon,  9 Nov 2020 14:46:13 +0000 (UTC)
Date:   Mon, 9 Nov 2020 16:45:49 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        v.narang@samsung.com, a.sahrawat@samsung.com,
        Marc Zyngier <maz@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Maninder Singh <maninder1.s@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/3] arm: introduce IRQ stacks
Message-ID: <20201109144549.GA26857@atomide.com>
References: <CGME20201008071639epcas5p465f13d992a25936ba63436baf1fb6f83@epcas5p4.samsung.com>
 <1602141333-17822-1-git-send-email-maninder1.s@samsung.com>
 <1602141333-17822-3-git-send-email-maninder1.s@samsung.com>
 <CAK8P3a2RYeNiTy9QmwFVKtFifXxWc9XfAT6ThPoSH9wGYsKGpA@mail.gmail.com>
 <CAK8P3a3eZjBVSuhv=Cx4aYC+E9tex+BbJH1b6YyMMief-mO7kQ@mail.gmail.com>
 <20201021124542.GL1551@shell.armlinux.org.uk>
 <20201021125740.GM1551@shell.armlinux.org.uk>
 <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3s9JJpeBpH38utw9aA1VaEkcBqKEGtwcmoP1zS6xDj5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Arnd Bergmann <arnd@kernel.org> [201021 16:07]:
> On Wed, Oct 21, 2020 at 2:57 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> > On Wed, Oct 21, 2020 at 01:45:42PM +0100, Russell King - ARM Linux admin wrote:
> > > > > - define 'current' as 'this_cpu_read_stable(current_task);'
> > > > > - convert to CONFIG_THREAD_INFO_IN_TASK
> > >
> > > That means we need to also code that up in assembly - remember, we
> > > need to access thread_info from assembly code.
> >
> > Note also that there is a circular dependency involved. If you make
> > thread_info accessible via per-cpu, then:
> >
> > #ifndef __my_cpu_offset
> > #define __my_cpu_offset per_cpu_offset(raw_smp_processor_id())
> > #endif
> > #ifdef CONFIG_DEBUG_PREEMPT
> > #define my_cpu_offset per_cpu_offset(smp_processor_id())
> > #else
> > #define my_cpu_offset __my_cpu_offset
> > #endif
> 
> Right, I had missed the fallback path using asm-generic/percpu.h
> that is used with CONFIG_SMP && CONFIG_CPU_V6
> Almost everything either uses fixed percpu data (on UP builds)
> or TPIDRPRW when building a v7-only or v6k/v7 kernel without
> v6 support.
> 
> > smp_processor_id() ultimately ends up as raw_smp_processor_id() which
> > is:
> >
> > #define raw_smp_processor_id() (current_thread_info()->cpu)
> >
> > and if current_thread_info() itself involves reading from per-cpu data,
> > we end up recursing... infinitely.
> >
> > This is why I said in the other thread:
> >
> > "We don't do it because we don't have a separate register to be able
> > to store the thread_info pointer, and copying that lump between the
> > SVC and IRQ stack will add massively to IRQ latency, especially for
> > older machines."
> 
> As discussed on IRC, I think it can still be done in one of these
> ways, though admittedly none of them are perfect:
> 
> a) add runtime patching for __my_cpu_offset() when
>   CONFIG_SMP_ON_UP is set. This adds complexity but avoids the
>   fallback for for SMP&&CPU_V6. It possibly also speeds up
>   running on single-cpu systems if the TPIDRPRW access adds
>   any measurable runtime overhead compared to patching it out.

Out of these options a) sounds best to me.

> b) If irq stacks are left as a compile-time option, that could be
>   made conditional on "!(SMP&&CPU_V6)". Presumably very
>   few people still run kernels built that way any more. The only
>   supported platforms are i.MX3, OMAP2 and Realview-eb, all of
>   which are fairly uncommon these days and would usually
>   run v6-only non-SMP kernels.

This has been working just fine for years though. In general,
removing the conditional compile ifdefferey has made things quite
a bit easier for us, so let's continue on that.

> c) If we decide that we no longer care about that configuration
>   at all, we could decide to just make SMP depend on !CPU_V6,
>   and possibly kill off the entire SMP_ON_UP patching logic.
>   I suspect we still want to keep SMP_ON_UP for performance
>   reasons, but I don't know how significant they are to start with.

And this too has been working just fine for years :)

Regards,

Tony

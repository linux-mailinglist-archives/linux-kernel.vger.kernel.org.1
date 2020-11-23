Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7B02C177D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 22:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbgKWVPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 16:15:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38366 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgKWVPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 16:15:40 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606166137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gm1CPhRLA62MixEhWNse8RMY9b3E4f8m1H9gWjse9cs=;
        b=Y2OkQkppV8kNYpV/D5hyHPbrP5xyW5B/qyDB89W93uqkUHEAUY5gi14F0pIRvvhHs0I8wl
        pt0jgy+1U1ln8g4i8PLLODu8nbqssEqI0lC6K2vv2xNktV1rLDtrr6SvN9ld9JzqRBAyYj
        3AIM4dIZYamalXdFsqElELjebzhl2IonyCD8FbcNxIUa+KgRTrUcEwgUmPsXFIxzxM8Kfx
        N0MieqVTa/u6Bn2HRkaPt/7U4M8kZB+aPcFy4QES8WXI97OvzFWfBfAp48eWRhnwDg3siv
        wJ4S/ThQrjkUC30AZi5mDPlzhSwi7V6DhAcwp1VmqF1WW1P652ixko1nfj7bGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606166137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gm1CPhRLA62MixEhWNse8RMY9b3E4f8m1H9gWjse9cs=;
        b=5Z/aMzD9l8krrHy43JORosDbr9Rfl9CKVBmxFMbGP0Qs/6EwppEnFXERwQL4aoi9Wx5Lvs
        z5MGo2jAwJ4nU1Bw==
To:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent of RT
In-Reply-To: <CALCETrWHzHXLKuD4JWxDyBULAuFivP55csFp=6feireZhianVw@mail.gmail.com>
References: <20201118194838.753436396@linutronix.de> <20201118204007.269943012@linutronix.de> <20201119093834.GH3306@suse.de> <20201119111411.GL3121378@hirez.programming.kicks-ass.net> <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com> <20201119182843.GA2414@hirez.programming.kicks-ass.net> <87tutkolq1.fsf@nanos.tec.linutronix.de> <20201120092928.GA3021@hirez.programming.kicks-ass.net> <CALCETrWHzHXLKuD4JWxDyBULAuFivP55csFp=6feireZhianVw@mail.gmail.com>
Date:   Mon, 23 Nov 2020 22:15:37 +0100
Message-ID: <87mtz7n5ae.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22 2020 at 15:16, Andy Lutomirski wrote:
> On Fri, Nov 20, 2020 at 1:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> Anyway, clearly I'm the only one that cares, so I'll just crawl back
>> under my rock...
>
> I'll poke my head out of the rock for a moment, though...
>
> Several years ago, we discussed (in person at some conference IIRC)
> having percpu pagetables to get sane kmaps, percpu memory, etc.

Yes, I remember. That was our initial reaction in Prague to the looming
PTI challenge 3 years ago.

> The conclusion was that Linus thought the performance would suck and
> we shouldn't do it.

Linus had opinions, but we all agreed that depending on the workload and
the CPU features (think !PCID) the copy/pagefault overhead could be
significant.

> Since then, though, we added really fancy infrastructure for keeping
> track of a per-CPU list of recently used mms and efficiently tracking
> when they need to be invalidated.  We called these "ASIDs".  It would
> be fairly straightforward to have an entire pgd for each (cpu, asid)
> pair.  Newly added second-level (p4d/pud/whatever -- have I ever
> mentioned how much I dislike the Linux pagetable naming conventions
> and folding tricks?) tables could be lazily faulted in, and copies of
> the full 2kB mess would only be neeced when a new (cpu,asid) is
> allocated because either a flush happened while the mm was inactive on
> the CPU in question or because the mm fell off the percpu cache.
>
> The total overhead would be a bit more cache usage, 4kB * num cpus *
> num ASIDs per CPU (or 8k for PTI), and a few extra page faults (max
> num cpus * 256 per mm over the entire lifetime of that mm).

> The common case of a CPU switching back and forth between a small
> number of mms would have no significant overhead.

For CPUs which do not support PCID this sucks, which is everything pre
Westmere and all of 32bit. Yes, 32bit. If we go there then 32bit has to
bite the bullet and use the very same mechanism. Not that I care much
TBH.

Even for those CPUs which support it we'd need to increase the number of
ASIDs significantly.  Right now we use only 6 ASIDs, which is not a
lot. There are process heavy workloads out there which do quite some
context switching so avoiding the copy matters. I'm not worried about
fork as the copy will probably be just noise.

That said, I'm not saying it shouldn't be done, but there are quite a
few things which need to be looked at.

TBH, I really would love to see that just to make GS kernel usage and
the related mess in the ASM code go away completely.

For the task at hand, i.e. replacing kmap_atomic() by kmap_local(), this
is not really helpful because we'd need to make all highmem using
architectures do the same thing. But if we can pull it off on x86 the
required changes for the kmap_local() code are not really significant.

> On an unrelated note, what happens if you migrate_disable(), sleep for
> a looooong time, and someone tries to offline your CPU?

The hotplug code will prevent the CPU from going offline in that case,
i.e. it waits until the last task left it's migrate disabled section.

But you are not supposed to invoke sleep($ETERNAL) in such a
context. Emphasis on 'not supposed' :)

Thanks,

        tglx

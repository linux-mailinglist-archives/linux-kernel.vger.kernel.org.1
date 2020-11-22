Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC6E2BFCF6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 00:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKVXQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 18:16:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgKVXQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 18:16:27 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BDB208FE
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606086986;
        bh=hDV+6vxRY4eADdd/pIRKC6Rd7kdzU/zz7SC7dpNa+uM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w8K+TGnSTqkQJ1qBb/OBagUufRHfBMX+SbL4pa0hGQq+xClrowduurW8vapUkLG0u
         mZkiwYd0sl4jQTEhxiH+o4kI5lyfz47u6/ptdzW5OP1EtgfohsHhPrzbF0Yev0xUQc
         d/syrtm5X/q7bh+Jx74OzciKLOCaTxfrRz/jnVEU=
Received: by mail-wm1-f44.google.com with SMTP id h21so15709864wmb.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 15:16:26 -0800 (PST)
X-Gm-Message-State: AOAM533F2NksD09chFLLIptLEHJ98aIZ0LIFc6AZnPJuMwX2wBAigV0I
        V1dy6AUmPUdgotyzd1tR0GwQWdsav+MnQgXlJOVTGg==
X-Google-Smtp-Source: ABdhPJzY5ZafJcEvAWHLlKqjLDdYKnT78P2PX32Ynzq62mz1lBcZ/cIjgS1QAhjuqlJ5G1M0qhIJGSIiqEjP/XdzziI=
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr20937078wml.138.1606086984696;
 Sun, 22 Nov 2020 15:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20201118194838.753436396@linutronix.de> <20201118204007.269943012@linutronix.de>
 <20201119093834.GH3306@suse.de> <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
 <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com>
 <20201119182843.GA2414@hirez.programming.kicks-ass.net> <87tutkolq1.fsf@nanos.tec.linutronix.de>
 <20201120092928.GA3021@hirez.programming.kicks-ass.net>
In-Reply-To: <20201120092928.GA3021@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 22 Nov 2020 15:16:12 -0800
X-Gmail-Original-Message-ID: <CALCETrWHzHXLKuD4JWxDyBULAuFivP55csFp=6feireZhianVw@mail.gmail.com>
Message-ID: <CALCETrWHzHXLKuD4JWxDyBULAuFivP55csFp=6feireZhianVw@mail.gmail.com>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 1:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
>

> As already stated, per-cpu page-tables would allow for a much saner kmap
> approach, but alas, x86 really can't sanely do that (the archs that have
> separate kernel and user page-tables could do this, and how we cursed
> x86 didn't have that when meltdown happened).
>
> [ and using fixmaps in the per-cpu memory space _could_ work, but is a
>   giant pain because then all accesses need GS prefix and blah... ]
>
> And I'm sure there's creative ways for other problems too, but yes, it's
> hard.
>
> Anyway, clearly I'm the only one that cares, so I'll just crawl back
> under my rock...

I'll poke my head out of the rock for a moment, though...

Several years ago, we discussed (in person at some conference IIRC)
having percpu pagetables to get sane kmaps, percpu memory, etc.  The
conclusion was that Linus thought the performance would suck and we
shouldn't do it.  Since then, though, we added really fancy
infrastructure for keeping track of a per-CPU list of recently used
mms and efficiently tracking when they need to be invalidated.  We
called these "ASIDs".  It would be fairly straightforward to have an
entire pgd for each (cpu, asid) pair.  Newly added second-level
(p4d/pud/whatever -- have I ever mentioned how much I dislike the
Linux pagetable naming conventions and folding tricks?) tables could
be lazily faulted in, and copies of the full 2kB mess would only be
neeced when a new (cpu,asid) is allocated because either a flush
happened while the mm was inactive on the CPU in question or because
the mm fell off the percpu cache.

The total overhead would be a bit more cache usage, 4kB * num cpus *
num ASIDs per CPU (or 8k for PTI), and a few extra page faults (max
num cpus * 256 per mm over the entire lifetime of that mm).  The
common case of a CPU switching back and forth between a small number
of mms would have no significant overhead.

On an unrelated note, what happens if you migrate_disable(), sleep for
a looooong time, and someone tries to offline your CPU?

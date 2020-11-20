Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5420E2BA62A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbgKTJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgKTJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:29:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A5AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 20 Nov 2020 01:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KnWHAuO/d7na5b0cDyX5jOiWukZojb1N5brkXlfYaXQ=; b=dE4QPEP4pDETcw4r21v+Q06SMs
        c4Mz7MNxnXchPKYlFMI2qc/c+vUJko74+sQ/IM9aLhYk8dYcJEkEtvOn3Xynv32v6WnwbBmCAPPvi
        d+cZiHWBAfX6APUu1ZUA5o1HeqV6iWTF7sBBuMloWPFHXfvlx/SCUn+Ts7AVQ9ODdJJzA8jfsZ5+k
        MmXp6MVKgdU3YPOfGdn/Gu/Nc0LKVK3W/TMJPjWeeL8tAD3gK5/AMQeCDb1SVocqi+BBsG+Bp3mGt
        sNTX08D8rCRefJRSfrTwtI7l0AcsOIH2SqwlICfkoK1+bRXsNGrUFVxBRc3yhIE8FLnw643WDHxJU
        H6ttX5Dw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kg2jR-00056M-Kw; Fri, 20 Nov 2020 09:29:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96425304D28;
        Fri, 20 Nov 2020 10:29:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 72147200E6202; Fri, 20 Nov 2020 10:29:28 +0100 (CET)
Date:   Fri, 20 Nov 2020 10:29:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
Message-ID: <20201120092928.GA3021@hirez.programming.kicks-ass.net>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.269943012@linutronix.de>
 <20201119093834.GH3306@suse.de>
 <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
 <CAHk-=wire3dzhHx=KiL_f5Rj0=1u9ustsa33QoR-F9-v-NU9Ng@mail.gmail.com>
 <20201119182843.GA2414@hirez.programming.kicks-ass.net>
 <87tutkolq1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tutkolq1.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 20, 2020 at 02:33:58AM +0100, Thomas Gleixner wrote:
> On Thu, Nov 19 2020 at 19:28, Peter Zijlstra wrote:
> > On Thu, Nov 19, 2020 at 09:23:47AM -0800, Linus Torvalds wrote:
> >> Because this is certainly not the only time migration limiting has
> >> come up, and no, it has absolutely nothing to do with per-cpu page
> >> tables being completely unacceptable.
> >
> > It is for this instance; but sure, it's come up before in other
> > contexts.
> 
> Indeed. And one of the really bad outcomes of this is that people are
> forced to use preempt_disable() to prevent migration which entails a
> slew of consequences:
> 
>      - Using spinlocks where it wouldn't be needed otherwise
>      - Spinwaiting instead of sleeping
>      - The whole crazyness of doing copy_to/from_user_in_atomic() along
>        with the necessary out of line error handling.
>      - ....
> 
> The introduction of per-cpu storage happened almost 20 years ago (2002)
> and still the only answer we have is preempt_disable().

IIRC the first time this migrate_disable() stuff came up was when Chris
Lameter did SLUB. Eventually he settled for that cmpxchg_double()
approach (which is somewhat similar to userspace rseq) which is vastly
superiour and wouldn't have happened had we provided migrate_disable().

As already stated, per-cpu page-tables would allow for a much saner kmap
approach, but alas, x86 really can't sanely do that (the archs that have
separate kernel and user page-tables could do this, and how we cursed
x86 didn't have that when meltdown happened).

[ and using fixmaps in the per-cpu memory space _could_ work, but is a
  giant pain because then all accesses need GS prefix and blah... ]

And I'm sure there's creative ways for other problems too, but yes, it's
hard.

Anyway, clearly I'm the only one that cares, so I'll just crawl back
under my rock...

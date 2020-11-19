Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF972B9264
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 13:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgKSMOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 07:14:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:34918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgKSMOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 07:14:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68312ABD6;
        Thu, 19 Nov 2020 12:14:16 +0000 (UTC)
Date:   Thu, 19 Nov 2020 12:14:13 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [patch V4 4/8] sched: Make migrate_disable/enable() independent
 of RT
Message-ID: <20201119121413.GI3306@suse.de>
References: <20201118194838.753436396@linutronix.de>
 <20201118204007.269943012@linutronix.de>
 <20201119093834.GH3306@suse.de>
 <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20201119111411.GL3121378@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 12:14:11PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 09:38:34AM +0000, Mel Gorman wrote:
> > On Wed, Nov 18, 2020 at 08:48:42PM +0100, Thomas Gleixner wrote:
> > > From: Thomas Gleixner <tglx@linutronix.de>
> > > 
> > > Now that the scheduler can deal with migrate disable properly, there is no
> > > real compelling reason to make it only available for RT.
> > > 
> > > There are quite some code pathes which needlessly disable preemption in
> > > order to prevent migration and some constructs like kmap_atomic() enforce
> > > it implicitly.
> > > 
> > > Making it available independent of RT allows to provide a preemptible
> > > variant of kmap_atomic() and makes the code more consistent in general.
> > > 
> > > FIXME: Rework the comment in preempt.h - Peter?
> > > 
> > 
> > I didn't keep up to date and there is clearly a dependency on patches in
> > tip for migrate_enable/migrate_disable . It's not 100% clear to me what
> > reworking you're asking for but then again, I'm not Peter!
> 
> He's talking about the big one: "Migrate-Disable and why it is
> undesired.".
> 

Ah yes, that makes more sense. I was thinking in terms of what is protected
but the PREEMPT_RT hazard is severe.

> I still hate all of this, and I really fear that with migrate_disable()
> available, people will be lazy and usage will increase :/
> 
> Case at hand is this series, the only reason we need it here is because
> per-cpu page-tables are expensive...
> 

I guessed, it was the only thing that made sense.

> I really do think we want to limit the usage and get rid of the implicit
> migrate_disable() in spinlock_t/rwlock_t for example.
> 
> AFAICT the scenario described there is entirely possible; and it has to
> show up for workloads that rely on multi-cpu bandwidth for correctness.
> 
> Switching from preempt_disable() to migrate_disable() hides the
> immediate / easily visible high priority latency, but you move the
> interference term into a place where it is much harder to detect, you
> don't lose the term, it stays in the system.
> 
> So no, I don't want to make the comment less scary. Usage is
> discouraged.

More scary then by adding this to the kerneldoc section for
migrate_disable?

* Usage of migrate_disable is heavily discouraged as it is extremely
* hazardous on PREEMPT_RT kernels and any usage needs to be heavily
* justified. Before even thinking about using this, read
* "Migrate-Disable and why it is undesired" in
* include/linux/preempt.h and include both a comment and document
* in the changelog why the use case is an exception.

It's not necessary for the current series because the interface hides
it and anyone poking at the internals of kmap_atomic probably should be
aware of the address space and TLB hazards associated with it. There are
few in-tree users and presumably any future preempt-rt related merges
already know why migrate_disable is required.

However, with the kerneldoc, there is no excuse for missing it for new
users that are not PREEMPT_RT-aware. It makes it easier to NAK/revert a
patch without proper justification similar to how undocumented usages of
memory barriers tend to get a poor reception.

-- 
Mel Gorman
SUSE Labs

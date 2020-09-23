Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD213275271
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 09:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgIWHsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 03:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIWHse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 03:48:34 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AB2C061755
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ium0r5qarBE5F8AFqZ70l2AvO11YU9QJd/DjtLUB3xo=; b=tUQV++5XV8zV5ePZpcP017lJCN
        v1t4G42DKhDM8LfTuFfNYtKTTGpqXnZ4YvPiYMh0LKkYD/olc435Jh6hzMsgRSkTirSAomW/Bwha2
        SSyTCuvsUEDUTnvlfk3gBQ96sD4BUe3t672Je9vOKdvaIJzCkpsgS1Lu0tkireHu7WRWWWYsoses/
        fgnh5uMtHvCRODNiMST+TwbnCU6WfFycrnvFr0qPsj2S7/VU4CvuZydyV6jQKcTxzrOCHD/H4jZLc
        kBAgxLyeuvq9YX0hbQP1FWelfQUaBuw1iFTuCY88Vz9ca8Em2ZvME6/vl1xa7hwo/grSbK/Qit3ie
        oZiAaENg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kKzVh-0008Eh-Po; Wed, 23 Sep 2020 07:48:18 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 57AE8303DA0;
        Wed, 23 Sep 2020 09:48:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27DAB2B7B7DF4; Wed, 23 Sep 2020 09:48:13 +0200 (CEST)
Date:   Wed, 23 Sep 2020 09:48:13 +0200
From:   peterz@infradead.org
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
Message-ID: <20200923074813.GT1362448@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.769861942@infradead.org>
 <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9g7aqjd.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:16:54PM +0200, Thomas Gleixner wrote:
> On Mon, Sep 21 2020 at 18:36, Peter Zijlstra wrote:

> > +/*
> > + * Migrate-Disable and why it is (strongly) undesired.
> > + *
> > + * The premise of the Real-Time schedulers we have on Linux
> > + * (SCHED_FIFO/SCHED_DEADLINE) is that M CPUs can/will run M tasks
> > + * concurrently, provided there are sufficient runnable tasks, also known as
> > + * work-conserving. For instance SCHED_DEADLINE tries to schedule the M
> > + * earliest deadline threads, and SCHED_FIFO the M highest priority threads.
> > + *
> > + * The correctness of various scheduling models depends on this, but is it
> > + * broken by migrate_disable() that doesn't imply preempt_disable(). Where
> > + * preempt_disable() implies an immediate priority ceiling, preemptible
> > + * migrate_disable() allows nesting.
> > + *
> > + * The worst case is that all tasks preempt one another in a migrate_disable()
> > + * region and stack on a single CPU. This then reduces the available bandwidth
> > + * to a single CPU. And since Real-Time schedulability theory considers the
> > + * Worst-Case only, all Real-Time analysis shall revert to single-CPU
> > + * (instantly solving the SMP analysis problem).
> 
> I'm telling you for years that SMP is the source of all evils and
> NR_CPUS=0 is the ultimate solution of all problems. Paul surely
> disagrees as he thinks that NR_CPUS<0 is the right thing to do.

Surely imaginary numbers are even better :-)

> But seriously, I completely understand your concern vs. schedulability
> theories, but those theories can neither deal well with preemption
> disable simply because you can create other trainwrecks when enough low
> priority tasks run long enough in preempt disabled regions in
> parallel.

Ah, no, those theories can deal with preemption disable perfectly fine.
The result is an increase in latency. It so happens we don't like that,
but that's our problem :-)

> The scheduler simply does not know ahead how long these
> sections will take and how many of them will run in parallel.

Ah, but the thing is, preempt_disable() does not limit concurrency.
Assuming idle CPUs, the waking task can always go elsewhere.

The thing with migrate_disable() OTOH is that even though there are idle
CPUs, we're actively prohibited from using them.

> The theories make some assumptions about preempt disable and consider it
> as temporary priority ceiling, but that's all assumptions as the bounds
> of these operations simply unknown.

Sure, that directly translates into unbounded (or rather of
non-deterministic duration) latencies, which are bad for determinism.
But the theory is fairly clear on this.

> > + * The reason we have it anyway.
> > + *
> > + * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
> > + * number of primitives into becoming preemptible, they would also allow
> > + * migration. This turns out to break a bunch of per-cpu usage. To this end,
> > + * all these primitives employ migirate_disable() to restore this implicit
> > + * assumption.
> > + *
> > + * This is a 'temporary' work-around at best. The correct solution is getting
> > + * rid of the above assumptions and reworking the code to employ explicit
> > + * per-cpu locking or short preempt-disable regions.
> 
> What timeframe are you envisioning for 'temporary'? I assume something
> which is closer to your retirement than to mine :)

I figured we'd put a WARN on per-cpu usage with only migrate_disable(),
under a Kconfig knob, much like how RCU-lockdep started, once all of
PREEMPT_RT has landed. Gotta keep busy, right :-)

> > + * The end goal must be to get rid of migrate_disable(), alternatively we need
> > + * a schedulability theory that does not depend on abritrary migration.
> 
> Finally something new the academics can twist their brain around :)

I'm sure they've been waiting for more work ;-)

> But as the kmap discussion has shown, the current situation of enforcing
> preempt disable even on a !RT kernel is not pretty either. I looked at
> quite some of the kmap_atomic() usage sites and the resulting
> workarounds for non-preemptability are pretty horrible especially if
> they do copy_from/to_user() or such in those regions. There is tons of
> other code which really only requires migrate disable.

Yes, I'm on that thread, I'll reply there as well, I really hate going
down that path without having a decent understanding of the
ramifications.

The more we spread this muck around, the deeper the hole we dig for
ourselves to climb out of.

The thing is, afaik the only theory that 'works' with migrate_disable()
is fully partitioned, but we break that by having cross CPU blocking
chains.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54FE28B5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388855AbgJLNSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388160AbgJLNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:18:33 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36A4C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Hq040/XyURZ/o35rdIX1Xf3tR4gho9qLt4e+CVUXi6s=; b=otYCoNU8KVVZR99rDkPv3IQcSQ
        am99wN1F4yjO6dNH4cNhzAzbGPeUwftB+ICE11bEW7i64rAPg1gZ4bPnIPPpt4vVyUfEbS6pJLqtB
        ReIg2h+n5SPEk1m4sBUwzQJ3iNK23Zlaj8gnOqgm+Il3H3+wLEoe4wlv9dAq1g/mc5x8CFwnu5amy
        yok/juvhvHhPvEKeqj0RG8yt7gv+4Yw/hbSjoxrhH4NlesDyrH6qr3CNcQcjWlYtc2EO3+rxjcAZO
        SgHlHMWakRUyT4qe4H3VBC7rM3Sy37k9PHEPh9s7ZLTKL22TyJ+xNYv/RgxonCNoB2pErYRCUmX/x
        TSTIaU5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kRxiV-0004Bg-Nq; Mon, 12 Oct 2020 13:18:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12F7B300DB4;
        Mon, 12 Oct 2020 15:18:18 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EB75F20116727; Mon, 12 Oct 2020 15:18:17 +0200 (CEST)
Date:   Mon, 12 Oct 2020 15:18:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        valentin.schneider@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 07/17] sched: Fix hotplug vs CPU bandwidth control
Message-ID: <20201012131817.GP2651@hirez.programming.kicks-ass.net>
References: <20201005145717.346020688@infradead.org>
 <20201005150921.661842442@infradead.org>
 <336a3916-1dd8-98cf-44e8-88dbf27018d5@arm.com>
 <20201012125200.GW2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125200.GW2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:52:00PM +0200, Peter Zijlstra wrote:
> On Fri, Oct 09, 2020 at 10:41:11PM +0200, Dietmar Eggemann wrote:
> > On 05/10/2020 16:57, Peter Zijlstra wrote:
> > > Since we now migrate tasks away before DYING, we should also move
> > > bandwidth unthrottle, otherwise we can gain tasks from unthrottle
> > > after we expect all tasks to be gone already.
> > > 
> > > Also; it looks like the RT balancers don't respect cpu_active() and
> > > instead rely on rq->online in part, complete this. This too requires
> > > we do set_rq_offline() earlier to match the cpu_active() semantics.
> > > (The bigger patch is to convert RT to cpu_active() entirely)
> > > 
> > > Since set_rq_online() is called from sched_cpu_activate(), place
> > > set_rq_offline() in sched_cpu_deactivate().
> 
> > [   76.215229] WARNING: CPU: 1 PID: 1913 at kernel/irq_work.c:95 irq_work_queue_on+0x108/0x110
> 
> > [   76.341076]  irq_work_queue_on+0x108/0x110
> > [   76.349185]  pull_rt_task+0x58/0x68
> > [   76.352673]  balance_rt+0x84/0x88
> 
> > balance_rt() checks via need_pull_rt_task() that rq is online but it
> > looks like that with RT_PUSH_IPI pull_rt_task() -> tell_cpu_to_push()
> > calls irq_work_queue_on() with cpu = rto_next_cpu(rq->rd) and this one
> > can be offline here as well now.
> 
> Hurmph... so if I read this right, we reach offline with overload set?
> 
> Oooh, I think I see how that happens..

I think the below two hunks need to be reverted from the patch. Can you
confirm?

--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2326,9 +2326,6 @@ static void rq_online_dl(struct rq *rq)
 /* Assumes rq->lock is held */
 static void rq_offline_dl(struct rq *rq)
 {
-	if (rq->dl.overloaded)
-		dl_clear_overload(rq);
-
 	cpudl_clear(&rq->rd->cpudl, rq->cpu);
 	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
 }
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2245,9 +2245,6 @@ static void rq_online_rt(struct rq *rq)
 /* Assumes rq->lock is held */
 static void rq_offline_rt(struct rq *rq)
 {
-	if (rq->rt.overloaded)
-		rt_clear_overload(rq);
-
 	__disable_runtime(rq);
 
 	cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_INVALID);

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9166F2DABCC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 12:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgLOLTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 06:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgLOLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 06:19:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF0C06179C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 03:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kXqNJfqsMhizlbjgk7UAR+OpnNOsmOAh6Kvk0nEO5bQ=; b=tvt1baH3yuSZ5jrcbM94bLsMSc
        cfoePGWSa2Jm1gRevRg+uo5nZIimAIS11mlQP5plBBfx5CxH8ApjrU+OoKWVwwzG2EdCUNt3M9C4E
        dkyki6zkpI0N8HjM/MyiE+X3WjYbmcDrGO3NrsLe0xf2UycwKjR7ol2bUT6gNqD+zxTkCYyU4wxFn
        ENY2rUHFMJP41XfFcYZ++BXykHtlj9Se6B456gI0FgtNhhMkbVIc8Wts440OLYPaYes9u4OUSEmv+
        JQedRB6o413rhCgqDJ+tNn6iPAnm+FxIYhieXH6OE7wHR1/AvfNViIhOkbFvQGSGxon8lFtNEfmd9
        mHo5JNnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kp8LK-0006GH-IZ; Tue, 15 Dec 2020 11:18:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1FD6D304D28;
        Tue, 15 Dec 2020 12:18:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BE70203C6489; Tue, 15 Dec 2020 12:18:07 +0100 (CET)
Date:   Tue, 15 Dec 2020 12:18:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] sched: Prevent raising SCHED_SOFTIRQ when CPU is !active
Message-ID: <20201215111806.GF3040@hirez.programming.kicks-ass.net>
References: <20201215104400.9435-1-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215104400.9435-1-anna-maria@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 11:44:00AM +0100, Anna-Maria Behnsen wrote:
> SCHED_SOFTIRQ is raised to trigger periodic load balancing. When CPU is not
> active, CPU should not participate in load balancing.
> 
> The scheduler uses nohz.idle_cpus_mask to keep track of the CPUs which can
> do idle load balancing. When bringing a CPU up the CPU is added to the mask
> when it reaches the active state, but on teardown the CPU stays in the mask
> until it goes offline and invokes sched_cpu_dying().
> 
> When SCHED_SOFTIRQ is raised on a !active CPU, there might be a pending
> softirq when stopping the tick which triggers a warning in NOHZ code. The
> SCHED_SOFTIRQ can also be raised by the scheduler tick which has the same
> issue.
> 
> Therefore remove the CPU from nohz.idle_cpus_mask when it is marked
> inactive and also prevent the scheduler_tick() from raising SCHED_SOFTIRQ
> after this point.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
>  kernel/sched/core.c | 7 ++++++-
>  kernel/sched/fair.c | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 21b548b69455..69284dc121d3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7492,6 +7492,12 @@ int sched_cpu_deactivate(unsigned int cpu)
>  	struct rq_flags rf;
>  	int ret;
>  
> +	/*
> +	 * Remove CPU from nohz.idle_cpus_mask to prevent participating in
> +	 * load balancing when not active
> +	 */
> +	nohz_balance_exit_idle(rq);
> +
>  	set_cpu_active(cpu, false);
>  	/*
>  	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU

OK, so we must clear the state before !active, because getting an
interrupt/softirq after would trigger the badness. And we're guaranteed
nothing blocks between them to re-set it.

That works I suppose.

Thanks!

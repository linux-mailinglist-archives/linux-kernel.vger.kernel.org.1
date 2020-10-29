Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6182F29F3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 18:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJ2Rzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 13:55:44 -0400
Received: from foss.arm.com ([217.140.110.172]:41836 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725777AbgJ2Rzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:55:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77E96139F;
        Thu, 29 Oct 2020 10:55:43 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 591DD3F66E;
        Thu, 29 Oct 2020 10:55:41 -0700 (PDT)
References: <20201023101158.088940906@infradead.org> <20201023102347.067278757@infradead.org> <jhjd011ov4y.mognet@arm.com> <20201029173409.GT2628@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 11/19] sched/core: Make migrate disable and CPU hotplug cooperative
In-reply-to: <20201029173409.GT2628@hirez.programming.kicks-ass.net>
Date:   Thu, 29 Oct 2020 17:55:34 +0000
Message-ID: <jhj7dr8q5m1.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/20 17:34, Peter Zijlstra wrote:
> On Thu, Oct 29, 2020 at 04:27:09PM +0000, Valentin Schneider wrote:
[...]
> Can do I suppose, although I'm no sure what, if anything that helps,
> because then we needs yet another comment explaining things.
>
> I ended up with the below. Is that an improvement?

I'm leaning towards "yes", but YMMV.

>
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3d7d5b7b9c99..c9c69511ece4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7226,11 +7226,19 @@ static void balance_push(struct rq *rq)
>  	lockdep_assert_held(&rq->lock);
>  	SCHED_WARN_ON(rq->cpu != smp_processor_id());
>  
> +	/*
> +	 * When migrate_disable(), we'll also have nr_pinned incremented due to
> +	 * this being the tail end of schedule(). Therefore we do not need to wake
> +	 * the hotplug_wait and go straight to jail^Wexit.
> +	 */
> +	if (is_migration_disabled(push_task))
> +		return;
> +
>  	/*
>  	 * Both the cpu-hotplug and stop task are in this case and are
>  	 * required to complete the hotplug process.
>  	 */
> -	if (is_per_cpu_kthread(push_task) || is_migration_disabled(push_task)) {
> +	if (is_per_cpu_kthread(push_task)) {
>  		/*
>  		 * If this is the idle task on the outgoing CPU try to wake
>  		 * up the hotplug control thread which might wait for the


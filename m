Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB48420FA25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390025AbgF3RIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 13:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgF3RIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:08:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4E0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6RvaZ6HYLRvAKD3a9BOgZ2QI0Vb9cyS65MB8Cxo+mxY=; b=cB1GP3AQYB1xjPe/bGVy/XyVLd
        1YYSPjv+SaRwEMOWgOIOtgsHy0+WzXSJtFLpnr/w0P4qtXTOAHZP6IIEtYHodqy3bckEBy+nK2t3/
        xJ9fokeR5EH9nxn3vT18pXsbKmTS3b3ycfHV5zCfDd24hqevEOBIV6zKSp3i3I/bLgtRGTvoMRl8C
        3OpWCZaqcNd9KxsfSzvR39LuRi64/HYu9WJ8KNgQ1pJzeSqSQaTnG5s4MvjKH5QAL7n7DhfXOdRg5
        +EBdK+LB4G5HRng3rlNJiBTD1Zqq69+9CeUh+WbWGm0FAwdfgm8/wOtseAI1BSm0dYkbDcSEWXHqn
        p35Lyc0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqJjf-0006Ob-Eb; Tue, 30 Jun 2020 17:07:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 511FF3011B2;
        Tue, 30 Jun 2020 19:07:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 19FAE213D7D64; Tue, 30 Jun 2020 19:07:51 +0200 (CEST)
Date:   Tue, 30 Jun 2020 19:07:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200630170751.GA4817@hirez.programming.kicks-ass.net>
References: <20200630112123.12076-1-qais.yousef@arm.com>
 <20200630112123.12076-3-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630112123.12076-3-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 12:21:23PM +0100, Qais Yousef wrote:
> @@ -993,10 +1013,38 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>  
>  	lockdep_assert_held(&rq->lock);
>  
> +	/*
> +	 * If sched_uclamp_used was enabled after task @p was enqueued,
> +	 * we could end up with unbalanced call to uclamp_rq_dec_id().
> +	 *
> +	 * In this case the uc_se->active flag should be false since no uclamp
> +	 * accounting was performed at enqueue time and we can just return
> +	 * here.
> +	 *
> +	 * Need to be careful of the following enqeueue/dequeue ordering
> +	 * problem too
> +	 *
> +	 *	enqueue(taskA)
> +	 *	// sched_uclamp_used gets enabled
> +	 *	enqueue(taskB)
> +	 *	dequeue(taskA)
> +	 *	// Must not decrement bukcet->tasks here
> +	 *	dequeue(taskB)
> +	 *
> +	 * where we could end up with stale data in uc_se and
> +	 * bucket[uc_se->bucket_id].
> +	 *
> +	 * The following check here eliminates the possibility of such race.
> +	 */
> +	if (unlikely(!uc_se->active))
> +		return;
> +
>  	bucket = &uc_rq->bucket[uc_se->bucket_id];
> +
>  	SCHED_WARN_ON(!bucket->tasks);
>  	if (likely(bucket->tasks))
>  		bucket->tasks--;
> +
>  	uc_se->active = false;
>  
>  	/*

> @@ -1221,6 +1289,8 @@ static void __setscheduler_uclamp(struct task_struct *p,
>  	if (likely(!(attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)))
>  		return;
>  
> +	static_branch_enable(&sched_uclamp_used);
> +
>  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
>  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
>  			      attr->sched_util_min, true);
> @@ -7387,6 +7457,8 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
>  	if (req.ret)
>  		return req.ret;
>  
> +	static_branch_enable(&sched_uclamp_used);
> +
>  	mutex_lock(&uclamp_mutex);
>  	rcu_read_lock();
>  

There's a fun race described in 9107c89e269d ("perf: Fix race between
event install and jump_labels"), are we sure this isn't also susceptible
to something similar?

I suspect not, but I just wanted to make sure.

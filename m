Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B97C62861CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgJGPHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgJGPHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E98C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NbX1ykHFrbFRcpkWX+4eB6loFXRWmEWCwz+tjsJAz6U=; b=B+4rgxdgN0gp1L0HpHtoaUsZ64
        OijsaAeHuqH7ss1toeabI1+RrXmbcVR98vhJ5lWP24NZ5CX9awhWowF9kupIFnomhGCArUXa2IjUX
        XRHr/mHd4BvT8MstyNQIiD36iUaGmbOCl5i4sKpuUpYF51/VDvHisOmfZC1ppUE1ho9sYjhRVSUkw
        8tIAqDEEz0Jfax+zHW1+7o1YrQseltCKtdbDaE5620RannmIkeSUVOg8OgU9ZyefomZxSnVxkLoRO
        JYjC1XVidAPf9ZNBGvSXUfdn5RLN2JHDl6d/uA5HvknWDpxrvlNbsZuuRmp7XFwT9EQDfyeZ3BK/a
        PAxCEQWg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQB21-0005fY-Gb; Wed, 07 Oct 2020 15:07:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9BCB53019CE;
        Wed,  7 Oct 2020 17:07:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 877DE2BC1621E; Wed,  7 Oct 2020 17:07:04 +0200 (CEST)
Date:   Wed, 7 Oct 2020 17:07:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] sched: membarrier: cover kthread_use_mm (v3)
Message-ID: <20201007150704.GH2628@hirez.programming.kicks-ass.net>
References: <20200924172508.8724-1-mathieu.desnoyers@efficios.com>
 <20200924172508.8724-3-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924172508.8724-3-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 01:25:07PM -0400, Mathieu Desnoyers wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..bab6f4f2809f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3736,6 +3736,8 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  	 */
>  	arch_start_context_switch(prev);
>  
> +	membarrier_switch_mm(rq, prev->mm, next->mm);
> +
>  	/*
>  	 * kernel -> kernel   lazy + transfer active
>  	 *   user -> kernel   lazy + mmgrab() active
> @@ -3752,7 +3754,6 @@ context_switch(struct rq *rq, struct task_struct *prev,
>  		else
>  			prev->active_mm = NULL;
>  	} else {                                        // to user
> -		membarrier_switch_mm(rq, prev->active_mm, next->mm);
>  		/*
>  		 * sys_membarrier() requires an smp_mb() between setting
>  		 * rq->curr / membarrier_switch_mm() and returning to userspace.

I was thinking... do we need the above, when:

> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index 8bc8b8a888b7..e5246580201b 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -112,13 +112,9 @@ static int membarrier_global_expedited(void)
>  		    MEMBARRIER_STATE_GLOBAL_EXPEDITED))
>  			continue;
>  
> -		/*
> -		 * Skip the CPU if it runs a kernel thread. The scheduler
> -		 * leaves the prior task mm in place as an optimization when
> -		 * scheduling a kthread.
> -		 */
> +		/* Skip the CPU if it runs the idle thread. */
>  		p = rcu_dereference(cpu_rq(cpu)->curr);
> -		if (p->flags & PF_KTHREAD)

We retain this in the form:

		if ((p->flags & PF_KTHREAD) && !p-mm)
			continue;

> +		if (is_idle_task(p))
>  			continue;
>  
>  		__cpumask_set_cpu(cpu, tmpmask);

Specifically, we only care about kthreads when they're between
kthread_use_mm() / kthread_unuse_mm(), and in that case they will have
updated state already.

It's too late in the day to be sure about the memory ordering though;
but if we see !->mm, they'll do/have-done switch_mm() which implies
sufficient barriers().

Hmm?

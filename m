Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F03D27838B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgIYJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgIYJFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:05:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF580C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2VfsxKk+lvb78Dy2zYBJ7EZ0K1Ur8Rj4+jrmVbK9eiM=; b=kuTiZaIufgjZLlPze2YeEahUXc
        rHmhyoulRiAVzPH4MbHnQm9riafnmEQ0dpz2BFRYcnq8qfX1hTla++0IJ4gWwEYQKnrc0mObao+2y
        +yJzZhHJTFwWOBOJgKECkORmKI73N4QWC0YTsWu25sxZ5F6VG0XPxR7mTDZJTHx7gTOX8+I8ZOB5N
        bBsyuIoPUOJZ0m2ZoGiVix6VHthau1BIWvN8p6K5PLst5huceENfVR+Upzeq/Cvm+vUwkq7mRNtid
        pd7ur4wAHUMvct83VS9qtjoVgiDJHdQZzDxaWdEeVSRaO6TUr7adcXBIEUm3LQGmR6VbkJFjYLH7J
        9mxzsLZA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLjfV-0001g7-Tc; Fri, 25 Sep 2020 09:05:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 71137300DB4;
        Fri, 25 Sep 2020 11:05:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 30CEB202075FD; Fri, 25 Sep 2020 11:05:28 +0200 (CEST)
Date:   Fri, 25 Sep 2020 11:05:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 8/9] sched: Fix migrate_disable() vs
 set_cpus_allowed_ptr()
Message-ID: <20200925090528.GV2628@hirez.programming.kicks-ass.net>
References: <20200921163557.234036895@infradead.org>
 <20200921163845.830487105@infradead.org>
 <jhj3637lzdm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj3637lzdm.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 08:59:33PM +0100, Valentin Schneider wrote:
> > @@ -2025,19 +2138,8 @@ static int __set_cpus_allowed_ptr(struct
> >       if (cpumask_test_cpu(task_cpu(p), new_mask))
> >               goto out;
> 
> I think this needs a cancellation of any potential pending migration
> requests. Consider a task P0 running on CPU0:
> 
>    P0                     P1                               P2
> 
>    migrate_disable();
>    <preempt>
>                           set_cpus_allowed_ptr(P0, CPU1);
>                           // waits for completion
>                                                            set_cpus_allowed_ptr(P0, CPU0);
>                                                            // Already good, no waiting for completion
>    <resumes>
>    migrate_enable();
>    // task_cpu(p) allowed, no move_task()
> 
> AIUI in this scenario P1 would stay forever waiting.

Hurmph, looking at it, I think you're right. But I'm fairly sure I did
test that, maybe I just didn't run it long enough to hit the window ...

> I *think* this can be
> cured by making this function slightly more hideous:

It's a real beauty isn't it :-/

> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 01113e6f941f..829334f00f7b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2102,6 +2102,8 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>                                   u32 flags)
>  {
>         const struct cpumask *cpu_valid_mask = cpu_active_mask;
> +	struct set_affinity_pending *pending;
> +	bool cancel_pending = false;
>         unsigned int dest_cpu;
>         struct rq_flags rf;
>         struct rq *rq;
> @@ -2158,14 +2160,20 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>         }
> 
>         /* Can the task run on the task's current CPU? If so, we're done */
> -	if (cpumask_test_cpu(task_cpu(p), new_mask))
> +	if (cpumask_test_cpu(task_cpu(p), new_mask)) {
> +		cancel_pending = true;
>                 goto out;
> +	}
> 
>         return move_task(rq, &rf, p, dest_cpu, flags);
> 
>  out:
> +	pending = p->migration_pending;
>         task_rq_unlock(rq, p, &rf);
> 
> +	if (cancel_pending && pending)
> +		complete_all(&pending->done);
> +
>         return ret;
>  }

He who completes pending should also clear ->migration_pending,
otherwise the next caller will be able to observe a dangling pointer.

The other approach is trying to handle that last condition in
move_task(), but I'm quite sure that's going to be aweful too :/



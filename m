Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3F5F2B34C5
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 13:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgKOMD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 07:03:59 -0500
Received: from m12-14.163.com ([220.181.12.14]:53150 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbgKOMD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 07:03:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=BHIgG
        /hTVQDJ46BC1d6/5nGrpx1PZb4joFvDuu33RZI=; b=onPfkHYGcy6TxA7J+alh5
        tDVWhmKhB29fcxX7HL3w50HnRke3IbSJZputsQHOa46wm8/W1YInMbSPSPJ5SU8a
        8UPyMItcpGtjSSuCJEWi1ZLG6Zg2A45BaBp1oWNNO5P682YElcg625zejWMJmLuc
        pP58MufmSrgTZqtI5gnMVM=
Received: from localhost (unknown [122.193.81.123])
        by smtp10 (Coremail) with SMTP id DsCowABndFAhGLFfo5a5Vw--.2891S2;
        Sun, 15 Nov 2020 19:59:30 +0800 (CST)
Date:   Sun, 15 Nov 2020 19:59:39 +0800
From:   Tao Zhou <t1zhou@163.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Qian Cai <cai@redhat.com>,
        bigeasy@linutronix.de, bristot@redhat.com, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@kernel.org, ouwen210@hotmail.com, peterz@infradead.org,
        qais.yousef@arm.com, rostedt@goodmis.org, swood@redhat.com,
        tglx@linutronix.de, tj@kernel.org, vincent.donnefort@arm.com,
        vincent.guittot@linaro.org, t1zhou@163.com
Subject: Re: [PATCH] sched/core: Add missing completion for
 affine_move_task() waiters
Message-ID: <20201115115849.GA6943@geo.homenetwork>
References: <20201113112414.2569-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113112414.2569-1-valentin.schneider@arm.com>
X-CM-TRANSID: DsCowABndFAhGLFfo5a5Vw--.2891S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4kZFW3GFW8KFWxKF4rKrg_yoW5Xw4kpr
        Z2g3WYkF47XryUt3yaqw4vkF15Z3s7Gr43GanxXryfCw43tFnFvr4FgF15urnI9rs7Cay7
        ZF1a9Fy7CFnYqrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRI4EiUUUUU=
X-Originating-IP: [122.193.81.123]
X-CM-SenderInfo: vwr2x0rx6rljoofrz/1tbiygLdllQHKLRqVgAAsw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 13, 2020 at 11:24:14AM +0000, Valentin Schneider wrote:

> Qian reported that some fuzzer issuing sched_setaffinity() ends up stuck on
> a wait_for_completion(). The problematic pattern seems to be:
>   affine_move_task()
>       // task_running() case
>       stop_one_cpu();
>       wait_for_completion(&pending->done);
> 
> Combined with, on the stopper side:
> 
>   migration_cpu_stop()
>     // Task moved between unlocks and scheduling the stopper
>     task_rq(p) != rq &&
>     // task_running() case
>     dest_cpu >= 0
> 
>     => no complete_all()
> 
> This can happen with both PREEMPT and !PREEMPT, although !PREEMPT should
> be more likely to see this given the targeted task has a much bigger window
> to block and be woken up elsewhere before the stopper runs.
> 
> Make migration_cpu_stop() always look at pending affinity requests; signal
> their completion if the stopper hits a rq mismatch but the task is
> still within its allowed mask. When Migrate-Disable isn't involved, this
> matches the previous set_cpus_allowed_ptr() vs migration_cpu_stop()
> behaviour.
> 
> Link: https://lore.kernel.org/lkml/8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com
> Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
> Reported-by: Qian Cai <cai@redhat.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
>  kernel/sched/core.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 02076e6d3792..fad0a8e62aca 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1923,7 +1923,7 @@ static int migration_cpu_stop(void *data)
>  		else
>  			p->wake_cpu = dest_cpu;
>  
> -	} else if (dest_cpu < 0) {
> +	} else if (dest_cpu < 0 || pending) {
>  		/*
>  		 * This happens when we get migrated between migrate_enable()'s
>  		 * preempt_enable() and scheduling the stopper task. At that
> @@ -1933,6 +1933,17 @@ static int migration_cpu_stop(void *data)
>  		 * more likely.
>  		 */
>  
> +		/*
> +		 * The task moved before the stopper got to run. We're holding
> +		 * ->pi_lock, so the allowed mask is stable - if it got
> +		 * somewhere allowed, we're done.
> +		 */
> +		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
> +			p->migration_pending = NULL;
> +			complete = true;
> +			goto out;
> +		}
> +
>  		/*
>  		 * When this was migrate_enable() but we no longer have an
>  		 * @pending, a concurrent SCA 'fixed' things and we should be
> -- 
> 2.27.0

Oh, I did not receive this patch from 'ouwen210@hotmail.com'
account. Checked that you sent the patch to that mail address
from web. If 'ouwen210' is not a good mail account name(I have
used this name since 2002), I will change to use this one(Now
is smooth enough and can go to lkml).

Thanks,
Tao


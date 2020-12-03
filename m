Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E038F2CD971
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389281AbgLCOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:40:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387666AbgLCOkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:40:40 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6374522799;
        Thu,  3 Dec 2020 14:39:58 +0000 (UTC)
Date:   Thu, 3 Dec 2020 09:39:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Xianting Tian <tian.xianting@h3c.com>
Cc:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <bsegall@google.com>,
        <mgorman@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/rt: Print curr when RT throttling activated
Message-ID: <20201203093956.6dd8a753@gandalf.local.home>
In-Reply-To: <20201203075129.17902-1-tian.xianting@h3c.com>
References: <20201203075129.17902-1-tian.xianting@h3c.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Dec 2020 15:51:29 +0800
Xianting Tian <tian.xianting@h3c.com> wrote:

> We may meet the issue, that one RT thread occupied the cpu by 950ms/1s,
> The RT thread maybe is a business thread or other unknown thread.
> 
> Currently, it only outputs the print "sched: RT throttling activated"
> when RT throttling happen. It is hard to know what is the RT thread,
> For further analysis, we need add more prints.
> 
> This patch is to print current RT task when RT throttling activated,
> It help us to know what is the RT thread in the first time.

I think this can be useful information to include.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> ---
>  kernel/sched/rt.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index f215eea6a..8913f38cb 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -946,7 +946,7 @@ static inline int rt_se_prio(struct sched_rt_entity *rt_se)
>  	return rt_task_of(rt_se)->prio;
>  }
>  
> -static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
> +static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq, struct task_struct *curr)
>  {
>  	u64 runtime = sched_rt_runtime(rt_rq);
>  
> @@ -970,7 +970,8 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
>  		 */
>  		if (likely(rt_b->rt_runtime)) {
>  			rt_rq->rt_throttled = 1;
> -			printk_deferred_once("sched: RT throttling activated\n");
> +			printk_deferred_once("sched: RT throttling activated (curr: pid %d, comm %s)\n",
> +						curr->pid, curr->comm);
>  		} else {
>  			/*
>  			 * In case we did anyway, make it go away,
> @@ -1026,7 +1027,7 @@ static void update_curr_rt(struct rq *rq)
>  		if (sched_rt_runtime(rt_rq) != RUNTIME_INF) {
>  			raw_spin_lock(&rt_rq->rt_runtime_lock);
>  			rt_rq->rt_time += delta_exec;
> -			if (sched_rt_runtime_exceeded(rt_rq))
> +			if (sched_rt_runtime_exceeded(rt_rq, curr))
>  				resched_curr(rq);
>  			raw_spin_unlock(&rt_rq->rt_runtime_lock);
>  		}


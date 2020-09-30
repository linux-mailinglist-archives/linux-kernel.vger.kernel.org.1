Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE44927DD5F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 02:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgI3A3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 20:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgI3A3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 20:29:20 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EACE2071E;
        Wed, 30 Sep 2020 00:29:18 +0000 (UTC)
Date:   Tue, 29 Sep 2020 20:29:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hui Su <sh_def@163.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt.c remove unnecessary parameter in
 pick_next_rt_entity
Message-ID: <20200929202916.7e26f4cb@oasis.local.home>
In-Reply-To: <20200929165640.GA28986@rlk>
References: <20200929165640.GA28986@rlk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 00:56:40 +0800
Hui Su <sh_def@163.com> wrote:

> struct rq is not necessary for pick_next_rt_entity(),
> we can get next sched_rt_entity just from struct rt_rq.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/rt.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index f215eea6a966..113965e1952c 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1593,11 +1593,9 @@ static inline void set_next_task_rt(struct rq *rq, struct task_struct *p, bool f
>  	rt_queue_push_tasks(rq);
>  }
>  
> -static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
> -						   struct rt_rq *rt_rq)
> +static struct sched_rt_entity *pick_next_rt_entity(struct rt_rq *rt_rq)
>  {
>  	struct rt_prio_array *array = &rt_rq->active;
> -	struct sched_rt_entity *next = NULL;
>  	struct list_head *queue;
>  	int idx;
>  
> @@ -1605,9 +1603,8 @@ static struct sched_rt_entity *pick_next_rt_entity(struct rq *rq,
>  	BUG_ON(idx >= MAX_RT_PRIO);
>  
>  	queue = array->queue + idx;
> -	next = list_entry(queue->next, struct sched_rt_entity, run_list);
>  
> -	return next;
> +	return list_entry(queue->next, struct sched_rt_entity, run_list);

The above code looks to be left over from a time that there was a goto
out; with out: being between the next = list_etry() and the return
next. This was removed back in 2008 with commit 326587b84078 ("sched:
fix goto retry in pick_next_task_rt()").

The above looks fine to me.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


>  }
>  
>  static struct task_struct *_pick_next_task_rt(struct rq *rq)
> @@ -1616,7 +1613,7 @@ static struct task_struct *_pick_next_task_rt(struct rq *rq)
>  	struct rt_rq *rt_rq  = &rq->rt;
>  
>  	do {
> -		rt_se = pick_next_rt_entity(rq, rt_rq);
> +		rt_se = pick_next_rt_entity(rt_rq);
>  		BUG_ON(!rt_se);
>  		rt_rq = group_rt_rq(rt_se);
>  	} while (rt_rq);


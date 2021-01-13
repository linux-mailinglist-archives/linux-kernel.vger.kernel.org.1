Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E952F5526
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 00:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbhAMXP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 18:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729378AbhAMWj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:39:57 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204BD23136;
        Wed, 13 Jan 2021 22:38:45 +0000 (UTC)
Date:   Wed, 13 Jan 2021 17:38:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Hui Su <sh_def@163.com>, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: use task_current() instead of 'rq->curr == p'
Message-ID: <20210113173843.19227a86@gandalf.local.home>
In-Reply-To: <20201030173223.GA52339@rlk>
References: <20201030173223.GA52339@rlk>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter,

This is a simple clean up patch that makes sense to me. Want to take it?

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


On Sat, 31 Oct 2020 01:32:23 +0800
Hui Su <sh_def@163.com> wrote:

> We have supplied the macro: 'task_current()', and we should
> all use task_current() instaed of 'rq->curr == p',
> which is more readable.
> 
> No functional change.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/deadline.c | 2 +-
>  kernel/sched/debug.c    | 2 +-
>  kernel/sched/fair.c     | 6 +++---
>  kernel/sched/rt.c       | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f232305dcefe..3b335be97952 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2474,7 +2474,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  static void prio_changed_dl(struct rq *rq, struct task_struct *p,
>  			    int oldprio)
>  {
> -	if (task_on_rq_queued(p) || rq->curr == p) {
> +	if (task_on_rq_queued(p) || task_current(rq, p)) {
>  #ifdef CONFIG_SMP
>  		/*
>  		 * This might be too much, but unfortunately
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 0655524700d2..1ca554f10901 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -486,7 +486,7 @@ static char *task_group_path(struct task_group *tg)
>  static void
>  print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
>  {
> -	if (rq->curr == p)
> +	if (task_current(rq, p))
>  		SEQ_printf(m, ">R");
>  	else
>  		SEQ_printf(m, " %c", task_state_to_char(p));
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e38378c..c3e3ae76302e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5399,7 +5399,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
>  		s64 delta = slice - ran;
>  
>  		if (delta < 0) {
> -			if (rq->curr == p)
> +			if (task_current(rq, p))
>  				resched_curr(rq);
>  			return;
>  		}
> @@ -10740,7 +10740,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
>  	 * our priority decreased, or if we are not currently running on
>  	 * this runqueue and our priority is higher than the current's
>  	 */
> -	if (rq->curr == p) {
> +	if (task_current(rq, p)) {
>  		if (p->prio > oldprio)
>  			resched_curr(rq);
>  	} else
> @@ -10873,7 +10873,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
>  		 * kick off the schedule if running, otherwise just see
>  		 * if we can still preempt the current task.
>  		 */
> -		if (rq->curr == p)
> +		if (task_current(rq, p))
>  			resched_curr(rq);
>  		else
>  			check_preempt_curr(rq, p, 0);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 49ec096a8aa1..cd615aace14c 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2317,7 +2317,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
>  	if (!task_on_rq_queued(p))
>  		return;
>  
> -	if (rq->curr == p) {
> +	if (task_current(rq, p)) {
>  #ifdef CONFIG_SMP
>  		/*
>  		 * If our priority decreases while running, we


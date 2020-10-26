Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ECA299551
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 19:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1789785AbgJZS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 14:29:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:35788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1789777AbgJZS37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 14:29:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9F820756;
        Mon, 26 Oct 2020 18:29:58 +0000 (UTC)
Date:   Mon, 26 Oct 2020 14:29:56 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Hui Su <sh_def@163.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/rt.c: use list_is_singular() instead of '->prev
 != ->next'
Message-ID: <20201026142956.0a429137@gandalf.local.home>
In-Reply-To: <20201026174152.GA10163@rlk>
References: <20201026174152.GA10163@rlk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020 01:41:52 +0800
Hui Su <sh_def@163.com> wrote:

> Use the list_is_singular(&rt_se->run_list) api instead of
> 'rt_se->run_list.prev != rt_se->run_list.next'.
> Fix a comment by the way, and make the comment more clearly.
> 
> Signed-off-by: Hui Su <sh_def@163.com>
> ---
>  kernel/sched/rt.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 49ec096a8aa1..1479d00656b4 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2381,7 +2381,7 @@ static inline void watchdog(struct rq *rq, struct task_struct *p) { }
>   *
>   * NOTE: This function can be called remotely by the tick offload that
>   * goes along full dynticks. Therefore no local assumption can be made
> - * and everything must be accessed through the @rq and @curr passed in
> + * and everything must be accessed through the @rq and @p passed in
>   * parameters.
>   */
>  static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
> @@ -2406,11 +2406,11 @@ static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued)
>  	p->rt.time_slice = sched_rr_timeslice;
>  
>  	/*
> -	 * Requeue to the end of queue if we (and all of our ancestors) are not
> -	 * the only element on the queue
> +	 * Requeue to the end of rt_prio_array queue if we (and all of our
> +	 * ancestors) are not the only element on the rt_prio_array queue.
>  	 */
>  	for_each_sched_rt_entity(rt_se) {
> -		if (rt_se->run_list.prev != rt_se->run_list.next) {
> +		if (!list_is_singular(&rt_se->run_list)) {

Perhaps there should be a list_has_more_than_one() API, as list_is_singular
requires two checks, and the "more_than_one" only requires a single check.

list_is_singular() is:

		return !list_empty(list) && (list->next == list->prev);


which is more work than what you are replacing.

-- Steve


>  			requeue_task_rt(rq, p, 0);
>  			resched_curr(rq);
>  			return;


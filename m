Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D3D1B136C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDTRog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 13:44:36 -0400
Received: from foss.arm.com ([217.140.110.172]:52878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:44:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 675BA31B;
        Mon, 20 Apr 2020 10:44:33 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03DBB3F73D;
        Mon, 20 Apr 2020 10:44:31 -0700 (PDT)
References: <cover.1587393807.git.yu.c.chen@intel.com> <4f301770996c02f44d52a4868f510025d5a3a558.1587393807.git.yu.c.chen@intel.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][v2] sched: Extract the task putting code from pick_next_task()
In-reply-to: <4f301770996c02f44d52a4868f510025d5a3a558.1587393807.git.yu.c.chen@intel.com>
Date:   Mon, 20 Apr 2020 18:44:29 +0100
Message-ID: <jhjy2qqkq6a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/04/20 16:01, Chen Yu wrote:
> Introduce a new function finish_prev_task() to do the balance
> when necessary, and then put previous task back to the run queue.
> This function is extracted from pick_next_task() to prepare for
> future usage by other type of task picking logic.
>
> No functional change.
>

With the absolutely tiny nit below:

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
>  kernel/sched/core.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a61a3b8eaa9..bf59a5cf030c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
>       schedstat_inc(this_rq()->sched_count);
>  }
>
> +static void finish_prev_task(struct rq *rq, struct task_struct *prev,
> +			     struct rq_flags *rf)
> +{
> +	const struct sched_class *class;
> +#ifdef CONFIG_SMP

Nit: I would've put that declaration within the ifdef, given it isn't used
outside of it.

> +	/*
> +	 * We must do the balancing pass before put_next_task(), such
> +	 * that when we release the rq->lock the task is in the same
> +	 * state as before we took rq->lock.
> +	 *
> +	 * We can terminate the balance pass as soon as we know there is
> +	 * a runnable task of @class priority or higher.
> +	 */
> +	for_class_range(class, prev->sched_class, &idle_sched_class) {
> +		if (class->balance(rq, prev, rf))
> +			break;
> +	}
> +#endif
> +
> +	put_prev_task(rq, prev);
> +}
> +
>  /*
>   * Pick up the highest-prio task:
>   */

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94922B04F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgKLMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:30:04 -0500
Received: from foss.arm.com ([217.140.110.172]:49070 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgKLMaE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:30:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54FD0101E;
        Thu, 12 Nov 2020 04:30:03 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6CA6B3F718;
        Thu, 12 Nov 2020 04:30:01 -0800 (PST)
References: <20201112111201.2081902-1-qperret@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "open list\:SCHEDULER" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Rick Yiu <rickyiu@google.com>
Subject: Re: [PATCH] sched/fair: Fix overutilized update in enqueue_task_fair()
In-reply-to: <20201112111201.2081902-1-qperret@google.com>
Date:   Thu, 12 Nov 2020 12:29:59 +0000
Message-ID: <jhjh7puyczc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Quentin,

On 12/11/20 11:12, Quentin Perret wrote:
> enqueue_task_fair() attempts to skip the overutilized update for new
> tasks as their util_avg is not accurate yet. However, the flag we check
> to do so is overwritten earlier on in the function, which makes the
> condition pretty much a nop.
>
> Fix this by saving the flag early on.
>
> Fixes: 2802bf3cd936 ("sched/fair: Add over-utilization/tipping point
> indicator")
> Reported-by: Rick Yiu <rickyiu@google.com>
> Signed-off-by: Quentin Perret <qperret@google.com>

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

Alternatively: how much does not updating the overutilized status here help
us? The next tick will unconditionally update it, which for arm64 is
anywhere in the next ]0, 4]ms. That "fake" fork-time util_avg should already
be accounted in the rq util_avg, and even if the new task was running the
entire time, 4ms doesn't buy us much decay.

> ---
>  kernel/sched/fair.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 290f9e38378c..f3ee60b92718 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5477,6 +5477,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>       struct cfs_rq *cfs_rq;
>       struct sched_entity *se = &p->se;
>       int idle_h_nr_running = task_has_idle_policy(p);
> +	int task_new = !(flags & ENQUEUE_WAKEUP);
>
>       /*
>        * The code below (indirectly) updates schedutil which looks at
> @@ -5549,7 +5550,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>        * into account, but that is not straightforward to implement,
>        * and the following generally works well enough in practice.
>        */
> -	if (flags & ENQUEUE_WAKEUP)
> +	if (!task_new)
>               update_overutilized_status(rq);
>
>  enqueue_throttle:

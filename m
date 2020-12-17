Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A975B2DD639
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 18:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgLQR3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 12:29:16 -0500
Received: from foss.arm.com ([217.140.110.172]:48450 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729341AbgLQR3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 12:29:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D50031B;
        Thu, 17 Dec 2020 09:28:29 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCDBC3F66E;
        Thu, 17 Dec 2020 09:28:25 -0800 (PST)
Subject: Re: [PATCH v2] fair/util_est: fix schedutil may use an old
 util_est.enqueued value at dequeue
To:     Xuewen Yan <xuewen.yan94@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        Xuewen.Yan@unisoc.com, Ke.Wang@unisoc.com, xuewyan@foxmail.com,
        zhang.lyra@gmail.com, patrick.bellasi@arm.com
References: <1608094223-22564-1-git-send-email-xuewen.yan94@gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f509539d-6a4e-e74f-1b1a-8563e5c39d28@arm.com>
Date:   Thu, 17 Dec 2020 18:28:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1608094223-22564-1-git-send-email-xuewen.yan94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2020 05:50, Xuewen Yan wrote:
> From: Xuewen Yan <xuewen.yan@unisoc.com>
> 
> when a task dequeued, it would update it's util and cfs_rq's util,
> the following calling relationship exists here:
> 
> update_load_avg() -> cfs_rq_util_change() -> cpufreq_update_util()->
> sugov_update_[shared\|single] -> sugov_get_util() -> cpu_util_cfs();
> 
> util = max {rq->cfs.avg.util_avg,rq->cfs.avg.util_est.enqueued };
> 
> For those tasks alternate long and short runs scenarios, the
> rq->cfs.avg.util_est.enqueued may be bigger than rq->cfs.avg.util_avg.
> but because the _task_util_est(p) didn't be subtracted, this would
> cause schedutil use an old util_est.enqueued value.
> 
> This could have an effect in task ramp-down and ramp-up scenarios.
> when the task dequeued, we hope the freq could be reduced as soon
> as possible. If the schedutil's value is the old util_est.enqueued, this
> may cause the cpu couldn't reduce it's freq.
> 
> separate the util_est_dequeue() into util_est_dequeue() and
> util_est_update(), and dequeue the _task_util_est(p) before update util.

IMHO we could still describe it a little bit different:

---

sched/fair: Avoid stale CPU util_est value for schedutil in task dequeue


CPU (root cfs_rq) estimated utilization (util_est) is currently used in
dequeue_task_fair() to drive frequency selection before it is updated.


with:

CPU_util        : rq->cfs.avg.util_avg
CPU_util_est    : rq->cfs.avg.util_est
CPU_utilization : max(CPU_util, CPU_util_est)
task_util       : p->se.avg.util_avg
task_util_est   : p->se.avg.util_est

dequeue_task_fair()

    /* (1) CPU_util and task_util update + inform schedutil about
           CPU_utilization changes */
    for_each_sched_entity() /* 2 loops */
        (dequeue_entity() ->) update_load_avg() -> cfs_rq_util_change()
         -> cpufreq_update_util() ->...-> sugov_update_[shared\|single]
         -> sugov_get_util() -> cpu_util_cfs()

    /* (2) CPU_util_est and task_util_est update */
    util_est_dequeue()


cpu_util_cfs() uses CPU_utilization which could lead to a false (too
high) utilization value for schedutil in task ramp-down or ramp-up
scenarios during task dequeue.

To mitigate the issue split the util_est update (2) into:

 (A) CPU_util_est update in util_est_dequeue()
 (B) task_util_est update in util_est_update()

Place (A) before (1) and keep (B) where (2) is. The latter is necessary
since (B) relies on task_util update in (1).

---

What do you think?

> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Please remove my Signed-off-by line. I'm just reviewing & testing it.

With the comments below adressed you can change it to a:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

> ---
> Changes since v1:
> -change the util_est_dequeue/update to inline type
> -use unsigned int enqueued rather than util_est in util_est_dequeue
> -remove "cpu" var
> 
> ---
>  kernel/sched/fair.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae7ceba..864d6b9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3945,22 +3945,31 @@ static inline bool within_margin(int value, int margin)
>  	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
>  }
>  
> -static void
> -util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> +static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
> +				struct task_struct *p)

Could you move util_est_dequeue above within_margin() since the later is
only used in util_est_update().

>  {
> -	long last_ewma_diff;
> -	struct util_est ue;
> -	int cpu;
> +	unsigned int enqueued;
>  
>  	if (!sched_feat(UTIL_EST))
>  		return;
>  
>  	/* Update root cfs_rq's estimated utilization */
> -	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
> -	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
> -	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
> +	enqueued  = cfs_rq->avg.util_est.enqueued;
> +	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
> +	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
>  
>  	trace_sched_util_est_cfs_tp(cfs_rq);
> +}
> +
> +static inline void util_est_update(struct cfs_rq *cfs_rq,
> +				struct task_struct *p,
> +				bool task_sleep)

Nitpick: util_est_enqueue() aligns the arguments on space whereas you do
on tab for util_est_dequeue and util_est_update. I know there is no
strict rule but IMHO these util_est_xxx() should use the same.

[...]

During review I got suspicious about the 'if (sched_feat(UTIL_EST))'
condition in cpu_util_without() mentioning a race window w/
[detach_task() p->on_rq = TASK_ON_RQ_MIGRATING <-> util_est_dequeue()].

But this patch should actually make this window smaller.

Anyway, retested commit c469933e7721 ("sched/fair: Fix cpu_util_wake()
for 'execl' type workloads") with unixbench execl test on E5-2690 (40
CPUs) and didn't spot any regression.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEEF2DB32E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 19:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgLOSAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 13:00:51 -0500
Received: from foss.arm.com ([217.140.110.172]:55142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgLOSAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 13:00:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F0BE830E;
        Tue, 15 Dec 2020 09:59:45 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F1CE3F66E;
        Tue, 15 Dec 2020 09:59:43 -0800 (PST)
Subject: Re: [PATCH] fair/util_est: Separate util_est_dequeue() for
 cfs_rq_util_change
To:     Xuewen Yan <xuewen.yan94@gmail.com>, patrick.bellasi@arm.com,
        vincent.guittot@linaro.org, peterz@infradead.org
Cc:     mingo@redhat.com, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, Xuewen.Yan@unisoc.com,
        xuewyan@foxmail.com
References: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <d79da8c3-4904-c21f-9c7a-190ab6d12948@arm.com>
Date:   Tue, 15 Dec 2020 18:59:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1607510656-22990-1-git-send-email-xuewen.yan@unisoc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2020 11:44, Xuewen Yan wrote:
> when a task dequeued, it will update it's util, and cfs_rq_util_change
> would check rq's util, if the cfs_rq->avg.util_est.enqueued is bigger
> than  cfs_rq->avg.util_avg, but because the cfs_rq->avg.util_est.enqueued
> didn't be decreased, this would cause bigger cfs_rq_util by mistake,
> as a result, cfs_rq_util_change may change freq unreasonablely.
> 
> separate the util_est_dequeue() into util_est_dequeue() and
> util_est_update(), and dequeue the _task_util_est(p) before update util.

I assume this patch header needs a little more substance so that less
involved folks understand the issue as well. Describing the testcase
which reveals the problem would help here too. 

> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  kernel/sched/fair.c | 24 +++++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ae7ceba..20ecfd5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3946,11 +3946,9 @@ static inline bool within_margin(int value, int margin)
>  }
>  
>  static void
> -util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> +util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p)

Not sure why util_est_enqueue is inline and util_est_dequeue() and
util_est_update() aren't?

>  {
> -	long last_ewma_diff;
>  	struct util_est ue;

You would just need a 'unsigned int enqueued' here, like in util_est_enqueue().

> -	int cpu;
>  
>  	if (!sched_feat(UTIL_EST))
>  		return;
> @@ -3961,6 +3959,17 @@ static inline bool within_margin(int value, int margin)
>  	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
>  
>  	trace_sched_util_est_cfs_tp(cfs_rq);
> +}
> +
> +static void
> +util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
> +{
> +	long last_ewma_diff;
> +	struct util_est ue;
> +	int cpu;

Nitpick: 'int cpu' not needed

---8<---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c3685a743a76..53dfb20d101e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3956,28 +3956,28 @@ static inline bool within_margin(int value, int margin)
 	return ((unsigned int)(value + margin - 1) < (2 * margin - 1));
 }
 
-static void
-util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p)
+static inline void util_est_dequeue(struct cfs_rq *cfs_rq,
+				    struct task_struct *p)
 {
-	struct util_est ue;
+	unsigned int enqueued;
 
 	if (!sched_feat(UTIL_EST))
 		return;
 
 	/* Update root cfs_rq's estimated utilization */
-	ue.enqueued  = cfs_rq->avg.util_est.enqueued;
-	ue.enqueued -= min_t(unsigned int, ue.enqueued, _task_util_est(p));
-	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, ue.enqueued);
+	enqueued  = cfs_rq->avg.util_est.enqueued;
+	enqueued -= min_t(unsigned int, enqueued, _task_util_est(p));
+	WRITE_ONCE(cfs_rq->avg.util_est.enqueued, enqueued);
 
 	trace_sched_util_est_cfs_tp(cfs_rq);
 }
 
-static void
-util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
+static inline void util_est_update(struct cfs_rq *cfs_rq,
+				   struct task_struct *p,
+				   bool task_sleep)
 {
 	long last_ewma_diff;
 	struct util_est ue;
-	int cpu;
 
 	if (!sched_feat(UTIL_EST))
 		return;
@@ -4021,8 +4021,7 @@ util_est_update(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	 * To avoid overestimation of actual task utilization, skip updates if
 	 * we cannot grant there is idle time in this CPU.
 	 */
-	cpu = cpu_of(rq_of(cfs_rq));
-	if (task_util(p) > capacity_orig_of(cpu))
+	if (task_util(p) > capacity_orig_of(cpu_of(rq_of(cfs_rq))))
 		return;
 
 	/*
-- 
2.17.1

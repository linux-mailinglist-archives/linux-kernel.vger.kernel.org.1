Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 738D12DCD10
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgLQHsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 02:48:43 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57013 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgLQHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 02:48:43 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UIuSawz_1608191190;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UIuSawz_1608191190)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 17 Dec 2020 15:46:30 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     bsegall@google.com, changhuaixin@linux.alibaba.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com, mgorman@suse.de,
        mingo@redhat.com, pauld@redhead.com, peterz@infradead.org,
        pjt@google.com, rostedt@goodmis.org, vincent.guittot@linaro.org,
        khlebnikov@yandex-team.ru, xiyou.wangcong@gmail.com,
        shanpeic@linux.alibaba.com
Subject: [PATCH 2/4] sched/fair: Make CFS bandwidth controller burstable
Date:   Thu, 17 Dec 2020 15:46:18 +0800
Message-Id: <20201217074620.58338-3-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accumulate unused quota from previous periods, thus accumulated
bandwidth runtime can be used in the following periods. During
accumulation, take care of runtime overflow. Previous non-burstable
CFS bandwidth controller only assign quota to runtime, that saves a lot.

A sysctl parameter sysctl_sched_cfs_bw_burst_onset_percent is introduced to
denote how many percent of burst is given on setting cfs bandwidth. By
default it is 0, which means on burst is allowed unless accumulated.

Also, parameter sysctl_sched_cfs_bw_burst_enabled is introduced as a
switch for burst. It is enabled by default.

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
---
 include/linux/sched/sysctl.h |  2 ++
 kernel/sched/core.c          | 31 +++++++++++++++++++++++++----
 kernel/sched/fair.c          | 46 ++++++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h         |  4 ++--
 kernel/sysctl.c              | 18 +++++++++++++++++
 5 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 3c31ba88aca5..3400828eaf2d 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -72,6 +72,8 @@ extern unsigned int sysctl_sched_uclamp_util_min_rt_default;
 
 #ifdef CONFIG_CFS_BANDWIDTH
 extern unsigned int sysctl_sched_cfs_bandwidth_slice;
+extern unsigned int sysctl_sched_cfs_bw_burst_onset_percent;
+extern unsigned int sysctl_sched_cfs_bw_burst_enabled;
 #endif
 
 #ifdef CONFIG_SCHED_AUTOGROUP
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 48d3bad12be2..71cced83df2f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -66,6 +66,16 @@ const_debug unsigned int sysctl_sched_features =
  */
 const_debug unsigned int sysctl_sched_nr_migrate = 32;
 
+#ifdef CONFIG_CFS_BANDWIDTH
+/*
+ * Percent of burst assigned to cfs_b->runtime on tg_set_cfs_bandwidth,
+ * 0 by default.
+ */
+unsigned int sysctl_sched_cfs_bw_burst_onset_percent;
+
+unsigned int sysctl_sched_cfs_bw_burst_enabled = 1;
+#endif
+
 /*
  * period over which we measure -rt task CPU usage in us.
  * default: 1s
@@ -7891,7 +7901,7 @@ static DEFINE_MUTEX(cfs_constraints_mutex);
 const u64 max_cfs_quota_period = 1 * NSEC_PER_SEC; /* 1s */
 static const u64 min_cfs_quota_period = 1 * NSEC_PER_MSEC; /* 1ms */
 /* More than 203 days if BW_SHIFT equals 20. */
-static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
+const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
@@ -7900,7 +7910,7 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-	u64 buffer;
+	u64 buffer, burst_onset;
 
 	if (tg == &root_task_group)
 		return -EINVAL;
@@ -7961,11 +7971,24 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 	cfs_b->burst = burst;
 	cfs_b->buffer = buffer;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
+	cfs_b->max_overrun = DIV_ROUND_UP_ULL(max_cfs_runtime, quota);
+	cfs_b->runtime = cfs_b->quota;
+
+	/* burst_onset needed */
+	if (cfs_b->quota != RUNTIME_INF &&
+			sysctl_sched_cfs_bw_burst_enabled &&
+			sysctl_sched_cfs_bw_burst_onset_percent > 0) {
+
+		burst_onset = burst / 100 *
+			sysctl_sched_cfs_bw_burst_onset_percent;
+
+		cfs_b->runtime += burst_onset;
+		cfs_b->runtime = min(max_cfs_runtime, cfs_b->runtime);
+	}
 
 	/* Restart the period timer (if active) to handle new period expiry: */
 	if (runtime_enabled)
-		start_cfs_bandwidth(cfs_b);
+		start_cfs_bandwidth(cfs_b, 1);
 
 	raw_spin_unlock_irq(&cfs_b->lock);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6bb4f89259fd..38a726f77783 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4598,10 +4598,22 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  *
  * requires cfs_b->lock
  */
-void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
+void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b, u64 overrun)
 {
-	if (cfs_b->quota != RUNTIME_INF)
-		cfs_b->runtime = cfs_b->quota;
+	u64 refill;
+
+	if (cfs_b->quota != RUNTIME_INF) {
+
+		if (!sysctl_sched_cfs_bw_burst_enabled) {
+			cfs_b->runtime = cfs_b->quota;
+			return;
+		}
+
+		overrun = min(overrun, cfs_b->max_overrun);
+		refill = cfs_b->quota * overrun;
+		cfs_b->runtime += refill;
+		cfs_b->runtime = min(cfs_b->runtime, cfs_b->buffer);
+	}
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
@@ -4623,7 +4635,7 @@ static int __assign_cfs_rq_runtime(struct cfs_bandwidth *cfs_b,
 	if (cfs_b->quota == RUNTIME_INF)
 		amount = min_amount;
 	else {
-		start_cfs_bandwidth(cfs_b);
+		start_cfs_bandwidth(cfs_b, 0);
 
 		if (cfs_b->runtime > 0) {
 			amount = min(cfs_b->runtime, min_amount);
@@ -4957,7 +4969,7 @@ static int do_sched_cfs_period_timer(struct cfs_bandwidth *cfs_b, int overrun, u
 	if (cfs_b->idle && !throttled)
 		goto out_deactivate;
 
-	__refill_cfs_bandwidth_runtime(cfs_b);
+	__refill_cfs_bandwidth_runtime(cfs_b, overrun);
 
 	if (!throttled) {
 		/* mark as potentially idle for the upcoming period */
@@ -5181,6 +5193,7 @@ static enum hrtimer_restart sched_cfs_slack_timer(struct hrtimer *timer)
 }
 
 extern const u64 max_cfs_quota_period;
+extern const u64 max_cfs_runtime;
 
 static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 {
@@ -5210,7 +5223,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
 			new = old * 2;
 			if (new < max_cfs_quota_period) {
 				cfs_b->period = ns_to_ktime(new);
-				cfs_b->quota *= 2;
+				cfs_b->quota = min(cfs_b->quota * 2,
+						max_cfs_runtime);
+
+				cfs_b->buffer = min(max_cfs_runtime,
+						cfs_b->quota + cfs_b->burst);
+				/* Add 1 in case max_overrun becomes 0. */
+				cfs_b->max_overrun >>= 1;
+				cfs_b->max_overrun++;
 
 				pr_warn_ratelimited(
 	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
@@ -5259,16 +5279,26 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
 }
 
-void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
+void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b, int init)
 {
+	u64 overrun;
+
 	lockdep_assert_held(&cfs_b->lock);
 
 	if (cfs_b->period_active)
 		return;
 
 	cfs_b->period_active = 1;
-	hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
+	overrun = hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
 	hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
+
+	/*
+	 * When period timer stops, quota for the following period is not
+	 * refilled, however period timer is already forwarded. We should
+	 * accumulate quota once more than overrun here.
+	 */
+	if (!init)
+		__refill_cfs_bandwidth_runtime(cfs_b, overrun + 1);
 }
 
 static void destroy_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a8772eca8cbb..ff8b5382485d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -366,6 +366,7 @@ struct cfs_bandwidth {
 	u64			runtime;
 	u64			burst;
 	u64			buffer;
+	u64			max_overrun;
 	s64			hierarchical_quota;
 
 	u8			idle;
@@ -476,8 +477,7 @@ extern void init_tg_cfs_entry(struct task_group *tg, struct cfs_rq *cfs_rq,
 			struct sched_entity *parent);
 extern void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
 
-extern void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b);
-extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b);
+extern void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b, int init);
 extern void unthrottle_cfs_rq(struct cfs_rq *cfs_rq);
 
 extern void free_rt_sched_group(struct task_group *tg);
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..291dca62a571 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1842,6 +1842,24 @@ static struct ctl_table kern_table[] = {
 		.proc_handler	= proc_dointvec_minmax,
 		.extra1		= SYSCTL_ONE,
 	},
+	{
+		.procname	= "sched_cfs_bw_burst_onset_percent",
+		.data		= &sysctl_sched_cfs_bw_burst_onset_percent,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= &one_hundred,
+	},
+	{
+		.procname	= "sched_cfs_bw_burst_enabled",
+		.data		= &sysctl_sched_cfs_bw_burst_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 #endif
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 	{
-- 
2.14.4.44.g2045bb6


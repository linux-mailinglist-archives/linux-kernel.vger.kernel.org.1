Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2498E2FE86B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 12:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbhAULJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 06:09:55 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56687 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729698AbhAULFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 06:05:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=changhuaixin@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0UMQXykY_1611227101;
Received: from localhost(mailfrom:changhuaixin@linux.alibaba.com fp:SMTPD_---0UMQXykY_1611227101)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 21 Jan 2021 19:05:01 +0800
From:   Huaixin Chang <changhuaixin@linux.alibaba.com>
To:     changhuaixin@linux.alibaba.com
Cc:     bsegall@google.com, dietmar.eggemann@arm.com,
        juri.lelli@redhat.com, khlebnikov@yandex-team.ru,
        linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
        pauld@redhead.com, peterz@infradead.org, pjt@google.com,
        rostedt@goodmis.org, shanpeic@linux.alibaba.com,
        vincent.guittot@linaro.org, xiyou.wangcong@gmail.com
Subject: [PATCH v3 1/4] sched/fair: Introduce primitives for CFS bandwidth burst
Date:   Thu, 21 Jan 2021 19:04:50 +0800
Message-Id: <20210121110453.18899-2-changhuaixin@linux.alibaba.com>
X-Mailer: git-send-email 2.14.4.44.g2045bb6
In-Reply-To: <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
References: <20201217074620.58338-1-changhuaixin@linux.alibaba.com>
 <20210121110453.18899-1-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In this patch, we introduce the notion of CFS bandwidth burst. Unused
"quota" from pervious "periods" might be accumulated and used in the
following "periods". The maximum amount of accumulated bandwidth is
bounded by "burst". And the maximun amount of CPU a group can consume in
a given period is "buffer" which is equivalent to "quota" + "burst in
case that this group has done enough accumulation.

Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
---
 kernel/sched/core.c  | 91 ++++++++++++++++++++++++++++++++++++++++++++--------
 kernel/sched/fair.c  |  2 ++
 kernel/sched/sched.h |  2 ++
 3 files changed, 82 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e453492cff..48d3bad12be2 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7895,10 +7895,12 @@ static const u64 max_cfs_runtime = MAX_BW * NSEC_PER_USEC;
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
-static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
+static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
+							u64 burst)
 {
 	int i, ret = 0, runtime_enabled, runtime_was_enabled;
 	struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
+	u64 buffer;
 
 	if (tg == &root_task_group)
 		return -EINVAL;
@@ -7925,6 +7927,16 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	if (quota != RUNTIME_INF && quota > max_cfs_runtime)
 		return -EINVAL;
 
+	/*
+	 * Bound burst to defend burst against overflow during bandwidth shift.
+	 */
+	if (burst > max_cfs_runtime)
+		return -EINVAL;
+
+	if (quota == RUNTIME_INF)
+		buffer = RUNTIME_INF;
+	else
+		buffer = min(max_cfs_runtime, quota + burst);
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
@@ -7946,6 +7958,8 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 	raw_spin_lock_irq(&cfs_b->lock);
 	cfs_b->period = ns_to_ktime(period);
 	cfs_b->quota = quota;
+	cfs_b->burst = burst;
+	cfs_b->buffer = buffer;
 
 	__refill_cfs_bandwidth_runtime(cfs_b);
 
@@ -7979,9 +7993,10 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota)
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	burst = tg->cfs_bandwidth.burst;
 	if (cfs_quota_us < 0)
 		quota = RUNTIME_INF;
 	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
@@ -7989,7 +8004,7 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 	else
 		return -EINVAL;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_quota(struct task_group *tg)
@@ -8007,15 +8022,16 @@ static long tg_get_cfs_quota(struct task_group *tg)
 
 static int tg_set_cfs_period(struct task_group *tg, long cfs_period_us)
 {
-	u64 quota, period;
+	u64 quota, period, burst;
 
 	if ((u64)cfs_period_us > U64_MAX / NSEC_PER_USEC)
 		return -EINVAL;
 
 	period = (u64)cfs_period_us * NSEC_PER_USEC;
 	quota = tg->cfs_bandwidth.quota;
+	burst = tg->cfs_bandwidth.burst;
 
-	return tg_set_cfs_bandwidth(tg, period, quota);
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
 }
 
 static long tg_get_cfs_period(struct task_group *tg)
@@ -8028,6 +8044,35 @@ static long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
+static int tg_set_cfs_burst(struct task_group *tg, long cfs_burst_us)
+{
+	u64 quota, period, burst;
+
+	period = ktime_to_ns(tg->cfs_bandwidth.period);
+	quota = tg->cfs_bandwidth.quota;
+	if (cfs_burst_us < 0)
+		burst = RUNTIME_INF;
+	else if ((u64)cfs_burst_us <= U64_MAX / NSEC_PER_USEC)
+		burst = (u64)cfs_burst_us * NSEC_PER_USEC;
+	else
+		return -EINVAL;
+
+	return tg_set_cfs_bandwidth(tg, period, quota, burst);
+}
+
+static long tg_get_cfs_burst(struct task_group *tg)
+{
+	u64 burst_us;
+
+	if (tg->cfs_bandwidth.burst == RUNTIME_INF)
+		return -1;
+
+	burst_us = tg->cfs_bandwidth.burst;
+	do_div(burst_us, NSEC_PER_USEC);
+
+	return burst_us;
+}
+
 static s64 cpu_cfs_quota_read_s64(struct cgroup_subsys_state *css,
 				  struct cftype *cft)
 {
@@ -8052,6 +8097,18 @@ static int cpu_cfs_period_write_u64(struct cgroup_subsys_state *css,
 	return tg_set_cfs_period(css_tg(css), cfs_period_us);
 }
 
+static s64 cpu_cfs_burst_read_s64(struct cgroup_subsys_state *css,
+				  struct cftype *cft)
+{
+	return tg_get_cfs_burst(css_tg(css));
+}
+
+static int cpu_cfs_burst_write_s64(struct cgroup_subsys_state *css,
+				   struct cftype *cftype, s64 cfs_burst_us)
+{
+	return tg_set_cfs_burst(css_tg(css), cfs_burst_us);
+}
+
 struct cfs_schedulable_data {
 	struct task_group *tg;
 	u64 period, quota;
@@ -8204,6 +8261,11 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_cfs_period_read_u64,
 		.write_u64 = cpu_cfs_period_write_u64,
 	},
+	{
+		.name = "cfs_burst_us",
+		.read_s64 = cpu_cfs_burst_read_s64,
+		.write_s64 = cpu_cfs_burst_write_s64,
+	},
 	{
 		.name = "stat",
 		.seq_show = cpu_cfs_stat_show,
@@ -8324,26 +8386,27 @@ static int cpu_weight_nice_write_s64(struct cgroup_subsys_state *css,
 #endif
 
 static void __maybe_unused cpu_period_quota_print(struct seq_file *sf,
-						  long period, long quota)
+					long period, long quota, long burst)
 {
 	if (quota < 0)
 		seq_puts(sf, "max");
 	else
 		seq_printf(sf, "%ld", quota);
 
-	seq_printf(sf, " %ld\n", period);
+	seq_printf(sf, " %ld %ld\n", period, burst);
 }
 
-/* caller should put the current value in *@periodp before calling */
+/* caller should put the current value in *@periodp and *@burstp before calling */
 static int __maybe_unused cpu_period_quota_parse(char *buf,
-						 u64 *periodp, u64 *quotap)
+					 u64 *periodp, u64 *quotap, u64 *burstp)
 {
 	char tok[21];	/* U64_MAX */
 
-	if (sscanf(buf, "%20s %llu", tok, periodp) < 1)
+	if (sscanf(buf, "%20s %llu %llu", tok, periodp, burstp) < 1)
 		return -EINVAL;
 
 	*periodp *= NSEC_PER_USEC;
+	*burstp *= NSEC_PER_USEC;
 
 	if (sscanf(tok, "%llu", quotap))
 		*quotap *= NSEC_PER_USEC;
@@ -8360,7 +8423,8 @@ static int cpu_max_show(struct seq_file *sf, void *v)
 {
 	struct task_group *tg = css_tg(seq_css(sf));
 
-	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg));
+	cpu_period_quota_print(sf, tg_get_cfs_period(tg), tg_get_cfs_quota(tg),
+			tg_get_cfs_burst(tg));
 	return 0;
 }
 
@@ -8369,12 +8433,13 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 {
 	struct task_group *tg = css_tg(of_css(of));
 	u64 period = tg_get_cfs_period(tg);
+	u64 burst = tg_get_cfs_burst(tg);
 	u64 quota;
 	int ret;
 
-	ret = cpu_period_quota_parse(buf, &period, &quota);
+	ret = cpu_period_quota_parse(buf, &period, &quota, &burst);
 	if (!ret)
-		ret = tg_set_cfs_bandwidth(tg, period, quota);
+		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
 	return ret ?: nbytes;
 }
 #endif
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba8fd4f..6bb4f89259fd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5242,6 +5242,8 @@ void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
 	cfs_b->runtime = 0;
 	cfs_b->quota = RUNTIME_INF;
 	cfs_b->period = ns_to_ktime(default_cfs_period());
+	cfs_b->burst = 0;
+	cfs_b->buffer = RUNTIME_INF;
 
 	INIT_LIST_HEAD(&cfs_b->throttled_cfs_rq);
 	hrtimer_init(&cfs_b->period_timer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfcea92e..a8772eca8cbb 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -364,6 +364,8 @@ struct cfs_bandwidth {
 	ktime_t			period;
 	u64			quota;
 	u64			runtime;
+	u64			burst;
+	u64			buffer;
 	s64			hierarchical_quota;
 
 	u8			idle;
-- 
2.14.4.44.g2045bb6


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6BE1E02BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 22:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbgEXUaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 May 2020 16:30:01 -0400
Received: from outbound-smtp49.blacknight.com ([46.22.136.233]:53171 "EHLO
        outbound-smtp49.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728357AbgEXUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 16:30:00 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp49.blacknight.com (Postfix) with ESMTPS id 8C118FA97D
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:29:57 +0100 (IST)
Received: (qmail 3179 invoked from network); 24 May 2020 20:29:57 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 24 May 2020 20:29:57 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jirka Hladky <jhladky@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/2] sched: Offload wakee task activation if it the wakee is descheduling
Date:   Sun, 24 May 2020 21:29:56 +0100
Message-Id: <20200524202956.27665-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200524202956.27665-1-mgorman@techsingularity.net>
References: <20200524202956.27665-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch "sched: Optimize ttwu() spinning on p->on_cpu" avoids spinning
on p->on_rq when the task is descheduling but only if the wakee is on
a CPU that does not share cache with the waker. This patch offloads the
activation of the wakee to the CPU that is about to go idle if the task
is the only one on the runqueue. This potentially allows the waker task
to continue making progress when the wakeup is not strictly synchronous.

This is very obvious with netperf UDP_STREAM running on localhost. The
waker is sending packets as quickly as possible without waiting for any
reply. It frequently wakes the server for the processing of packets and
when netserver is using local memory, it quickly completes the processing
and goes back to idle. The waker often observes that netserver is on_rq
and spins excessively leading to a drop in throughput.

This is a comparison of 5.7-rc6 against "sched: Optimize ttwu() spinning
on p->on_cpu" and against this patch labeled vanilla, optttwu-v1r1 and
localwakelist-v1r2 respectively.

                                  5.7.0-rc6              5.7.0-rc6              5.7.0-rc6
                                    vanilla           optttwu-v1r1     localwakelist-v1r2
Hmean     send-64         251.49 (   0.00%)      258.05 *   2.61%*      305.59 *  21.51%*
Hmean     send-128        497.86 (   0.00%)      519.89 *   4.43%*      600.25 *  20.57%*
Hmean     send-256        944.90 (   0.00%)      997.45 *   5.56%*     1140.19 *  20.67%*
Hmean     send-1024      3779.03 (   0.00%)     3859.18 *   2.12%*     4518.19 *  19.56%*
Hmean     send-2048      7030.81 (   0.00%)     7315.99 *   4.06%*     8683.01 *  23.50%*
Hmean     send-3312     10847.44 (   0.00%)    11149.43 *   2.78%*    12896.71 *  18.89%*
Hmean     send-4096     13436.19 (   0.00%)    13614.09 (   1.32%)    15041.09 *  11.94%*
Hmean     send-8192     22624.49 (   0.00%)    23265.32 *   2.83%*    24534.96 *   8.44%*
Hmean     send-16384    34441.87 (   0.00%)    36457.15 *   5.85%*    35986.21 *   4.48%*

Note that this benefit is not universal to all wakeups, it only applies
to the case where the waker often spins on p->on_rq.

The impact can be seen from a "perf sched latency" report generated from
a single iteration of one packet size.

 -----------------------------------------------------------------------------------------------------------------
  Task                  |   Runtime ms  | Switches | Average delay ms | Maximum delay ms | Maximum delay at       |
 -----------------------------------------------------------------------------------------------------------------

vanilla
  netperf:4337          |  21709.193 ms |     2932 | avg:    0.002 ms | max:    0.041 ms | max at:    112.154512 s
  netserver:4338        |  14629.459 ms |  5146990 | avg:    0.001 ms | max: 1615.864 ms | max at:    140.134496 s

localwakelist-v1r2
  netperf:4339          |  29789.717 ms |     2460 | avg:    0.002 ms | max:    0.059 ms | max at:    138.205389 s
  netserver:4340        |  18858.767 ms |  7279005 | avg:    0.001 ms | max:    0.362 ms | max at:    135.709683 s
 -----------------------------------------------------------------------------------------------------------------

Note that the average wakeup delay is quite small on both the vanilla
kernel and with the two patches applied. However, there are significant
outliers with the vanilla kernel with the maximum one measured as 1615
milliseconds with a vanilla kernel but never worse than 0.362 ms with
both patches applied and a much higher rate of context switching.

Similarly a separate profile of cycles showed that 2.83% of all cycles
were spent in try_to_wake_up() with almost half of the cycles spent
on spinning on p->on_rq. With the two patches, the percentage of cycles
spent in try_to_wake_up() drops to 1.13%

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/core.c  | 41 ++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h |  3 ++-
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 987b8ecf2ee9..cdf0da1dcc05 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2330,13 +2330,19 @@ void scheduler_ipi(void)
 	irq_exit();
 }
 
-static void __ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+/*
+ * Queue a task on the target CPUs wake_list and wake the CPU via IPI if
+ * necessary. The wakee CPU on receipt of the IPI will queue the task
+ * via sched_ttwu_wakeup() for activation so the wakee incurs the cost
+ * of the wakeup instead of the waker.
+ */
+static void __ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
 	struct rq *rq = cpu_rq(cpu);
 
 	p->sched_remote_wakeup = !!(wake_flags & WF_MIGRATED);
 
-	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
+	if (llist_add(&p->wake_entry, &rq->wake_list)) {
 		if (!set_nr_if_polling(rq->idle))
 			smp_send_reschedule(cpu);
 		else
@@ -2373,11 +2379,32 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
 	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
 }
 
-static bool ttwu_queue_remote(struct task_struct *p, int cpu, int wake_flags)
+static inline bool ttwu_queue_cond(int cpu, int wake_flags)
+{
+	/*
+	 * If the CPU does not share cache, then queue the task on the
+	 * remote rqs wakelist to avoid accessing remote data.
+	 */
+	if (!cpus_share_cache(smp_processor_id(), cpu))
+		return true;
+
+	/*
+	 * If the task is descheduling and the only running task on the
+	 * CPU then use the wakelist to offload the task activation to
+	 * the soon-to-be-idle CPU as the current CPU is likely busy.
+	 * nr_running is checked to avoid unnecessary task stacking.
+	 */
+	if ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)
+		return true;
+
+	return false;
+}
+
+static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
-	if (sched_feat(TTWU_QUEUE) && !cpus_share_cache(smp_processor_id(), cpu)) {
+	if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
 		sched_clock_cpu(cpu); /* Sync clocks across CPUs */
-		__ttwu_queue_remote(p, cpu, wake_flags);
+		__ttwu_queue_wakelist(p, cpu, wake_flags);
 		return true;
 	}
 
@@ -2391,7 +2418,7 @@ static void ttwu_queue(struct task_struct *p, int cpu, int wake_flags)
 	struct rq_flags rf;
 
 #if defined(CONFIG_SMP)
-	if (ttwu_queue_remote(p, cpu, wake_flags))
+	if (ttwu_queue_wakelist(p, cpu, wake_flags))
 		return;
 #endif
 
@@ -2611,7 +2638,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * let the waker make forward progress. This is safe because IRQs are
 	 * disabled and the IPI will deliver after on_cpu is cleared.
 	 */
-	if (READ_ONCE(p->on_cpu) && ttwu_queue_remote(p, cpu, wake_flags))
+	if (READ_ONCE(p->on_cpu) && ttwu_queue_wakelist(p, cpu, wake_flags | WF_ON_RQ))
 		goto unlock;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index db3a57675ccf..06297d1142a0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1688,7 +1688,8 @@ static inline int task_on_rq_migrating(struct task_struct *p)
  */
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
-#define WF_MIGRATED		0x4		/* Internal use, task got migrated */
+#define WF_MIGRATED		0x04		/* Internal use, task got migrated */
+#define WF_ON_RQ		0x08		/* Wakee is on_rq */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
-- 
2.26.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6F02D0CCE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgLGJQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:16:59 -0500
Received: from outbound-smtp61.blacknight.com ([46.22.136.249]:55951 "EHLO
        outbound-smtp61.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726138AbgLGJQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:16:59 -0500
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp61.blacknight.com (Postfix) with ESMTPS id DA1B1FAB8B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 09:16:09 +0000 (GMT)
Received: (qmail 14772 invoked from network); 7 Dec 2020 09:16:09 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.22.4])
  by 81.17.254.9 with ESMTPA; 7 Dec 2020 09:16:09 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Ziljstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] sched/fair: Avoid revisiting CPUs multiple times during select_idle_sibling
Date:   Mon,  7 Dec 2020 09:15:16 +0000
Message-Id: <20201207091516.24683-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201207091516.24683-1-mgorman@techsingularity.net>
References: <20201207091516.24683-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

select_idle_core() potentially searches a number of CPUs for idle candidates
before select_idle_cpu() clears the mask and revisits the same CPUs. This
patch moves the initialisation of select_idle_mask to the top-level and
reuses the same mask across both select_idle_core and select_idle_cpu.
select_idle_smt() is left alone as the cost of checking one SMT sibling
is marginal relative to calling __clear_cpumask_cpu() for every CPU
visited by select_idle_core().

With tbench on a 2-socket CascadeLake machine, 80 logical CPUs, HT enabled

                          5.10.0-rc6             5.10.0-rc6
                        altrecent-v2          singlepass-v2
Hmean     1        502.05 (   0.00%)      498.53 *  -0.70%*
Hmean     2        983.65 (   0.00%)      982.33 *  -0.13%*
Hmean     4       1920.24 (   0.00%)     1929.34 *   0.47%*
Hmean     8       3663.96 (   0.00%)     3536.94 *  -3.47%*
Hmean     16      6545.58 (   0.00%)     6560.21 *   0.22%*
Hmean     32     10253.73 (   0.00%)    10374.30 *   1.18%*
Hmean     64     12506.31 (   0.00%)    11692.26 *  -6.51%*
Hmean     128    21967.13 (   0.00%)    21705.80 *  -1.19%*
Hmean     256    21534.52 (   0.00%)    21223.50 *  -1.44%*
Hmean     320    21070.14 (   0.00%)    21023.31 *  -0.22%*

As before, results are somewhat workload and machine-specific with a mix
of good and bad. For example, netperf UDP_STREAM on an 80-cpu Broadwell
machine shows;

                                 5.10.0-rc6             5.10.0-rc6
                               altrecent-v2          singlepass-v2
Hmean     send-64         232.78 (   0.00%)      258.02 *  10.85%*
Hmean     send-128        464.69 (   0.00%)      511.53 *  10.08%*
Hmean     send-256        904.72 (   0.00%)      999.40 *  10.46%*
Hmean     send-1024      3512.08 (   0.00%)     3868.86 *  10.16%*
Hmean     send-2048      6777.61 (   0.00%)     7435.05 *   9.70%*
Hmean     send-3312     10352.45 (   0.00%)    11321.43 *   9.36%*
Hmean     send-4096     12660.58 (   0.00%)    13577.08 *   7.24%*
Hmean     send-8192     19240.36 (   0.00%)    21321.34 *  10.82%*
Hmean     send-16384    29691.27 (   0.00%)    31296.47 *   5.41%*

The real question is -- is it better to scan CPU runqueues just once
where possible or scan multiple times? This patch scans once but it must
do additional work to track that scanning so for shallow scans it's a
loss and or deep scans, it's a win.

The main downside to this patch is that cpumask manipulations are
more complex because two cpumasks are involved. The alternative is that
select_idle_core() would scan the full domain and always return a CPU which
was previously considered. Alternatively, the depth of select_idle_core()
could be limited. Similarly, select_idle_core() often scans when no idle
core is available as test_idle_cores is very race-prone and maybe there
is a better approach to determining if select_idle_core() is likely to
succeed or not.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 00c3b526a5bd..3b1736dc5bde 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6064,10 +6064,11 @@ void __update_idle_core(struct rq *rq)
  * there are no idle cores left in the system; tracked through
  * sd_llc->shared->has_idle_cores and enabled through update_idle_core() above.
  */
-static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_core(struct task_struct *p, struct sched_domain *sd,
+					int target, struct cpumask *cpus_scan)
 {
 	int idle_candidate = -1;
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	struct cpumask *cpus;
 	int core, cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
@@ -6076,12 +6077,21 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	if (!test_idle_cores(target, false))
 		return -1;
 
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	/*
+	 * Repurpose load_balance_mask to avoid rescanning cores while
+	 * cpus_scan tracks the cpu if select_idle_cpu() is necessary.
+	 * In this context, it should be impossible to enter LB and
+	 * clobber load_balance_mask.
+	 */
+	cpus = this_cpu_cpumask_var_ptr(load_balance_mask);
+	cpumask_copy(cpus, cpus_scan);
 
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
+			__cpumask_clear_cpu(cpu, cpus_scan);
+
 			if (!available_idle_cpu(cpu)) {
 				idle = false;
 				break;
@@ -6130,7 +6140,8 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 
 #else /* CONFIG_SCHED_SMT */
 
-static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
+static inline int select_idle_core(struct task_struct *p, struct sched_domain *sd,
+					int target, struct cpumask *cpus)
 {
 	return -1;
 }
@@ -6147,9 +6158,9 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
  * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
  * average idle time for this rq (as found in rq->avg_idle).
  */
-static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
+static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd,
+				int target, struct cpumask *cpus)
 {
-	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	struct sched_domain *this_sd;
 	u64 avg_cost, avg_idle;
 	u64 time;
@@ -6176,9 +6187,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 	}
 
 	time = cpu_clock(this);
-
-	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
-
 	for_each_cpu_wrap(cpu, cpus, target) {
 		if (!--nr)
 			return -1;
@@ -6240,6 +6248,7 @@ static inline bool asym_fits_capacity(int task_util, int cpu)
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd;
+	struct cpumask *cpus_scan;
 	unsigned long task_util;
 	int i, recent_used_cpu;
 
@@ -6319,11 +6328,20 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	if (!sd)
 		return target;
 
-	i = select_idle_core(p, sd, target);
+	/*
+	 * Init the select_idle_mask. select_idle_core() will mask
+	 * out the CPUs that have already been limited to limit the
+	 * search in select_idle_cpu(). Further clearing is not
+	 * done as select_idle_smt checks only one CPU.
+	 */
+	cpus_scan = this_cpu_cpumask_var_ptr(select_idle_mask);
+	cpumask_and(cpus_scan, sched_domain_span(sd), p->cpus_ptr);
+
+	i = select_idle_core(p, sd, target, cpus_scan);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-	i = select_idle_cpu(p, sd, target);
+	i = select_idle_cpu(p, sd, target, cpus_scan);
 	if ((unsigned)i < nr_cpumask_bits)
 		return i;
 
-- 
2.26.2


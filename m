Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E35D42B34FF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 14:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgKONBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 08:01:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35262 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726863AbgKONBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 08:01:38 -0500
Date:   Sun, 15 Nov 2020 13:00:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605445295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pnQyTI1tBI/RcJUtDwnYXCZ4IfJWf8Uit307BI2dtFY=;
        b=qayVM0qP5hozXA+hJj76wbxZQNH7wVp29fxaS5wxGdVDMf7VpBM2gnD2Upwb4unrsDwVWO
        2cYr5mS39vkHkvwP+syIPpyVg/3UiMkRMBd60QOJu2pxITDyV0yOMiSLTzBNbhxkkINYXk
        qjIj/7qCd8jq5u7EKFFtqgPHg38gYN6lXkV8/d0rrJPYUvAGZMBPVd2sjSM3vfvX9zLKb8
        xhyAJeNVhMO4UsunXuJFotDTLe4ErvvcIxUkNupTgr0rSHUadTBloVyNZus6iz7no1nOxA
        UCJfNdKKuCyzj+5y3X6vn+N03PzeiBnRSrZY+X/oVNz15GacoCv2JJeE2e6vSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605445295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pnQyTI1tBI/RcJUtDwnYXCZ4IfJWf8Uit307BI2dtFY=;
        b=rqILnreyHZ0HzOwpPZCZb3mXL3GXlbg/9gJ5Bs1KYxbQ7OsNxgKoTcgzttzXGh8pciLdSY
        ZLtsHYY/EVYPd6DQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.10-rc4
References: <160544524024.25051.12292089189937197323.tglx@nanos>
Message-ID: <160544524266.25051.13876494098346280672.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-2020-11-15

up to:  8d4d9c7b4333: sched/debug: Fix memory corruption caused by multiple small reads of flags


A set of scheduler fixes:

 - Address a load balancer regression by making the load balancer use the
   same logic as the wakeup path to spread tasks in the LLC domain.

 - Prefer the CPU on which a task run last over the local CPU in the fast
   wakeup path for asymmetric CPU capacity systems to align with the
   symmetric case. This ensures more locality and prevents massive
   migration overhead on those asymetric systems

 - Fix a memory corruption bug in the scheduler debug code caused by
   handing a modified buffer pointer to kfree().

Thanks,

	tglx

------------------>
Colin Ian King (1):
      sched/debug: Fix memory corruption caused by multiple small reads of flags

Vincent Guittot (2):
      sched/fair: Ensure tasks spreading in LLC during LB
      sched/fair: Prefer prev cpu in asymmetric wakeup path


 kernel/sched/debug.c | 12 ++++-----
 kernel/sched/fair.c  | 70 +++++++++++++++++++++++++++++++++-------------------
 2 files changed, 51 insertions(+), 31 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 0655524700d2..2357921580f9 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -251,7 +251,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 	unsigned long flags = *(unsigned long *)table->data;
 	size_t data_size = 0;
 	size_t len = 0;
-	char *tmp;
+	char *tmp, *buf;
 	int idx;
 
 	if (write)
@@ -269,17 +269,17 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 		return 0;
 	}
 
-	tmp = kcalloc(data_size + 1, sizeof(*tmp), GFP_KERNEL);
-	if (!tmp)
+	buf = kcalloc(data_size + 1, sizeof(*buf), GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
 		char *name = sd_flag_debug[idx].name;
 
-		len += snprintf(tmp + len, strlen(name) + 2, "%s ", name);
+		len += snprintf(buf + len, strlen(name) + 2, "%s ", name);
 	}
 
-	tmp += *ppos;
+	tmp = buf + *ppos;
 	len -= *ppos;
 
 	if (len > *lenp)
@@ -294,7 +294,7 @@ static int sd_ctl_doflags(struct ctl_table *table, int write,
 	*lenp = len;
 	*ppos += len;
 
-	kfree(tmp);
+	kfree(buf);
 
 	return 0;
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..8e563cf2b5e7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6172,21 +6172,21 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
-	unsigned long best_cap = 0;
+	unsigned long task_util, best_cap = 0;
 	int cpu, best_cpu = -1;
 	struct cpumask *cpus;
 
-	sync_entity_load_avg(&p->se);
-
 	cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
+	task_util = uclamp_task_util(p);
+
 	for_each_cpu_wrap(cpu, cpus, target) {
 		unsigned long cpu_cap = capacity_of(cpu);
 
 		if (!available_idle_cpu(cpu) && !sched_idle_cpu(cpu))
 			continue;
-		if (task_fits_capacity(p, cpu_cap))
+		if (fits_capacity(task_util, cpu_cap))
 			return cpu;
 
 		if (cpu_cap > best_cap) {
@@ -6198,44 +6198,42 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
+static inline bool asym_fits_capacity(int task_util, int cpu)
+{
+	if (static_branch_unlikely(&sched_asym_cpucapacity))
+		return fits_capacity(task_util, capacity_of(cpu));
+
+	return true;
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd;
+	unsigned long task_util;
 	int i, recent_used_cpu;
 
 	/*
-	 * For asymmetric CPU capacity systems, our domain of interest is
-	 * sd_asym_cpucapacity rather than sd_llc.
+	 * On asymmetric system, update task utilization because we will check
+	 * that the task fits with cpu's capacity.
 	 */
 	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
-		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
-		/*
-		 * On an asymmetric CPU capacity system where an exclusive
-		 * cpuset defines a symmetric island (i.e. one unique
-		 * capacity_orig value through the cpuset), the key will be set
-		 * but the CPUs within that cpuset will not have a domain with
-		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
-		 * capacity path.
-		 */
-		if (!sd)
-			goto symmetric;
-
-		i = select_idle_capacity(p, sd, target);
-		return ((unsigned)i < nr_cpumask_bits) ? i : target;
+		sync_entity_load_avg(&p->se);
+		task_util = uclamp_task_util(p);
 	}
 
-symmetric:
-	if (available_idle_cpu(target) || sched_idle_cpu(target))
+	if ((available_idle_cpu(target) || sched_idle_cpu(target)) &&
+	    asym_fits_capacity(task_util, target))
 		return target;
 
 	/*
 	 * If the previous CPU is cache affine and idle, don't be stupid:
 	 */
 	if (prev != target && cpus_share_cache(prev, target) &&
-	    (available_idle_cpu(prev) || sched_idle_cpu(prev)))
+	    (available_idle_cpu(prev) || sched_idle_cpu(prev)) &&
+	    asym_fits_capacity(task_util, prev))
 		return prev;
 
 	/*
@@ -6258,7 +6256,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
+	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+	    asym_fits_capacity(task_util, recent_used_cpu)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
 		 * candidate for the next wake:
@@ -6267,6 +6266,26 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 		return recent_used_cpu;
 	}
 
+	/*
+	 * For asymmetric CPU capacity systems, our domain of interest is
+	 * sd_asym_cpucapacity rather than sd_llc.
+	 */
+	if (static_branch_unlikely(&sched_asym_cpucapacity)) {
+		sd = rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
+		/*
+		 * On an asymmetric CPU capacity system where an exclusive
+		 * cpuset defines a symmetric island (i.e. one unique
+		 * capacity_orig value through the cpuset), the key will be set
+		 * but the CPUs within that cpuset will not have a domain with
+		 * SD_ASYM_CPUCAPACITY. These should follow the usual symmetric
+		 * capacity path.
+		 */
+		if (sd) {
+			i = select_idle_capacity(p, sd, target);
+			return ((unsigned)i < nr_cpumask_bits) ? i : target;
+		}
+	}
+
 	sd = rcu_dereference(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
@@ -9031,7 +9050,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 * emptying busiest.
 	 */
 	if (local->group_type == group_has_spare) {
-		if (busiest->group_type > group_fully_busy) {
+		if ((busiest->group_type > group_fully_busy) &&
+		    !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
 			/*
 			 * If busiest is overloaded, try to fill spare
 			 * capacity. This might end up creating spare capacity


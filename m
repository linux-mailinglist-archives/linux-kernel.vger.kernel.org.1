Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0D229F117
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 17:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgJ2QSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 12:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgJ2QSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 12:18:32 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D73C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:31 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c16so415496wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 09:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=l3+pnBSxL350+SDMnnTsVBpaoiC0FQWr3iKYPK2gxbE=;
        b=p1L+TVOSL7gCYlcludxdGqZDmHmaOVP6ImzING5lk/+Q6526O+FvFG/lYlS/oNCpT0
         mx6D7R0kd/J8hrcuL42sri1PLLeNKgZeSEkX5NVOFvve7asTEv+e4YTqSL7WioknULky
         pXDROE/lbDM1I6kE3vXe8v4J+BsXv8O1aanGE5kYEFgwlGbPiT1GUPzjHhKOMBzPD+1Q
         gM8dK9kV4wVST3VN/hLNUPApnVxiIhUnTmzRaUbn7PHbOY69D71uh4jndaDlKI+dBjKW
         LUeJOT1VJPueHUAhVmOsckDkg8FyxHgGDkGArggiOpQ/6VvcJXLVB+hUyd6hDxa1kFOV
         aCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=l3+pnBSxL350+SDMnnTsVBpaoiC0FQWr3iKYPK2gxbE=;
        b=GPsbv4iRRI5G+RI/hTLUdW2GJ5Sg2ylhoB25uj2BrlxY9UvmfcbztUNcU93vl2uIKT
         hldHovYVZp2nI13waMXr6O4MvyQkH5jsovWbwqdannnvDiWOmhrhXEWPy0RqAbBojPdf
         YNeUEqT/Hc6M3oBE0dRD5CQury/Az0jB+JRSrRSxcxStalTr8klPg6sVTEN2JpBk2AD5
         AYgqjZqNX/BPJXPZAxfIC+EMGgXl8Etlbsy2OzyW9sL5XxBNd2NS8qwEgRsUJdE0uOtq
         2cxvlteqTF5y1Na0QeIdues7Ugr+SCqj10jSXNX7WIFr4rdaAb7/3jSUaSYqfWy3QOLj
         uGNg==
X-Gm-Message-State: AOAM532m9bNZimXoTL9q442+cxi5e1HmRQNj8tl0SjxMebNFep/FSwo0
        71YgcbG6S/DAgu6Cjr3Mt6i26A==
X-Google-Smtp-Source: ABdhPJx9/Nv0ZKojsE4voZmEYftqJvlhNbeL0GVYW0nwjbjrVsbt5CSPsUnOM24S9Zs6VQYtolaBDg==
X-Received: by 2002:a1c:5a86:: with SMTP id o128mr569556wmb.129.1603988310444;
        Thu, 29 Oct 2020 09:18:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5997:135b:37b7:ac24])
        by smtp.gmail.com with ESMTPSA id z11sm6171944wrr.66.2020.10.29.09.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 09:18:29 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@arm.com,
        ouwen210@hotmail.com
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3] sched/fair: prefer prev cpu in asymmetric wakeup path
Date:   Thu, 29 Oct 2020 17:18:24 +0100
Message-Id: <20201029161824.26389-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During fast wakeup path, scheduler always check whether local or prev cpus
are good candidates for the task before looking for other cpus in the
domain. With
  commit b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
the heterogenous system gains a dedicated path but doesn't try to reuse
prev cpu whenever possible. If the previous cpu is idle and belong to the
LLC domain, we should check it 1st before looking for another cpu because
it stays one of the best candidate and this also stabilizes task placement
on the system.

This change aligns asymmetric path behavior with symmetric one and reduces
cases where the task migrates across all cpus of the sd_asym_cpucapacity
domains at wakeup.

This change does not impact normal EAS mode but only the overloaded case or
when EAS is not used.

- On hikey960 with performance governor (EAS disable)

./perf bench sched pipe -T -l 50000
             mainline           w/ patch
# migrations   999364                  0
ops/sec        149313(+/-0.28%)   182587(+/- 0.40) +22%

- On hikey with performance governor

./perf bench sched pipe -T -l 50000
             mainline           w/ patch
# migrations        0                  0
ops/sec         47721(+/-0.76%)    47899(+/- 0.56) +0.4%

According to test on hikey, the patch doesn't impact symmetric system
compared to current implementation (only tested on arm64)

Also read the uclamped value of task's utilization at most twice instead
instead each time we compare task's utilization with cpu's capacity.

Fixes: b7a331615d25 ("sched/fair: Add asymmetric CPU capacity wakeup scan")
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---

changes in v3:
- fix cast problems raised by Tao
- added Valentin's RB as agreed on IRC

 kernel/sched/fair.c | 67 +++++++++++++++++++++++++++++----------------
 1 file changed, 43 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..6a66898108d5 100644
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
-- 
2.17.1


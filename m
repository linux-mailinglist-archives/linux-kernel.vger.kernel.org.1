Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF329D360
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgJ1VnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgJ1Vmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03384C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:42:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c18so645316wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=905FbrtD4TjFT/A8l0R4rOOHTzIHj38Wh8xRLM+wZgQ=;
        b=EX33TIvx3/6ZGWTWZ7eIigplrQOOYRCxTrpCTgX9HoZUDFBGkALD0fJ+xUe6zbr83B
         UE/ya8hPb2h6LW6F8e3C+ucU66zT7W6mm79pp/akoy0ShyVjkw3AY25OCreX6R9QXTju
         YDfRtnpXYARfP4GjuxndCpamkaL7GYPKLnhKLkzj6Lzn2Pf4B7/CRw0my0Vd7AD0yC6d
         W3Kz76+2ikoDFq99C7IeCFWhNfya3jmQ/ub27/16ALHhSQb58SYtPob9V/nipU9WIZQk
         1qX/lM5zyBivmjiVjtx+AGjN5wssg2GSlt1OtDPxpbQ+aXHjnE7zWjZ4TTA4J7C1NoXE
         M46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=905FbrtD4TjFT/A8l0R4rOOHTzIHj38Wh8xRLM+wZgQ=;
        b=uAI5J9IA44U7WTZoBWpYX//U3oMhFkfWo+1fBIDptDGOTLtBrix7s7vBCv6EtJnqc9
         dGvvDqV/5OfA6g7OAiz0fQ7aVYrXiMQ3VuRTUkib8gEr2rfwWkmpMMFtXyslEIi6Ewoq
         wfoYVyBR5bsoedtilTzS1Aemrhc5XleEgNVJATLUCNNg/s0TsveEhIgKd4/AsjaFljcr
         9WMzFbbXO9amdRmbPlF4EtjtLqoJgOEN45Iz0xGDo3YEzNVlnXvjQ1KrhaCNp6B4EO+J
         GotnW5vXAsyXyN/NDGvzuiYSD4+9GY7AqAZs9zazSILETaBbTjrIuTlSiJx4p/ICEoJg
         ZsfQ==
X-Gm-Message-State: AOAM532TUW9oAxcOHX9p9mEeYCT9JlYrqq4LmRub9O0v/paDregtqO8W
        SS21tbHn6vFBOTYKt3s5HBMmUhsEM2ahlQ==
X-Google-Smtp-Source: ABdhPJxmT/8WzDGTKyp1Lw+Mu4GZOEGeCqor7uy5enbYnZCVkdKpR3VJaXInCpbopevhCnGaCmCcNQ==
X-Received: by 2002:a05:600c:242:: with SMTP id 2mr579119wmj.165.1603907060116;
        Wed, 28 Oct 2020 10:44:20 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f597:fc9e:55a9:f168])
        by smtp.gmail.com with ESMTPSA id y4sm169616wmj.2.2020.10.28.10.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 10:44:19 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com, morten.rasmussen@arm.com
Cc:     ouwen210@hotmail.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: prefer prev cpu in asymmetric wakeup path
Date:   Wed, 28 Oct 2020 18:44:12 +0100
Message-Id: <20201028174412.680-1-vincent.guittot@linaro.org>
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
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
Changes in v2:
- merge asymmetric and symmetric path instead of duplicating tests on target,
  prev and other special cases.

- factorize call to uclamp_task_util(p) and use fits_capacity(). This could
  explain part of the additionnal improvement compared to v1 (+22% instead of
  +17% on v1).

- Keep using LLC instead of asym domain for early check of target, prev and
  recent_used_cpu to ensure cache sharing between the task. This doesn't
  change anything for dynamiQ but will ensure same cache for legacy big.LITTLE
  and also simply the changes.

- don't check capacity for the per-cpu kthread UC because the assumption is
  that the wakee queued work for the per-cpu kthread that is now complete and
  the task was already on this cpu.

- On an asymmetric system where an exclusive cpuset defines a symmetric island,
  task's load is synced and tested although it's not needed. But taking care of
  this special case by testing if sd_asym_cpucapacity is not null impacts by
  more than 4% the performance of default sched_asym_cpucapacity path.

- The huge increase of the number of migration for hikey960 mainline comes from
  teh fact that the ftrace buffer was overloaded by events in the tests done
  with v1.

 kernel/sched/fair.c | 68 ++++++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..131b917b70f8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6173,20 +6173,20 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	unsigned long best_cap = 0;
-	int cpu, best_cpu = -1;
+	int task_util, cpu, best_cpu = -1;
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
@@ -6198,44 +6198,41 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 	return best_cpu;
 }
 
+static inline int asym_fits_capacity(int task_util, int cpu)
+{
+	if (static_branch_unlikely(&sched_asym_cpucapacity))
+		return fits_capacity(task_util, capacity_of(cpu));
+
+	return 1;
+}
+
 /*
  * Try and locate an idle core/thread in the LLC cache domain.
  */
 static int select_idle_sibling(struct task_struct *p, int prev, int target)
 {
 	struct sched_domain *sd;
-	int i, recent_used_cpu;
+	int i, recent_used_cpu, task_util;
 
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
@@ -6258,7 +6255,8 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
-	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr)) {
+	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
+	    asym_fits_capacity(task_util, recent_used_cpu)) {
 		/*
 		 * Replace recent_used_cpu with prev as it is a potential
 		 * candidate for the next wake:
@@ -6267,6 +6265,26 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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


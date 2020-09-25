Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E50D9278E47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbgIYQUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIYQUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:20:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFC7C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:20:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z19so3653232pfn.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Jq2TRjayDffKN2IwDmhBR62SvM+kTJMYH93NJa2Ag1w=;
        b=PiDqo9vt4pi/vuTz8/SvI16sD0bMxZ8wHVXN9y7AlzDMvToUEIKIVo0JF8OIWQqcna
         m3H+IQZ4uP9DQUeGv8/hp+YruxB/qo7q+eXecOOpOpby/iJX5rO4+b5XJ53Wz58ENY/6
         TtcAO7Zo5FCj6X5Nt+Lm4/sVcSWViE7AhQxac+qYAu0MF1cFKkF2RxGsECYmtGdxPsBD
         hgXA5ZzhxR6/sTSwHvIz9WWedj8FGye9Krg9vmabds92xbD1u67kJCKw+JInzDiVh9eP
         BQ/gM4J7U4YmFCHjb5sNsgRhA9+1ynYIEOpFgb8glOWsymTHAdmewtATqN7DXuaIHNju
         TOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Jq2TRjayDffKN2IwDmhBR62SvM+kTJMYH93NJa2Ag1w=;
        b=sJXryu+Sd/Z5Q/g+UjMsucgcQqqlttVfZRkZx2Ld/1hSRP48SMRKPxF/gANlGZQ6Lk
         KtMeFsYta5qs1579MLOo9dhoBsN/ZhUi5Yj/Sb+wJzRY4NngsagHfo5Dwm6t5xs4L/B8
         u4aG/smTM/O8V2/RAP6PND6zgwRN1WCjj69o/1ubIRaoU+BwPQPQYUL6lInxXQMtMkvw
         oTDp91VcoPaMnViYwpU6a/1okKy8IBwfm5iM7DdUdPei8BBrjyER7DGnTxpDoJmTqMmU
         gf8RfI+CAehAyuKCUCQ5J9LVl40HBMlioRWfU+JEYpdQyr9ATbXvW2FyjOo19fbcTHI+
         99xg==
X-Gm-Message-State: AOAM531HkD73rxFb0H8Qm1kXlwj4OQDeDCn/MckV5JhF5335xlVW+AVg
        hnSgxjd5rsUBb4L1GkPLCc6XUJNWvN8=
X-Google-Smtp-Source: ABdhPJxU63xh50Sf4WNGDH+OXHvhBXwUR4t12YaKuybz2NPgjw5mhz7POxxWeDUHb2iyMH7I0Lch8w==
X-Received: by 2002:a63:230f:: with SMTP id j15mr668813pgj.363.1601050836804;
        Fri, 25 Sep 2020 09:20:36 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id q190sm3170489pfc.176.2020.09.25.09.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Sep 2020 09:20:36 -0700 (PDT)
Date:   Sat, 26 Sep 2020 00:20:32 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v4] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200925162032.GA9692@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I created another root domain(contains 2 CPUs) besides the default
one, and the global default rt bandwidth is 95%. Then launched a
DL process which need 25% bandwidth and moved it to the new root
domain, so far so good.

Then I tried to change global rt bandwidth to 20% with cmd:
	echo 200000 > /proc/sys/kernel/sched_rt_runtime_us
but ending with the below error:
	bash: echo: write error: Device or resource busy
Only values greater than 250000 could work.

The new root domain contains two CPUs, thus should could provide
totally 2*20%(>25%) bandwidth. So the error is strange.
Finally I found it's the sched_dl_global_validate() mistakenly
do the validation.

When change sched_rt_{runtime, period}_us, then

  sched_rt_handler()
    -->	sched_dl_bandwidth_validate()
	{
		new_bw = global_rt_runtime()/global_rt_period();

		for_each_possible_cpu(cpu) {
			dl_b = dl_bw_of(cpu);
			if (new_bw < dl_b->total_bw)
				ret = -EBUSY;
		}
	}

Under CONFIG_SMP, dl_bw is per root domain , but not per CPU,
dl_b->total_bw is the allocated bandwidth of the whole root domain.
we should compare dl_b->total_bw against cpus*new_bw, where 'cpus'
is the number of CPUs of the root domain.

Also, below annotation(in kernel/sched/sched.h) implied implementation
only appeared in SCHED_DEADLINE v2[1], then deadline scheduler kept
evolving till got merged(v9), but the annotation remains unchanged,
meaningless and misleading, correct it.

* With respect to SMP, the bandwidth is given on a per-CPU basis,
* meaning that:
*  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
*  - dl_total_bw array contains, in the i-eth element, the currently
*    allocated bandwidth on the i-eth CPU.

[1]: https://lore.kernel.org/lkml/1267385230.13676.101.camel@Palantir/

Fixes: 332ac17ef5bf ("sched/deadline: Add bandwidth management for SCHED_DEADLINE tasks")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---

v4 <-- v3:
 - refine changelog;
 - eliminate the ugly #ifdef guys with Peter's method;

v3 <-- v2:
 - fix build error for !CONFIG_SMP, reported by kernel test robot;

v2 <-- v1:
 - replace cpumask_weight(cpu_rq(cpu)->rd->span) with dl_bw_cpus(cpu),
   suggested by Juri;

 kernel/sched/deadline.c | 43 ++++++++++++++++++++++++++++++++---------
 kernel/sched/sched.h    | 22 +++++++++------------
 kernel/sched/topology.c |  1 +
 3 files changed, 44 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d..c95af33b7274 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -97,6 +97,17 @@ static inline unsigned long dl_bw_capacity(int i)
 		return __dl_bw_capacity(i);
 	}
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	struct root_domain *rd = cpu_rq(cpu)->rd;
+
+	if (rd->visit_gen == gen)
+		return true;
+
+	rd->visit_gen = gen;
+	return false;
+}
 #else
 static inline struct dl_bw *dl_bw_of(int i)
 {
@@ -112,6 +123,11 @@ static inline unsigned long dl_bw_capacity(int i)
 {
 	return SCHED_CAPACITY_SCALE;
 }
+
+static inline bool dl_bw_visited(int cpu, u64 gen)
+{
+	return false;
+}
 #endif
 
 static inline
@@ -2511,33 +2527,38 @@ const struct sched_class dl_sched_class
 	.update_curr		= update_curr_dl,
 };
 
+static u64 dl_generation;
+
 int sched_dl_global_validate(void)
 {
 	u64 runtime = global_rt_runtime();
 	u64 period = global_rt_period();
 	u64 new_bw = to_ratio(period, runtime);
 	struct dl_bw *dl_b;
-	int cpu, ret = 0;
+	int cpu, cpus, ret = 0;
 	unsigned long flags;
+	u64 gen = ++dl_generation;
 
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen))
+			goto next;
+
 		dl_b = dl_bw_of(cpu);
+		cpus = dl_bw_cpus(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
 
+next:
 		rcu_read_unlock_sched();
 
 		if (ret)
@@ -2563,6 +2584,7 @@ static void init_dl_rq_bw_ratio(struct dl_rq *dl_rq)
 void sched_dl_do_global(void)
 {
 	u64 new_bw = -1;
+	u64 gen = ++dl_generation;
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
@@ -2573,11 +2595,14 @@ void sched_dl_do_global(void)
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
-	/*
-	 * FIXME: As above...
-	 */
 	for_each_possible_cpu(cpu) {
 		rcu_read_lock_sched();
+
+		if (dl_bw_visited(cpu, gen)) {
+			rcu_read_unlock_sched();
+			continue;
+		}
+
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..c23976bc38e9 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -258,10 +258,11 @@ struct rt_bandwidth {
 void __dl_clear_params(struct task_struct *p);
 
 /*
- * To keep the bandwidth of -deadline tasks and groups under control
+ * To keep the bandwidth of -deadline tasks under control
  * we need some place where:
- *  - store the maximum -deadline bandwidth of the system (the group);
- *  - cache the fraction of that bandwidth that is currently allocated.
+ *  - store the maximum -deadline bandwidth of each CPU;
+ *  - cache the fraction of that bandwidth that is currently allocated
+ *    in each root domain;
  *
  * This is all done in the data structure below. It is similar to the
  * one used for RT-throttling (rt_bandwidth), with the main difference
@@ -269,17 +270,10 @@ void __dl_clear_params(struct task_struct *p);
  * do not decrease any runtime while the group "executes", neither we
  * need a timer to replenish it.
  *
- * With respect to SMP, the bandwidth is given on a per-CPU basis,
+ * With respect to SMP, the bandwidth is given on per root domain basis,
  * meaning that:
- *  - dl_bw (< 100%) is the bandwidth of the system (group) on each CPU;
- *  - dl_total_bw array contains, in the i-eth element, the currently
- *    allocated bandwidth on the i-eth CPU.
- * Moreover, groups consume bandwidth on each CPU, while tasks only
- * consume bandwidth on the CPU they're running on.
- * Finally, dl_total_bw_cpu is used to cache the index of dl_total_bw
- * that will be shown the next time the proc or cgroup controls will
- * be red. It on its turn can be changed by writing on its own
- * control.
+ *  - bw (< 100%) is the deadline bandwidth of each CPU;
+ *  - total_bw is the currently allocated bandwidth on each root domain.
  */
 struct dl_bandwidth {
 	raw_spinlock_t		dl_runtime_lock;
@@ -801,6 +795,8 @@ struct root_domain {
 	struct dl_bw		dl_bw;
 	struct cpudl		cpudl;
 
+	u64			visit_gen;
+
 #ifdef HAVE_RT_PUSH_IPI
 	/*
 	 * For IPI pull requests, loop across the rto_mask.
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 55c453d140e9..f431daefed68 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -516,6 +516,7 @@ static int init_rootdomain(struct root_domain *rd)
 	init_irq_work(&rd->rto_push_work, rto_push_irq_work_func);
 #endif
 
+	rd->visit_gen = 0;
 	init_dl_bw(&rd->dl_bw);
 	if (cpudl_init(&rd->cpudl) != 0)
 		goto free_rto_mask;
-- 
2.20.1


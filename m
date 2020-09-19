Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83522709B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 03:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgISBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 21:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISBmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 21:42:55 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAEFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:42:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k13so3916777plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 18:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=EhoP3N7hvag0b8mP1hRbWzDoofE3rRk8aNl4i8BZvqc=;
        b=Nc12u21uLbmQtPwURkkktCz7tf37xyAb9vDwo8zhGE9PIHELSyO1HSuf/x6IfR/tG/
         jA8acg0sQtgaPwopP7uY2QWTutYF9nKFbH28bvCg4gvN9ybsiY1etpOhRvp89V68LJbH
         i0DJwJ6q1q/B5xPCxS0GG1LTI6fp/RHUN0aa8P2uMQiLGDFlA4+CgW5Pfg0ADwDSJiVZ
         t1uDqGGh7HQsAaMwjMGfX6dyqTGl/scDa/ehj37fRZbtPpi7P4cs0yySENpJj3wjzbNI
         Fykk7Cgef+pZTclndCZ4yG86MnMFx21da9X4kV/gOUtJJyETfxyVwbCkWEFFHOmWI1Bg
         MBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=EhoP3N7hvag0b8mP1hRbWzDoofE3rRk8aNl4i8BZvqc=;
        b=ef0qHpyyll1qC+cCdSNGdBQyzpG9ganMVsn95UvTLYAXHcZ7MCHIFc77mHM2IEgA3G
         EZN+jLhdAMb7/4kmzR/Bb36JR8yp+uuoYPLaAfOvhE+i5Ac8E7cx9z7NgoqO7BbDGyAn
         N09VvMFGyAzegC2brQ/PtvVbvxUjmXvzJCmbb0u3YRhR8S8sU44yakjwSeTs1mcx5WzW
         D3j7ImdGm9ztMSJHoeHi2JS78QzSFKBd7bi/b5o0uuNh9s1I2pjZpwEnHmWvgTl+BGEm
         1Cl27mSgUgmkQbhh8RSzhsgiXoq0pyRpWv/7Acvf0JdheyWw5x5TbypPfxkDFYWO1Kf8
         0Y7g==
X-Gm-Message-State: AOAM531w+8N9lt2moeNmEVtqyv+ofEdbCLG3DlO5TdfwC9YCRORsqzml
        RWNu7Cw8Xv1tQnhXDWlUQm9mon3KuiM=
X-Google-Smtp-Source: ABdhPJwrA4oz7iUiPFOcgrH2Jnw5ub3gOHUvyHPH4FvUoyn6c07Kx40i7L7ZpjzNKr5ZwnNC3RLCSQ==
X-Received: by 2002:a17:90b:1256:: with SMTP id gx22mr15886479pjb.47.1600479773895;
        Fri, 18 Sep 2020 18:42:53 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id f18sm5066522pfe.153.2020.09.18.18.42.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Sep 2020 18:42:53 -0700 (PDT)
Date:   Sat, 19 Sep 2020 09:42:49 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        iwtbavbm@gmail.com
Subject: [PATCH v3] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200919014249.GA31707@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user changes sched_rt_{runtime, period}_us, then

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

[1] https://lkml.org/lkml/2010/2/28/119

[!CONFIG_SMP build error]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
v3 <-- v2:
 Fix build error for !CONFIG_SMP, reported by kernel test robot.

v2 <-- v1:
 Replace cpumask_weight(cpu_rq(cpu)->rd->span) with dl_bw_cpus(cpu),
 suggested by Juri.

 kernel/sched/deadline.c | 43 ++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h    | 17 +++++-----------
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d..39ec0be574e8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2511,33 +2511,45 @@ const struct sched_class dl_sched_class
 	.update_curr		= update_curr_dl,
 };
 
+#ifdef CONFIG_SMP
+static struct cpumask dl_local_possible_mask;
+#endif /* CONFIG_SMP */
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
 
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
+#ifdef CONFIG_SMP
+	cpumask_t *possible_mask = &dl_local_possible_mask;
+
+	cpumask_copy(possible_mask, cpu_possible_mask);
+	for_each_cpu(cpu, possible_mask) {
+#else
 	for_each_possible_cpu(cpu) {
+#endif /* CONFIG_SMP */
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
-
+		cpus = dl_bw_cpus(cpu);
+#ifdef CONFIG_SMP
+		/* Do the "andnot" operation iff it's necessary. */
+		if (cpus > 1)
+			cpumask_andnot(possible_mask, possible_mask,
+				       cpu_rq(cpu)->rd->span);
+#endif /* CONFIG_SMP */
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
-
 		rcu_read_unlock_sched();
 
 		if (ret)
@@ -2566,6 +2578,7 @@ void sched_dl_do_global(void)
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
+	cpumask_t *possible_mask = NULL;
 
 	def_dl_bandwidth.dl_period = global_rt_period();
 	def_dl_bandwidth.dl_runtime = global_rt_runtime();
@@ -2573,17 +2586,21 @@ void sched_dl_do_global(void)
 	if (global_rt_runtime() != RUNTIME_INF)
 		new_bw = to_ratio(global_rt_period(), global_rt_runtime());
 
-	/*
-	 * FIXME: As above...
-	 */
-	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_SMP
+	possible_mask = &dl_local_possible_mask;
+	cpumask_copy(possible_mask, cpu_possible_mask);
+#endif /* CONFIG_SMP */
+	for_each_cpu(cpu, possible_mask) {
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
 
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
 		dl_b->bw = new_bw;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
-
+#ifdef CONFIG_SMP
+		cpumask_andnot(possible_mask, possible_mask,
+			       cpu_rq(cpu)->rd->span);
+#endif /* CONFIG_SMP */
 		rcu_read_unlock_sched();
 		init_dl_rq_bw_ratio(&cpu_rq(cpu)->dl);
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..2602544e06ff 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -258,9 +258,9 @@ struct rt_bandwidth {
 void __dl_clear_params(struct task_struct *p);
 
 /*
- * To keep the bandwidth of -deadline tasks and groups under control
+ * To keep the bandwidth of -deadline tasks under control
  * we need some place where:
- *  - store the maximum -deadline bandwidth of the system (the group);
+ *  - store the maximum -deadline bandwidth of each root domain;
  *  - cache the fraction of that bandwidth that is currently allocated.
  *
  * This is all done in the data structure below. It is similar to the
@@ -269,17 +269,10 @@ void __dl_clear_params(struct task_struct *p);
  * do not decrease any runtime while the group "executes", neither we
  * need a timer to replenish it.
  *
- * With respect to SMP, the bandwidth is given on a per-CPU basis,
+ * With respect to SMP, the bandwidth is given on a per root domain basis,
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
+ *  - bw (< 100%) is the bandwidth of the system on each CPU;
+ *  - total_bw is the currently allocated bandwidth on each root domain.
  */
 struct dl_bandwidth {
 	raw_spinlock_t		dl_runtime_lock;
-- 
2.20.1


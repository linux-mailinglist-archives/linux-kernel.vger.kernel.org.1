Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2395226B1AE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:34:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgIOQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 12:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgIOPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:20:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750DC061788
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:20:53 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id d13so2154627pgl.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eRDwPJef3ElvaaFcUCZV2XCWcz5NA5r/DCuudMkUJtU=;
        b=VwZzVxiQTUO0FBJ3PAtnb6LwlArqgU8OLU3XDLejHEekcwZIE15hm1UlyUO4Y+DZWT
         +U+oMC7IxAOkv1nD1+6J9XhH5g7nIK2g3QjvpRvbJpARdEqfSK9SS0o2O4AjtT476fVq
         4jkO2LDFfV3i1RaCe3RI3sJtZi6Tp1ByFgFLfNU6O7TSJcrjYDHrGkN6iO8OYK9lwfuZ
         8SpstwBlFr/U2gCeTDZWT7+REBhiGFdkKnmnx2u2+s0rRi/aM68t7CeLipClg2SCq0Qd
         PsBYvsADDa+0f+UrXWiIWL2hMXUgRjkLGcecEilxzrKOmFV7OCg29udz/6pUbQo6HsYD
         2/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eRDwPJef3ElvaaFcUCZV2XCWcz5NA5r/DCuudMkUJtU=;
        b=PXEUDIUg2ctB7QO4Yve2fgmgA4/X2q1ulUIdyIT++UiCmQc/k3LhW5uCihIjfaNbIt
         G6qLHUhilAesXe6ka3ErGOTv2aRTJwb27cAZiqDoizQrT+5bjEaMiEUH49xst1qQcmPD
         +hGM0Kfe1SLPhQ9/b3WguqHgZSHj6sJ3l+OXZni6pBz+f33GYzCXUF2zvETCZkN1kjrT
         GtEgt362G7gGo1jkGOWYTReTP6w6vp4XG9bb8vo53iX0/td8uM0IYEm4fspteT07kKPe
         2gXsLam5p5iJzbex2iPIE4uaPNHhjI1pXBkmg4mru0on/UmDZS4wzBL+sILbZ8QFMnUo
         SNJw==
X-Gm-Message-State: AOAM532sDAllQEj74Qpw2ASxwy4RD7q59cWIrQppWtM+2cnUaE3CZptN
        w05QJ6Axn0QrNG1hgpRNpCA=
X-Google-Smtp-Source: ABdhPJwGHVbGeNaO05rXg58GJwtSpLMgWm5/0wvvrlpogmqMRh3lFULLczypKRQEQOKGr6+4eMfzQQ==
X-Received: by 2002:a62:1b4e:0:b029:13e:d13d:a135 with SMTP id b75-20020a621b4e0000b029013ed13da135mr18060882pfb.29.1600183253154;
        Tue, 15 Sep 2020 08:20:53 -0700 (PDT)
Received: from iZj6chx1xj0e0buvshuecpZ ([47.75.1.235])
        by smtp.gmail.com with ESMTPSA id t12sm10321973pfh.73.2020.09.15.08.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 08:20:52 -0700 (PDT)
Date:   Tue, 15 Sep 2020 23:20:48 +0800
From:   Peng Liu <iwtbavbm@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, valentin.schneider@arm.com, raistlin@linux.it,
        linux-kernel@vger.kernel.org
Cc:     iwtbavbm@gmail.com
Subject: [PATCH] sched/deadline: Fix sched_dl_global_validate()
Message-ID: <20200915152048.GA25835@iZj6chx1xj0e0buvshuecpZ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
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

Signed-off-by: Peng Liu <iwtbavbm@gmail.com>
---
In fact, I'm not 100% sure that's a bug, since it's too 'obvious' and
not newly introduced code.

Also, the introduced #ifdef...#endif pairs look ugly, I have no idea
how to eliminate them. Ideas and comments are welcome. Thanks.

 kernel/sched/deadline.c | 48 ++++++++++++++++++++++++++++-------------
 kernel/sched/sched.h    | 17 +++++----------
 2 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3862a28cd05d..6524cb31148e 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2511,33 +2511,43 @@ const struct sched_class dl_sched_class
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
+	int cpu, cpus = 1, ret = 0;
 	unsigned long flags;
-
+	cpumask_t *possible_mask = NULL;
+#ifdef CONFIG_SMP
+	cpumask_t *span;
+#endif /* CONFIG_SMP */
 	/*
 	 * Here we want to check the bandwidth not being set to some
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
-	 *
-	 * FIXME: Cycling on all the CPUs is overdoing, but simpler than
-	 * cycling on root_domains... Discussion on different/better
-	 * solutions is welcome!
 	 */
-	for_each_possible_cpu(cpu) {
+#ifdef CONFIG_SMP
+	possible_mask = &dl_local_possible_mask;
+	cpumask_copy(possible_mask, cpu_possible_mask);
+#endif /* CONFIG_SMP */
+	for_each_cpu(cpu, possible_mask) {
 		rcu_read_lock_sched();
 		dl_b = dl_bw_of(cpu);
-
+#ifdef CONFIG_SMP
+		span = cpu_rq(cpu)->rd->span;
+		cpus = cpumask_weight(span);
+		cpumask_andnot(possible_mask, possible_mask, span);
+#endif /* CONFIG_SMP */
 		raw_spin_lock_irqsave(&dl_b->lock, flags);
-		if (new_bw < dl_b->total_bw)
+		if (new_bw * cpus < dl_b->total_bw)
 			ret = -EBUSY;
 		raw_spin_unlock_irqrestore(&dl_b->lock, flags);
-
 		rcu_read_unlock_sched();
 
 		if (ret)
@@ -2566,6 +2576,10 @@ void sched_dl_do_global(void)
 	struct dl_bw *dl_b;
 	int cpu;
 	unsigned long flags;
+	cpumask_t *possible_mask = NULL;
+#ifdef CONFIG_SMP
+	cpumask_t *span;
+#endif /* CONFIG_SMP */
 
 	def_dl_bandwidth.dl_period = global_rt_period();
 	def_dl_bandwidth.dl_runtime = global_rt_runtime();
@@ -2573,17 +2587,21 @@ void sched_dl_do_global(void)
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
+		span = cpu_rq(cpu)->rd->span;
+		cpumask_andnot(possible_mask, possible_mask, span);
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


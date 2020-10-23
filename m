Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4880E2971AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750847AbgJWOsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 10:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbgJWOrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 10:47:35 -0400
Received: from localhost.localdomain (unknown [176.167.163.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38418208FE;
        Fri, 23 Oct 2020 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603464454;
        bh=V2e0D6r2RjFl/j0PBWKI/QkYBtNbEYkUYq1noFjtq7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AlLmYP4oyKIVpPOIOal+3bjln7dlfGTBOhelVGncwUW8JQgb5zBXDT1mjDPb8a8gq
         stgLzlXBk1pZPHKnH2w6AsHWRlKwV8dwpB0Kg9kkqQinRFARB//dNi7UuZz+7nJ1KK
         tsJtpdVSnog61InWkrNqWImnj5R+PZKGjvcBnQvo=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: [PATCH 15/16] rcutorture: Test runtime toggling of CPUs' callback offloading
Date:   Fri, 23 Oct 2020 16:46:48 +0200
Message-Id: <20201023144649.53046-16-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201023144649.53046-1-frederic@kernel.org>
References: <20201023144649.53046-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Frederic Weisbecker is adding the ability to change the rcu_nocbs state
of CPUs at runtime, that is, to offload and deoffload their RCU callback
processing without the need to reboot.  As the old saying goes, "if it
ain't tested, it don't work", so this commit therefore adds prototype
rcutorture testing for this capability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Neeraj Upadhyay <neeraju@codeaurora.org>
---
 .../admin-guide/kernel-parameters.txt         |  8 ++
 kernel/rcu/rcutorture.c                       | 86 ++++++++++++++++++-
 kernel/rcu/tree_plugin.h                      |  3 +-
 3 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 02d4adbf98d2..de31a867e0d9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4324,6 +4324,14 @@
 			stress RCU, they don't participate in the actual
 			test, hence the "fake".
 
+	rcutorture.nocbs_nthreads= [KNL]
+			Set number of RCU callback-offload togglers.
+			Zero (the default) disables toggling.
+
+	rcutorture.nocbs_toggle= [KNL]
+			Set the delay in milliseconds between successive
+			callback-offload toggling attempts.
+
 	rcutorture.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N-1, where N is the number of CPUs.  A value
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 916ea4f66e4b..c027b753bed5 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -97,6 +97,8 @@ torture_param(int, object_debug, 0,
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
 	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
+torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, read_exit_delay, 13,
 	      "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16,
@@ -127,10 +129,12 @@ static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
+static int nrealnocbers;
 static int nrealreaders;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
 static struct task_struct *boost_tasks[NR_CPUS];
@@ -174,6 +178,8 @@ static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
 static unsigned long start_gp_seq;
+static atomic_long_t n_nocb_offload;
+static atomic_long_t n_nocb_deoffload;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -1483,6 +1489,53 @@ rcu_torture_reader(void *arg)
 	return 0;
 }
 
+/*
+ * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
+ * increase race probabilities and fuzzes the interval between toggling.
+ */
+static int rcu_nocb_toggle(void *arg)
+{
+	int cpu;
+	int maxcpu = -1;
+	int oldnice = task_nice(current);
+	long r;
+	DEFINE_TORTURE_RANDOM(rand);
+	ktime_t toggle_delay;
+	unsigned long toggle_fuzz;
+	ktime_t toggle_interval = ms_to_ktime(nocbs_toggle);
+
+	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
+	for_each_online_cpu(cpu)
+		maxcpu = cpu;
+	WARN_ON(maxcpu < 0);
+	if (toggle_interval > ULONG_MAX)
+		toggle_fuzz = ULONG_MAX >> 3;
+	else
+		toggle_fuzz = toggle_interval >> 3;
+	if (toggle_fuzz <= 0)
+		toggle_fuzz = NSEC_PER_USEC;
+	do {
+		r = torture_random(&rand);
+		cpu = (r >> 4) % (maxcpu + 1);
+		if (r & 0x1) {
+			rcu_nocb_cpu_offload(cpu);
+			atomic_long_inc(&n_nocb_offload);
+		} else {
+			rcu_nocb_cpu_deoffload(cpu);
+			atomic_long_inc(&n_nocb_deoffload);
+		}
+		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
+		if (stutter_wait("rcu_nocb_toggle"))
+			sched_set_normal(current, oldnice);
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_nocb_toggle");
+	return 0;
+}
+
 /*
  * Print torture statistics.  Caller must ensure that there is only
  * one call to this function at a given time!!!  This is normally
@@ -1538,7 +1591,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
-	pr_cont("read-exits: %ld\n", data_race(n_read_exits));
+	pr_cont("read-exits: %ld ", data_race(n_read_exits));
+	pr_cont("nocb-toggles: %ld:%ld\n",
+		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -1631,7 +1686,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
-		 "read_exit_delay=%d read_exit_burst=%d\n",
+		 "read_exit_delay=%d read_exit_burst=%d "
+		 "nocbs_nthreads=%d nocbs_toggle=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -1641,7 +1697,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stall_cpu_block,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
-		 read_exit_delay, read_exit_burst);
+		 read_exit_delay, read_exit_burst,
+		 nocbs_nthreads, nocbs_toggle);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -2479,6 +2536,13 @@ rcu_torture_cleanup(void)
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
+	if (nocb_tasks) {
+		for (i = 0; i < nrealnocbers; i++)
+			torture_stop_kthread(rcu_nocb_toggle, nocb_tasks[i]);
+		kfree(nocb_tasks);
+		nocb_tasks = NULL;
+	}
+
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -2742,6 +2806,22 @@ rcu_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	nrealnocbers = nocbs_nthreads;
+	if (WARN_ON(nrealnocbers < 0))
+		nrealnocbers = 1;
+	if (WARN_ON(nocbs_toggle < 0))
+		nocbs_toggle = HZ;
+	nocb_tasks = kcalloc(nrealnocbers, sizeof(nocb_tasks[0]), GFP_KERNEL);
+	if (nocb_tasks == NULL) {
+		VERBOSE_TOROUT_ERRSTRING("out of memory");
+		firsterr = -ENOMEM;
+		goto unwind;
+	}
+	for (i = 0; i < nrealnocbers; i++) {
+		firsterr = torture_create_kthread(rcu_nocb_toggle, NULL, nocb_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(rcu_torture_stats, NULL,
 						  stats_task);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2f083beab9d9..5e0870229dd5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2398,6 +2398,7 @@ int rcu_nocb_cpu_deoffload(int cpu)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_deoffload);
 
 static int __rcu_nocb_rdp_offload(struct rcu_data *rdp)
 {
@@ -2473,7 +2474,7 @@ int rcu_nocb_cpu_offload(int cpu)
 
 	return ret;
 }
-
+EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
 void __init rcu_init_nohz(void)
 {
-- 
2.25.1


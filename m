Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE0F258056
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 20:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgHaSIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 14:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729319AbgHaSIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:08:00 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA89121789;
        Mon, 31 Aug 2020 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598897275;
        bh=38/lC+wtbX9+iKTtSZJnhabAvE6NwcvJ+0QRa5d6JsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O/2nGODXk7UD5VZepAC2wkhuUIQwCUGRgyP8XVk7B8lkEu7zFwQPnx4zqtKCLt5H+
         pMUPOSINAFE0DeuWDtpa7bOQ39myUCt5pVKHU7P37+olrPshOFpKswzP58kXOBFF2E
         MZiP7+qi9a3jULrbJl15OIzDRVzidlINEkP86obI=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/19] rcuperf: Change rcuperf to rcuscale
Date:   Mon, 31 Aug 2020 11:07:49 -0700
Message-Id: <20200831180749.843-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200831180731.GA582@paulmck-ThinkPad-P72>
References: <20200831180731.GA582@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit further avoids conflation of rcuperf with the kernel's perf
feature by renaming kernel/rcu/rcuperf.c to kernel/rcu/rcuscale.c, and
also by similarly renaming the functions and variables inside this file.
This has the side effect of changing the names of the kernel boot
parameters, so kernel-parameters.txt and ver_functions.sh are also
updated.  The rcutorture --torture type was also updated from rcuperf
to rcuscale.

[ paulmck: Fix bugs located by Stephen Rothwell. ]
Reported-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt    |  36 +--
 MAINTAINERS                                        |   3 +-
 kernel/rcu/Kconfig.debug                           |   2 +-
 kernel/rcu/Makefile                                |   2 +-
 kernel/rcu/{rcuperf.c => rcuscale.c}               | 330 ++++++++++-----------
 ...rf-ftrace.sh => kvm-recheck-rcuscale-ftrace.sh} |   6 +-
 ...-recheck-rcuperf.sh => kvm-recheck-rcuscale.sh} |  14 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |   8 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   4 +-
 .../selftests/rcutorture/configs/rcuperf/CFcommon  |   2 -
 .../configs/{rcuperf => rcuscale}/CFLIST           |   0
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   2 +
 .../rcutorture/configs/{rcuperf => rcuscale}/TINY  |   0
 .../rcutorture/configs/{rcuperf => rcuscale}/TREE  |   0
 .../configs/{rcuperf => rcuscale}/TREE54           |   0
 .../configs/{rcuperf => rcuscale}/ver_functions.sh |   4 +-
 16 files changed, 207 insertions(+), 206 deletions(-)
 rename kernel/rcu/{rcuperf.c => rcuscale.c} (64%)
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-rcuperf-ftrace.sh => kvm-recheck-rcuscale-ftrace.sh} (92%)
 rename tools/testing/selftests/rcutorture/bin/{kvm-recheck-rcuperf.sh => kvm-recheck-rcuscale.sh} (84%)
 delete mode 100644 tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/CFLIST (100%)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TINY (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TREE (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/TREE54 (100%)
 rename tools/testing/selftests/rcutorture/configs/{rcuperf => rcuscale}/ver_functions.sh (88%)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 91a5638..c27bbe9 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4157,41 +4157,41 @@
 			rcu_node tree with an eye towards determining
 			why a new grace period has not yet started.
 
-	rcuperf.gp_async= [KNL]
+	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
 			grace-period primitives such as call_rcu().
 
-	rcuperf.gp_async_max= [KNL]
+	rcuscale.gp_async_max= [KNL]
 			Specify the maximum number of outstanding
 			callbacks per writer thread.  When a writer
 			thread exceeds this limit, it invokes the
 			corresponding flavor of rcu_barrier() to allow
 			previously posted callbacks to drain.
 
-	rcuperf.gp_exp= [KNL]
+	rcuscale.gp_exp= [KNL]
 			Measure performance of expedited synchronous
 			grace-period primitives.
 
-	rcuperf.holdoff= [KNL]
+	rcuscale.holdoff= [KNL]
 			Set test-start holdoff period.  The purpose of
 			this parameter is to delay the start of the
 			test until boot completes in order to avoid
 			interference.
 
-	rcuperf.kfree_rcu_test= [KNL]
+	rcuscale.kfree_rcu_test= [KNL]
 			Set to measure performance of kfree_rcu() flooding.
 
-	rcuperf.kfree_nthreads= [KNL]
+	rcuscale.kfree_nthreads= [KNL]
 			The number of threads running loops of kfree_rcu().
 
-	rcuperf.kfree_alloc_num= [KNL]
+	rcuscale.kfree_alloc_num= [KNL]
 			Number of allocations and frees done in an iteration.
 
-	rcuperf.kfree_loops= [KNL]
-			Number of loops doing rcuperf.kfree_alloc_num number
+	rcuscale.kfree_loops= [KNL]
+			Number of loops doing rcuscale.kfree_alloc_num number
 			of allocations and frees.
 
-	rcuperf.nreaders= [KNL]
+	rcuscale.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N, where N is the number of CPUs.  A value
 			"n" less than -1 selects N-n+1, where N is again
@@ -4200,23 +4200,23 @@
 			A value of "n" less than or equal to -N selects
 			a single reader.
 
-	rcuperf.nwriters= [KNL]
+	rcuscale.nwriters= [KNL]
 			Set number of RCU writers.  The values operate
-			the same as for rcuperf.nreaders.
+			the same as for rcuscale.nreaders.
 			N, where N is the number of CPUs
 
-	rcuperf.perf_type= [KNL]
+	rcuscale.perf_type= [KNL]
 			Specify the RCU implementation to test.
 
-	rcuperf.shutdown= [KNL]
+	rcuscale.shutdown= [KNL]
 			Shut the system down after performance tests
 			complete.  This is useful for hands-off automated
 			testing.
 
-	rcuperf.verbose= [KNL]
+	rcuscale.verbose= [KNL]
 			Enable additional printk() statements.
 
-	rcuperf.writer_holdoff= [KNL]
+	rcuscale.writer_holdoff= [KNL]
 			Write-side holdoff between grace periods,
 			in microseconds.  The default of zero says
 			no holdoff.
@@ -4490,8 +4490,8 @@
 	refscale.shutdown= [KNL]
 			Shut down the system at the end of the performance
 			test.  This defaults to 1 (shut it down) when
-			rcuperf is built into the kernel and to 0 (leave
-			it running) when rcuperf is built as a module.
+			refscale is built into the kernel and to 0 (leave
+			it running) when refscale is built as a module.
 
 	refscale.verbose= [KNL]
 			Enable additional printk() statements.
diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb6..d299e3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17510,8 +17510,9 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
 F:	Documentation/RCU/torture.rst
 F:	kernel/locking/locktorture.c
-F:	kernel/rcu/rcuperf.c
+F:	kernel/rcu/rcuscale.c
 F:	kernel/rcu/rcutorture.c
+F:	kernel/rcu/refscale.c
 F:	kernel/torture.c
 
 TOSHIBA ACPI EXTRAS DRIVER
diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 3cf6132..5cb175d 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -23,7 +23,7 @@ config TORTURE_TEST
 	tristate
 	default n
 
-config RCU_PERF_TEST
+config RCU_SCALE_TEST
 	tristate "performance tests for RCU"
 	depends on DEBUG_KERNEL
 	select TORTURE_TEST
diff --git a/kernel/rcu/Makefile b/kernel/rcu/Makefile
index 95f5117..0cfb009 100644
--- a/kernel/rcu/Makefile
+++ b/kernel/rcu/Makefile
@@ -11,7 +11,7 @@ obj-y += update.o sync.o
 obj-$(CONFIG_TREE_SRCU) += srcutree.o
 obj-$(CONFIG_TINY_SRCU) += srcutiny.o
 obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
-obj-$(CONFIG_RCU_PERF_TEST) += rcuperf.o
+obj-$(CONFIG_RCU_SCALE_TEST) += rcuscale.o
 obj-$(CONFIG_RCU_REF_SCALE_TEST) += refscale.o
 obj-$(CONFIG_TREE_RCU) += tree.o
 obj-$(CONFIG_TINY_RCU) += tiny.o
diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuscale.c
similarity index 64%
rename from kernel/rcu/rcuperf.c
rename to kernel/rcu/rcuscale.c
index 21448d3..2819b95 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuscale.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * Read-Copy Update module-based performance-test facility
+ * Read-Copy Update module-based scalability-test facility
  *
  * Copyright (C) IBM Corporation, 2015
  *
@@ -44,13 +44,13 @@
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 
-#define PERF_FLAG "-perf:"
-#define PERFOUT_STRING(s) \
-	pr_alert("%s" PERF_FLAG " %s\n", perf_type, s)
-#define VERBOSE_PERFOUT_STRING(s) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG " %s\n", perf_type, s); } while (0)
-#define VERBOSE_PERFOUT_ERRSTRING(s) \
-	do { if (verbose) pr_alert("%s" PERF_FLAG "!!! %s\n", perf_type, s); } while (0)
+#define SCALE_FLAG "-scale:"
+#define SCALEOUT_STRING(s) \
+	pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s)
+#define VERBOSE_SCALEOUT_STRING(s) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG " %s\n", scale_type, s); } while (0)
+#define VERBOSE_SCALEOUT_ERRSTRING(s) \
+	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! %s\n", scale_type, s); } while (0)
 
 /*
  * The intended use cases for the nreaders and nwriters module parameters
@@ -61,25 +61,25 @@ MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
  *	nr_cpus for a mixed reader/writer test.
  *
  * 2.	Specify the nr_cpus kernel boot parameter, but set
- *	rcuperf.nreaders to zero.  This will set nwriters to the
+ *	rcuscale.nreaders to zero.  This will set nwriters to the
  *	value specified by nr_cpus for an update-only test.
  *
  * 3.	Specify the nr_cpus kernel boot parameter, but set
- *	rcuperf.nwriters to zero.  This will set nreaders to the
+ *	rcuscale.nwriters to zero.  This will set nreaders to the
  *	value specified by nr_cpus for a read-only test.
  *
  * Various other use cases may of course be specified.
  *
  * Note that this test's readers are intended only as a test load for
- * the writers.  The reader performance statistics will be overly
+ * the writers.  The reader scalability statistics will be overly
  * pessimistic due to the per-critical-section interrupt disabling,
  * test-end checks, and the pair of calls through pointers.
  */
 
 #ifdef MODULE
-# define RCUPERF_SHUTDOWN 0
+# define RCUSCALE_SHUTDOWN 0
 #else
-# define RCUPERF_SHUTDOWN 1
+# define RCUSCALE_SHUTDOWN 1
 #endif
 
 torture_param(bool, gp_async, false, "Use asynchronous GP wait primitives");
@@ -88,16 +88,16 @@ torture_param(bool, gp_exp, false, "Use expedited GP wait primitives");
 torture_param(int, holdoff, 10, "Holdoff time before test start (s)");
 torture_param(int, nreaders, -1, "Number of RCU reader threads");
 torture_param(int, nwriters, -1, "Number of RCU updater threads");
-torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
-	      "Shutdown at end of performance tests.");
+torture_param(bool, shutdown, RCUSCALE_SHUTDOWN,
+	      "Shutdown at end of scalability tests.");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
-torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
+torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() scale test?");
 torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 
-static char *perf_type = "rcu";
-module_param(perf_type, charp, 0444);
-MODULE_PARM_DESC(perf_type, "Type of RCU to performance-test (rcu, srcu, ...)");
+static char *scale_type = "rcu";
+module_param(scale_type, charp, 0444);
+MODULE_PARM_DESC(scale_type, "Type of RCU to scalability-test (rcu, srcu, ...)");
 
 static int nrealreaders;
 static int nrealwriters;
@@ -107,12 +107,12 @@ static struct task_struct *shutdown_task;
 
 static u64 **writer_durations;
 static int *writer_n_durations;
-static atomic_t n_rcu_perf_reader_started;
-static atomic_t n_rcu_perf_writer_started;
-static atomic_t n_rcu_perf_writer_finished;
+static atomic_t n_rcu_scale_reader_started;
+static atomic_t n_rcu_scale_writer_started;
+static atomic_t n_rcu_scale_writer_finished;
 static wait_queue_head_t shutdown_wq;
-static u64 t_rcu_perf_writer_started;
-static u64 t_rcu_perf_writer_finished;
+static u64 t_rcu_scale_writer_started;
+static u64 t_rcu_scale_writer_finished;
 static unsigned long b_rcu_gp_test_started;
 static unsigned long b_rcu_gp_test_finished;
 static DEFINE_PER_CPU(atomic_t, n_async_inflight);
@@ -124,7 +124,7 @@ static DEFINE_PER_CPU(atomic_t, n_async_inflight);
  * Operations vector for selecting different types of tests.
  */
 
-struct rcu_perf_ops {
+struct rcu_scale_ops {
 	int ptype;
 	void (*init)(void);
 	void (*cleanup)(void);
@@ -140,19 +140,19 @@ struct rcu_perf_ops {
 	const char *name;
 };
 
-static struct rcu_perf_ops *cur_ops;
+static struct rcu_scale_ops *cur_ops;
 
 /*
- * Definitions for rcu perf testing.
+ * Definitions for rcu scalability testing.
  */
 
-static int rcu_perf_read_lock(void) __acquires(RCU)
+static int rcu_scale_read_lock(void) __acquires(RCU)
 {
 	rcu_read_lock();
 	return 0;
 }
 
-static void rcu_perf_read_unlock(int idx) __releases(RCU)
+static void rcu_scale_read_unlock(int idx) __releases(RCU)
 {
 	rcu_read_unlock();
 }
@@ -162,15 +162,15 @@ static unsigned long __maybe_unused rcu_no_completed(void)
 	return 0;
 }
 
-static void rcu_sync_perf_init(void)
+static void rcu_sync_scale_init(void)
 {
 }
 
-static struct rcu_perf_ops rcu_ops = {
+static struct rcu_scale_ops rcu_ops = {
 	.ptype		= RCU_FLAVOR,
-	.init		= rcu_sync_perf_init,
-	.readlock	= rcu_perf_read_lock,
-	.readunlock	= rcu_perf_read_unlock,
+	.init		= rcu_sync_scale_init,
+	.readlock	= rcu_scale_read_lock,
+	.readunlock	= rcu_scale_read_unlock,
 	.get_gp_seq	= rcu_get_gp_seq,
 	.gp_diff	= rcu_seq_diff,
 	.exp_completed	= rcu_exp_batches_completed,
@@ -182,23 +182,23 @@ static struct rcu_perf_ops rcu_ops = {
 };
 
 /*
- * Definitions for srcu perf testing.
+ * Definitions for srcu scalability testing.
  */
 
-DEFINE_STATIC_SRCU(srcu_ctl_perf);
-static struct srcu_struct *srcu_ctlp = &srcu_ctl_perf;
+DEFINE_STATIC_SRCU(srcu_ctl_scale);
+static struct srcu_struct *srcu_ctlp = &srcu_ctl_scale;
 
-static int srcu_perf_read_lock(void) __acquires(srcu_ctlp)
+static int srcu_scale_read_lock(void) __acquires(srcu_ctlp)
 {
 	return srcu_read_lock(srcu_ctlp);
 }
 
-static void srcu_perf_read_unlock(int idx) __releases(srcu_ctlp)
+static void srcu_scale_read_unlock(int idx) __releases(srcu_ctlp)
 {
 	srcu_read_unlock(srcu_ctlp, idx);
 }
 
-static unsigned long srcu_perf_completed(void)
+static unsigned long srcu_scale_completed(void)
 {
 	return srcu_batches_completed(srcu_ctlp);
 }
@@ -213,78 +213,78 @@ static void srcu_rcu_barrier(void)
 	srcu_barrier(srcu_ctlp);
 }
 
-static void srcu_perf_synchronize(void)
+static void srcu_scale_synchronize(void)
 {
 	synchronize_srcu(srcu_ctlp);
 }
 
-static void srcu_perf_synchronize_expedited(void)
+static void srcu_scale_synchronize_expedited(void)
 {
 	synchronize_srcu_expedited(srcu_ctlp);
 }
 
-static struct rcu_perf_ops srcu_ops = {
+static struct rcu_scale_ops srcu_ops = {
 	.ptype		= SRCU_FLAVOR,
-	.init		= rcu_sync_perf_init,
-	.readlock	= srcu_perf_read_lock,
-	.readunlock	= srcu_perf_read_unlock,
-	.get_gp_seq	= srcu_perf_completed,
+	.init		= rcu_sync_scale_init,
+	.readlock	= srcu_scale_read_lock,
+	.readunlock	= srcu_scale_read_unlock,
+	.get_gp_seq	= srcu_scale_completed,
 	.gp_diff	= rcu_seq_diff,
-	.exp_completed	= srcu_perf_completed,
+	.exp_completed	= srcu_scale_completed,
 	.async		= srcu_call_rcu,
 	.gp_barrier	= srcu_rcu_barrier,
-	.sync		= srcu_perf_synchronize,
-	.exp_sync	= srcu_perf_synchronize_expedited,
+	.sync		= srcu_scale_synchronize,
+	.exp_sync	= srcu_scale_synchronize_expedited,
 	.name		= "srcu"
 };
 
 static struct srcu_struct srcud;
 
-static void srcu_sync_perf_init(void)
+static void srcu_sync_scale_init(void)
 {
 	srcu_ctlp = &srcud;
 	init_srcu_struct(srcu_ctlp);
 }
 
-static void srcu_sync_perf_cleanup(void)
+static void srcu_sync_scale_cleanup(void)
 {
 	cleanup_srcu_struct(srcu_ctlp);
 }
 
-static struct rcu_perf_ops srcud_ops = {
+static struct rcu_scale_ops srcud_ops = {
 	.ptype		= SRCU_FLAVOR,
-	.init		= srcu_sync_perf_init,
-	.cleanup	= srcu_sync_perf_cleanup,
-	.readlock	= srcu_perf_read_lock,
-	.readunlock	= srcu_perf_read_unlock,
-	.get_gp_seq	= srcu_perf_completed,
+	.init		= srcu_sync_scale_init,
+	.cleanup	= srcu_sync_scale_cleanup,
+	.readlock	= srcu_scale_read_lock,
+	.readunlock	= srcu_scale_read_unlock,
+	.get_gp_seq	= srcu_scale_completed,
 	.gp_diff	= rcu_seq_diff,
-	.exp_completed	= srcu_perf_completed,
+	.exp_completed	= srcu_scale_completed,
 	.async		= srcu_call_rcu,
 	.gp_barrier	= srcu_rcu_barrier,
-	.sync		= srcu_perf_synchronize,
-	.exp_sync	= srcu_perf_synchronize_expedited,
+	.sync		= srcu_scale_synchronize,
+	.exp_sync	= srcu_scale_synchronize_expedited,
 	.name		= "srcud"
 };
 
 /*
- * Definitions for RCU-tasks perf testing.
+ * Definitions for RCU-tasks scalability testing.
  */
 
-static int tasks_perf_read_lock(void)
+static int tasks_scale_read_lock(void)
 {
 	return 0;
 }
 
-static void tasks_perf_read_unlock(int idx)
+static void tasks_scale_read_unlock(int idx)
 {
 }
 
-static struct rcu_perf_ops tasks_ops = {
+static struct rcu_scale_ops tasks_ops = {
 	.ptype		= RCU_TASKS_FLAVOR,
-	.init		= rcu_sync_perf_init,
-	.readlock	= tasks_perf_read_lock,
-	.readunlock	= tasks_perf_read_unlock,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_scale_read_lock,
+	.readunlock	= tasks_scale_read_unlock,
 	.get_gp_seq	= rcu_no_completed,
 	.gp_diff	= rcu_seq_diff,
 	.async		= call_rcu_tasks,
@@ -294,7 +294,7 @@ static struct rcu_perf_ops tasks_ops = {
 	.name		= "tasks"
 };
 
-static unsigned long rcuperf_seq_diff(unsigned long new, unsigned long old)
+static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
 		return new - old;
@@ -302,60 +302,60 @@ static unsigned long rcuperf_seq_diff(unsigned long new, unsigned long old)
 }
 
 /*
- * If performance tests complete, wait for shutdown to commence.
+ * If scalability tests complete, wait for shutdown to commence.
  */
-static void rcu_perf_wait_shutdown(void)
+static void rcu_scale_wait_shutdown(void)
 {
 	cond_resched_tasks_rcu_qs();
-	if (atomic_read(&n_rcu_perf_writer_finished) < nrealwriters)
+	if (atomic_read(&n_rcu_scale_writer_finished) < nrealwriters)
 		return;
 	while (!torture_must_stop())
 		schedule_timeout_uninterruptible(1);
 }
 
 /*
- * RCU perf reader kthread.  Repeatedly does empty RCU read-side critical
- * section, minimizing update-side interference.  However, the point of
- * this test is not to evaluate reader performance, but instead to serve
- * as a test load for update-side performance testing.
+ * RCU scalability reader kthread.  Repeatedly does empty RCU read-side
+ * critical section, minimizing update-side interference.  However, the
+ * point of this test is not to evaluate reader scalability, but instead
+ * to serve as a test load for update-side scalability testing.
  */
 static int
-rcu_perf_reader(void *arg)
+rcu_scale_reader(void *arg)
 {
 	unsigned long flags;
 	int idx;
 	long me = (long)arg;
 
-	VERBOSE_PERFOUT_STRING("rcu_perf_reader task started");
+	VERBOSE_SCALEOUT_STRING("rcu_scale_reader task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
-	atomic_inc(&n_rcu_perf_reader_started);
+	atomic_inc(&n_rcu_scale_reader_started);
 
 	do {
 		local_irq_save(flags);
 		idx = cur_ops->readlock();
 		cur_ops->readunlock(idx);
 		local_irq_restore(flags);
-		rcu_perf_wait_shutdown();
+		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
-	torture_kthread_stopping("rcu_perf_reader");
+	torture_kthread_stopping("rcu_scale_reader");
 	return 0;
 }
 
 /*
- * Callback function for asynchronous grace periods from rcu_perf_writer().
+ * Callback function for asynchronous grace periods from rcu_scale_writer().
  */
-static void rcu_perf_async_cb(struct rcu_head *rhp)
+static void rcu_scale_async_cb(struct rcu_head *rhp)
 {
 	atomic_dec(this_cpu_ptr(&n_async_inflight));
 	kfree(rhp);
 }
 
 /*
- * RCU perf writer kthread.  Repeatedly does a grace period.
+ * RCU scale writer kthread.  Repeatedly does a grace period.
  */
 static int
-rcu_perf_writer(void *arg)
+rcu_scale_writer(void *arg)
 {
 	int i = 0;
 	int i_max;
@@ -366,7 +366,7 @@ rcu_perf_writer(void *arg)
 	u64 *wdp;
 	u64 *wdpp = writer_durations[me];
 
-	VERBOSE_PERFOUT_STRING("rcu_perf_writer task started");
+	VERBOSE_SCALEOUT_STRING("rcu_scale_writer task started");
 	WARN_ON(!wdpp);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	sched_set_fifo_low(current);
@@ -383,8 +383,8 @@ rcu_perf_writer(void *arg)
 		schedule_timeout_uninterruptible(1);
 
 	t = ktime_get_mono_fast_ns();
-	if (atomic_inc_return(&n_rcu_perf_writer_started) >= nrealwriters) {
-		t_rcu_perf_writer_started = t;
+	if (atomic_inc_return(&n_rcu_scale_writer_started) >= nrealwriters) {
+		t_rcu_scale_writer_started = t;
 		if (gp_exp) {
 			b_rcu_gp_test_started =
 				cur_ops->exp_completed() / 2;
@@ -404,7 +404,7 @@ rcu_perf_writer(void *arg)
 				rhp = kmalloc(sizeof(*rhp), GFP_KERNEL);
 			if (rhp && atomic_read(this_cpu_ptr(&n_async_inflight)) < gp_async_max) {
 				atomic_inc(this_cpu_ptr(&n_async_inflight));
-				cur_ops->async(rhp, rcu_perf_async_cb);
+				cur_ops->async(rhp, rcu_scale_async_cb);
 				rhp = NULL;
 			} else if (!kthread_should_stop()) {
 				cur_ops->gp_barrier();
@@ -421,19 +421,19 @@ rcu_perf_writer(void *arg)
 		*wdp = t - *wdp;
 		i_max = i;
 		if (!started &&
-		    atomic_read(&n_rcu_perf_writer_started) >= nrealwriters)
+		    atomic_read(&n_rcu_scale_writer_started) >= nrealwriters)
 			started = true;
 		if (!done && i >= MIN_MEAS) {
 			done = true;
 			sched_set_normal(current, 0);
-			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
-				 perf_type, PERF_FLAG, me, MIN_MEAS);
-			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
+			pr_alert("%s%s rcu_scale_writer %ld has %d measurements\n",
+				 scale_type, SCALE_FLAG, me, MIN_MEAS);
+			if (atomic_inc_return(&n_rcu_scale_writer_finished) >=
 			    nrealwriters) {
 				schedule_timeout_interruptible(10);
 				rcu_ftrace_dump(DUMP_ALL);
-				PERFOUT_STRING("Test complete");
-				t_rcu_perf_writer_finished = t;
+				SCALEOUT_STRING("Test complete");
+				t_rcu_scale_writer_finished = t;
 				if (gp_exp) {
 					b_rcu_gp_test_finished =
 						cur_ops->exp_completed() / 2;
@@ -448,30 +448,30 @@ rcu_perf_writer(void *arg)
 			}
 		}
 		if (done && !alldone &&
-		    atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters)
+		    atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters)
 			alldone = true;
 		if (started && !alldone && i < MAX_MEAS - 1)
 			i++;
-		rcu_perf_wait_shutdown();
+		rcu_scale_wait_shutdown();
 	} while (!torture_must_stop());
 	if (gp_async) {
 		cur_ops->gp_barrier();
 	}
 	writer_n_durations[me] = i_max;
-	torture_kthread_stopping("rcu_perf_writer");
+	torture_kthread_stopping("rcu_scale_writer");
 	return 0;
 }
 
 static void
-rcu_perf_print_module_parms(struct rcu_perf_ops *cur_ops, const char *tag)
+rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
 {
-	pr_alert("%s" PERF_FLAG
+	pr_alert("%s" SCALE_FLAG
 		 "--- %s: nreaders=%d nwriters=%d verbose=%d shutdown=%d\n",
-		 perf_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
+		 scale_type, tag, nrealreaders, nrealwriters, verbose, shutdown);
 }
 
 static void
-rcu_perf_cleanup(void)
+rcu_scale_cleanup(void)
 {
 	int i;
 	int j;
@@ -484,11 +484,11 @@ rcu_perf_cleanup(void)
 	 * during the mid-boot phase, so have to wait till the end.
 	 */
 	if (rcu_gp_is_expedited() && !rcu_gp_is_normal() && !gp_exp)
-		VERBOSE_PERFOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
+		VERBOSE_SCALEOUT_ERRSTRING("All grace periods expedited, no normal ones to measure!");
 	if (rcu_gp_is_normal() && gp_exp)
-		VERBOSE_PERFOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
+		VERBOSE_SCALEOUT_ERRSTRING("All grace periods normal, no expedited ones to measure!");
 	if (gp_exp && gp_async)
-		VERBOSE_PERFOUT_ERRSTRING("No expedited async GPs, so went with async!");
+		VERBOSE_SCALEOUT_ERRSTRING("No expedited async GPs, so went with async!");
 
 	if (torture_cleanup_begin())
 		return;
@@ -499,30 +499,30 @@ rcu_perf_cleanup(void)
 
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
-			torture_stop_kthread(rcu_perf_reader,
+			torture_stop_kthread(rcu_scale_reader,
 					     reader_tasks[i]);
 		kfree(reader_tasks);
 	}
 
 	if (writer_tasks) {
 		for (i = 0; i < nrealwriters; i++) {
-			torture_stop_kthread(rcu_perf_writer,
+			torture_stop_kthread(rcu_scale_writer,
 					     writer_tasks[i]);
 			if (!writer_n_durations)
 				continue;
 			j = writer_n_durations[i];
 			pr_alert("%s%s writer %d gps: %d\n",
-				 perf_type, PERF_FLAG, i, j);
+				 scale_type, SCALE_FLAG, i, j);
 			ngps += j;
 		}
 		pr_alert("%s%s start: %llu end: %llu duration: %llu gps: %d batches: %ld\n",
-			 perf_type, PERF_FLAG,
-			 t_rcu_perf_writer_started, t_rcu_perf_writer_finished,
-			 t_rcu_perf_writer_finished -
-			 t_rcu_perf_writer_started,
+			 scale_type, SCALE_FLAG,
+			 t_rcu_scale_writer_started, t_rcu_scale_writer_finished,
+			 t_rcu_scale_writer_finished -
+			 t_rcu_scale_writer_started,
 			 ngps,
-			 rcuperf_seq_diff(b_rcu_gp_test_finished,
-					  b_rcu_gp_test_started));
+			 rcuscale_seq_diff(b_rcu_gp_test_finished,
+					   b_rcu_gp_test_started));
 		for (i = 0; i < nrealwriters; i++) {
 			if (!writer_durations)
 				break;
@@ -534,7 +534,7 @@ rcu_perf_cleanup(void)
 			for (j = 0; j <= writer_n_durations[i]; j++) {
 				wdp = &wdpp[j];
 				pr_alert("%s%s %4d writer-duration: %5d %llu\n",
-					perf_type, PERF_FLAG,
+					scale_type, SCALE_FLAG,
 					i, j, *wdp);
 				if (j % 100 == 0)
 					schedule_timeout_uninterruptible(1);
@@ -573,22 +573,22 @@ static int compute_real(int n)
 }
 
 /*
- * RCU perf shutdown kthread.  Just waits to be awakened, then shuts
+ * RCU scalability shutdown kthread.  Just waits to be awakened, then shuts
  * down system.
  */
 static int
-rcu_perf_shutdown(void *arg)
+rcu_scale_shutdown(void *arg)
 {
 	wait_event(shutdown_wq,
-		   atomic_read(&n_rcu_perf_writer_finished) >= nrealwriters);
+		   atomic_read(&n_rcu_scale_writer_finished) >= nrealwriters);
 	smp_mb(); /* Wake before output. */
-	rcu_perf_cleanup();
+	rcu_scale_cleanup();
 	kernel_power_off();
 	return -EINVAL;
 }
 
 /*
- * kfree_rcu() performance tests: Start a kfree_rcu() loop on all CPUs for number
+ * kfree_rcu() scalability tests: Start a kfree_rcu() loop on all CPUs for number
  * of iterations and measure total time and number of GP for all iterations to complete.
  */
 
@@ -598,8 +598,8 @@ torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num alloc
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
-static atomic_t n_kfree_perf_thread_started;
-static atomic_t n_kfree_perf_thread_ended;
+static atomic_t n_kfree_scale_thread_started;
+static atomic_t n_kfree_scale_thread_ended;
 
 struct kfree_obj {
 	char kfree_obj[8];
@@ -607,7 +607,7 @@ struct kfree_obj {
 };
 
 static int
-kfree_perf_thread(void *arg)
+kfree_scale_thread(void *arg)
 {
 	int i, loop = 0;
 	long me = (long)arg;
@@ -615,13 +615,13 @@ kfree_perf_thread(void *arg)
 	u64 start_time, end_time;
 	long long mem_begin, mem_during = 0;
 
-	VERBOSE_PERFOUT_STRING("kfree_perf_thread task started");
+	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 
 	start_time = ktime_get_mono_fast_ns();
 
-	if (atomic_inc_return(&n_kfree_perf_thread_started) >= kfree_nrealthreads) {
+	if (atomic_inc_return(&n_kfree_scale_thread_started) >= kfree_nrealthreads) {
 		if (gp_exp)
 			b_rcu_gp_test_started = cur_ops->exp_completed() / 2;
 		else
@@ -646,7 +646,7 @@ kfree_perf_thread(void *arg)
 		cond_resched();
 	} while (!torture_must_stop() && ++loop < kfree_loops);
 
-	if (atomic_inc_return(&n_kfree_perf_thread_ended) >= kfree_nrealthreads) {
+	if (atomic_inc_return(&n_kfree_scale_thread_ended) >= kfree_nrealthreads) {
 		end_time = ktime_get_mono_fast_ns();
 
 		if (gp_exp)
@@ -656,7 +656,7 @@ kfree_perf_thread(void *arg)
 
 		pr_alert("Total time taken by all kfree'ers: %llu ns, loops: %d, batches: %ld, memory footprint: %lldMB\n",
 		       (unsigned long long)(end_time - start_time), kfree_loops,
-		       rcuperf_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
+		       rcuscale_seq_diff(b_rcu_gp_test_finished, b_rcu_gp_test_started),
 		       (mem_begin - mem_during) >> (20 - PAGE_SHIFT));
 
 		if (shutdown) {
@@ -665,12 +665,12 @@ kfree_perf_thread(void *arg)
 		}
 	}
 
-	torture_kthread_stopping("kfree_perf_thread");
+	torture_kthread_stopping("kfree_scale_thread");
 	return 0;
 }
 
 static void
-kfree_perf_cleanup(void)
+kfree_scale_cleanup(void)
 {
 	int i;
 
@@ -679,7 +679,7 @@ kfree_perf_cleanup(void)
 
 	if (kfree_reader_tasks) {
 		for (i = 0; i < kfree_nrealthreads; i++)
-			torture_stop_kthread(kfree_perf_thread,
+			torture_stop_kthread(kfree_scale_thread,
 					     kfree_reader_tasks[i]);
 		kfree(kfree_reader_tasks);
 	}
@@ -691,20 +691,20 @@ kfree_perf_cleanup(void)
  * shutdown kthread.  Just waits to be awakened, then shuts down system.
  */
 static int
-kfree_perf_shutdown(void *arg)
+kfree_scale_shutdown(void *arg)
 {
 	wait_event(shutdown_wq,
-		   atomic_read(&n_kfree_perf_thread_ended) >= kfree_nrealthreads);
+		   atomic_read(&n_kfree_scale_thread_ended) >= kfree_nrealthreads);
 
 	smp_mb(); /* Wake before output. */
 
-	kfree_perf_cleanup();
+	kfree_scale_cleanup();
 	kernel_power_off();
 	return -EINVAL;
 }
 
 static int __init
-kfree_perf_init(void)
+kfree_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
@@ -713,7 +713,7 @@ kfree_perf_init(void)
 	/* Start up the kthreads. */
 	if (shutdown) {
 		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
+		firsterr = torture_create_kthread(kfree_scale_shutdown, NULL,
 						  shutdown_task);
 		if (firsterr)
 			goto unwind;
@@ -730,13 +730,13 @@ kfree_perf_init(void)
 	}
 
 	for (i = 0; i < kfree_nrealthreads; i++) {
-		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
+		firsterr = torture_create_kthread(kfree_scale_thread, (void *)i,
 						  kfree_reader_tasks[i]);
 		if (firsterr)
 			goto unwind;
 	}
 
-	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
+	while (atomic_read(&n_kfree_scale_thread_started) < kfree_nrealthreads)
 		schedule_timeout_uninterruptible(1);
 
 	torture_init_end();
@@ -744,35 +744,35 @@ kfree_perf_init(void)
 
 unwind:
 	torture_init_end();
-	kfree_perf_cleanup();
+	kfree_scale_cleanup();
 	return firsterr;
 }
 
 static int __init
-rcu_perf_init(void)
+rcu_scale_init(void)
 {
 	long i;
 	int firsterr = 0;
-	static struct rcu_perf_ops *perf_ops[] = {
+	static struct rcu_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
 	};
 
-	if (!torture_init_begin(perf_type, verbose))
+	if (!torture_init_begin(scale_type, verbose))
 		return -EBUSY;
 
-	/* Process args and tell the world that the perf'er is on the job. */
-	for (i = 0; i < ARRAY_SIZE(perf_ops); i++) {
-		cur_ops = perf_ops[i];
-		if (strcmp(perf_type, cur_ops->name) == 0)
+	/* Process args and announce that the scalability'er is on the job. */
+	for (i = 0; i < ARRAY_SIZE(scale_ops); i++) {
+		cur_ops = scale_ops[i];
+		if (strcmp(scale_type, cur_ops->name) == 0)
 			break;
 	}
-	if (i == ARRAY_SIZE(perf_ops)) {
-		pr_alert("rcu-perf: invalid perf type: \"%s\"\n", perf_type);
-		pr_alert("rcu-perf types:");
-		for (i = 0; i < ARRAY_SIZE(perf_ops); i++)
-			pr_cont(" %s", perf_ops[i]->name);
+	if (i == ARRAY_SIZE(scale_ops)) {
+		pr_alert("rcu-scale: invalid scale type: \"%s\"\n", scale_type);
+		pr_alert("rcu-scale types:");
+		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
+			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_PERF_TEST));
+		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -781,20 +781,20 @@ rcu_perf_init(void)
 		cur_ops->init();
 
 	if (kfree_rcu_test)
-		return kfree_perf_init();
+		return kfree_scale_init();
 
 	nrealwriters = compute_real(nwriters);
 	nrealreaders = compute_real(nreaders);
-	atomic_set(&n_rcu_perf_reader_started, 0);
-	atomic_set(&n_rcu_perf_writer_started, 0);
-	atomic_set(&n_rcu_perf_writer_finished, 0);
-	rcu_perf_print_module_parms(cur_ops, "Start of test");
+	atomic_set(&n_rcu_scale_reader_started, 0);
+	atomic_set(&n_rcu_scale_writer_started, 0);
+	atomic_set(&n_rcu_scale_writer_finished, 0);
+	rcu_scale_print_module_parms(cur_ops, "Start of test");
 
 	/* Start up the kthreads. */
 
 	if (shutdown) {
 		init_waitqueue_head(&shutdown_wq);
-		firsterr = torture_create_kthread(rcu_perf_shutdown, NULL,
+		firsterr = torture_create_kthread(rcu_scale_shutdown, NULL,
 						  shutdown_task);
 		if (firsterr)
 			goto unwind;
@@ -803,17 +803,17 @@ rcu_perf_init(void)
 	reader_tasks = kcalloc(nrealreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (reader_tasks == NULL) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
 	for (i = 0; i < nrealreaders; i++) {
-		firsterr = torture_create_kthread(rcu_perf_reader, (void *)i,
+		firsterr = torture_create_kthread(rcu_scale_reader, (void *)i,
 						  reader_tasks[i]);
 		if (firsterr)
 			goto unwind;
 	}
-	while (atomic_read(&n_rcu_perf_reader_started) < nrealreaders)
+	while (atomic_read(&n_rcu_scale_reader_started) < nrealreaders)
 		schedule_timeout_uninterruptible(1);
 	writer_tasks = kcalloc(nrealwriters, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
@@ -823,7 +823,7 @@ rcu_perf_init(void)
 		kcalloc(nrealwriters, sizeof(*writer_n_durations),
 			GFP_KERNEL);
 	if (!writer_tasks || !writer_durations || !writer_n_durations) {
-		VERBOSE_PERFOUT_ERRSTRING("out of memory");
+		VERBOSE_SCALEOUT_ERRSTRING("out of memory");
 		firsterr = -ENOMEM;
 		goto unwind;
 	}
@@ -835,7 +835,7 @@ rcu_perf_init(void)
 			firsterr = -ENOMEM;
 			goto unwind;
 		}
-		firsterr = torture_create_kthread(rcu_perf_writer, (void *)i,
+		firsterr = torture_create_kthread(rcu_scale_writer, (void *)i,
 						  writer_tasks[i]);
 		if (firsterr)
 			goto unwind;
@@ -845,9 +845,9 @@ rcu_perf_init(void)
 
 unwind:
 	torture_init_end();
-	rcu_perf_cleanup();
+	rcu_scale_cleanup();
 	return firsterr;
 }
 
-module_init(rcu_perf_init);
-module_exit(rcu_perf_cleanup);
+module_init(rcu_scale_init);
+module_exit(rcu_scale_cleanup);
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh
similarity index 92%
rename from tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
rename to tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh
index 7d3c2be..d4bec53 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf-ftrace.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale-ftrace.sh
@@ -1,12 +1,12 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Analyze a given results directory for rcuperf performance measurements,
+# Analyze a given results directory for rcuscale performance measurements,
 # looking for ftrace data.  Exits with 0 if data was found, analyzed, and
-# printed.  Intended to be invoked from kvm-recheck-rcuperf.sh after
+# printed.  Intended to be invoked from kvm-recheck-rcuscale.sh after
 # argument checking.
 #
-# Usage: kvm-recheck-rcuperf-ftrace.sh resdir
+# Usage: kvm-recheck-rcuscale-ftrace.sh resdir
 #
 # Copyright (C) IBM Corporation, 2016
 #
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
similarity index 84%
rename from tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
rename to tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
index db0375a..aa74515 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuperf.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
@@ -1,9 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Analyze a given results directory for rcuperf performance measurements.
+# Analyze a given results directory for rcuscale scalability measurements.
 #
-# Usage: kvm-recheck-rcuperf.sh resdir
+# Usage: kvm-recheck-rcuscale.sh resdir
 #
 # Copyright (C) IBM Corporation, 2016
 #
@@ -20,7 +20,7 @@ fi
 PATH=`pwd`/tools/testing/selftests/rcutorture/bin:$PATH; export PATH
 . functions.sh
 
-if kvm-recheck-rcuperf-ftrace.sh $i
+if kvm-recheck-rcuscale-ftrace.sh $i
 then
 	# ftrace data was successfully analyzed, call it good!
 	exit 0
@@ -30,12 +30,12 @@ configfile=`echo $i | sed -e 's/^.*\///'`
 
 sed -e 's/^\[[^]]*]//' < $i/console.log |
 awk '
-/-perf: .* gps: .* batches:/ {
+/-scale: .* gps: .* batches:/ {
 	ngps = $9;
 	nbatches = $11;
 }
 
-/-perf: .*writer-duration/ {
+/-scale: .*writer-duration/ {
 	gptimes[++n] = $5 / 1000.;
 	sum += $5 / 1000.;
 }
@@ -43,7 +43,7 @@ awk '
 END {
 	newNR = asort(gptimes);
 	if (newNR <= 0) {
-		print "No rcuperf records found???"
+		print "No rcuscale records found???"
 		exit;
 	}
 	pct50 = int(newNR * 50 / 100);
@@ -79,5 +79,5 @@ END {
 	print "99th percentile grace-period duration: " gptimes[pct99];
 	print "Maximum grace-period duration: " gptimes[newNR];
 	print "Grace periods: " ngps + 0 " Batches: " nbatches + 0 " Ratio: " ngps / nbatches;
-	print "Computed from rcuperf printk output.";
+	print "Computed from rcuscale printk output.";
 }'
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 44dfdd9..0489c19 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -65,7 +65,7 @@ usage () {
 	echo "       --qemu-args qemu-arguments"
 	echo "       --qemu-cmd qemu-system-..."
 	echo "       --results absolute-pathname"
-	echo "       --torture rcu"
+	echo "       --torture lock|rcu|rcuscale|refscale|scf"
 	echo "       --trust-make"
 	exit 1
 }
@@ -184,13 +184,13 @@ do
 		shift
 		;;
 	--torture)
-		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuperf\|refscale\|scf\)$' '^--'
+		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\)$' '^--'
 		TORTURE_SUITE=$2
 		shift
-		if test "$TORTURE_SUITE" = rcuperf || test "$TORTURE_SUITE" = refscale
+		if test "$TORTURE_SUITE" = rcuscale || test "$TORTURE_SUITE" = refscale
 		then
 			# If you really want jitter for refscale or
-			# rcuperf, specify it after specifying the rcuperf
+			# rcuscale, specify it after specifying the rcuscale
 			# or the refscale.  (But why jitter in these cases?)
 			jitter=0
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 4e081a2..e033380 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -33,8 +33,8 @@ then
 fi
 cat /dev/null > $file.diags
 
-# Check for proper termination, except for rcuperf and refscale.
-if test "$TORTURE_SUITE" != rcuperf && test "$TORTURE_SUITE" != refscale
+# Check for proper termination, except for rcuscale and refscale.
+if test "$TORTURE_SUITE" != rcuscale && test "$TORTURE_SUITE" != refscale
 then
 	# check for abject failure
 
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
deleted file mode 100644
index a09816b..0000000
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/CFcommon
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_RCU_PERF_TEST=y
-CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST b/tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcuperf/CFLIST
rename to tools/testing/selftests/rcutorture/configs/rcuscale/CFLIST
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
new file mode 100644
index 0000000..87caa0e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -0,0 +1,2 @@
+CONFIG_RCU_SCALE_TEST=y
+CONFIG_PRINTK_TIME=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/TINY b/tools/testing/selftests/rcutorture/configs/rcuscale/TINY
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcuperf/TINY
rename to tools/testing/selftests/rcutorture/configs/rcuscale/TINY
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/TREE b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcuperf/TREE
rename to tools/testing/selftests/rcutorture/configs/rcuscale/TREE
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/TREE54 b/tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
similarity index 100%
rename from tools/testing/selftests/rcutorture/configs/rcuperf/TREE54
rename to tools/testing/selftests/rcutorture/configs/rcuscale/TREE54
diff --git a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
similarity index 88%
rename from tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
rename to tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
index 777d5b0..0333e9b 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuperf/ver_functions.sh
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/ver_functions.sh
@@ -11,6 +11,6 @@
 #
 # Adds per-version torture-module parameters to kernels supporting them.
 per_version_boot_params () {
-	echo $1 rcuperf.shutdown=1 \
-		rcuperf.verbose=1
+	echo $1 rcuscale.shutdown=1 \
+		rcuscale.verbose=1
 }
-- 
2.9.5


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B1C2DA17D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 21:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503239AbgLNU0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 15:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502983AbgLNU0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 15:26:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA24FC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 12:25:25 -0800 (PST)
Date:   Mon, 14 Dec 2020 20:22:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607977523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yMXrksUG9P5eJiZeeqotR7zSfd4cw/cVU53//jPj1tg=;
        b=JXE5CShHP/31eUhYNk3rSewUGJmK0gJ2zkJz5hPjnsmI+krp80uIo7nlFjewmmZEwvj7JN
        GaLArV5dD9/OogWitAxO2bZ+OazoCqVNYOR7SN/v+iYye8qBrFWSxB2cUE9GM8STvLTTDW
        IndFPMVqKDvE6cnpn3dZL1DBZVKVriALotncAbkUDc9xD0FUza6LGcpur0kIWnXZ8d13kY
        5iZYeKBBrjHEkTLN8t9RTLZntPWjplbrcGrf6mH8QF1NGPs9J3vsSUBXvrq52uoitAW5rl
        JSZiMNMG5RaURrwsLo8eD3MZiMWFzZy4vh6+QbXLTp+TXL7CM9eFl+f+3iCuBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607977523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yMXrksUG9P5eJiZeeqotR7zSfd4cw/cVU53//jPj1tg=;
        b=v+76mS6xtaBiLRg/+GiUxHLoCLUWV5TFw00O5DOCdogaXjlinq+ZgaNqWylCqLmUxh/+nt
        +nGXYSShV/FpOXAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [GIT pull] core/rcu for v5.11-rc1
References: <160797732939.10793.9152151866806316627.tglx@nanos>
Message-ID: <160797733061.10793.14355556994633266637.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/rcu branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-rcu-2020-12-14

up to:  50df51d12c31: Merge branch 'lkmm.2020.11.06a' into HEAD


RCU, LKMM and KCSAN updates collected by Paul McKenney:

  RCU:

    - Avoid cpuinfo-induced IPI pileups and idle-CPU IPIs.

    - Lockdep-RCU updates reducing the need for __maybe_unused.

    - Tasks-RCU updates.

    - Miscellaneous fixes.

    - Documentation updates.

    - Torture-test updates.

  KCSAN:
  
    - updates for selftests, avoiding setting watchpoints on NULL pointers

    - fix to watchpoint encoding

  LKMM:

    - updates for documentation along with some updates to example-code
      litmus tests  

Thanks,

	tglx

------------------>
Alan Stern (1):
      tools: memory-model: Document that the LKMM can easily miss control dependencies

Anna-Maria Behnsen (1):
      tools/rcutorture: Fix BUG parsing of console.log

Asif Rasheed (1):
      list.h: Update comment to explicitly note circular lists

Bhaskar Chowdhury (1):
      tools/nolibc:  Fix a spelling error in a comment

Fox Chen (1):
      docs/memory-barriers.txt: Fix a typo in CPU MEMORY BARRIERS section

Frederic Weisbecker (1):
      rcu: Implement rcu_segcblist_is_offloaded() config dependent

Hou Tao (2):
      locktorture: Ignore nreaders_stress if no readlock support
      locktorture: Invoke percpu_free_rwsem() to do percpu-rwsem cleanup

Hui Su (1):
      docs/rcu: Update the call_rcu() API

Jakub Kicinski (7):
      sched: Un-hide lockdep_tasklist_lock_is_held() for !LOCKDEP
      rcu: Un-hide lockdep maps for !LOCKDEP
      net: Un-hide lockdep_sock_is_held() for !LOCKDEP
      net: sched: Remove broken definitions and un-hide for !LOCKDEP
      srcu: Use a more appropriate lockdep helper
      lockdep: Provide dummy forward declaration of *_is_held() helpers
      rcu: Prevent RCU_LOCKDEP_WARN() from swallowing the condition

Joe Perches (1):
      rcu/tree: Make struct kernel_param_ops definitions const

Joel Fernandes (Google) (3):
      docs: Update RCU's hotplug requirements with a bit about design
      rcu/tree: Add a warning if CPU being onlined did not report QS already
      rcu/tree: nocb: Avoid raising softirq for offloaded ready-to-execute CBs

Marco Elver (3):
      kcsan: selftest: Ensure that address is at least PAGE_SIZE
      kcsan: Never set up watchpoints on NULL pointers
      kcsan: Fix encoding masks and regain address bit

Mauro Carvalho Chehab (1):
      docs: RCU: Requirements.rst: Fix a list block

Neeraj Upadhyay (2):
      rcu: Fix single-CPU check in rcu_blocking_is_gp()
      rcu: Clarify nocb kthreads naming in RCU_NOCB_CPU config

Paul E. McKenney (40):
      tools/memory-model: Move Documentation description to Documentation/README
      doc: Present the role of READ_ONCE()
      rcutorture: Make preemptible TRACE02 enable lockdep
      rcu-tasks: Convert rcu_tasks_wait_gp() for-loop to while-loop
      rcutorture: Make grace-period kthread report match RCU flavor being tested
      refscale: Bounds-check module parameters
      torture: Don't kill gdb sessions
      x86/cpu: Avoid cpuinfo-induced IPI pileups
      x86/cpu: Avoid cpuinfo-induced IPIing of idle CPUs
      locktorture: Track time of last ->writeunlock()
      torture: Periodically pause in stutter_wait()
      torture: Make torture_stutter() use hrtimer
      scftorture: Add an alternative IPI vector
      rcuscale: Add RCU Tasks Trace
      rcuscale: Avoid divide by zero
      torture: Exclude "NOHZ tick-stop error" from fatal errors
      rcuscale: Prevent hangs for invalid arguments
      refscale: Prevent hangs for invalid arguments
      rcutorture: Adjust scenarios SRCU-t and SRCU-u to make kconfig happy
      locktorture: Prevent hangs for invalid arguments
      torture: Prevent jitter processes from delaying failed run
      rcutorture: Prevent hangs for invalid arguments
      torture: Force weak-hashed pointers on console log
      rcutorture:  Make stutter_wait() caller restore priority
      torture: Accept time units on kvm.sh --duration argument
      rcutorture: Small code cleanups
      torture: Allow alternative forms of kvm.sh command-line arguments
      scftorture: Add full-test stutter capability
      rcutorture: Don't do need_resched() testing if ->sync is NULL
      torture: Make kvm-check-branches.sh use --allcpus
      rcu-tasks: Make the units of ->init_fract be jiffies
      tools/memory-model: Document categories of ordering primitives
      tools/memory-model: Add a glossary of LKMM terms
      tools/memory-model: Add types to litmus tests
      tools/memory-model: Use "buf" and "flag" for message-passing tests
      tools/memory-model: Label MP tests' producers and consumers
      x86/smpboot:  Move rcu_cpu_starting() earlier
      rcu: Prevent lockdep-RCU splats on lock acquisition/release
      rcu: Do not report strict GPs for outgoing CPUs
      srcu: Take early exit on memory-allocation failure

Peter Zijlstra (2):
      rcu: Allow rcu_irq_enter_check_tick() from NMI
      rcu,ftrace: Fix ftrace recursion

Samuel Hernandez (1):
      rcutorture/nolibc: Fix a typo in header file

Uladzislau Rezki (Sony) (1):
      rcu/tree: Defer kvfree_rcu() allocation to a clean context

Zhouyi Zhou (1):
      rcu: Fix a typo in rcu_blocking_is_gp() header comment

chao (1):
      rcu: Panic after fixed number of stalls


 .../RCU/Design/Requirements/Requirements.rst       |  50 +-
 Documentation/RCU/checklist.rst                    |   7 +
 Documentation/RCU/rcu_dereference.rst              |   6 +
 Documentation/RCU/whatisRCU.rst                    |   3 +-
 Documentation/memory-barriers.txt                  |   2 +-
 arch/x86/kernel/cpu/aperfmperf.c                   |  16 +-
 arch/x86/kernel/cpu/mtrr/mtrr.c                    |   2 -
 arch/x86/kernel/smpboot.c                          |   1 +
 include/linux/kernel.h                             |   1 +
 include/linux/list.h                               |   2 +-
 include/linux/lockdep.h                            |   6 +
 include/linux/rcupdate.h                           |  11 +-
 include/linux/rcupdate_trace.h                     |   4 +-
 include/linux/rcutiny.h                            |   2 +
 include/linux/rcutree.h                            |   1 +
 include/linux/sched/task.h                         |   2 -
 include/net/sch_generic.h                          |  12 -
 include/net/sock.h                                 |   2 -
 kernel/kcsan/encoding.h                            |  20 +-
 kernel/kcsan/selftest.c                            |   3 +
 kernel/locking/locktorture.c                       |  36 +-
 kernel/rcu/Kconfig                                 |  20 +-
 kernel/rcu/rcu.h                                   |  16 +
 kernel/rcu/rcu_segcblist.h                         |   2 +-
 kernel/rcu/rcuscale.c                              |  37 +-
 kernel/rcu/rcutorture.c                            |  52 +-
 kernel/rcu/refscale.c                              |  11 +-
 kernel/rcu/srcutree.c                              |   6 +-
 kernel/rcu/tasks.h                                 |  49 +-
 kernel/rcu/tree.c                                  | 200 +++++---
 kernel/rcu/tree.h                                  |   2 +
 kernel/rcu/tree_plugin.h                           |   2 +-
 kernel/rcu/tree_stall.h                            |   6 +
 kernel/scftorture.c                                |  49 +-
 kernel/sysctl.c                                    |  11 +
 kernel/torture.c                                   |  34 +-
 tools/include/nolibc/nolibc.h                      |   4 +-
 tools/memory-model/Documentation/README            |  76 +++
 .../Documentation/control-dependencies.txt         | 258 ++++++++++
 tools/memory-model/Documentation/glossary.txt      | 172 +++++++
 tools/memory-model/Documentation/litmus-tests.txt  |  17 +
 tools/memory-model/Documentation/ordering.txt      | 556 +++++++++++++++++++++
 tools/memory-model/README                          |  22 +-
 .../litmus-tests/CoRR+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoRW+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoWR+poonceonce+Once.litmus       |   4 +-
 .../litmus-tests/CoWW+poonceonce.litmus            |   4 +-
 .../IRIW+fencembonceonces+OnceOnce.litmus          |   5 +-
 .../litmus-tests/IRIW+poonceonces+OnceOnce.litmus  |   5 +-
 .../ISA2+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 .../litmus-tests/ISA2+poonceonces.litmus           |   6 +-
 ...cerelease+poacquirerelease+poacquireonce.litmus |   6 +-
 .../LB+fencembonceonce+ctrlonceonce.litmus         |   5 +-
 .../LB+poacquireonce+pooncerelease.litmus          |   5 +-
 .../litmus-tests/LB+poonceonces.litmus             |   5 +-
 .../MP+fencewmbonceonce+fencermbonceonce.litmus    |  19 +-
 .../litmus-tests/MP+onceassign+derefonce.litmus    |  15 +-
 .../MP+polockmbonce+poacquiresilsil.litmus         |   8 +-
 .../MP+polockonce+poacquiresilsil.litmus           |   8 +-
 tools/memory-model/litmus-tests/MP+polocks.litmus  |  20 +-
 .../litmus-tests/MP+poonceonces.litmus             |  19 +-
 .../MP+pooncerelease+poacquireonce.litmus          |  19 +-
 .../memory-model/litmus-tests/MP+porevlocks.litmus |  20 +-
 .../litmus-tests/R+fencembonceonces.litmus         |   5 +-
 .../memory-model/litmus-tests/R+poonceonces.litmus |   5 +-
 .../S+fencewmbonceonce+poacquireonce.litmus        |   5 +-
 .../memory-model/litmus-tests/S+poonceonces.litmus |   5 +-
 .../litmus-tests/SB+fencembonceonces.litmus        |   5 +-
 .../litmus-tests/SB+poonceonces.litmus             |   5 +-
 .../litmus-tests/SB+rfionceonce-poonceonces.litmus |   5 +-
 .../litmus-tests/WRC+poonceonces+Once.litmus       |   5 +-
 .../WRC+pooncerelease+fencermbonceonce+Once.litmus |   5 +-
 .../Z6.0+pooncelock+poonceLock+pombonce.litmus     |   7 +-
 .../Z6.0+pooncelock+pooncelock+pombonce.litmus     |   7 +-
 ...release+poacquirerelease+fencembonceonce.litmus |   6 +-
 .../selftests/rcutorture/bin/console-badness.sh    |   3 +-
 .../testing/selftests/rcutorture/bin/functions.sh  |   1 +
 .../selftests/rcutorture/bin/kvm-check-branches.sh |   5 +-
 .../rcutorture/bin/kvm-recheck-rcuscale.sh         |   2 +-
 .../selftests/rcutorture/bin/kvm-test-1-run.sh     |  19 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh      |  29 +-
 .../selftests/rcutorture/bin/parse-console.sh      |   2 +-
 .../selftests/rcutorture/configs/rcu/SRCU-t        |   3 +-
 .../selftests/rcutorture/configs/rcu/SRCU-u        |   3 +-
 .../selftests/rcutorture/configs/rcu/TRACE01       |   6 +-
 .../selftests/rcutorture/configs/rcu/TRACE02       |   6 +-
 .../selftests/rcutorture/configs/rcuscale/CFcommon |   3 +
 .../selftests/rcutorture/configs/rcuscale/TRACE01  |  15 +
 .../rcutorture/configs/rcuscale/TRACE01.boot       |   1 +
 89 files changed, 1822 insertions(+), 320 deletions(-)
 create mode 100644 tools/memory-model/Documentation/README
 create mode 100644 tools/memory-model/Documentation/control-dependencies.txt
 create mode 100644 tools/memory-model/Documentation/glossary.txt
 create mode 100644 tools/memory-model/Documentation/ordering.txt
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1ae79a10a8de..e8c84fcc0507 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1929,16 +1929,46 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
 appropriately to a given CPU-hotplug operation. Most RCU operations may
 be invoked from CPU-hotplug notifiers, including even synchronous
-grace-period operations such as ``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``.
-
-However, all-callback-wait operations such as ``rcu_barrier()`` are also
-not supported, due to the fact that there are phases of CPU-hotplug
-operations where the outgoing CPU's callbacks will not be invoked until
-after the CPU-hotplug operation ends, which could also result in
-deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
-during its execution, which results in another type of deadlock when
-invoked from a CPU-hotplug notifier.
+grace-period operations such as (``synchronize_rcu()`` and
+``synchronize_rcu_expedited()``).  However, these synchronous operations
+do block and therefore cannot be invoked from notifiers that execute via
+``stop_machine()``, specifically those between the ``CPUHP_AP_OFFLINE``
+and ``CPUHP_AP_ONLINE`` states.
+
+In addition, all-callback-wait operations such as ``rcu_barrier()`` may
+not be invoked from any CPU-hotplug notifier.  This restriction is due
+to the fact that there are phases of CPU-hotplug operations where the
+outgoing CPU's callbacks will not be invoked until after the CPU-hotplug
+operation ends, which could also result in deadlock. Furthermore,
+``rcu_barrier()`` blocks CPU-hotplug operations during its execution,
+which results in another type of deadlock when invoked from a CPU-hotplug
+notifier.
+
+Finally, RCU must avoid deadlocks due to interaction between hotplug,
+timers and grace period processing. It does so by maintaining its own set
+of books that duplicate the centrally maintained ``cpu_online_mask``,
+and also by reporting quiescent states explicitly when a CPU goes
+offline.  This explicit reporting of quiescent states avoids any need
+for the force-quiescent-state loop (FQS) to report quiescent states for
+offline CPUs.  However, as a debugging measure, the FQS loop does splat
+if offline CPUs block an RCU grace period for too long.
+
+An offline CPU's quiescent state will be reported either:
+
+1.  As the CPU goes offline using RCU's hotplug notifier (``rcu_report_dead()``).
+2.  When grace period initialization (``rcu_gp_init()``) detects a
+    race either with CPU offlining or with a task unblocking on a leaf
+    ``rcu_node`` structure whose CPUs are all offline.
+
+The CPU-online path (``rcu_cpu_starting()``) should never need to report
+a quiescent state for an offline CPU.  However, as a debugging measure,
+it does emit a warning if a quiescent state was not already reported
+for that CPU.
+
+During the checking/modification of RCU's hotplug bookkeeping, the
+corresponding CPU's leaf node lock is held. This avoids race conditions
+between RCU's hotplug notifier hooks, the grace period initialization
+code, and the FQS loop, all of which refer to or modify this bookkeeping.
 
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 2efed9926c3f..bb7128eb322e 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -314,6 +314,13 @@ over a rather long period of time, but improvements are always welcome!
 	shared between readers and updaters.  Additional primitives
 	are provided for this case, as discussed in lockdep.txt.
 
+	One exception to this rule is when data is only ever added to
+	the linked data structure, and is never removed during any
+	time that readers might be accessing that structure.  In such
+	cases, READ_ONCE() may be used in place of rcu_dereference()
+	and the read-side markers (rcu_read_lock() and rcu_read_unlock(),
+	for example) may be omitted.
+
 10.	Conversely, if you are in an RCU read-side critical section,
 	and you don't hold the appropriate update-side lock, you -must-
 	use the "_rcu()" variants of the list macros.  Failing to do so
diff --git a/Documentation/RCU/rcu_dereference.rst b/Documentation/RCU/rcu_dereference.rst
index c9667eb0d444..f3e587acb4de 100644
--- a/Documentation/RCU/rcu_dereference.rst
+++ b/Documentation/RCU/rcu_dereference.rst
@@ -28,6 +28,12 @@ Follow these rules to keep your RCU code working properly:
 	for an example where the compiler can in fact deduce the exact
 	value of the pointer, and thus cause misordering.
 
+-	In the special case where data is added but is never removed
+	while readers are accessing the structure, READ_ONCE() may be used
+	instead of rcu_dereference().  In this case, use of READ_ONCE()
+	takes on the role of the lockless_dereference() primitive that
+	was removed in v4.15.
+
 -	You are only permitted to use rcu_dereference on pointer values.
 	The compiler simply knows too much about integral values to
 	trust it to carry dependencies through integer operations.
diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index fb3ff76c3e73..1a4723f48bd9 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -497,8 +497,7 @@ long -- there might be other high-priority work to be done.
 In such cases, one uses call_rcu() rather than synchronize_rcu().
 The call_rcu() API is as follows::
 
-	void call_rcu(struct rcu_head * head,
-		      void (*func)(struct rcu_head *head));
+	void call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 This function invokes func(head) after a grace period has elapsed.
 This invocation might happen from either softirq or process context,
diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 17c8e0c2deb4..7367ada13208 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1870,7 +1870,7 @@ There are some more advanced barrier functions:
 
      These are for use with atomic RMW functions that do not imply memory
      barriers, but where the code needs a memory barrier. Examples for atomic
-     RMW functions that do not imply are memory barrier are e.g. add,
+     RMW functions that do not imply a memory barrier are e.g. add,
      subtract, (failed) conditional operations, _relaxed functions,
      but not atomic_read or atomic_set. A common example where a memory
      barrier may be required is when atomic ops are used for reference
diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
index e2f319dc992d..22911deacb6e 100644
--- a/arch/x86/kernel/cpu/aperfmperf.c
+++ b/arch/x86/kernel/cpu/aperfmperf.c
@@ -14,11 +14,13 @@
 #include <linux/cpufreq.h>
 #include <linux/smp.h>
 #include <linux/sched/isolation.h>
+#include <linux/rcupdate.h>
 
 #include "cpu.h"
 
 struct aperfmperf_sample {
 	unsigned int	khz;
+	atomic_t	scfpending;
 	ktime_t	time;
 	u64	aperf;
 	u64	mperf;
@@ -62,17 +64,20 @@ static void aperfmperf_snapshot_khz(void *dummy)
 	s->aperf = aperf;
 	s->mperf = mperf;
 	s->khz = div64_u64((cpu_khz * aperf_delta), mperf_delta);
+	atomic_set_release(&s->scfpending, 0);
 }
 
 static bool aperfmperf_snapshot_cpu(int cpu, ktime_t now, bool wait)
 {
 	s64 time_delta = ktime_ms_delta(now, per_cpu(samples.time, cpu));
+	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
 
 	/* Don't bother re-computing within the cache threshold time. */
 	if (time_delta < APERFMPERF_CACHE_THRESHOLD_MS)
 		return true;
 
-	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
+	if (!atomic_xchg(&s->scfpending, 1) || wait)
+		smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, wait);
 
 	/* Return false if the previous iteration was too long ago. */
 	return time_delta <= APERFMPERF_STALE_THRESHOLD_MS;
@@ -89,6 +94,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 	if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 		return 0;
 
+	if (rcu_is_idle_cpu(cpu))
+		return 0; /* Idle CPUs are completely uninteresting. */
+
 	aperfmperf_snapshot_cpu(cpu, ktime_get(), true);
 	return per_cpu(samples.khz, cpu);
 }
@@ -108,6 +116,8 @@ void arch_freq_prepare_all(void)
 	for_each_online_cpu(cpu) {
 		if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
 			continue;
+		if (rcu_is_idle_cpu(cpu))
+			continue; /* Idle CPUs are completely uninteresting. */
 		if (!aperfmperf_snapshot_cpu(cpu, now, false))
 			wait = true;
 	}
@@ -118,6 +128,8 @@ void arch_freq_prepare_all(void)
 
 unsigned int arch_freq_get_on_cpu(int cpu)
 {
+	struct aperfmperf_sample *s = per_cpu_ptr(&samples, cpu);
+
 	if (!cpu_khz)
 		return 0;
 
@@ -131,6 +143,8 @@ unsigned int arch_freq_get_on_cpu(int cpu)
 		return per_cpu(samples.khz, cpu);
 
 	msleep(APERFMPERF_REFRESH_DELAY_MS);
+	atomic_set(&s->scfpending, 1);
+	smp_mb(); /* ->scfpending before smp_call_function_single(). */
 	smp_call_function_single(cpu, aperfmperf_snapshot_khz, NULL, 1);
 
 	return per_cpu(samples.khz, cpu);
diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
index 6a80f36b5d59..5f436cb4f7c4 100644
--- a/arch/x86/kernel/cpu/mtrr/mtrr.c
+++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
@@ -794,8 +794,6 @@ void mtrr_ap_init(void)
 	if (!use_intel() || mtrr_aps_delayed_init)
 		return;
 
-	rcu_cpu_starting(smp_processor_id());
-
 	/*
 	 * Ideally we should hold mtrr_mutex here to avoid mtrr entries
 	 * changed, but this routine will be called in cpu boot time,
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index de776b2e6046..99bdcebaedfc 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -229,6 +229,7 @@ static void notrace start_secondary(void *unused)
 #endif
 	cpu_init_exception_handling();
 	cpu_init();
+	rcu_cpu_starting(raw_smp_processor_id());
 	x86_cpuinit.early_percpu_clock_init();
 	preempt_disable();
 	smp_callin();
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 2f05e9128201..4b5fd3da5fe8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -536,6 +536,7 @@ extern int panic_on_warn;
 extern unsigned long panic_on_taint;
 extern bool panic_on_taint_nousertaint;
 extern int sysctl_panic_on_rcu_stall;
+extern int sysctl_max_rcu_stall_to_panic;
 extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
diff --git a/include/linux/list.h b/include/linux/list.h
index a18c87b63376..89bdc92e75c3 100644
--- a/include/linux/list.h
+++ b/include/linux/list.h
@@ -9,7 +9,7 @@
 #include <linux/kernel.h>
 
 /*
- * Simple doubly linked list implementation.
+ * Circular doubly linked list implementation.
  *
  * Some of the internal functions ("__xxx") are useful when
  * manipulating whole lists rather than single entries, as
diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index f5594879175a..ccc3ce66c7e0 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -375,6 +375,12 @@ static inline void lockdep_unregister_key(struct lock_class_key *key)
 
 #define lockdep_depth(tsk)	(0)
 
+/*
+ * Dummy forward declarations, allow users to write less ifdef-y code
+ * and depend on dead code elimination.
+ */
+extern int lock_is_held(const void *);
+extern int lockdep_is_held(const void *);
 #define lockdep_is_held_type(l, r)		(1)
 
 #define lockdep_assert_held(l)			do { (void)(l); } while (0)
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 6cdd0152c253..de0826411311 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -241,6 +241,11 @@ bool rcu_lockdep_current_cpu_online(void);
 static inline bool rcu_lockdep_current_cpu_online(void) { return true; }
 #endif /* #else #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PROVE_RCU) */
 
+extern struct lockdep_map rcu_lock_map;
+extern struct lockdep_map rcu_bh_lock_map;
+extern struct lockdep_map rcu_sched_lock_map;
+extern struct lockdep_map rcu_callback_map;
+
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 static inline void rcu_lock_acquire(struct lockdep_map *map)
@@ -253,10 +258,6 @@ static inline void rcu_lock_release(struct lockdep_map *map)
 	lock_release(map, _THIS_IP_);
 }
 
-extern struct lockdep_map rcu_lock_map;
-extern struct lockdep_map rcu_bh_lock_map;
-extern struct lockdep_map rcu_sched_lock_map;
-extern struct lockdep_map rcu_callback_map;
 int debug_lockdep_rcu_enabled(void);
 int rcu_read_lock_held(void);
 int rcu_read_lock_bh_held(void);
@@ -327,7 +328,7 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 #else /* #ifdef CONFIG_PROVE_RCU */
 
-#define RCU_LOCKDEP_WARN(c, s) do { } while (0)
+#define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
 #define rcu_sleep_check() do { } while (0)
 
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.h
index 3e7919fc5f34..86c8f6c98412 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -11,10 +11,10 @@
 #include <linux/sched.h>
 #include <linux/rcupdate.h>
 
-#ifdef CONFIG_DEBUG_LOCK_ALLOC
-
 extern struct lockdep_map rcu_trace_lock_map;
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+
 static inline int rcu_read_lock_trace_held(void)
 {
 	return lock_is_held(&rcu_trace_lock_map);
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 7c1ecdb356d8..2a97334eb786 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -89,6 +89,8 @@ static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_preempt(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
+#define rcu_is_idle_cpu(cpu) \
+	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
 static inline void exit_rcu(void) { }
 static inline bool rcu_preempt_need_deferred_qs(struct task_struct *t)
 {
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 59eb5cd567d7..df578b73960f 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -50,6 +50,7 @@ void rcu_irq_exit(void);
 void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
+bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
 void rcu_irq_exit_check_preempt(void);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 85fb2f34c59b..c0f71f2e7160 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -47,9 +47,7 @@ extern spinlock_t mmlist_lock;
 extern union thread_union init_thread_union;
 extern struct task_struct init_task;
 
-#ifdef CONFIG_PROVE_RCU
 extern int lockdep_tasklist_lock_is_held(void);
-#endif /* #ifdef CONFIG_PROVE_RCU */
 
 extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index d8fd8676fc72..749db62f6215 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -435,7 +435,6 @@ struct tcf_block {
 	struct mutex proto_destroy_lock; /* Lock for proto_destroy hashtable. */
 };
 
-#ifdef CONFIG_PROVE_LOCKING
 static inline bool lockdep_tcf_chain_is_locked(struct tcf_chain *chain)
 {
 	return lockdep_is_held(&chain->filter_chain_lock);
@@ -445,17 +444,6 @@ static inline bool lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
 {
 	return lockdep_is_held(&tp->lock);
 }
-#else
-static inline bool lockdep_tcf_chain_is_locked(struct tcf_block *chain)
-{
-	return true;
-}
-
-static inline bool lockdep_tcf_proto_is_locked(struct tcf_proto *tp)
-{
-	return true;
-}
-#endif /* #ifdef CONFIG_PROVE_LOCKING */
 
 #define tcf_chain_dereference(p, chain)					\
 	rcu_dereference_protected(p, lockdep_tcf_chain_is_locked(chain))
diff --git a/include/net/sock.h b/include/net/sock.h
index a5c6ae78df77..198d5486fb09 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1566,13 +1566,11 @@ do {									\
 	lockdep_init_map(&(sk)->sk_lock.dep_map, (name), (key), 0);	\
 } while (0)
 
-#ifdef CONFIG_LOCKDEP
 static inline bool lockdep_sock_is_held(const struct sock *sk)
 {
 	return lockdep_is_held(&sk->sk_lock) ||
 	       lockdep_is_held(&sk->sk_lock.slock);
 }
-#endif
 
 void lock_sock_nested(struct sock *sk, int subclass);
 
diff --git a/kernel/kcsan/encoding.h b/kernel/kcsan/encoding.h
index 1a6db2f797ac..7ee405524904 100644
--- a/kernel/kcsan/encoding.h
+++ b/kernel/kcsan/encoding.h
@@ -37,18 +37,20 @@
  */
 #define WATCHPOINT_ADDR_BITS (BITS_PER_LONG-1 - WATCHPOINT_SIZE_BITS)
 
-/*
- * Masks to set/retrieve the encoded data.
- */
-#define WATCHPOINT_WRITE_MASK BIT(BITS_PER_LONG-1)
-#define WATCHPOINT_SIZE_MASK                                                   \
-	GENMASK(BITS_PER_LONG-2, BITS_PER_LONG-2 - WATCHPOINT_SIZE_BITS)
-#define WATCHPOINT_ADDR_MASK                                                   \
-	GENMASK(BITS_PER_LONG-3 - WATCHPOINT_SIZE_BITS, 0)
+/* Bitmasks for the encoded watchpoint access information. */
+#define WATCHPOINT_WRITE_MASK	BIT(BITS_PER_LONG-1)
+#define WATCHPOINT_SIZE_MASK	GENMASK(BITS_PER_LONG-2, WATCHPOINT_ADDR_BITS)
+#define WATCHPOINT_ADDR_MASK	GENMASK(WATCHPOINT_ADDR_BITS-1, 0)
+static_assert(WATCHPOINT_ADDR_MASK == (1UL << WATCHPOINT_ADDR_BITS) - 1);
+static_assert((WATCHPOINT_WRITE_MASK ^ WATCHPOINT_SIZE_MASK ^ WATCHPOINT_ADDR_MASK) == ~0UL);
 
 static inline bool check_encodable(unsigned long addr, size_t size)
 {
-	return size <= MAX_ENCODABLE_SIZE;
+	/*
+	 * While we can encode addrs<PAGE_SIZE, avoid crashing with a NULL
+	 * pointer deref inside KCSAN.
+	 */
+	return addr >= PAGE_SIZE && size <= MAX_ENCODABLE_SIZE;
 }
 
 static inline long
diff --git a/kernel/kcsan/selftest.c b/kernel/kcsan/selftest.c
index d98bc208d06d..9014a3a82cf9 100644
--- a/kernel/kcsan/selftest.c
+++ b/kernel/kcsan/selftest.c
@@ -33,6 +33,9 @@ static bool test_encode_decode(void)
 		unsigned long addr;
 
 		prandom_bytes(&addr, sizeof(addr));
+		if (addr < PAGE_SIZE)
+			addr = PAGE_SIZE;
+
 		if (WARN_ON(!check_encodable(addr, size)))
 			return false;
 
diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
index 62d215b2e39f..fd838cea3934 100644
--- a/kernel/locking/locktorture.c
+++ b/kernel/locking/locktorture.c
@@ -29,6 +29,7 @@
 #include <linux/slab.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/torture.h>
+#include <linux/reboot.h>
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
@@ -60,6 +61,7 @@ static struct task_struct **reader_tasks;
 
 static bool lock_is_write_held;
 static bool lock_is_read_held;
+static unsigned long last_lock_release;
 
 struct lock_stress_stats {
 	long n_lock_fail;
@@ -74,6 +76,7 @@ static void lock_torture_cleanup(void);
  */
 struct lock_torture_ops {
 	void (*init)(void);
+	void (*exit)(void);
 	int (*writelock)(void);
 	void (*write_delay)(struct torture_random_state *trsp);
 	void (*task_boost)(struct torture_random_state *trsp);
@@ -90,12 +93,13 @@ struct lock_torture_cxt {
 	int nrealwriters_stress;
 	int nrealreaders_stress;
 	bool debug_lock;
+	bool init_called;
 	atomic_t n_lock_torture_errors;
 	struct lock_torture_ops *cur_ops;
 	struct lock_stress_stats *lwsa; /* writer statistics */
 	struct lock_stress_stats *lrsa; /* reader statistics */
 };
-static struct lock_torture_cxt cxt = { 0, 0, false,
+static struct lock_torture_cxt cxt = { 0, 0, false, false,
 				       ATOMIC_INIT(0),
 				       NULL, NULL};
 /*
@@ -571,6 +575,11 @@ static void torture_percpu_rwsem_init(void)
 	BUG_ON(percpu_init_rwsem(&pcpu_rwsem));
 }
 
+static void torture_percpu_rwsem_exit(void)
+{
+	percpu_free_rwsem(&pcpu_rwsem);
+}
+
 static int torture_percpu_rwsem_down_write(void) __acquires(pcpu_rwsem)
 {
 	percpu_down_write(&pcpu_rwsem);
@@ -595,6 +604,7 @@ static void torture_percpu_rwsem_up_read(void) __releases(pcpu_rwsem)
 
 static struct lock_torture_ops percpu_rwsem_lock_ops = {
 	.init		= torture_percpu_rwsem_init,
+	.exit		= torture_percpu_rwsem_exit,
 	.writelock	= torture_percpu_rwsem_down_write,
 	.write_delay	= torture_rwsem_write_delay,
 	.task_boost     = torture_boost_dummy,
@@ -632,6 +642,7 @@ static int lock_torture_writer(void *arg)
 		lwsp->n_lock_acquired++;
 		cxt.cur_ops->write_delay(&rand);
 		lock_is_write_held = false;
+		WRITE_ONCE(last_lock_release, jiffies);
 		cxt.cur_ops->writeunlock();
 
 		stutter_wait("lock_torture_writer");
@@ -786,9 +797,10 @@ static void lock_torture_cleanup(void)
 
 	/*
 	 * Indicates early cleanup, meaning that the test has not run,
-	 * such as when passing bogus args when loading the module. As
-	 * such, only perform the underlying torture-specific cleanups,
-	 * and avoid anything related to locktorture.
+	 * such as when passing bogus args when loading the module.
+	 * However cxt->cur_ops.init() may have been invoked, so beside
+	 * perform the underlying torture-specific cleanups, cur_ops.exit()
+	 * will be invoked if needed.
 	 */
 	if (!cxt.lwsa && !cxt.lrsa)
 		goto end;
@@ -828,6 +840,11 @@ static void lock_torture_cleanup(void)
 	cxt.lrsa = NULL;
 
 end:
+	if (cxt.init_called) {
+		if (cxt.cur_ops->exit)
+			cxt.cur_ops->exit();
+		cxt.init_called = false;
+	}
 	torture_cleanup_end();
 }
 
@@ -868,14 +885,17 @@ static int __init lock_torture_init(void)
 		goto unwind;
 	}
 
-	if (nwriters_stress == 0 && nreaders_stress == 0) {
+	if (nwriters_stress == 0 &&
+	    (!cxt.cur_ops->readlock || nreaders_stress == 0)) {
 		pr_alert("lock-torture: must run at least one locking thread\n");
 		firsterr = -EINVAL;
 		goto unwind;
 	}
 
-	if (cxt.cur_ops->init)
+	if (cxt.cur_ops->init) {
 		cxt.cur_ops->init();
+		cxt.init_called = true;
+	}
 
 	if (nwriters_stress >= 0)
 		cxt.nrealwriters_stress = nwriters_stress;
@@ -1038,6 +1058,10 @@ static int __init lock_torture_init(void)
 unwind:
 	torture_init_end();
 	lock_torture_cleanup();
+	if (shutdown_secs) {
+		WARN_ON(!IS_MODULE(CONFIG_LOCK_TORTURE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index b71e21f73c40..cdc57b4f6d48 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -221,19 +221,23 @@ config RCU_NOCB_CPU
 	  Use this option to reduce OS jitter for aggressive HPC or
 	  real-time workloads.	It can also be used to offload RCU
 	  callback invocation to energy-efficient CPUs in battery-powered
-	  asymmetric multiprocessors.
+	  asymmetric multiprocessors.  The price of this reduced jitter
+	  is that the overhead of call_rcu() increases and that some
+	  workloads will incur significant increases in context-switch
+	  rates.
 
 	  This option offloads callback invocation from the set of CPUs
 	  specified at boot time by the rcu_nocbs parameter.  For each
 	  such CPU, a kthread ("rcuox/N") will be created to invoke
 	  callbacks, where the "N" is the CPU being offloaded, and where
-	  the "p" for RCU-preempt (PREEMPTION kernels) and "s" for RCU-sched
-	  (!PREEMPTION kernels).  Nothing prevents this kthread from running
-	  on the specified CPUs, but (1) the kthreads may be preempted
-	  between each callback, and (2) affinity or cgroups can be used
-	  to force the kthreads to run on whatever set of CPUs is desired.
-
-	  Say Y here if you want to help to debug reduced OS jitter.
+	  the "x" is "p" for RCU-preempt (PREEMPTION kernels) and "s" for
+	  RCU-sched (!PREEMPTION kernels).  Nothing prevents this kthread
+	  from running on the specified CPUs, but (1) the kthreads may be
+	  preempted between each callback, and (2) affinity or cgroups can
+	  be used to force the kthreads to run on whatever set of CPUs is
+	  desired.
+
+	  Say Y here if you need reduced OS jitter, despite added overhead.
 	  Say N here if you are unsure.
 
 config TASKS_TRACE_RCU_READ_MB
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e01cba5e4b52..59ef1ae6dc37 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -533,4 +533,20 @@ static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RCU)
+void show_rcu_tasks_classic_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_classic_gp_kthread(void) {}
+#endif
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
+void show_rcu_tasks_rude_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_rude_gp_kthread(void) {}
+#endif
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_TRACE_RCU)
+void show_rcu_tasks_trace_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_trace_gp_kthread(void) {}
+#endif
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 5c293afc07b8..492262bcb591 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -62,7 +62,7 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
 /* Is the specified rcu_segcblist offloaded?  */
 static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
 {
-	return rsclp->offloaded;
+	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;
 }
 
 /*
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95479af..06491d5530db 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -38,6 +38,7 @@
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
+#include <linux/rcupdate_trace.h>
 
 #include "rcu.h"
 
@@ -294,6 +295,35 @@ static struct rcu_scale_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+/*
+ * Definitions for RCU-tasks-trace scalability testing.
+ */
+
+static int tasks_trace_scale_read_lock(void)
+{
+	rcu_read_lock_trace();
+	return 0;
+}
+
+static void tasks_trace_scale_read_unlock(int idx)
+{
+	rcu_read_unlock_trace();
+}
+
+static struct rcu_scale_ops tasks_tracing_ops = {
+	.ptype		= RCU_TASKS_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_trace_scale_read_lock,
+	.readunlock	= tasks_trace_scale_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
+	.async		= call_rcu_tasks_trace,
+	.gp_barrier	= rcu_barrier_tasks_trace,
+	.sync		= synchronize_rcu_tasks_trace,
+	.exp_sync	= synchronize_rcu_tasks_trace,
+	.name		= "tasks-tracing"
+};
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -754,7 +784,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops, &tasks_tracing_ops
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
@@ -772,7 +802,6 @@ rcu_scale_init(void)
 		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -846,6 +875,10 @@ rcu_scale_init(void)
 unwind:
 	torture_init_end();
 	rcu_scale_cleanup();
+	if (shutdown) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_SCALE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 916ea4f66e4b..528ed10b78fd 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -317,6 +317,7 @@ struct rcu_torture_ops {
 	void (*cb_barrier)(void);
 	void (*fqs)(void);
 	void (*stats)(void);
+	void (*gp_kthread_dbg)(void);
 	int (*stall_dur)(void);
 	int irq_capable;
 	int can_boost;
@@ -466,6 +467,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.cb_barrier	= rcu_barrier,
 	.fqs		= rcu_force_quiescent_state,
 	.stats		= NULL,
+	.gp_kthread_dbg	= show_rcu_gp_kthreads,
 	.stall_dur	= rcu_jiffies_till_stall_check,
 	.irq_capable	= 1,
 	.can_boost	= rcu_can_boost(),
@@ -693,6 +695,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.exp_sync	= synchronize_rcu_mult_test,
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
+	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -762,6 +765,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.exp_sync	= synchronize_rcu_tasks_rude,
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
+	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -800,6 +804,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
+	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -912,7 +917,8 @@ static int rcu_torture_boost(void *arg)
 		oldstarttime = boost_starttime;
 		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
-			stutter_wait("rcu_torture_boost");
+			if (stutter_wait("rcu_torture_boost"))
+				sched_set_fifo_low(current);
 			if (torture_must_stop())
 				goto checkwait;
 		}
@@ -932,7 +938,8 @@ static int rcu_torture_boost(void *arg)
 								 jiffies);
 				call_rcu_time = jiffies;
 			}
-			stutter_wait("rcu_torture_boost");
+			if (stutter_wait("rcu_torture_boost"))
+				sched_set_fifo_low(current);
 			if (torture_must_stop())
 				goto checkwait;
 		}
@@ -964,7 +971,8 @@ static int rcu_torture_boost(void *arg)
 		}
 
 		/* Go do the stutter. */
-checkwait:	stutter_wait("rcu_torture_boost");
+checkwait:	if (stutter_wait("rcu_torture_boost"))
+			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
 	/* Clean up and exit. */
@@ -987,6 +995,7 @@ rcu_torture_fqs(void *arg)
 {
 	unsigned long fqs_resume_time;
 	int fqs_burst_remaining;
+	int oldnice = task_nice(current);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
 	do {
@@ -1002,7 +1011,8 @@ rcu_torture_fqs(void *arg)
 			udelay(fqs_holdoff);
 			fqs_burst_remaining -= fqs_holdoff;
 		}
-		stutter_wait("rcu_torture_fqs");
+		if (stutter_wait("rcu_torture_fqs"))
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_fqs");
 	return 0;
@@ -1022,9 +1032,11 @@ rcu_torture_writer(void *arg)
 	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
 	bool gp_sync1 = gp_sync;
 	int i;
+	int oldnice = task_nice(current);
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
+	bool stutter_waited;
 	int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC,
 			   RTWS_COND_GET, RTWS_SYNC };
 	int nsynctypes = 0;
@@ -1143,7 +1155,8 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		if (stutter_wait("rcu_torture_writer") &&
+		stutter_waited = stutter_wait("rcu_torture_writer");
+		if (stutter_waited &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
@@ -1155,6 +1168,8 @@ rcu_torture_writer(void *arg)
 					rcu_ftrace_dump(DUMP_ALL);
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 				}
+		if (stutter_waited)
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	rcu_torture_current = NULL;  // Let stats task know that we are done.
 	/* Reset expediting back to unexpedited. */
@@ -1594,7 +1609,8 @@ rcu_torture_stats_print(void)
 			sched_show_task(wtp);
 			splatted = true;
 		}
-		show_rcu_gp_kthreads();
+		if (cur_ops->gp_kthread_dbg)
+			cur_ops->gp_kthread_dbg();
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	rtcv_snap = rcu_torture_current_version;
@@ -1913,7 +1929,9 @@ static void rcu_torture_fwd_prog_nr(struct rcu_fwd *rfp,
 	unsigned long stopat;
 	static DEFINE_TORTURE_RANDOM(trs);
 
-	if  (cur_ops->call && cur_ops->sync && cur_ops->cb_barrier) {
+	if (!cur_ops->sync)
+		return; // Cannot do need_resched() forward progress testing without ->sync.
+	if (cur_ops->call && cur_ops->cb_barrier) {
 		init_rcu_head_on_stack(&fcs.rh);
 		selfpropcb = true;
 	}
@@ -2103,6 +2121,7 @@ static struct notifier_block rcutorture_oom_nb = {
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
+	int oldnice = task_nice(current);
 	struct rcu_fwd *rfp = args;
 	int tested = 0;
 	int tested_tries = 0;
@@ -2121,7 +2140,8 @@ static int rcu_torture_fwd_prog(void *args)
 			rcu_torture_fwd_prog_cr(rfp);
 
 		/* Avoid slow periods, better to test when busy. */
-		stutter_wait("rcu_torture_fwd_prog");
+		if (stutter_wait("rcu_torture_fwd_prog"))
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	/* Short runs might not contain a valid forward-progress attempt. */
 	WARN_ON(!tested && tested_tries >= 5);
@@ -2137,8 +2157,8 @@ static int __init rcu_torture_fwd_prog_init(void)
 
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
-	if (!cur_ops->stall_dur || cur_ops->stall_dur() <= 0 ||
-	    cur_ops == &rcu_busted_ops) {
+	if ((!cur_ops->sync && !cur_ops->call) ||
+	    !cur_ops->stall_dur || cur_ops->stall_dur() <= 0 || cur_ops == &rcu_busted_ops) {
 		VERBOSE_TOROUT_STRING("rcu_torture_fwd_prog_init: Disabled, unsupported by RCU flavor under test");
 		return 0;
 	}
@@ -2472,7 +2492,8 @@ rcu_torture_cleanup(void)
 		return;
 	}
 
-	show_rcu_gp_kthreads();
+	if (cur_ops->gp_kthread_dbg)
+		cur_ops->gp_kthread_dbg();
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
 	rcu_torture_fwd_prog_cleanup();
@@ -2484,13 +2505,13 @@ rcu_torture_cleanup(void)
 			torture_stop_kthread(rcu_torture_reader,
 					     reader_tasks[i]);
 		kfree(reader_tasks);
+		reader_tasks = NULL;
 	}
 
 	if (fakewriter_tasks) {
-		for (i = 0; i < nfakewriters; i++) {
+		for (i = 0; i < nfakewriters; i++)
 			torture_stop_kthread(rcu_torture_fakewriter,
 					     fakewriter_tasks[i]);
-		}
 		kfree(fakewriter_tasks);
 		fakewriter_tasks = NULL;
 	}
@@ -2647,7 +2668,6 @@ rcu_torture_init(void)
 		for (i = 0; i < ARRAY_SIZE(torture_ops); i++)
 			pr_cont(" %s", torture_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -2815,6 +2835,10 @@ rcu_torture_init(void)
 unwind:
 	torture_init_end();
 	rcu_torture_cleanup();
+	if (shutdown_secs) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_TORTURE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 952595c678b3..23ff36a66f97 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -658,7 +658,6 @@ ref_scale_init(void)
 		for (i = 0; i < ARRAY_SIZE(scale_ops); i++)
 			pr_cont(" %s", scale_ops[i]->name);
 		pr_cont("\n");
-		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
 		firsterr = -EINVAL;
 		cur_ops = NULL;
 		goto unwind;
@@ -681,6 +680,12 @@ ref_scale_init(void)
 	// Reader tasks (default to ~75% of online CPUs).
 	if (nreaders < 0)
 		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
+		loops = 1;
+	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
+		nreaders = 1;
+	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
+		nruns = 1;
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
@@ -712,6 +717,10 @@ ref_scale_init(void)
 unwind:
 	torture_init_end();
 	ref_scale_cleanup();
+	if (shutdown) {
+		WARN_ON(!IS_MODULE(CONFIG_RCU_REF_SCALE_TEST));
+		kernel_power_off();
+	}
 	return firsterr;
 }
 
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index c13348ee80a5..0f23d20d485a 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -177,11 +177,13 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	INIT_DELAYED_WORK(&ssp->work, process_srcu);
 	if (!is_static)
 		ssp->sda = alloc_percpu(struct srcu_data);
+	if (!ssp->sda)
+		return -ENOMEM;
 	init_srcu_struct_nodes(ssp, is_static);
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
-	return ssp->sda ? 0 : -ENOMEM;
+	return 0;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -906,7 +908,7 @@ static void __synchronize_srcu(struct srcu_struct *ssp, bool do_norm)
 {
 	struct rcu_synchronize rcu;
 
-	RCU_LOCKDEP_WARN(lock_is_held(&ssp->dep_map) ||
+	RCU_LOCKDEP_WARN(lockdep_is_held(ssp) ||
 			 lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index d5d9f2d03e8a..35bdcfd84d42 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -290,7 +290,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+#endif // #ifndef CONFIG_TINY_RCU
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 
@@ -335,23 +335,18 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 	// Start off with initial wait and slowly back off to 1 HZ wait.
 	fract = rtp->init_fract;
-	if (fract > HZ)
-		fract = HZ;
 
-	for (;;) {
+	while (!list_empty(&holdouts)) {
 		bool firstreport;
 		bool needreport;
 		int rtst;
 
-		if (list_empty(&holdouts))
-			break;
-
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_idle(HZ/fract);
+		schedule_timeout_idle(fract);
 
-		if (fract > 1)
-			fract--;
+		if (fract < HZ)
+			fract++;
 
 		rtst = READ_ONCE(rcu_task_stall_timeout);
 		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
@@ -560,7 +555,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 static int __init rcu_spawn_tasks_kthread(void)
 {
 	rcu_tasks.gp_sleep = HZ / 10;
-	rcu_tasks.init_fract = 10;
+	rcu_tasks.init_fract = HZ / 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -571,12 +566,13 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_classic_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_classic_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
@@ -598,7 +594,6 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
-static inline void show_rcu_tasks_classic_gp_kthread(void) { }
 void exit_tasks_rcu_start(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
@@ -699,16 +694,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_rude_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_rude_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
-
-#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
-static void show_rcu_tasks_rude_gp_kthread(void) {}
-#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -1183,12 +1176,12 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 {
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
 		rcu_tasks_trace.gp_sleep = HZ / 10;
-		rcu_tasks_trace.init_fract = 10;
+		rcu_tasks_trace.init_fract = HZ / 10;
 	} else {
 		rcu_tasks_trace.gp_sleep = HZ / 200;
 		if (rcu_tasks_trace.gp_sleep <= 0)
 			rcu_tasks_trace.gp_sleep = 1;
-		rcu_tasks_trace.init_fract = HZ / 5;
+		rcu_tasks_trace.init_fract = HZ / 200;
 		if (rcu_tasks_trace.init_fract <= 0)
 			rcu_tasks_trace.init_fract = 1;
 	}
@@ -1202,8 +1195,8 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_trace_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
@@ -1213,11 +1206,11 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
-static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef85d69..516c6893e359 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -177,7 +177,7 @@ module_param(rcu_unlock_delay, int, 0444);
  * per-CPU. Object size is equal to one page. This value
  * can be changed at boot time.
  */
-static int rcu_min_cached_objs = 2;
+static int rcu_min_cached_objs = 5;
 module_param(rcu_min_cached_objs, int, 0444);
 
 /* Retrieve RCU kthreads priority for rcutorture */
@@ -341,6 +341,14 @@ static bool rcu_dynticks_in_eqs(int snap)
 	return !(snap & RCU_DYNTICK_CTRL_CTR);
 }
 
+/* Return true if the specified CPU is currently idle from an RCU viewpoint.  */
+bool rcu_is_idle_cpu(int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	return rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
+}
+
 /*
  * Return true if the CPU corresponding to the specified rcu_data
  * structure has spent some time in an extended quiescent state since
@@ -546,12 +554,12 @@ static int param_set_next_fqs_jiffies(const char *val, const struct kernel_param
 	return ret;
 }
 
-static struct kernel_param_ops first_fqs_jiffies_ops = {
+static const struct kernel_param_ops first_fqs_jiffies_ops = {
 	.set = param_set_first_fqs_jiffies,
 	.get = param_get_ulong,
 };
 
-static struct kernel_param_ops next_fqs_jiffies_ops = {
+static const struct kernel_param_ops next_fqs_jiffies_ops = {
 	.set = param_set_next_fqs_jiffies,
 	.get = param_get_ulong,
 };
@@ -928,8 +936,8 @@ void __rcu_irq_enter_check_tick(void)
 {
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
-	 // Enabling the tick is unsafe in NMI handlers.
-	if (WARN_ON_ONCE(in_nmi()))
+	// If we're here from NMI there's nothing to do.
+	if (in_nmi())
 		return;
 
 	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
@@ -1093,8 +1101,11 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
  * CPU can safely enter RCU read-side critical sections.  In other words,
  * if the current CPU is not in its idle loop or is in an interrupt or
  * NMI handler, return true.
+ *
+ * Make notrace because it can be called by the internal functions of
+ * ftrace, and making this notrace removes unnecessary recursion calls.
  */
-bool rcu_is_watching(void)
+notrace bool rcu_is_watching(void)
 {
 	bool ret;
 
@@ -1149,7 +1160,7 @@ bool rcu_lockdep_current_cpu_online(void)
 	preempt_disable_notrace();
 	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
-	if (rdp->grpmask & rcu_rnp_online_cpus(rnp))
+	if (rdp->grpmask & rcu_rnp_online_cpus(rnp) || READ_ONCE(rnp->ofl_seq) & 0x1)
 		ret = true;
 	preempt_enable_notrace();
 	return ret;
@@ -1603,8 +1614,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
 	bool need_qs;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1715,6 +1725,7 @@ static void rcu_strict_gp_boundary(void *unused)
  */
 static bool rcu_gp_init(void)
 {
+	unsigned long firstseq;
 	unsigned long flags;
 	unsigned long oldmask;
 	unsigned long mask;
@@ -1758,6 +1769,12 @@ static bool rcu_gp_init(void)
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
+		smp_mb(); // Pair with barriers used when updating ->ofl_seq to odd values.
+		firstseq = READ_ONCE(rnp->ofl_seq);
+		if (firstseq & 0x1)
+			while (firstseq == READ_ONCE(rnp->ofl_seq))
+				schedule_timeout_idle(1);  // Can't wake unless RCU is watching.
+		smp_mb(); // Pair with barriers used when updating ->ofl_seq to even values.
 		raw_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -2048,8 +2065,7 @@ static void rcu_gp_cleanup(void)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-		    rcu_segcblist_is_offloaded(&rdp->cblist);
+	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
 		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
 		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
@@ -2248,8 +2264,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long mask;
 	bool needwake = false;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_node *rnp;
 
 	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
@@ -2399,6 +2414,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
 		return 0;
 
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
 	/* Adjust any no-longer-needed kthreads. */
 	rcu_boost_kthread_setaffinity(rnp, -1);
 	/* Do any needed no-CB deferred wakeups from this CPU. */
@@ -2417,8 +2433,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 {
 	int div;
 	unsigned long flags;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 	struct rcu_head *rhp;
 	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
 	long bl, count;
@@ -2675,8 +2690,7 @@ static __latent_entropy void rcu_core(void)
 	unsigned long flags;
 	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
-	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-			       rcu_segcblist_is_offloaded(&rdp->cblist);
+	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);
 
 	if (cpu_is_offline(smp_processor_id()))
 		return;
@@ -2978,8 +2992,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 				   rcu_segcblist_n_cbs(&rdp->cblist));
 
 	/* Go handle any RCU core processing required. */
-	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
-	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
+	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
 		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
@@ -3084,6 +3097,9 @@ struct kfree_rcu_cpu_work {
  *	In order to save some per-cpu space the list is singular.
  *	Even though it is lockless an access has to be protected by the
  *	per-cpu lock.
+ * @page_cache_work: A work to refill the cache when it is empty
+ * @work_in_progress: Indicates that page_cache_work is running
+ * @hrtimer: A hrtimer for scheduling a page_cache_work
  * @nr_bkv_objs: number of allocated objects at @bkvcache.
  *
  * This is a per-CPU structure.  The reason that it is not included in
@@ -3100,6 +3116,11 @@ struct kfree_rcu_cpu {
 	bool monitor_todo;
 	bool initialized;
 	int count;
+
+	struct work_struct page_cache_work;
+	atomic_t work_in_progress;
+	struct hrtimer hrtimer;
+
 	struct llist_head bkvcache;
 	int nr_bkv_objs;
 };
@@ -3217,10 +3238,10 @@ static void kfree_rcu_work(struct work_struct *work)
 			}
 			rcu_lock_release(&rcu_callback_map);
 
-			krcp = krc_this_cpu_lock(&flags);
+			raw_spin_lock_irqsave(&krcp->lock, flags);
 			if (put_cached_bnode(krcp, bkvhead[i]))
 				bkvhead[i] = NULL;
-			krc_this_cpu_unlock(krcp, flags);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
 
 			if (bkvhead[i])
 				free_page((unsigned long) bkvhead[i]);
@@ -3347,6 +3368,57 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		raw_spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static enum hrtimer_restart
+schedule_page_work_fn(struct hrtimer *t)
+{
+	struct kfree_rcu_cpu *krcp =
+		container_of(t, struct kfree_rcu_cpu, hrtimer);
+
+	queue_work(system_highpri_wq, &krcp->page_cache_work);
+	return HRTIMER_NORESTART;
+}
+
+static void fill_page_cache_func(struct work_struct *work)
+{
+	struct kvfree_rcu_bulk_data *bnode;
+	struct kfree_rcu_cpu *krcp =
+		container_of(work, struct kfree_rcu_cpu,
+			page_cache_work);
+	unsigned long flags;
+	bool pushed;
+	int i;
+
+	for (i = 0; i < rcu_min_cached_objs; i++) {
+		bnode = (struct kvfree_rcu_bulk_data *)
+			__get_free_page(GFP_KERNEL | __GFP_NOWARN);
+
+		if (bnode) {
+			raw_spin_lock_irqsave(&krcp->lock, flags);
+			pushed = put_cached_bnode(krcp, bnode);
+			raw_spin_unlock_irqrestore(&krcp->lock, flags);
+
+			if (!pushed) {
+				free_page((unsigned long) bnode);
+				break;
+			}
+		}
+	}
+
+	atomic_set(&krcp->work_in_progress, 0);
+}
+
+static void
+run_page_cache_worker(struct kfree_rcu_cpu *krcp)
+{
+	if (rcu_scheduler_active == RCU_SCHEDULER_RUNNING &&
+			!atomic_xchg(&krcp->work_in_progress, 1)) {
+		hrtimer_init(&krcp->hrtimer, CLOCK_MONOTONIC,
+			HRTIMER_MODE_REL);
+		krcp->hrtimer.function = schedule_page_work_fn;
+		hrtimer_start(&krcp->hrtimer, 0, HRTIMER_MODE_REL);
+	}
+}
+
 static inline bool
 kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 {
@@ -3363,32 +3435,8 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	if (!krcp->bkvhead[idx] ||
 			krcp->bkvhead[idx]->nr_records == KVFREE_BULK_MAX_ENTR) {
 		bnode = get_cached_bnode(krcp);
-		if (!bnode) {
-			/*
-			 * To keep this path working on raw non-preemptible
-			 * sections, prevent the optional entry into the
-			 * allocator as it uses sleeping locks. In fact, even
-			 * if the caller of kfree_rcu() is preemptible, this
-			 * path still is not, as krcp->lock is a raw spinlock.
-			 * With additional page pre-allocation in the works,
-			 * hitting this return is going to be much less likely.
-			 */
-			if (IS_ENABLED(CONFIG_PREEMPT_RT))
-				return false;
-
-			/*
-			 * NOTE: For one argument of kvfree_rcu() we can
-			 * drop the lock and get the page in sleepable
-			 * context. That would allow to maintain an array
-			 * for the CONFIG_PREEMPT_RT as well if no cached
-			 * pages are available.
-			 */
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-		}
-
 		/* Switch to emergency path. */
-		if (unlikely(!bnode))
+		if (!bnode)
 			return false;
 
 		/* Initialize the new block. */
@@ -3452,12 +3500,10 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
-	/*
-	 * Under high memory pressure GFP_NOWAIT can fail,
-	 * in that case the emergency path is maintained.
-	 */
 	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
 	if (!success) {
+		run_page_cache_worker(krcp);
+
 		if (head == NULL)
 			// Inline if kvfree_rcu(one_arg) call.
 			goto unlock_return;
@@ -3567,7 +3613,7 @@ void __init kfree_rcu_scheduler_running(void)
  * During early boot, any blocking grace-period wait automatically
  * implies a grace period.  Later on, this is never the case for PREEMPTION.
  *
- * Howevr, because a context switch is a grace period for !PREEMPTION, any
+ * However, because a context switch is a grace period for !PREEMPTION, any
  * blocking grace-period wait automatically implies a grace period if
  * there is only one CPU online at any point time during execution of
  * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
@@ -3583,7 +3629,20 @@ static int rcu_blocking_is_gp(void)
 		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
 	might_sleep();  /* Check for RCU read-side critical section. */
 	preempt_disable();
-	ret = num_online_cpus() <= 1;
+	/*
+	 * If the rcu_state.n_online_cpus counter is equal to one,
+	 * there is only one CPU, and that CPU sees all prior accesses
+	 * made by any CPU that was online at the time of its access.
+	 * Furthermore, if this counter is equal to one, its value cannot
+	 * change until after the preempt_enable() below.
+	 *
+	 * Furthermore, if rcu_state.n_online_cpus is equal to one here,
+	 * all later CPUs (both this one and any that come online later
+	 * on) are guaranteed to see all accesses prior to this point
+	 * in the code, without the need for additional memory barriers.
+	 * Those memory barriers are provided by CPU-hotplug code.
+	 */
+	ret = READ_ONCE(rcu_state.n_online_cpus) <= 1;
 	preempt_enable();
 	return ret;
 }
@@ -3628,7 +3687,7 @@ void synchronize_rcu(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu() in RCU read-side critical section");
 	if (rcu_blocking_is_gp())
-		return;
+		return;  // Context allows vacuous grace periods.
 	if (rcu_gp_is_expedited())
 		synchronize_rcu_expedited();
 	else
@@ -3707,13 +3766,13 @@ static int rcu_pending(int user)
 		return 1;
 
 	/* Does this CPU have callbacks ready to invoke? */
-	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+	if (!rcu_segcblist_is_offloaded(&rdp->cblist) &&
+	    rcu_segcblist_ready_cbs(&rdp->cblist))
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
-	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
-	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
+	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
@@ -3969,6 +4028,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_cpu_nocb_kthread(cpu);
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
 	return 0;
 }
@@ -4057,6 +4117,9 @@ void rcu_cpu_starting(unsigned int cpu)
 
 	rnp = rdp->mynode;
 	mask = rdp->grpmask;
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
 	newcpu = !(rnp->expmaskinitnext & mask);
@@ -4067,13 +4130,18 @@ void rcu_cpu_starting(unsigned int cpu)
 	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
 	rdp->rcu_onl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_onl_gp_flags = READ_ONCE(rcu_state.gp_flags);
-	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+
+	/* An incoming CPU should never be blocking a grace period. */
+	if (WARN_ON_ONCE(rnp->qsmask & mask)) { /* RCU waiting on incoming CPU? */
 		rcu_disable_urgency_upon_qs(rdp);
 		/* Report QS -after- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 	} else {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
 
@@ -4101,6 +4169,9 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(!(rnp->ofl_seq & 0x1));
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
 	raw_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
@@ -4113,6 +4184,9 @@ void rcu_report_dead(unsigned int cpu)
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	raw_spin_unlock(&rcu_state.ofl_lock);
+	smp_mb(); // Pair with rcu_gp_cleanup()'s ->ofl_seq barrier().
+	WRITE_ONCE(rnp->ofl_seq, rnp->ofl_seq + 1);
+	WARN_ON_ONCE(rnp->ofl_seq & 0x1);
 
 	rdp->cpu_started = false;
 }
@@ -4449,24 +4523,14 @@ static void __init kfree_rcu_batch_init(void)
 
 	for_each_possible_cpu(cpu) {
 		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
-		struct kvfree_rcu_bulk_data *bnode;
 
 		for (i = 0; i < KFREE_N_BATCHES; i++) {
 			INIT_RCU_WORK(&krcp->krw_arr[i].rcu_work, kfree_rcu_work);
 			krcp->krw_arr[i].krcp = krcp;
 		}
 
-		for (i = 0; i < rcu_min_cached_objs; i++) {
-			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
-
-			if (bnode)
-				put_cached_bnode(krcp, bnode);
-			else
-				pr_err("Failed to preallocate for %d CPU!\n", cpu);
-		}
-
 		INIT_DELAYED_WORK(&krcp->monitor_work, kfree_rcu_monitor);
+		INIT_WORK(&krcp->page_cache_work, fill_page_cache_func);
 		krcp->initialized = true;
 	}
 	if (register_shrinker(&kfree_rcu_shrinker))
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e4f66b8f7c47..7708ed161f4a 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -56,6 +56,7 @@ struct rcu_node {
 				/*  Initialized from ->qsmaskinitnext at the */
 				/*  beginning of each grace period. */
 	unsigned long qsmaskinitnext;
+	unsigned long ofl_seq;	/* CPU-hotplug operation sequence count. */
 				/* Online CPUs for next grace period. */
 	unsigned long expmask;	/* CPUs or groups that need to check in */
 				/*  to allow the current expedited GP */
@@ -298,6 +299,7 @@ struct rcu_state {
 						/* Hierarchy levels (+1 to */
 						/*  shut bogus gcc warning) */
 	int ncpus;				/* # CPUs seen so far. */
+	int n_online_cpus;			/* # CPUs online for RCU. */
 
 	/* The following fields are guarded by the root rcu_node's lock. */
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fd8a52e9a887..7e291ce0a1d6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -628,7 +628,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			set_tsk_need_resched(current);
 			set_preempt_need_resched();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
-			    !rdp->defer_qs_iw_pending && exp) {
+			    !rdp->defer_qs_iw_pending && exp && cpu_online(rdp->cpu)) {
 				// Get scheduler to re-evaluate and call hooks.
 				// If !IRQ_WORK, FQS scan will eventually IPI.
 				init_irq_work(&rdp->defer_qs_iw,
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index ca21d28a0f98..70d48c52fabc 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -13,6 +13,7 @@
 
 /* panic() on RCU Stall sysctl. */
 int sysctl_panic_on_rcu_stall __read_mostly;
+int sysctl_max_rcu_stall_to_panic __read_mostly;
 
 #ifdef CONFIG_PROVE_RCU
 #define RCU_STALL_DELAY_DELTA		(5 * HZ)
@@ -106,6 +107,11 @@ early_initcall(check_cpu_stall_init);
 /* If so specified via sysctl, panic, yielding cleaner stall-warning output. */
 static void panic_on_rcu_stall(void)
 {
+	static int cpu_stall;
+
+	if (++cpu_stall < sysctl_max_rcu_stall_to_panic)
+		return;
+
 	if (sysctl_panic_on_rcu_stall)
 		panic("RCU Stall\n");
 }
diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 554a521ee235..d55a9f8cda3d 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -59,9 +59,10 @@ torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0, "Time between CPU hotplugs (s), 0=disable");
 torture_param(int, shutdown_secs, 0, "Shutdown time (ms), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s.");
-torture_param(int, stutter_cpus, 5, "Number of jiffies to change CPUs under test, 0=disable");
+torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
 torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU hotplug.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+torture_param(int, weight_resched, -1, "Testing weight for resched_cpu() operations.");
 torture_param(int, weight_single, -1, "Testing weight for single-CPU no-wait operations.");
 torture_param(int, weight_single_wait, -1, "Testing weight for single-CPU operations.");
 torture_param(int, weight_many, -1, "Testing weight for multi-CPU no-wait operations.");
@@ -82,6 +83,7 @@ torture_param(bool, shutdown, SCFTORT_SHUTDOWN, "Shutdown at end of torture test
 struct scf_statistics {
 	struct task_struct *task;
 	int cpu;
+	long long n_resched;
 	long long n_single;
 	long long n_single_ofl;
 	long long n_single_wait;
@@ -97,12 +99,15 @@ static struct task_struct *scf_torture_stats_task;
 static DEFINE_PER_CPU(long long, scf_invoked_count);
 
 // Data for random primitive selection
-#define SCF_PRIM_SINGLE		0
-#define SCF_PRIM_MANY		1
-#define SCF_PRIM_ALL		2
-#define SCF_NPRIMS		(2 * 3) // Need wait and no-wait versions of each.
+#define SCF_PRIM_RESCHED	0
+#define SCF_PRIM_SINGLE		1
+#define SCF_PRIM_MANY		2
+#define SCF_PRIM_ALL		3
+#define SCF_NPRIMS		7 // Need wait and no-wait versions of each,
+				  //  except for SCF_PRIM_RESCHED.
 
 static char *scf_prim_name[] = {
+	"resched_cpu",
 	"smp_call_function_single",
 	"smp_call_function_many",
 	"smp_call_function",
@@ -136,6 +141,8 @@ static char *bangstr = "";
 
 static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
+extern void resched_cpu(int cpu); // An alternative IPI vector.
+
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
 {
@@ -148,6 +155,7 @@ static void scf_torture_stats_print(void)
 	for_each_possible_cpu(cpu)
 		invoked_count += data_race(per_cpu(scf_invoked_count, cpu));
 	for (i = 0; i < nthreads; i++) {
+		scfs.n_resched += scf_stats_p[i].n_resched;
 		scfs.n_single += scf_stats_p[i].n_single;
 		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
 		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
@@ -160,8 +168,8 @@ static void scf_torture_stats_print(void)
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
 	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
 		bangstr = "!!! ";
-	pr_alert("%s %sscf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
-		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count,
+	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
 		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
 		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
@@ -314,6 +322,13 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 	}
 	switch (scfsp->scfs_prim) {
+	case SCF_PRIM_RESCHED:
+		if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST)) {
+			cpu = torture_random(trsp) % nr_cpu_ids;
+			scfp->n_resched++;
+			resched_cpu(cpu);
+		}
+		break;
 	case SCF_PRIM_SINGLE:
 		cpu = torture_random(trsp) % nr_cpu_ids;
 		if (scfsp->scfs_wait)
@@ -421,6 +436,7 @@ static int scftorture_invoker(void *arg)
 			was_offline = false;
 		}
 		cond_resched();
+		stutter_wait("scftorture_invoker");
 	} while (!torture_must_stop());
 
 	VERBOSE_SCFTORTOUT("scftorture_invoker %d ended", scfp->cpu);
@@ -433,8 +449,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -475,6 +491,7 @@ static int __init scf_torture_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long weight_resched1 = weight_resched;
 	unsigned long weight_single1 = weight_single;
 	unsigned long weight_single_wait1 = weight_single_wait;
 	unsigned long weight_many1 = weight_many;
@@ -487,9 +504,10 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
-	if (weight_single == -1 && weight_single_wait == -1 &&
+	if (weight_resched == -1 && weight_single == -1 && weight_single_wait == -1 &&
 	    weight_many == -1 && weight_many_wait == -1 &&
 	    weight_all == -1 && weight_all_wait == -1) {
+		weight_resched1 = 2 * nr_cpu_ids;
 		weight_single1 = 2 * nr_cpu_ids;
 		weight_single_wait1 = 2 * nr_cpu_ids;
 		weight_many1 = 2;
@@ -497,6 +515,8 @@ static int __init scf_torture_init(void)
 		weight_all1 = 1;
 		weight_all_wait1 = 1;
 	} else {
+		if (weight_resched == -1)
+			weight_resched1 = 0;
 		if (weight_single == -1)
 			weight_single1 = 0;
 		if (weight_single_wait == -1)
@@ -517,6 +537,10 @@ static int __init scf_torture_init(void)
 		firsterr = -EINVAL;
 		goto unwind;
 	}
+	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
+		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
+	else if (weight_resched1)
+		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
 	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
 	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
 	scf_sel_add(weight_many1, SCF_PRIM_MANY, false);
@@ -535,6 +559,11 @@ static int __init scf_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	if (stutter > 0) {
+		firsterr = torture_stutter_init(stutter, stutter);
+		if (firsterr)
+			goto unwind;
+	}
 
 	// Worker tasks invoking smp_call_function().
 	if (nthreads < 0)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..c9fbdd848138 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2650,6 +2650,17 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_ONE,
 	},
 #endif
+#if defined(CONFIG_TREE_RCU)
+	{
+		.procname	= "max_rcu_stall_to_panic",
+		.data		= &sysctl_max_rcu_stall_to_panic,
+		.maxlen		= sizeof(sysctl_max_rcu_stall_to_panic),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_INT_MAX,
+	},
+#endif
 #ifdef CONFIG_STACKLEAK_RUNTIME_DISABLE
 	{
 		.procname	= "stack_erasing",
diff --git a/kernel/torture.c b/kernel/torture.c
index 1061492f14bd..8562ac18d2eb 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -602,18 +602,29 @@ static int stutter_gap;
  */
 bool stutter_wait(const char *title)
 {
-	int spt;
+	ktime_t delay;
+	unsigned int i = 0;
 	bool ret = false;
+	int spt;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		ret = true;
+		if (!ret) {
+			sched_set_normal(current, MAX_NICE);
+			ret = true;
+		}
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			while (READ_ONCE(stutter_pause_test))
+			while (READ_ONCE(stutter_pause_test)) {
+				if (!(i++ & 0xffff)) {
+					set_current_state(TASK_INTERRUPTIBLE);
+					delay = 10 * NSEC_PER_USEC;
+					schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				}
 				cond_resched();
+			}
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
@@ -629,20 +640,27 @@ EXPORT_SYMBOL_GPL(stutter_wait);
  */
 static int torture_stutter(void *arg)
 {
+	ktime_t delay;
+	DEFINE_TORTURE_RANDOM(rand);
 	int wtime;
 
 	VERBOSE_TOROUT_STRING("torture_stutter task started");
 	do {
 		if (!torture_must_stop() && stutter > 1) {
 			wtime = stutter;
-			if (stutter > HZ + 1) {
+			if (stutter > 2) {
 				WRITE_ONCE(stutter_pause_test, 1);
-				wtime = stutter - HZ - 1;
-				schedule_timeout_interruptible(wtime);
-				wtime = HZ + 1;
+				wtime = stutter - 3;
+				delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
+				delay += (torture_random(&rand) >> 3) % NSEC_PER_MSEC;
+				set_current_state(TASK_INTERRUPTIBLE);
+				schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
+				wtime = 2;
 			}
 			WRITE_ONCE(stutter_pause_test, 2);
-			schedule_timeout_interruptible(wtime);
+			delay = ktime_divns(NSEC_PER_SEC * wtime, HZ);
+			set_current_state(TASK_INTERRUPTIBLE);
+			schedule_hrtimeout(&delay, HRTIMER_MODE_REL);
 		}
 		WRITE_ONCE(stutter_pause_test, 0);
 		if (!torture_must_stop())
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 2551e9b71167..e61d36cd4e50 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -107,7 +107,7 @@ static int errno;
 #endif
 
 /* errno codes all ensure that they will not conflict with a valid pointer
- * because they all correspond to the highest addressable memry page.
+ * because they all correspond to the highest addressable memory page.
  */
 #define MAX_ERRNO 4095
 
@@ -231,7 +231,7 @@ struct rusage {
 #define DT_SOCK   12
 
 /* all the *at functions */
-#ifndef AT_FDWCD
+#ifndef AT_FDCWD
 #define AT_FDCWD             -100
 #endif
 
diff --git a/tools/memory-model/Documentation/README b/tools/memory-model/Documentation/README
new file mode 100644
index 000000000000..db90a26dbdf4
--- /dev/null
+++ b/tools/memory-model/Documentation/README
@@ -0,0 +1,76 @@
+It has been said that successful communication requires first identifying
+what your audience knows and then building a bridge from their current
+knowledge to what they need to know.  Unfortunately, the expected
+Linux-kernel memory model (LKMM) audience might be anywhere from novice
+to expert both in kernel hacking and in understanding LKMM.
+
+This document therefore points out a number of places to start reading,
+depending on what you know and what you would like to learn.  Please note
+that the documents later in this list assume that the reader understands
+the material provided by documents earlier in this list.
+
+o	You are new to Linux-kernel concurrency: simple.txt
+
+o	You have some background in Linux-kernel concurrency, and would
+	like an overview of the types of low-level concurrency primitives
+	that the Linux kernel provides:  ordering.txt
+
+	Here, "low level" means atomic operations to single variables.
+
+o	You are familiar with the Linux-kernel concurrency primitives
+	that you need, and just want to get started with LKMM litmus
+	tests:  litmus-tests.txt
+
+o	You are familiar with Linux-kernel concurrency, and would
+	like a detailed intuitive understanding of LKMM, including
+	situations involving more than two threads:  recipes.txt
+
+o	You would like a detailed understanding of what your compiler can
+	and cannot do to control dependencies:  control-dependencies.txt
+
+o	You are familiar with Linux-kernel concurrency and the use of
+	LKMM, and would like a quick reference:  cheatsheet.txt
+
+o	You are familiar with Linux-kernel concurrency and the use
+	of LKMM, and would like to learn about LKMM's requirements,
+	rationale, and implementation:	explanation.txt
+
+o	You are interested in the publications related to LKMM, including
+	hardware manuals, academic literature, standards-committee
+	working papers, and LWN articles:  references.txt
+
+
+====================
+DESCRIPTION OF FILES
+====================
+
+README
+	This file.
+
+cheatsheet.txt
+	Quick-reference guide to the Linux-kernel memory model.
+
+control-dependencies.txt
+	Guide to preventing compiler optimizations from destroying
+	your control dependencies.
+
+explanation.txt
+	Detailed description of the memory model.
+
+litmus-tests.txt
+	The format, features, capabilities, and limitations of the litmus
+	tests that LKMM can evaluate.
+
+ordering.txt
+	Overview of the Linux kernel's low-level memory-ordering
+	primitives by category.
+
+recipes.txt
+	Common memory-ordering patterns.
+
+references.txt
+	Background information.
+
+simple.txt
+	Starting point for someone new to Linux-kernel concurrency.
+	And also a reminder of the simpler approaches to concurrency!
diff --git a/tools/memory-model/Documentation/control-dependencies.txt b/tools/memory-model/Documentation/control-dependencies.txt
new file mode 100644
index 000000000000..8b743d20fe27
--- /dev/null
+++ b/tools/memory-model/Documentation/control-dependencies.txt
@@ -0,0 +1,258 @@
+CONTROL DEPENDENCIES
+====================
+
+A major difficulty with control dependencies is that current compilers
+do not support them.  One purpose of this document is therefore to
+help you prevent your compiler from breaking your code.  However,
+control dependencies also pose other challenges, which leads to the
+second purpose of this document, namely to help you to avoid breaking
+your own code, even in the absence of help from your compiler.
+
+One such challenge is that control dependencies order only later stores.
+Therefore, a load-load control dependency will not preserve ordering
+unless a read memory barrier is provided.  Consider the following code:
+
+	q = READ_ONCE(a);
+	if (q)
+		p = READ_ONCE(b);
+
+This is not guaranteed to provide any ordering because some types of CPUs
+are permitted to predict the result of the load from "b".  This prediction
+can cause other CPUs to see this load as having happened before the load
+from "a".  This means that an explicit read barrier is required, for example
+as follows:
+
+	q = READ_ONCE(a);
+	if (q) {
+		smp_rmb();
+		p = READ_ONCE(b);
+	}
+
+However, stores are not speculated.  This means that ordering is
+(usually) guaranteed for load-store control dependencies, as in the
+following example:
+
+	q = READ_ONCE(a);
+	if (q)
+		WRITE_ONCE(b, 1);
+
+Control dependencies can pair with each other and with other types
+of ordering.  But please note that neither the READ_ONCE() nor the
+WRITE_ONCE() are optional.  Without the READ_ONCE(), the compiler might
+fuse the load from "a" with other loads.  Without the WRITE_ONCE(),
+the compiler might fuse the store to "b" with other stores.  Worse yet,
+the compiler might convert the store into a load and a check followed
+by a store, and this compiler-generated load would not be ordered by
+the control dependency.
+
+Furthermore, if the compiler is able to prove that the value of variable
+"a" is always non-zero, it would be well within its rights to optimize
+the original example by eliminating the "if" statement as follows:
+
+	q = a;
+	b = 1;  /* BUG: Compiler and CPU can both reorder!!! */
+
+So don't leave out either the READ_ONCE() or the WRITE_ONCE().
+In particular, although READ_ONCE() does force the compiler to emit a
+load, it does *not* force the compiler to actually use the loaded value.
+
+It is tempting to try use control dependencies to enforce ordering on
+identical stores on both branches of the "if" statement as follows:
+
+	q = READ_ONCE(a);
+	if (q) {
+		barrier();
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		barrier();
+		WRITE_ONCE(b, 1);
+		do_something_else();
+	}
+
+Unfortunately, current compilers will transform this as follows at high
+optimization levels:
+
+	q = READ_ONCE(a);
+	barrier();
+	WRITE_ONCE(b, 1);  /* BUG: No ordering vs. load from a!!! */
+	if (q) {
+		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
+		do_something();
+	} else {
+		/* WRITE_ONCE(b, 1); -- moved up, BUG!!! */
+		do_something_else();
+	}
+
+Now there is no conditional between the load from "a" and the store to
+"b", which means that the CPU is within its rights to reorder them:  The
+conditional is absolutely required, and must be present in the final
+assembly code, after all of the compiler and link-time optimizations
+have been applied.  Therefore, if you need ordering in this example,
+you must use explicit memory ordering, for example, smp_store_release():
+
+	q = READ_ONCE(a);
+	if (q) {
+		smp_store_release(&b, 1);
+		do_something();
+	} else {
+		smp_store_release(&b, 1);
+		do_something_else();
+	}
+
+Without explicit memory ordering, control-dependency-based ordering is
+guaranteed only when the stores differ, for example:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		WRITE_ONCE(b, 2);
+		do_something_else();
+	}
+
+The initial READ_ONCE() is still required to prevent the compiler from
+knowing too much about the value of "a".
+
+But please note that you need to be careful what you do with the local
+variable "q", otherwise the compiler might be able to guess the value
+and again remove the conditional branch that is absolutely required to
+preserve ordering.  For example:
+
+	q = READ_ONCE(a);
+	if (q % MAX) {
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		WRITE_ONCE(b, 2);
+		do_something_else();
+	}
+
+If MAX is compile-time defined to be 1, then the compiler knows that
+(q % MAX) must be equal to zero, regardless of the value of "q".
+The compiler is therefore within its rights to transform the above code
+into the following:
+
+	q = READ_ONCE(a);
+	WRITE_ONCE(b, 2);
+	do_something_else();
+
+Given this transformation, the CPU is not required to respect the ordering
+between the load from variable "a" and the store to variable "b".  It is
+tempting to add a barrier(), but this does not help.  The conditional
+is gone, and the barrier won't bring it back.  Therefore, if you need
+to relying on control dependencies to produce this ordering, you should
+make sure that MAX is greater than one, perhaps as follows:
+
+	q = READ_ONCE(a);
+	BUILD_BUG_ON(MAX <= 1); /* Order load from a with store to b. */
+	if (q % MAX) {
+		WRITE_ONCE(b, 1);
+		do_something();
+	} else {
+		WRITE_ONCE(b, 2);
+		do_something_else();
+	}
+
+Please note once again that each leg of the "if" statement absolutely
+must store different values to "b".  As in previous examples, if the two
+values were identical, the compiler could pull this store outside of the
+"if" statement, destroying the control dependency's ordering properties.
+
+You must also be careful avoid relying too much on boolean short-circuit
+evaluation.  Consider this example:
+
+	q = READ_ONCE(a);
+	if (q || 1 > 0)
+		WRITE_ONCE(b, 1);
+
+Because the first condition cannot fault and the second condition is
+always true, the compiler can transform this example as follows, again
+destroying the control dependency's ordering:
+
+	q = READ_ONCE(a);
+	WRITE_ONCE(b, 1);
+
+This is yet another example showing the importance of preventing the
+compiler from out-guessing your code.  Again, although READ_ONCE() really
+does force the compiler to emit code for a given load, the compiler is
+within its rights to discard the loaded value.
+
+In addition, control dependencies apply only to the then-clause and
+else-clause of the "if" statement in question.  In particular, they do
+not necessarily order the code following the entire "if" statement:
+
+	q = READ_ONCE(a);
+	if (q) {
+		WRITE_ONCE(b, 1);
+	} else {
+		WRITE_ONCE(b, 2);
+	}
+	WRITE_ONCE(c, 1);  /* BUG: No ordering against the read from "a". */
+
+It is tempting to argue that there in fact is ordering because the
+compiler cannot reorder volatile accesses and also cannot reorder
+the writes to "b" with the condition.  Unfortunately for this line
+of reasoning, the compiler might compile the two writes to "b" as
+conditional-move instructions, as in this fanciful pseudo-assembly
+language:
+
+	ld r1,a
+	cmp r1,$0
+	cmov,ne r4,$1
+	cmov,eq r4,$2
+	st r4,b
+	st $1,c
+
+The control dependencies would then extend only to the pair of cmov
+instructions and the store depending on them.  This means that a weakly
+ordered CPU would have no dependency of any sort between the load from
+"a" and the store to "c".  In short, control dependencies provide ordering
+only to the stores in the then-clause and else-clause of the "if" statement
+in question (including functions invoked by those two clauses), and not
+to code following that "if" statement.
+
+
+In summary:
+
+  (*) Control dependencies can order prior loads against later stores.
+      However, they do *not* guarantee any other sort of ordering:
+      Not prior loads against later loads, nor prior stores against
+      later anything.  If you need these other forms of ordering, use
+      smp_load_acquire(), smp_store_release(), or, in the case of prior
+      stores and later loads, smp_mb().
+
+  (*) If both legs of the "if" statement contain identical stores to
+      the same variable, then you must explicitly order those stores,
+      either by preceding both of them with smp_mb() or by using
+      smp_store_release().  Please note that it is *not* sufficient to use
+      barrier() at beginning and end of each leg of the "if" statement
+      because, as shown by the example above, optimizing compilers can
+      destroy the control dependency while respecting the letter of the
+      barrier() law.
+
+  (*) Control dependencies require at least one run-time conditional
+      between the prior load and the subsequent store, and this
+      conditional must involve the prior load.  If the compiler is able
+      to optimize the conditional away, it will have also optimized
+      away the ordering.  Careful use of READ_ONCE() and WRITE_ONCE()
+      can help to preserve the needed conditional.
+
+  (*) Control dependencies require that the compiler avoid reordering the
+      dependency into nonexistence.  Careful use of READ_ONCE() or
+      atomic{,64}_read() can help to preserve your control dependency.
+
+  (*) Control dependencies apply only to the then-clause and else-clause
+      of the "if" statement containing the control dependency, including
+      any functions that these two clauses call.  Control dependencies
+      do *not* apply to code beyond the end of that "if" statement.
+
+  (*) Control dependencies pair normally with other types of barriers.
+
+  (*) Control dependencies do *not* provide multicopy atomicity.  If you
+      need all the CPUs to agree on the ordering of a given store against
+      all other accesses, use smp_mb().
+
+  (*) Compilers do not understand control dependencies.  It is therefore
+      your job to ensure that they do not break your code.
diff --git a/tools/memory-model/Documentation/glossary.txt b/tools/memory-model/Documentation/glossary.txt
new file mode 100644
index 000000000000..79acb75d56ea
--- /dev/null
+++ b/tools/memory-model/Documentation/glossary.txt
@@ -0,0 +1,172 @@
+This document contains brief definitions of LKMM-related terms.  Like most
+glossaries, it is not intended to be read front to back (except perhaps
+as a way of confirming a diagnosis of OCD), but rather to be searched
+for specific terms.
+
+
+Address Dependency:  When the address of a later memory access is computed
+	based on the value returned by an earlier load, an "address
+	dependency" extends from that load extending to the later access.
+	Address dependencies are quite common in RCU read-side critical
+	sections:
+
+	 1 rcu_read_lock();
+	 2 p = rcu_dereference(gp);
+	 3 do_something(p->a);
+	 4 rcu_read_unlock();
+
+	 In this case, because the address of "p->a" on line 3 is computed
+	 from the value returned by the rcu_dereference() on line 2, the
+	 address dependency extends from that rcu_dereference() to that
+	 "p->a".  In rare cases, optimizing compilers can destroy address
+	 dependencies.	Please see Documentation/RCU/rcu_dereference.txt
+	 for more information.
+
+	 See also "Control Dependency" and "Data Dependency".
+
+Acquire:  With respect to a lock, acquiring that lock, for example,
+	using spin_lock().  With respect to a non-lock shared variable,
+	a special operation that includes a load and which orders that
+	load before later memory references running on that same CPU.
+	An example special acquire operation is smp_load_acquire(),
+	but atomic_read_acquire() and atomic_xchg_acquire() also include
+	acquire loads.
+
+	When an acquire load returns the value stored by a release store
+	to that same variable, then all operations preceding that store
+	happen before any operations following that load acquire.
+
+	See also "Relaxed" and "Release".
+
+Coherence (co):  When one CPU's store to a given variable overwrites
+	either the value from another CPU's store or some later value,
+	there is said to be a coherence link from the second CPU to
+	the first.
+
+	It is also possible to have a coherence link within a CPU, which
+	is a "coherence internal" (coi) link.  The term "coherence
+	external" (coe) link is used when it is necessary to exclude
+	the coi case.
+
+	See also "From-reads" and "Reads-from".
+
+Control Dependency:  When a later store's execution depends on a test
+	of a value computed from a value returned by an earlier load,
+	a "control dependency" extends from that load to that store.
+	For example:
+
+	 1 if (READ_ONCE(x))
+	 2   WRITE_ONCE(y, 1);
+
+	 Here, the control dependency extends from the READ_ONCE() on
+	 line 1 to the WRITE_ONCE() on line 2.	Control dependencies are
+	 fragile, and can be easily destroyed by optimizing compilers.
+	 Please see control-dependencies.txt for more information.
+
+	 See also "Address Dependency" and "Data Dependency".
+
+Cycle:	Memory-barrier pairing is restricted to a pair of CPUs, as the
+	name suggests.	And in a great many cases, a pair of CPUs is all
+	that is required.  In other cases, the notion of pairing must be
+	extended to additional CPUs, and the result is called a "cycle".
+	In a cycle, each CPU's ordering interacts with that of the next:
+
+	CPU 0                CPU 1                CPU 2
+	WRITE_ONCE(x, 1);    WRITE_ONCE(y, 1);    WRITE_ONCE(z, 1);
+	smp_mb();            smp_mb();            smp_mb();
+	r0 = READ_ONCE(y);   r1 = READ_ONCE(z);   r2 = READ_ONCE(x);
+
+	CPU 0's smp_mb() interacts with that of CPU 1, which interacts
+	with that of CPU 2, which in turn interacts with that of CPU 0
+	to complete the cycle.	Because of the smp_mb() calls between
+	each pair of memory accesses, the outcome where r0, r1, and r2
+	are all equal to zero is forbidden by LKMM.
+
+	See also "Pairing".
+
+Data Dependency:  When the data written by a later store is computed based
+	on the value returned by an earlier load, a "data dependency"
+	extends from that load to that later store.  For example:
+
+	 1 r1 = READ_ONCE(x);
+	 2 WRITE_ONCE(y, r1 + 1);
+
+	In this case, the data dependency extends from the READ_ONCE()
+	on line 1 to the WRITE_ONCE() on line 2.  Data dependencies are
+	fragile and can be easily destroyed by optimizing compilers.
+	Because optimizing compilers put a great deal of effort into
+	working out what values integer variables might have, this is
+	especially true in cases where the dependency is carried through
+	an integer.
+
+	See also "Address Dependency" and "Control Dependency".
+
+From-Reads (fr):  When one CPU's store to a given variable happened
+	too late to affect the value returned by another CPU's
+	load from that same variable, there is said to be a from-reads
+	link from the load to the store.
+
+	It is also possible to have a from-reads link within a CPU, which
+	is a "from-reads internal" (fri) link.  The term "from-reads
+	external" (fre) link is used when it is necessary to exclude
+	the fri case.
+
+	See also "Coherence" and "Reads-from".
+
+Fully Ordered:  An operation such as smp_mb() that orders all of
+	its CPU's prior accesses with all of that CPU's subsequent
+	accesses, or a marked access such as atomic_add_return()
+	that orders all of its CPU's prior accesses, itself, and
+	all of its CPU's subsequent accesses.
+
+Marked Access:  An access to a variable that uses an special function or
+	macro such as "r1 = READ_ONCE(x)" or "smp_store_release(&a, 1)".
+
+	See also "Unmarked Access".
+
+Pairing: "Memory-barrier pairing" reflects the fact that synchronizing
+	data between two CPUs requires that both CPUs their accesses.
+	Memory barriers thus tend to come in pairs, one executed by
+	one of the CPUs and the other by the other CPU.  Of course,
+	pairing also occurs with other types of operations, so that a
+	smp_store_release() pairs with an smp_load_acquire() that reads
+	the value stored.
+
+	See also "Cycle".
+
+Reads-From (rf):  When one CPU's load returns the value stored by some other
+	CPU, there is said to be a reads-from link from the second
+	CPU's store to the first CPU's load.  Reads-from links have the
+	nice property that time must advance from the store to the load,
+	which means that algorithms using reads-from links can use lighter
+	weight ordering and synchronization compared to algorithms using
+	coherence and from-reads links.
+
+	It is also possible to have a reads-from link within a CPU, which
+	is a "reads-from internal" (rfi) link.	The term "reads-from
+	external" (rfe) link is used when it is necessary to exclude
+	the rfi case.
+
+	See also Coherence" and "From-reads".
+
+Relaxed:  A marked access that does not imply ordering, for example, a
+	READ_ONCE(), WRITE_ONCE(), a non-value-returning read-modify-write
+	operation, or a value-returning read-modify-write operation whose
+	name ends in "_relaxed".
+
+	See also "Acquire" and "Release".
+
+Release:  With respect to a lock, releasing that lock, for example,
+	using spin_unlock().  With respect to a non-lock shared variable,
+	a special operation that includes a store and which orders that
+	store after earlier memory references that ran on that same CPU.
+	An example special release store is smp_store_release(), but
+	atomic_set_release() and atomic_cmpxchg_release() also include
+	release stores.
+
+	See also "Acquire" and "Relaxed".
+
+Unmarked Access:  An access to a variable that uses normal C-language
+	syntax, for example, "a = b[2]";
+
+	See also "Marked Access".
diff --git a/tools/memory-model/Documentation/litmus-tests.txt b/tools/memory-model/Documentation/litmus-tests.txt
index 2f840dcd15cf..8a9d5d2787f9 100644
--- a/tools/memory-model/Documentation/litmus-tests.txt
+++ b/tools/memory-model/Documentation/litmus-tests.txt
@@ -946,6 +946,23 @@ Limitations of the Linux-kernel memory model (LKMM) include:
 	carrying a dependency, then the compiler can break that dependency
 	by substituting a constant of that value.
 
+	Conversely, LKMM sometimes doesn't recognize that a particular
+	optimization is not allowed, and as a result, thinks that a
+	dependency is not present (because the optimization would break it).
+	The memory model misses some pretty obvious control dependencies
+	because of this limitation.  A simple example is:
+
+		r1 = READ_ONCE(x);
+		if (r1 == 0)
+			smp_mb();
+		WRITE_ONCE(y, 1);
+
+	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
+	even when r1 is nonzero, but LKMM doesn't realize this and thinks
+	that the write may execute before the read if r1 != 0.  (Yes, that
+	doesn't make sense if you think about it, but the memory model's
+	intelligence is limited.)
+
 2.	Multiple access sizes for a single variable are not supported,
 	and neither are misaligned or partially overlapping accesses.
 
diff --git a/tools/memory-model/Documentation/ordering.txt b/tools/memory-model/Documentation/ordering.txt
new file mode 100644
index 000000000000..9b0949d3f5ec
--- /dev/null
+++ b/tools/memory-model/Documentation/ordering.txt
@@ -0,0 +1,556 @@
+This document gives an overview of the categories of memory-ordering
+operations provided by the Linux-kernel memory model (LKMM).
+
+
+Categories of Ordering
+======================
+
+This section lists LKMM's three top-level categories of memory-ordering
+operations in decreasing order of strength:
+
+1.	Barriers (also known as "fences").  A barrier orders some or
+	all of the CPU's prior operations against some or all of its
+	subsequent operations.
+
+2.	Ordered memory accesses.  These operations order themselves
+	against some or all of the CPU's prior accesses or some or all
+	of the CPU's subsequent accesses, depending on the subcategory
+	of the operation.
+
+3.	Unordered accesses, as the name indicates, have no ordering
+	properties except to the extent that they interact with an
+	operation in the previous categories.  This being the real world,
+	some of these "unordered" operations provide limited ordering
+	in some special situations.
+
+Each of the above categories is described in more detail by one of the
+following sections.
+
+
+Barriers
+========
+
+Each of the following categories of barriers is described in its own
+subsection below:
+
+a.	Full memory barriers.
+
+b.	Read-modify-write (RMW) ordering augmentation barriers.
+
+c.	Write memory barrier.
+
+d.	Read memory barrier.
+
+e.	Compiler barrier.
+
+Note well that many of these primitives generate absolutely no code
+in kernels built with CONFIG_SMP=n.  Therefore, if you are writing
+a device driver, which must correctly order accesses to a physical
+device even in kernels built with CONFIG_SMP=n, please use the
+ordering primitives provided for that purpose.  For example, instead of
+smp_mb(), use mb().  See the "Linux Kernel Device Drivers" book or the
+https://lwn.net/Articles/698014/ article for more information.
+
+
+Full Memory Barriers
+--------------------
+
+The Linux-kernel primitives that provide full ordering include:
+
+o	The smp_mb() full memory barrier.
+
+o	Value-returning RMW atomic operations whose names do not end in
+	_acquire, _release, or _relaxed.
+
+o	RCU's grace-period primitives.
+
+First, the smp_mb() full memory barrier orders all of the CPU's prior
+accesses against all subsequent accesses from the viewpoint of all CPUs.
+In other words, all CPUs will agree that any earlier action taken
+by that CPU happened before any later action taken by that same CPU.
+For example, consider the following:
+
+	WRITE_ONCE(x, 1);
+	smp_mb(); // Order store to x before load from y.
+	r1 = READ_ONCE(y);
+
+All CPUs will agree that the store to "x" happened before the load
+from "y", as indicated by the comment.  And yes, please comment your
+memory-ordering primitives.  It is surprisingly hard to remember their
+purpose after even a few months.
+
+Second, some RMW atomic operations provide full ordering.  These
+operations include value-returning RMW atomic operations (that is, those
+with non-void return types) whose names do not end in _acquire, _release,
+or _relaxed.  Examples include atomic_add_return(), atomic_dec_and_test(),
+cmpxchg(), and xchg().  Note that conditional RMW atomic operations such
+as cmpxchg() are only guaranteed to provide ordering when they succeed.
+When RMW atomic operations provide full ordering, they partition the
+CPU's accesses into three groups:
+
+1.	All code that executed prior to the RMW atomic operation.
+
+2.	The RMW atomic operation itself.
+
+3.	All code that executed after the RMW atomic operation.
+
+All CPUs will agree that any operation in a given partition happened
+before any operation in a higher-numbered partition.
+
+In contrast, non-value-returning RMW atomic operations (that is, those
+with void return types) do not guarantee any ordering whatsoever.  Nor do
+value-returning RMW atomic operations whose names end in _relaxed.
+Examples of the former include atomic_inc() and atomic_dec(),
+while examples of the latter include atomic_cmpxchg_relaxed() and
+atomic_xchg_relaxed().  Similarly, value-returning non-RMW atomic
+operations such as atomic_read() do not guarantee full ordering, and
+are covered in the later section on unordered operations.
+
+Value-returning RMW atomic operations whose names end in _acquire or
+_release provide limited ordering, and will be described later in this
+document.
+
+Finally, RCU's grace-period primitives provide full ordering.  These
+primitives include synchronize_rcu(), synchronize_rcu_expedited(),
+synchronize_srcu() and so on.  However, these primitives have orders
+of magnitude greater overhead than smp_mb(), atomic_xchg(), and so on.
+Furthermore, RCU's grace-period primitives can only be invoked in
+sleepable contexts.  Therefore, RCU's grace-period primitives are
+typically instead used to provide ordering against RCU read-side critical
+sections, as documented in their comment headers.  But of course if you
+need a synchronize_rcu() to interact with readers, it costs you nothing
+to also rely on its additional full-memory-barrier semantics.  Just please
+carefully comment this, otherwise your future self will hate you.
+
+
+RMW Ordering Augmentation Barriers
+----------------------------------
+
+As noted in the previous section, non-value-returning RMW operations
+such as atomic_inc() and atomic_dec() guarantee no ordering whatsoever.
+Nevertheless, a number of popular CPU families, including x86, provide
+full ordering for these primitives.  One way to obtain full ordering on
+all architectures is to add a call to smp_mb():
+
+	WRITE_ONCE(x, 1);
+	atomic_inc(&my_counter);
+	smp_mb(); // Inefficient on x86!!!
+	r1 = READ_ONCE(y);
+
+This works, but the added smp_mb() adds needless overhead for
+x86, on which atomic_inc() provides full ordering all by itself.
+The smp_mb__after_atomic() primitive can be used instead:
+
+	WRITE_ONCE(x, 1);
+	atomic_inc(&my_counter);
+	smp_mb__after_atomic(); // Order store to x before load from y.
+	r1 = READ_ONCE(y);
+
+The smp_mb__after_atomic() primitive emits code only on CPUs whose
+atomic_inc() implementations do not guarantee full ordering, thus
+incurring no unnecessary overhead on x86.  There are a number of
+variations on the smp_mb__*() theme:
+
+o	smp_mb__before_atomic(), which provides full ordering prior
+	to an unordered RMW atomic operation.
+
+o	smp_mb__after_atomic(), which, as shown above, provides full
+	ordering subsequent to an unordered RMW atomic operation.
+
+o	smp_mb__after_spinlock(), which provides full ordering subsequent
+	to a successful spinlock acquisition.  Note that spin_lock() is
+	always successful but spin_trylock() might not be.
+
+o	smp_mb__after_srcu_read_unlock(), which provides full ordering
+	subsequent to an srcu_read_unlock().
+
+It is bad practice to place code between the smp__*() primitive and the
+operation whose ordering that it is augmenting.  The reason is that the
+ordering of this intervening code will differ from one CPU architecture
+to another.
+
+
+Write Memory Barrier
+--------------------
+
+The Linux kernel's write memory barrier is smp_wmb().  If a CPU executes
+the following code:
+
+	WRITE_ONCE(x, 1);
+	smp_wmb();
+	WRITE_ONCE(y, 1);
+
+Then any given CPU will see the write to "x" has having happened before
+the write to "y".  However, you are usually better off using a release
+store, as described in the "Release Operations" section below.
+
+Note that smp_wmb() might fail to provide ordering for unmarked C-language
+stores because profile-driven optimization could determine that the
+value being overwritten is almost always equal to the new value.  Such a
+compiler might then reasonably decide to transform "x = 1" and "y = 1"
+as follows:
+
+	if (x != 1)
+		x = 1;
+	smp_wmb(); // BUG: does not order the reads!!!
+	if (y != 1)
+		y = 1;
+
+Therefore, if you need to use smp_wmb() with unmarked C-language writes,
+you will need to make sure that none of the compilers used to build
+the Linux kernel carry out this sort of transformation, both now and in
+the future.
+
+
+Read Memory Barrier
+-------------------
+
+The Linux kernel's read memory barrier is smp_rmb().  If a CPU executes
+the following code:
+
+	r0 = READ_ONCE(y);
+	smp_rmb();
+	r1 = READ_ONCE(x);
+
+Then any given CPU will see the read from "y" as having preceded the read from
+"x".  However, you are usually better off using an acquire load, as described
+in the "Acquire Operations" section below.
+
+Compiler Barrier
+----------------
+
+The Linux kernel's compiler barrier is barrier().  This primitive
+prohibits compiler code-motion optimizations that might move memory
+references across the point in the code containing the barrier(), but
+does not constrain hardware memory ordering.  For example, this can be
+used to prevent to compiler from moving code across an infinite loop:
+
+	WRITE_ONCE(x, 1);
+	while (dontstop)
+		barrier();
+	r1 = READ_ONCE(y);
+
+Without the barrier(), the compiler would be within its rights to move the
+WRITE_ONCE() to follow the loop.  This code motion could be problematic
+in the case where an interrupt handler terminates the loop.  Another way
+to handle this is to use READ_ONCE() for the load of "dontstop".
+
+Note that the barriers discussed previously use barrier() or its low-level
+equivalent in their implementations.
+
+
+Ordered Memory Accesses
+=======================
+
+The Linux kernel provides a wide variety of ordered memory accesses:
+
+a.	Release operations.
+
+b.	Acquire operations.
+
+c.	RCU read-side ordering.
+
+d.	Control dependencies.
+
+Each of the above categories has its own section below.
+
+
+Release Operations
+------------------
+
+Release operations include smp_store_release(), atomic_set_release(),
+rcu_assign_pointer(), and value-returning RMW operations whose names
+end in _release.  These operations order their own store against all
+of the CPU's prior memory accesses.  Release operations often provide
+improved readability and performance compared to explicit barriers.
+For example, use of smp_store_release() saves a line compared to the
+smp_wmb() example above:
+
+	WRITE_ONCE(x, 1);
+	smp_store_release(&y, 1);
+
+More important, smp_store_release() makes it easier to connect up the
+different pieces of the concurrent algorithm.  The variable stored to
+by the smp_store_release(), in this case "y", will normally be used in
+an acquire operation in other parts of the concurrent algorithm.
+
+To see the performance advantages, suppose that the above example read
+from "x" instead of writing to it.  Then an smp_wmb() could not guarantee
+ordering, and an smp_mb() would be needed instead:
+
+	r1 = READ_ONCE(x);
+	smp_mb();
+	WRITE_ONCE(y, 1);
+
+But smp_mb() often incurs much higher overhead than does
+smp_store_release(), which still provides the needed ordering of "x"
+against "y".  On x86, the version using smp_store_release() might compile
+to a simple load instruction followed by a simple store instruction.
+In contrast, the smp_mb() compiles to an expensive instruction that
+provides the needed ordering.
+
+There is a wide variety of release operations:
+
+o	Store operations, including not only the aforementioned
+	smp_store_release(), but also atomic_set_release(), and
+	atomic_long_set_release().
+
+o	RCU's rcu_assign_pointer() operation.  This is the same as
+	smp_store_release() except that: (1) It takes the pointer to
+	be assigned to instead of a pointer to that pointer, (2) It
+	is intended to be used in conjunction with rcu_dereference()
+	and similar rather than smp_load_acquire(), and (3) It checks
+	for an RCU-protected pointer in "sparse" runs.
+
+o	Value-returning RMW operations whose names end in _release,
+	such as atomic_fetch_add_release() and cmpxchg_release().
+	Note that release ordering is guaranteed only against the
+	memory-store portion of the RMW operation, and not against the
+	memory-load portion.  Note also that conditional operations such
+	as cmpxchg_release() are only guaranteed to provide ordering
+	when they succeed.
+
+As mentioned earlier, release operations are often paired with acquire
+operations, which are the subject of the next section.
+
+
+Acquire Operations
+------------------
+
+Acquire operations include smp_load_acquire(), atomic_read_acquire(),
+and value-returning RMW operations whose names end in _acquire.   These
+operations order their own load against all of the CPU's subsequent
+memory accesses.  Acquire operations often provide improved performance
+and readability compared to explicit barriers.  For example, use of
+smp_load_acquire() saves a line compared to the smp_rmb() example above:
+
+	r0 = smp_load_acquire(&y);
+	r1 = READ_ONCE(x);
+
+As with smp_store_release(), this also makes it easier to connect
+the different pieces of the concurrent algorithm by looking for the
+smp_store_release() that stores to "y".  In addition, smp_load_acquire()
+improves upon smp_rmb() by ordering against subsequent stores as well
+as against subsequent loads.
+
+There are a couple of categories of acquire operations:
+
+o	Load operations, including not only the aforementioned
+	smp_load_acquire(), but also atomic_read_acquire(), and
+	atomic64_read_acquire().
+
+o	Value-returning RMW operations whose names end in _acquire,
+	such as atomic_xchg_acquire() and atomic_cmpxchg_acquire().
+	Note that acquire ordering is guaranteed only against the
+	memory-load portion of the RMW operation, and not against the
+	memory-store portion.  Note also that conditional operations
+	such as atomic_cmpxchg_acquire() are only guaranteed to provide
+	ordering when they succeed.
+
+Symmetry being what it is, acquire operations are often paired with the
+release operations covered earlier.  For example, consider the following
+example, where task0() and task1() execute concurrently:
+
+	void task0(void)
+	{
+		WRITE_ONCE(x, 1);
+		smp_store_release(&y, 1);
+	}
+
+	void task1(void)
+	{
+		r0 = smp_load_acquire(&y);
+		r1 = READ_ONCE(x);
+	}
+
+If "x" and "y" are both initially zero, then either r0's final value
+will be zero or r1's final value will be one, thus providing the required
+ordering.
+
+
+RCU Read-Side Ordering
+----------------------
+
+This category includes read-side markers such as rcu_read_lock()
+and rcu_read_unlock() as well as pointer-traversal primitives such as
+rcu_dereference() and srcu_dereference().
+
+Compared to locking primitives and RMW atomic operations, markers
+for RCU read-side critical sections incur very low overhead because
+they interact only with the corresponding grace-period primitives.
+For example, the rcu_read_lock() and rcu_read_unlock() markers interact
+with synchronize_rcu(), synchronize_rcu_expedited(), and call_rcu().
+The way this works is that if a given call to synchronize_rcu() cannot
+prove that it started before a given call to rcu_read_lock(), then
+that synchronize_rcu() must block until the matching rcu_read_unlock()
+is reached.  For more information, please see the synchronize_rcu()
+docbook header comment and the material in Documentation/RCU.
+
+RCU's pointer-traversal primitives, including rcu_dereference() and
+srcu_dereference(), order their load (which must be a pointer) against any
+of the CPU's subsequent memory accesses whose address has been calculated
+from the value loaded.  There is said to be an *address dependency*
+from the value returned by the rcu_dereference() or srcu_dereference()
+to that subsequent memory access.
+
+A call to rcu_dereference() for a given RCU-protected pointer is
+usually paired with a call to a call to rcu_assign_pointer() for that
+same pointer in much the same way that a call to smp_load_acquire() is
+paired with a call to smp_store_release().  Calls to rcu_dereference()
+and rcu_assign_pointer are often buried in other APIs, for example,
+the RCU list API members defined in include/linux/rculist.h.  For more
+information, please see the docbook headers in that file, the most
+recent LWN article on the RCU API (https://lwn.net/Articles/777036/),
+and of course the material in Documentation/RCU.
+
+If the pointer value is manipulated between the rcu_dereference()
+that returned it and a later dereference(), please read
+Documentation/RCU/rcu_dereference.rst.  It can also be quite helpful to
+review uses in the Linux kernel.
+
+
+Control Dependencies
+--------------------
+
+A control dependency extends from a marked load (READ_ONCE() or stronger)
+through an "if" condition to a marked store (WRITE_ONCE() or stronger)
+that is executed only by one of the legs of that "if" statement.
+Control dependencies are so named because they are mediated by
+control-flow instructions such as comparisons and conditional branches.
+
+In short, you can use a control dependency to enforce ordering between
+an READ_ONCE() and a WRITE_ONCE() when there is an "if" condition
+between them.  The canonical example is as follows:
+
+	q = READ_ONCE(a);
+	if (q)
+		WRITE_ONCE(b, 1);
+
+In this case, all CPUs would see the read from "a" as happening before
+the write to "b".
+
+However, control dependencies are easily destroyed by compiler
+optimizations, so any use of control dependencies must take into account
+all of the compilers used to build the Linux kernel.  Please see the
+"control-dependencies.txt" file for more information.
+
+
+Unordered Accesses
+==================
+
+Each of these two categories of unordered accesses has a section below:
+
+a.	Unordered marked operations.
+
+b.	Unmarked C-language accesses.
+
+
+Unordered Marked Operations
+---------------------------
+
+Unordered operations to different variables are just that, unordered.
+However, if a group of CPUs apply these operations to a single variable,
+all the CPUs will agree on the operation order.  Of course, the ordering
+of unordered marked accesses can also be constrained using the mechanisms
+described earlier in this document.
+
+These operations come in three categories:
+
+o	Marked writes, such as WRITE_ONCE() and atomic_set().  These
+	primitives required the compiler to emit the corresponding store
+	instructions in the expected execution order, thus suppressing
+	a number of destructive optimizations.	However, they provide no
+	hardware ordering guarantees, and in fact many CPUs will happily
+	reorder marked writes with each other or with other unordered
+	operations, unless these operations are to the same variable.
+
+o	Marked reads, such as READ_ONCE() and atomic_read().  These
+	primitives required the compiler to emit the corresponding load
+	instructions in the expected execution order, thus suppressing
+	a number of destructive optimizations.	However, they provide no
+	hardware ordering guarantees, and in fact many CPUs will happily
+	reorder marked reads with each other or with other unordered
+	operations, unless these operations are to the same variable.
+
+o	Unordered RMW atomic operations.  These are non-value-returning
+	RMW atomic operations whose names do not end in _acquire or
+	_release, and also value-returning RMW operations whose names
+	end in _relaxed.  Examples include atomic_add(), atomic_or(),
+	and atomic64_fetch_xor_relaxed().  These operations do carry
+	out the specified RMW operation atomically, for example, five
+	concurrent atomic_inc() operations applied to a given variable
+	will reliably increase the value of that variable by five.
+	However, many CPUs will happily reorder these operations with
+	each other or with other unordered operations.
+
+	This category of operations can be efficiently ordered using
+	smp_mb__before_atomic() and smp_mb__after_atomic(), as was
+	discussed in the "RMW Ordering Augmentation Barriers" section.
+
+In short, these operations can be freely reordered unless they are all
+operating on a single variable or unless they are constrained by one of
+the operations called out earlier in this document.
+
+
+Unmarked C-Language Accesses
+----------------------------
+
+Unmarked C-language accesses are normal variable accesses to normal
+variables, that is, to variables that are not "volatile" and are not
+C11 atomic variables.  These operations provide no ordering guarantees,
+and further do not guarantee "atomic" access.  For example, the compiler
+might (and sometimes does) split a plain C-language store into multiple
+smaller stores.  A load from that same variable running on some other
+CPU while such a store is executing might see a value that is a mashup
+of the old value and the new value.
+
+Unmarked C-language accesses are unordered, and are also subject to
+any number of compiler optimizations, many of which can break your
+concurrent code.  It is possible to used unmarked C-language accesses for
+shared variables that are subject to concurrent access, but great care
+is required on an ongoing basis.  The compiler-constraining barrier()
+primitive can be helpful, as can the various ordering primitives discussed
+in this document.  It nevertheless bears repeating that use of unmarked
+C-language accesses requires careful attention to not just your code,
+but to all the compilers that might be used to build it.  Such compilers
+might replace a series of loads with a single load, and might replace
+a series of stores with a single store.  Some compilers will even split
+a single store into multiple smaller stores.
+
+But there are some ways of using unmarked C-language accesses for shared
+variables without such worries:
+
+o	Guard all accesses to a given variable by a particular lock,
+	so that there are never concurrent conflicting accesses to
+	that variable.	(There are "conflicting accesses" when
+	(1) at least one of the concurrent accesses to a variable is an
+	unmarked C-language access and (2) when at least one of those
+	accesses is a write, whether marked or not.)
+
+o	As above, but using other synchronization primitives such
+	as reader-writer locks or sequence locks.
+
+o	Use locking or other means to ensure that all concurrent accesses
+	to a given variable are reads.
+
+o	Restrict use of a given variable to statistics or heuristics
+	where the occasional bogus value can be tolerated.
+
+o	Declare the accessed variables as C11 atomics.
+	https://lwn.net/Articles/691128/
+
+o	Declare the accessed variables as "volatile".
+
+If you need to live more dangerously, please do take the time to
+understand the compilers.  One place to start is these two LWN
+articles:
+
+Who's afraid of a big bad optimizing compiler?
+	https://lwn.net/Articles/793253
+Calibrating your fear of big bad optimizing compilers
+	https://lwn.net/Articles/799218
+
+Used properly, unmarked C-language accesses can reduce overhead on
+fastpaths.  However, the price is great care and continual attention
+to your compiler as new versions come out and as new optimizations
+are enabled.
diff --git a/tools/memory-model/README b/tools/memory-model/README
index c8144d4aafa0..39d08d1f0443 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -161,26 +161,8 @@ running LKMM litmus tests.
 DESCRIPTION OF FILES
 ====================
 
-Documentation/cheatsheet.txt
-	Quick-reference guide to the Linux-kernel memory model.
-
-Documentation/explanation.txt
-	Describes the memory model in detail.
-
-Documentation/litmus-tests.txt
-	Describes the format, features, capabilities, and limitations
-	of the litmus tests that LKMM can evaluate.
-
-Documentation/recipes.txt
-	Lists common memory-ordering patterns.
-
-Documentation/references.txt
-	Provides background reading.
-
-Documentation/simple.txt
-	Starting point for someone new to Linux-kernel concurrency.
-	And also for those needing a reminder of the simpler approaches
-	to concurrency!
+Documentation/README
+	Guide to the other documents in the Documentation/ directory.
 
 linux-kernel.bell
 	Categorizes the relevant instructions, including memory
diff --git a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
index 967f9f2a6226..772544f03fb5 100644
--- a/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRR+poonceonce+Once.litmus
@@ -7,7 +7,9 @@ C CoRR+poonceonce+Once
  * reads from the same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
index 4635739f3974..5faae98f7ffb 100644
--- a/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoRW+poonceonce+Once.litmus
@@ -7,7 +7,9 @@ C CoRW+poonceonce+Once
  * a given variable and a later write to that same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
index bb068c92d8da..77c9cc9f8dc6 100644
--- a/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/CoWR+poonceonce+Once.litmus
@@ -7,7 +7,9 @@ C CoWR+poonceonce+Once
  * given variable and a later read from that same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
index 0d9f0a958799..85ef746f511a 100644
--- a/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
+++ b/tools/memory-model/litmus-tests/CoWW+poonceonce.litmus
@@ -7,7 +7,9 @@ C CoWW+poonceonce
  * writes to the same variable are ordered.
  *)
 
-{}
+{
+	int x;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
index e729d2776e89..87aa900125ab 100644
--- a/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+fencembonceonces+OnceOnce.litmus
@@ -10,7 +10,10 @@ C IRIW+fencembonceonces+OnceOnce
  * process?  This litmus test exercises LKMM's "propagation" rule.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
index 4b54dd6a6cd9..f84022dca555 100644
--- a/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
+++ b/tools/memory-model/litmus-tests/IRIW+poonceonces+OnceOnce.litmus
@@ -10,7 +10,10 @@ C IRIW+poonceonces+OnceOnce
  * different process?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
index 094d58df7789..398f624daa77 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncelock+pooncelock+pombonce.litmus
@@ -7,7 +7,12 @@ C ISA2+pooncelock+pooncelock+pombonce
  * (in P0() and P1()) is visible to external process P2().
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
index b321aa6f4ea5..212a432ba16b 100644
--- a/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+poonceonces.litmus
@@ -9,7 +9,11 @@ C ISA2+poonceonces
  * of the smp_load_acquire() invocations are replaced by READ_ONCE()?
  *)
 
-{}
+{
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
index 025b0462ec9b..7afd85672ccd 100644
--- a/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/ISA2+pooncerelease+poacquirerelease+poacquireonce.litmus
@@ -11,7 +11,11 @@ C ISA2+pooncerelease+poacquirerelease+poacquireonce
  * (AKA non-rf) link, so release-acquire is all that is needed.
  *)
 
-{}
+{
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
index 4727f5aaf03b..c8a93c7ee556 100644
--- a/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
+++ b/tools/memory-model/litmus-tests/LB+fencembonceonce+ctrlonceonce.litmus
@@ -11,7 +11,10 @@ C LB+fencembonceonce+ctrlonceonce
  * another control dependency and order would still be maintained.)
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
index 07b9904b0e49..2fa029568fa1 100644
--- a/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
+++ b/tools/memory-model/litmus-tests/LB+poacquireonce+pooncerelease.litmus
@@ -8,7 +8,10 @@ C LB+poacquireonce+pooncerelease
  * to the other?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/LB+poonceonces.litmus b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
index 74c49cb3c37b..2107306e8625 100644
--- a/tools/memory-model/litmus-tests/LB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/LB+poonceonces.litmus
@@ -7,7 +7,10 @@ C LB+poonceonces
  * be prevented even with no explicit ordering?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
index a273da9faa6d..c5c168d92973 100644
--- a/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+fencewmbonceonce+fencermbonceonce.litmus
@@ -8,23 +8,26 @@ C MP+fencewmbonceonce+fencermbonceonce
  * is usually better to use smp_store_release() and smp_load_acquire().
  *)
 
-{}
+{
+	int buf;
+	int flag;
+}
 
-P0(int *x, int *y)
+P0(int *buf, int *flag) // Producer
 {
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	smp_wmb();
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	smp_rmb();
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
index 97731b4bbdd8..20ff62649f1e 100644
--- a/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+onceassign+derefonce.litmus
@@ -10,25 +10,26 @@ C MP+onceassign+derefonce
  *)
 
 {
-y=z;
-z=0;
+	int *p=y;
+	int x;
+	int y=0;
 }
 
-P0(int *x, int **y)
+P0(int *x, int **p) // Producer
 {
 	WRITE_ONCE(*x, 1);
-	rcu_assign_pointer(*y, x);
+	rcu_assign_pointer(*p, x);
 }
 
-P1(int *x, int **y)
+P1(int *x, int **p) // Consumer
 {
 	int *r0;
 	int r1;
 
 	rcu_read_lock();
-	r0 = rcu_dereference(*y);
+	r0 = rcu_dereference(*p);
 	r1 = READ_ONCE(*r0);
 	rcu_read_unlock();
 }
 
-exists (1:r0=x /\ 1:r1=0)
+exists (1:r0=x /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
index 50f4d62bbf0e..153917ad5dc9 100644
--- a/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockmbonce+poacquiresilsil.litmus
@@ -11,9 +11,11 @@ C MP+polockmbonce+poacquiresilsil
  *)
 
 {
+	spinlock_t lo;
+	int x;
 }
 
-P0(spinlock_t *lo, int *x)
+P0(spinlock_t *lo, int *x) // Producer
 {
 	spin_lock(lo);
 	smp_mb__after_spinlock();
@@ -21,7 +23,7 @@ P0(spinlock_t *lo, int *x)
 	spin_unlock(lo);
 }
 
-P1(spinlock_t *lo, int *x)
+P1(spinlock_t *lo, int *x) // Consumer
 {
 	int r1;
 	int r2;
@@ -32,4 +34,4 @@ P1(spinlock_t *lo, int *x)
 	r3 = spin_is_locked(lo);
 }
 
-exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
index abf81e7a0895..aad64397bb8c 100644
--- a/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
+++ b/tools/memory-model/litmus-tests/MP+polockonce+poacquiresilsil.litmus
@@ -11,16 +11,18 @@ C MP+polockonce+poacquiresilsil
  *)
 
 {
+	spinlock_t lo;
+	int x;
 }
 
-P0(spinlock_t *lo, int *x)
+P0(spinlock_t *lo, int *x) // Producer
 {
 	spin_lock(lo);
 	WRITE_ONCE(*x, 1);
 	spin_unlock(lo);
 }
 
-P1(spinlock_t *lo, int *x)
+P1(spinlock_t *lo, int *x) // Consumer
 {
 	int r1;
 	int r2;
@@ -31,4 +33,4 @@ P1(spinlock_t *lo, int *x)
 	r3 = spin_is_locked(lo);
 }
 
-exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1)
+exists (1:r1=1 /\ 1:r2=0 /\ 1:r3=1) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+polocks.litmus b/tools/memory-model/litmus-tests/MP+polocks.litmus
index 712a4fcdf6ce..21cbca6f3be4 100644
--- a/tools/memory-model/litmus-tests/MP+polocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+polocks.litmus
@@ -11,25 +11,29 @@ C MP+polocks
  * to see all prior accesses by those other CPUs.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int buf;
+	int flag;
+}
 
-P0(int *x, int *y, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	spin_lock(mylock);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 	spin_unlock(mylock);
 }
 
-P1(int *x, int *y, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
 	int r0;
 	int r1;
 
 	spin_lock(mylock);
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	spin_unlock(mylock);
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+poonceonces.litmus b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
index 172f0145301c..9f9769d647c7 100644
--- a/tools/memory-model/litmus-tests/MP+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/MP+poonceonces.litmus
@@ -7,21 +7,24 @@ C MP+poonceonces
  * no ordering at all?
  *)
 
-{}
+{
+	int buf;
+	int flag;
+}
 
-P0(int *x, int *y)
+P0(int *buf, int *flag) // Producer
 {
-	WRITE_ONCE(*x, 1);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*buf, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
-	r1 = READ_ONCE(*x);
+	r0 = READ_ONCE(*flag);
+	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
index d52c68429722..cbe28e733443 100644
--- a/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/MP+pooncerelease+poacquireonce.litmus
@@ -8,21 +8,24 @@ C MP+pooncerelease+poacquireonce
  * pattern.
  *)
 
-{}
+{
+	int buf;
+	int flag;
+}
 
-P0(int *x, int *y)
+P0(int *buf, int *flag) // Producer
 {
-	WRITE_ONCE(*x, 1);
-	smp_store_release(y, 1);
+	WRITE_ONCE(*buf, 1);
+	smp_store_release(flag, 1);
 }
 
-P1(int *x, int *y)
+P1(int *buf, int *flag) // Consumer
 {
 	int r0;
 	int r1;
 
-	r0 = smp_load_acquire(y);
-	r1 = READ_ONCE(*x);
+	r0 = smp_load_acquire(flag);
+	r1 = READ_ONCE(*buf);
 }
 
-exists (1:r0=1 /\ 1:r1=0)
+exists (1:r0=1 /\ 1:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/MP+porevlocks.litmus b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
index 72c9276b363e..012041bd4feb 100644
--- a/tools/memory-model/litmus-tests/MP+porevlocks.litmus
+++ b/tools/memory-model/litmus-tests/MP+porevlocks.litmus
@@ -11,25 +11,29 @@ C MP+porevlocks
  * see all prior accesses by those other CPUs.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int buf;
+	int flag;
+}
 
-P0(int *x, int *y, spinlock_t *mylock)
+P0(int *buf, int *flag, spinlock_t *mylock) // Consumer
 {
 	int r0;
 	int r1;
 
-	r0 = READ_ONCE(*y);
+	r0 = READ_ONCE(*flag);
 	spin_lock(mylock);
-	r1 = READ_ONCE(*x);
+	r1 = READ_ONCE(*buf);
 	spin_unlock(mylock);
 }
 
-P1(int *x, int *y, spinlock_t *mylock)
+P1(int *buf, int *flag, spinlock_t *mylock) // Producer
 {
 	spin_lock(mylock);
-	WRITE_ONCE(*x, 1);
+	WRITE_ONCE(*buf, 1);
 	spin_unlock(mylock);
-	WRITE_ONCE(*y, 1);
+	WRITE_ONCE(*flag, 1);
 }
 
-exists (0:r0=1 /\ 0:r1=0)
+exists (0:r0=1 /\ 0:r1=0) (* Bad outcome. *)
diff --git a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
index 222a0b850b4a..af9463b39b4a 100644
--- a/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+fencembonceonces.litmus
@@ -9,7 +9,10 @@ C R+fencembonceonces
  * cause the resulting test to be allowed.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/R+poonceonces.litmus b/tools/memory-model/litmus-tests/R+poonceonces.litmus
index 5386f128a131..bcd5574e304a 100644
--- a/tools/memory-model/litmus-tests/R+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/R+poonceonces.litmus
@@ -8,7 +8,10 @@ C R+poonceonces
  * store propagation delays.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
index 18479823cd6c..c36341d1aed6 100644
--- a/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
+++ b/tools/memory-model/litmus-tests/S+fencewmbonceonce+poacquireonce.litmus
@@ -7,7 +7,10 @@ C S+fencewmbonceonce+poacquireonce
  * store against a subsequent store?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/S+poonceonces.litmus b/tools/memory-model/litmus-tests/S+poonceonces.litmus
index 8c9c2f81a580..7775c23143a0 100644
--- a/tools/memory-model/litmus-tests/S+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/S+poonceonces.litmus
@@ -9,7 +9,10 @@ C S+poonceonces
  * READ_ONCE(), is ordering preserved?
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
index ed5fff18d223..833cdfeb7c09 100644
--- a/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+fencembonceonces.litmus
@@ -9,7 +9,10 @@ C SB+fencembonceonces
  * suffice, but not much else.)
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+poonceonces.litmus b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
index 10d550730b25..c92211ecbfdf 100644
--- a/tools/memory-model/litmus-tests/SB+poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+poonceonces.litmus
@@ -8,7 +8,10 @@ C SB+poonceonces
  * variable that the preceding process reads.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
index 04a16603660b..84344b455eb7 100644
--- a/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
+++ b/tools/memory-model/litmus-tests/SB+rfionceonce-poonceonces.litmus
@@ -6,7 +6,10 @@ C SB+rfionceonce-poonceonces
  * This litmus test demonstrates that LKMM is not fully multicopy atomic.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
index 6a2bc12a1af1..431494708611 100644
--- a/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+poonceonces+Once.litmus
@@ -8,7 +8,10 @@ C WRC+poonceonces+Once
  * test has no ordering at all.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
index e9947250d7de..554999c64db5 100644
--- a/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
+++ b/tools/memory-model/litmus-tests/WRC+pooncerelease+fencermbonceonce+Once.litmus
@@ -10,7 +10,10 @@ C WRC+pooncerelease+fencermbonceonce+Once
  * is A-cumulative in LKMM.
  *)
 
-{}
+{
+	int x;
+	int y;
+}
 
 P0(int *x)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
index 415248fb6699..265a95ffef13 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus
@@ -9,7 +9,12 @@ C Z6.0+pooncelock+poonceLock+pombonce
  * by CPUs not holding that lock.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
index 10a2aa04cd07..0c9aea8e80df 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus
@@ -8,7 +8,12 @@ C Z6.0+pooncelock+pooncelock+pombonce
  * seen as ordered by a third process not holding that lock.
  *)
 
-{}
+{
+	spinlock_t mylock;
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y, spinlock_t *mylock)
 {
diff --git a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
index 88e70b87a683..661f9aaa5791 100644
--- a/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
+++ b/tools/memory-model/litmus-tests/Z6.0+pooncerelease+poacquirerelease+fencembonceonce.litmus
@@ -14,7 +14,11 @@ C Z6.0+pooncerelease+poacquirerelease+fencembonceonce
  * involving locking.)
  *)
 
-{}
+{
+	int x;
+	int y;
+	int z;
+}
 
 P0(int *x, int *y)
 {
diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
index 0e4c0b2eb7f0..80ae7f08b363 100755
--- a/tools/testing/selftests/rcutorture/bin/console-badness.sh
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -13,4 +13,5 @@
 egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
 grep -v 'ODEBUG: ' |
 grep -v 'This means that this is a DEBUG kernel and it is' |
-grep -v 'Warning: unable to open an initial console'
+grep -v 'Warning: unable to open an initial console' |
+grep -v 'NOHZ tick-stop error: Non-RCU local softirq work is pending, handler'
diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 51f3464b96d3..82663495fb38 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -169,6 +169,7 @@ identify_qemu () {
 # Output arguments for the qemu "-append" string based on CPU type
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
+	echo debug_boot_weak_hash
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
index 6e65c134e5f1..370406bbfeed 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-check-branches.sh
@@ -52,8 +52,7 @@ echo Results directory: $resdir/$ds
 KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
 PATH=${KVM}/bin:$PATH; export PATH
 . functions.sh
-cpus="`identify_qemu_vcpus`"
-echo Using up to $cpus CPUs.
+echo Using all `identify_qemu_vcpus` CPUs.
 
 # Each pass through this loop does one command-line argument.
 for gitbr in $@
@@ -74,7 +73,7 @@ do
 		# Test the specified commit.
 		git checkout $i > $resdir/$ds/$idir/git-checkout.out 2>&1
 		echo git checkout return code: $? "(Commit $ntry: $i)"
-		kvm.sh --cpus $cpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
+		kvm.sh --allcpus --duration 3 --trust-make > $resdir/$ds/$idir/kvm.sh.out 2>&1
 		ret=$?
 		echo kvm.sh return code $ret for commit $i from branch $gitbr
 
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
index aa745152a525..b582113178ac 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-recheck-rcuscale.sh
@@ -32,7 +32,7 @@ sed -e 's/^\[[^]]*]//' < $i/console.log |
 awk '
 /-scale: .* gps: .* batches:/ {
 	ngps = $9;
-	nbatches = $11;
+	nbatches = 1;
 }
 
 /-scale: .*writer-duration/ {
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 6dc2b49b85ea..3cd03d01857c 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -206,7 +206,10 @@ do
 	kruntime=`gawk 'BEGIN { print systime() - '"$kstarttime"' }' < /dev/null`
 	if test -z "$qemu_pid" || kill -0 "$qemu_pid" > /dev/null 2>&1
 	then
-		if test $kruntime -ge $seconds -o -f "$TORTURE_STOPFILE"
+		if test -n "$TORTURE_KCONFIG_GDB_ARG"
+		then
+			:
+		elif test $kruntime -ge $seconds || test -f "$TORTURE_STOPFILE"
 		then
 			break;
 		fi
@@ -223,6 +226,20 @@ do
 				echo "ps -fp $killpid" >> $resdir/Warnings 2>&1
 				ps -fp $killpid >> $resdir/Warnings 2>&1
 			fi
+			# Reduce probability of PID reuse by allowing a one-minute buffer
+			if test $((kruntime + 60)) -lt $seconds && test -s "$resdir/../jitter_pids"
+			then
+				awk < "$resdir/../jitter_pids" '
+				NF > 0 {
+					pidlist = pidlist " " $1;
+					n++;
+				}
+				END {
+					if (n > 0) {
+						print "kill " pidlist;
+					}
+				}' | sh
+			fi
 		else
 			echo ' ---' `date`: "Kernel done"
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6eb1d3f6524d..45d07b7b69f5 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -58,7 +58,7 @@ usage () {
 	echo "       --datestamp string"
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
-	echo "       --duration minutes"
+	echo "       --duration minutes | <seconds>s | <hours>h | <days>d"
 	echo "       --gdb"
 	echo "       --help"
 	echo "       --interactive"
@@ -93,7 +93,7 @@ do
 		TORTURE_BOOT_IMAGE="$2"
 		shift
 		;;
-	--buildonly)
+	--buildonly|--build-only)
 		TORTURE_BUILDONLY=1
 		;;
 	--configs|--config)
@@ -128,8 +128,20 @@ do
 		shift
 		;;
 	--duration)
-		checkarg --duration "(minutes)" $# "$2" '^[0-9]*$' '^error'
-		dur=$(($2*60))
+		checkarg --duration "(minutes)" $# "$2" '^[0-9][0-9]*\(s\|m\|h\|d\|\)$' '^error'
+		mult=60
+		if echo "$2" | grep -q 's$'
+		then
+			mult=1
+		elif echo "$2" | grep -q 'h$'
+		then
+			mult=3600
+		elif echo "$2" | grep -q 'd$'
+		then
+			mult=86400
+		fi
+		ts=`echo $2 | sed -e 's/[smhd]$//'`
+		dur=$(($ts*mult))
 		shift
 		;;
 	--gdb)
@@ -148,7 +160,7 @@ do
 		jitter="$2"
 		shift
 		;;
-	--kconfig)
+	--kconfig|--kconfigs)
 		checkarg --kconfig "(Kconfig options)" $# "$2" '^CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\( CONFIG_[A-Z0-9_]\+=\([ynm]\|[0-9]\+\)\)*$' '^error$'
 		TORTURE_KCONFIG_ARG="$2"
 		shift
@@ -159,7 +171,7 @@ do
 	--kcsan)
 		TORTURE_KCONFIG_KCSAN_ARG="CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y"; export TORTURE_KCONFIG_KCSAN_ARG
 		;;
-	--kmake-arg)
+	--kmake-arg|--kmake-args)
 		checkarg --kmake-arg "(kernel make arguments)" $# "$2" '.*' '^error$'
 		TORTURE_KMAKE_ARG="$2"
 		shift
@@ -459,8 +471,11 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	for (j = 0; j < njitter; j++)
+	print "\techo > " rd "jitter_pids"
+	for (j = 0; j < njitter; j++) {
 		print "\tjitter.sh " j " " dur " " ja[2] " " ja[3] "&"
+		print "\techo $! >> " rd "jitter_pids"
+	}
 	print "\twait"
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index e03338091a06..263b1be50008 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -133,7 +133,7 @@ then
 	then
 		summary="$summary  Warnings: $n_warn"
 	fi
-	n_bugs=`egrep -c 'BUG|Oops:' $file`
+	n_bugs=`egrep -c '\bBUG|Oops:' $file`
 	if test "$n_bugs" -ne 0
 	then
 		summary="$summary  Bugs: $n_bugs"
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
index 6c78022c8cd8..d6557c38dfe4 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-t
@@ -4,7 +4,8 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_DEBUG_ATOMIC_SLEEP=y
 #CHECK#CONFIG_PREEMPT_COUNT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
index c15ada821e45..6bc24e99862f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCU-u
@@ -4,7 +4,6 @@ CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
 #CHECK#CONFIG_TINY_SRCU=y
 CONFIG_RCU_TRACE=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_LOCK_ALLOC=n
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
 CONFIG_PREEMPT_COUNT=n
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
index 12e7661b86f5..34c8ff5a12f2 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -4,8 +4,8 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=y
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=n
-CONFIG_DEBUG_LOCK_ALLOC=y
-CONFIG_PROVE_LOCKING=y
-#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+#CHECK#CONFIG_PROVE_RCU=n
 CONFIG_TASKS_TRACE_RCU_READ_MB=y
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
index b69ed6673c41..77541eeb4e9f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE02
@@ -4,8 +4,8 @@ CONFIG_HOTPLUG_CPU=y
 CONFIG_PREEMPT_NONE=n
 CONFIG_PREEMPT_VOLUNTARY=n
 CONFIG_PREEMPT=y
-CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_PROVE_LOCKING=n
-#CHECK#CONFIG_PROVE_RCU=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
 CONFIG_TASKS_TRACE_RCU_READ_MB=n
 CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 87caa0e932c7..90942bb5bebc 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -1,2 +1,5 @@
 CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_TASKS_RCU_GENERIC=y
+CONFIG_TASKS_RCU=y
+CONFIG_TASKS_TRACE_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
new file mode 100644
index 000000000000..e6baa2fbaeb3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -0,0 +1,15 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
new file mode 100644
index 000000000000..af0aff1457a4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
@@ -0,0 +1 @@
+rcuscale.scale_type=tasks-tracing


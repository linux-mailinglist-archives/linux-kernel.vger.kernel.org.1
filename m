Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B4F2C04B8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729104AbgKWLiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:20 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:53423 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728830AbgKWLiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:16 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.53 with ESMTP; 23 Nov 2020 20:38:06 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.127 with ESMTP; 23 Nov 2020 20:38:06 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     torvalds@linux-foundation.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org,
        alexander.levin@microsoft.com, daniel.vetter@ffwll.ch,
        chris@chris-wilson.co.uk, duyuyang@gmail.com,
        johannes.berg@intel.com, tj@kernel.org, tytso@mit.edu,
        willy@infradead.org, david@fromorbit.com, amir73il@gmail.com,
        bfields@fieldses.org, gregkh@linuxfoundation.org,
        kernel-team@lge.com
Subject: [RFC 1/6] dept: Implement Dept(Dependency Tracker)
Date:   Mon, 23 Nov 2020 20:36:27 +0900
Message-Id: <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20201123110527.GB9464@X58A-UD3R>
References: <20201123110527.GB9464@X58A-UD3R>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CURRENT STATUS
--------------
Lockdep tracks acquisition order of locks in order to detect deadlock,
and IRQ and IRQ enable/disable state as well to take accident
acquisitions into account.

Lockdep should be turned off once it detects and reports a deadlock
since the data structure and algorithm are not reusable after detection
because of the complex design.

PROBLEM
-------
*Waits* and their *events* that never reach eventually cause deadlock.
However, Lockdep is only interested in lock acquisition order, forcing
to emulate lock acqusition even for just waits and events that have
nothing to do with real lock.

Even worse, no one likes Lockdep's false positive detection because that
prevents further one that might be more valuable. That's why all the
kernel developers are sensitive to Lockdep's false positive.

Besides those, by tracking acquisition order, it cannot correctly deal
with read lock and cross-event e.g. wait_for_completion()/complete() for
deadlock detection. Lockdep is no longer a good tool for that purpose.

SOLUTION
--------
Again, *waits* and their *events* that never reach eventually cause
deadlock. The new solution, Dept(DEPendency Tracker), focuses on waits
and events themselves. Dept tracks waits and events and report it if
any event would be never reachable.

Dept does:
   . Works with read lock in the right way.
   . Works with any wait and event e.i. cross-event.
   . Continue to work even after reporting multiple times.
   . Provides simple and intuitive APIs.
   . Does exactly what dependency checker should do.

Q & A
-----
Q. Is this the first try ever to address the problem?
A. No. Cross-release feature (b09be676e0ff2 locking/lockdep: Implement
   the 'crossrelease' feature) addressed it 2 years ago that was a
   Lockdep extention and merged but reverted shortly because:

   Cross-release started to report valuable hidden problems but started
   to give report false positive reports a few times. For sure, no one
   likes Lockdep's false positive reports since it makes Lockdep stop,
   preventing reporting further real problems.

Q. Why not Dept was developed as an extention of Lockdep?
A. Lockdep definitely includes all the efforts great developers have
   made for a long time so as to be quite stable enough. But I had to
   design and implement newly because of the following:

   1) Lockdep was designed to track lock acquisition order. The APIs and
      implementation do not fit on wait-event model.
   2) Lockdep would be turned off on detection including false positive.
      Which is terrible and would keep any extention for stronger
      detection from being developed.

Q. Do you intend to totally replace Lockdep?
A. No. Lockdep also checks if lock usage is correct. Of course, the
   deadlock check routine should be replaced but the other functions
   should be still there.

Q. Do you mean the deadlock check routine should be replaced right away?
A. No. I admit Lockdep is stable enough thanks to great efforts kernel
   developers have made. Lockdep and Dept, both should be in the kernel
   until Dept gets considered stable.

Q. Stronger detection would give more false positive report. Which was a
   big problem when cross-release was introduced. Is it ok with Dept?
A. It's ok. Dept allows multiple reporting thanks to simple and quite
   generalized design. Of course, false positive reports should be fixed
   but it's no longer critical problem.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h            |  495 +++++++++
 include/linux/hardirq.h         |    3 +
 include/linux/irqflags.h        |   33 +-
 include/linux/sched.h           |    3 +
 init/init_task.c                |    2 +
 init/main.c                     |    2 +
 kernel/Makefile                 |    1 +
 kernel/dependency/Makefile      |    4 +
 kernel/dependency/dept.c        | 2313 +++++++++++++++++++++++++++++++++++++++
 kernel/dependency/dept_hash.h   |    9 +
 kernel/dependency/dept_object.h |   12 +
 kernel/exit.c                   |    1 +
 kernel/fork.c                   |    2 +
 kernel/module.c                 |    2 +
 kernel/softirq.c                |    6 +-
 kernel/trace/trace_preemptirq.c |   19 +-
 lib/Kconfig.debug               |   15 +
 17 files changed, 2913 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/dept.h
 create mode 100644 kernel/dependency/Makefile
 create mode 100644 kernel/dependency/dept.c
 create mode 100644 kernel/dependency/dept_hash.h
 create mode 100644 kernel/dependency/dept_object.h

diff --git a/include/linux/dept.h b/include/linux/dept.h
new file mode 100644
index 0000000..7fe1e04
--- /dev/null
+++ b/include/linux/dept.h
@@ -0,0 +1,495 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Dept(DEPendency Tracker) - runtime dependency tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ */
+
+#ifndef __LINUX_DEPT_H
+#define __LINUX_DEPT_H
+
+#ifdef CONFIG_DEPT
+
+#include <linux/list.h>
+#include <linux/llist.h>
+
+#define DEPT_MAX_STACK_ENTRY		16
+#define DEPT_MAX_WAIT_HIST		16
+#define DEPT_MAX_ECXT_HELD		48
+
+#define DEPT_MAX_SUBCLASSES		16
+#define DEPT_MAX_SUBCLASSES_EVT		2
+#define DEPT_MAX_SUBCLASSES_USR		(DEPT_MAX_SUBCLASSES / DEPT_MAX_SUBCLASSES_EVT)
+#define DEPT_MAX_SUBCLASSES_CACHE	2
+
+#define DEPT_SIRQ			0
+#define DEPT_HIRQ			1
+#define DEPT_IRQS_NR			2
+#define DEPT_SIRQF			(1UL << DEPT_SIRQ)
+#define DEPT_HIRQF			(1UL << DEPT_HIRQ)
+
+enum dept_type {
+	DEPT_TYPE_NO_CHECK,
+	DEPT_TYPE_SPIN,
+	DEPT_TYPE_MUTEX,
+	DEPT_TYPE_RW,
+	DEPT_TYPE_WFC,
+	DEPT_TYPE_SDT,
+	DEPT_TYPE_OTHER,
+};
+
+struct dept_class {
+	union {
+		struct llist_node pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t ref;
+
+			/*
+			 * unique information about the class
+			 */
+			const char *name;
+			unsigned long key;
+			int sub;
+
+			/*
+			 * for BFS
+			 */
+			unsigned int bfs_gen;
+			int bfs_dist;
+			struct dept_class *bfs_parent;
+
+			/*
+			 * for hashing this object
+			 */
+			struct hlist_node hash_node;
+
+			/*
+			 * for linking all classes
+			 */
+			struct list_head all_node;
+
+			/*
+			 * for associating its dependencies
+			 */
+			struct list_head dep_head;
+			struct list_head dep_rev_head;
+
+			/*
+			 * for tracking IRQ dependencies
+			 */
+			int iwait_dist[DEPT_IRQS_NR];
+			struct dept_ecxt *iecxt[DEPT_IRQS_NR];
+			struct dept_wait *iwait[DEPT_IRQS_NR];
+		};
+	};
+};
+
+struct dept_stack {
+	union {
+		struct llist_node pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t ref;
+
+			/*
+			 * backtrace entries
+			 */
+			unsigned long raw[DEPT_MAX_STACK_ENTRY];
+			int nr;
+		};
+	};
+};
+
+struct dept_ecxt {
+	union {
+		struct llist_node pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t ref;
+
+			/*
+			 * function that entered to this ecxt
+			 */
+			const char *ecxt_fn;
+
+			/*
+			 * event function
+			 */
+			const char *event_fn;
+
+			/*
+			 * associated class
+			 */
+			struct dept_class *class;
+
+			/*
+			 * flag indicating which IRQ has been
+			 * enabled within the event context
+			 */
+			unsigned long enirqf;
+
+			/*
+			 * where the IRQ-enabled happened
+			 */
+			unsigned long enirq_ip[DEPT_IRQS_NR];
+			struct dept_stack *enirq_stack[DEPT_IRQS_NR];
+
+			/*
+			 * where the event context started
+			 */
+			unsigned long ecxt_ip;
+			struct dept_stack *ecxt_stack;
+
+			/*
+			 * where the event triggered
+			 */
+			unsigned long event_ip;
+			struct dept_stack *event_stack;
+		};
+	};
+};
+
+struct dept_wait {
+	union {
+		struct llist_node pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t ref;
+
+			/*
+			 * function causing this wait
+			 */
+			const char *wait_fn;
+
+			/*
+			 * the associated class
+			 */
+			struct dept_class *class;
+
+			/*
+			 * which IRQ the wait was placed in
+			 */
+			unsigned long irqf;
+
+			/*
+			 * where the wait happened
+			 */
+			unsigned long ip;
+			struct dept_stack *stack;
+		};
+	};
+};
+
+struct dept_dep {
+	union {
+		struct llist_node pool_node;
+		struct {
+			/*
+			 * reference counter for object management
+			 */
+			atomic_t ref;
+
+			/*
+			 * key data of dependency
+			 */
+			struct dept_ecxt *ecxt;
+			struct dept_wait *wait;
+
+			/*
+			 * This object can be referred without dept_lock
+			 * held but with IRQ disabled, e.g. for hash
+			 * lookup. So deferred deletion is needed.
+			 */
+			struct rcu_head rh;
+
+			/*
+			 * for BFS
+			 */
+			struct list_head bfs_node;
+
+			/*
+			 * for hashing this object
+			 */
+			struct hlist_node hash_node;
+
+			/*
+			 * for linking to a class object
+			 */
+			struct list_head dep_node;
+			struct list_head dep_rev_node;
+		};
+	};
+};
+
+struct dept_hash {
+	/*
+	 * hash table
+	 */
+	struct hlist_head *table;
+
+	/*
+	 * size of the table e.i. 2^bits
+	 */
+	int bits;
+};
+
+struct dept_pool {
+	const char *name;
+
+	/*
+	 * object size
+	 */
+	size_t obj_sz;
+
+	/*
+	 * the number of the static array
+	 */
+	atomic_t obj_nr;
+
+	/*
+	 * offset of ->pool_node
+	 */
+	size_t node_off;
+
+	/*
+	 * pointer to the pool
+	 */
+	void *spool;
+	struct llist_head boot_pool;
+	struct llist_head __percpu *lpool;
+};
+
+struct dept_ecxt_held {
+	/*
+	 * associated event context
+	 */
+	struct dept_ecxt *ecxt;
+
+	/*
+	 * unique key for this dept_ecxt_held
+	 */
+	unsigned long key;
+
+	/*
+	 * the wgen when the event context started
+	 */
+	unsigned int wgen;
+
+	/*
+	 * whether the event context has been started along with a wait
+	 */
+	bool with_wait;
+
+	/*
+	 * for allowing user aware nesting
+	 */
+	int nest;
+};
+
+struct dept_wait_hist {
+	/*
+	 * associated wait
+	 */
+	struct dept_wait *wait;
+
+	/*
+	 * unique id of all waits system-wise until wrapped
+	 */
+	unsigned int wgen;
+
+	/*
+	 * local context id to identify IRQ context
+	 */
+	unsigned int ctxt_id;
+};
+
+struct dept_task {
+	/*
+	 * all event contexts that have entered and before exiting
+	 */
+	struct dept_ecxt_held ecxt_held[DEPT_MAX_ECXT_HELD];
+	int ecxt_held_pos;
+
+	/*
+	 * ring buffer holding all waits that have happened
+	 */
+	struct dept_wait_hist wait_hist[DEPT_MAX_WAIT_HIST];
+	int wait_hist_pos;
+
+	/*
+	 * sequencial id to identify each IRQ context
+	 */
+	unsigned int irq_id[DEPT_IRQS_NR];
+
+	/*
+	 * for tracking IRQ-enabled points with cross-event
+	 */
+	unsigned int wgen_enirq[DEPT_IRQS_NR];
+
+	/*
+	 * for keeping up-to-date IRQ-enabled points
+	 */
+	unsigned long enirq_ip[DEPT_IRQS_NR];
+
+	/*
+	 * current effective IRQ-enabled flag
+	 */
+	unsigned long eff_enirqf;
+
+	/*
+	 * for reserving a current stack instance at each operation
+	 */
+	struct dept_stack *stack;
+
+	/*
+	 * for preventing recursive call into Dept engine
+	 */
+	int recursive;
+
+	/*
+	 * for tracking IRQ-enable state
+	 */
+	bool hardirqs_enabled;
+	bool softirqs_enabled;
+};
+
+struct dept_key {
+	union {
+		/*
+		 * Each byte-wise address will be used as its key.
+		 */
+		char subkeys[DEPT_MAX_SUBCLASSES];
+
+		/*
+		 * for caching the main class pointer
+		 */
+		struct dept_class *classes[DEPT_MAX_SUBCLASSES_CACHE];
+	};
+};
+
+struct dept_map {
+	const char *name;
+	struct dept_key *keys;
+	int sub_usr;
+
+	/*
+	 * It's local copy for fast acces to the associated classes. And
+	 * Also used for dept_key instance for statically defined map.
+	 */
+	struct dept_key keys_local;
+
+	/*
+	 * wait timestamp associated to this map
+	 */
+	unsigned int wgen;
+
+	/*
+	 * for handling the map differently according to the type
+	 */
+	enum dept_type type;
+};
+
+#define DEPT_TASK_INITIALIZER(t)					\
+	.dept_task.wait_hist = { { .wait = NULL, } },			\
+	.dept_task.ecxt_held_pos = 0,					\
+	.dept_task.wait_hist_pos = 0,					\
+	.dept_task.irq_id = { 0 },					\
+	.dept_task.wgen_enirq = { 0 },					\
+	.dept_task.enirq_ip = { 0 },					\
+	.dept_task.recursive = 0,					\
+	.dept_task.hardirqs_enabled = false,				\
+	.dept_task.softirqs_enabled = false,
+
+extern void dept_on(void);
+extern void dept_off(void);
+extern void dept_init(void);
+extern void dept_task_init(struct task_struct *t);
+extern void dept_task_exit(struct task_struct *t);
+extern void dept_free_range(void *start, unsigned int sz);
+extern void dept_map_init(struct dept_map *m, struct dept_key *k, int sub, const char *n, enum dept_type t);
+extern void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub, const char *n);
+extern void dept_map_nocheck(struct dept_map *m);
+
+extern void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip, const char *w_fn, int ne);
+extern void dept_wait_ecxt_enter(struct dept_map *m, unsigned long w_f, unsigned long e_f, unsigned long ip, const char *w_fn, const char *c_fn, const char *e_fn, int ne);
+extern void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *c_fn, const char *e_fn, int ne);
+extern void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip, const char *e_fn);
+extern void dept_ecxt_exit(struct dept_map *m, unsigned long ip);
+extern struct dept_map *dept_top_map(void);
+
+/*
+ * for users who want to manage external keys
+ */
+extern void dept_key_init(struct dept_key *k);
+extern void dept_key_destroy(struct dept_key *k);
+
+#define DEPT_MAP_INIT(dname)	{ .name = #dname, .type = DEPT_TYPE_SDT }
+#define DEFINE_DEPT_SDT(x)	struct dept_map x = DEPT_MAP_INIT(x)
+
+/*
+ * SDT(Simple version of Dependency Tracker) APIs
+ *
+ * In case that one dept_map instance maps to a single event, SDT APIs
+ * can be used.
+ */
+#define sdt_map_init(m)							\
+	do {								\
+		static struct dept_key __key;				\
+		dept_map_init(m, &__key, 0, #m, DEPT_TYPE_SDT);		\
+	} while (0)
+#define sdt_map_init_key(m, k)		dept_map_init(m, k, 0, #m)
+
+#define sdt_wait(m)			dept_wait(m, 1UL, _THIS_IP_, "wait", 0)
+#define sdt_wait_ecxt_enter(m)		dept_wait_ecxt_enter(m, 1UL, 1UL, _THIS_IP_, "wait", "start", "event", 0)
+#define sdt_ecxt_enter(m)		dept_ecxt_enter(m, 1UL, _THIS_IP_, "start", "event", 0)
+#define sdt_event(m)			dept_event(m, 1UL, _THIS_IP_, "event")
+#define sdt_ecxt_exit(m)		dept_ecxt_exit(m, _THIS_IP_)
+#else /* !CONFIG_DEPT */
+struct dept_task { };
+struct dept_key  { };
+struct dept_map  { };
+
+#define DEPT_TASK_INITIALIZER(t)
+
+#define dept_on()					do { } while (0)
+#define dept_off()					do { } while (0)
+#define dept_init()					do { } while (0)
+#define dept_task_init(t)				do { } while (0)
+#define dept_task_exit(t)				do { } while (0)
+#define dept_free_range(s, sz)				do { } while (0)
+#define dept_map_init(m, k, s, n, t)			do { (void)(n); (void)(k); } while (0)
+#define dept_map_reinit(m, k, s, n)			do { (void)(n); (void)(k); } while (0)
+#define dept_map_nocheck(m)				do { } while (0)
+
+#define dept_wait(m, w_f, ip, w_fn, ne)			do { } while (0)
+#define dept_wait_ecxt_enter(m, w_f, e_f, ip, w_fn, c_fn, e_fn, ne) do { } while (0)
+#define dept_ecxt_enter(m, e_f, ip, c_fn, e_fn, ne)	do { } while (0)
+#define dept_event(m, e_f, ip, e_fn)			do { } while (0)
+#define dept_ecxt_exit(m, ip)				do { } while (0)
+#define dept_top_map()					NULL
+#define dept_key_init(k)				do { (void)(k); } while (0)
+#define dept_key_destroy(k)				do { (void)(k); } while (0)
+
+#define DEFINE_DEPT_SDT(x)
+
+#define sdt_map_init(m)					do { } while (0)
+#define sdt_map_init_key(m, k)				do { (void)(k); } while (0)
+#define sdt_wait(m)					do { } while (0)
+#define sdt_wait_ecxt_enter(m)				do { } while (0)
+#define sdt_ecxt_enter(m)				do { } while (0)
+#define sdt_event(m)					do { } while (0)
+#define sdt_ecxt_exit(m)				do { } while (0)
+#endif
+#endif /* __LINUX_DEPT_H */
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 754f67a..55798fb 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -5,6 +5,7 @@
 #include <linux/context_tracking_state.h>
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
+#include <linux/dept.h>
 #include <linux/ftrace_irq.h>
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
@@ -113,6 +114,7 @@ static inline void rcu_nmi_exit(void) { }
  */
 #define __nmi_enter()						\
 	do {							\
+		dept_off();					\
 		lockdep_off();					\
 		arch_nmi_enter();				\
 		printk_nmi_enter();				\
@@ -137,6 +139,7 @@ static inline void rcu_nmi_exit(void) { }
 		printk_nmi_exit();				\
 		arch_nmi_exit();				\
 		lockdep_on();					\
+		dept_on();					\
 	} while (0)
 
 #define nmi_exit()						\
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 3ed4e87..dbab683 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -31,6 +31,22 @@
   static inline void lockdep_hardirqs_off(unsigned long ip) { }
 #endif
 
+#ifdef CONFIG_DEPT
+  extern void dept_hardirq_enter(void);
+  extern void dept_softirq_enter(void);
+  extern void dept_enable_hardirq(unsigned long ip);
+  extern void dept_enable_softirq(unsigned long ip);
+  extern void dept_disable_hardirq(unsigned long ip);
+  extern void dept_disable_softirq(unsigned long ip);
+#else
+  static inline void dept_hardirq_enter(void) { }
+  static inline void dept_softirq_enter(void) { }
+  static inline void dept_enable_hardirq(unsigned long ip) { }
+  static inline void dept_enable_softirq(unsigned long ip) { }
+  static inline void dept_disable_hardirq(unsigned long ip) { }
+  static inline void dept_disable_softirq(unsigned long ip) { }
+#endif
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 
 /* Per-task IRQ trace events information. */
@@ -53,15 +69,19 @@ struct irqtrace_events {
 extern void trace_hardirqs_off_finish(void);
 extern void trace_hardirqs_on(void);
 extern void trace_hardirqs_off(void);
+extern void trace_softirqs_on_caller(unsigned long ip);
+extern void trace_softirqs_off_caller(unsigned long ip);
 
 # define lockdep_hardirq_context()	(raw_cpu_read(hardirq_context))
 # define lockdep_softirq_context(p)	((p)->softirq_context)
 # define lockdep_hardirqs_enabled()	(this_cpu_read(hardirqs_enabled))
 # define lockdep_softirqs_enabled(p)	((p)->softirqs_enabled)
-# define lockdep_hardirq_enter()			\
-do {							\
-	if (__this_cpu_inc_return(hardirq_context) == 1)\
-		current->hardirq_threaded = 0;		\
+# define lockdep_hardirq_enter()				\
+do {								\
+	if (__this_cpu_inc_return(hardirq_context) == 1) {	\
+		current->hardirq_threaded = 0;			\
+		dept_hardirq_enter();				\
+	}							\
 } while (0)
 # define lockdep_hardirq_threaded()		\
 do {						\
@@ -73,7 +93,8 @@ struct irqtrace_events {
 } while (0)
 # define lockdep_softirq_enter()		\
 do {						\
-	current->softirq_context++;		\
+	if (!current->softirq_context++)	\
+		dept_softirq_enter();		\
 } while (0)
 # define lockdep_softirq_exit()			\
 do {						\
@@ -123,6 +144,8 @@ struct irqtrace_events {
 # define trace_hardirqs_off_finish()		do { } while (0)
 # define trace_hardirqs_on()			do { } while (0)
 # define trace_hardirqs_off()			do { } while (0)
+# define trace_softirqs_on_caller(ip)		do { } while (0)
+# define trace_softirqs_off_caller(ip)		do { } while (0)
 # define lockdep_hardirq_context()		0
 # define lockdep_softirq_context(p)		0
 # define lockdep_hardirqs_enabled()		0
diff --git a/include/linux/sched.h b/include/linux/sched.h
index afe01e2..d907e5d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -34,6 +34,7 @@
 #include <linux/rseq.h>
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
+#include <linux/dept.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1008,6 +1009,8 @@ struct task_struct {
 	struct held_lock		held_locks[MAX_LOCK_DEPTH];
 #endif
 
+	struct dept_task		dept_task;
+
 #ifdef CONFIG_UBSAN
 	unsigned int			in_ubsan;
 #endif
diff --git a/init/init_task.c b/init/init_task.c
index f6889fc..1770fb8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -12,6 +12,7 @@
 #include <linux/audit.h>
 #include <linux/numa.h>
 #include <linux/scs.h>
+#include <linux/dept.h>
 
 #include <linux/uaccess.h>
 
@@ -194,6 +195,7 @@ struct task_struct init_task
 	.curr_chain_key = INITIAL_CHAIN_KEY,
 	.lockdep_recursion = 0,
 #endif
+	DEPT_TASK_INITIALIZER(init_task)
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	.ret_stack	= NULL,
 #endif
diff --git a/init/main.c b/init/main.c
index e880b4e..d33ef05 100644
--- a/init/main.c
+++ b/init/main.c
@@ -63,6 +63,7 @@
 #include <linux/debug_locks.h>
 #include <linux/debugobjects.h>
 #include <linux/lockdep.h>
+#include <linux/dept.h>
 #include <linux/kmemleak.h>
 #include <linux/padata.h>
 #include <linux/pid_namespace.h>
@@ -979,6 +980,7 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
 		      panic_param);
 
 	lockdep_init();
+	dept_init();
 
 	/*
 	 * Need to run this when irqs are enabled, because it wants
diff --git a/kernel/Makefile b/kernel/Makefile
index 9a20016..ce54317 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y += rcu/
 obj-y += livepatch/
 obj-y += dma/
 obj-y += entry/
+obj-y += dependency/
 
 obj-$(CONFIG_CHECKPOINT_RESTORE) += kcmp.o
 obj-$(CONFIG_FREEZER) += freezer.o
diff --git a/kernel/dependency/Makefile b/kernel/dependency/Makefile
new file mode 100644
index 0000000..9f7778e
--- /dev/null
+++ b/kernel/dependency/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_DEPT) += dept.o
+
diff --git a/kernel/dependency/dept.c b/kernel/dependency/dept.c
new file mode 100644
index 0000000..ac840ac
--- /dev/null
+++ b/kernel/dependency/dept.c
@@ -0,0 +1,2313 @@
+/*
+ * Dept(DEPendency Tracker) - Runtime dependency tracker
+ *
+ * Started by Byungchul Park <max.byungchul.park@gmail.com>:
+ *
+ *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
+ *
+ * Dept provides a general way to detect deadlock possibility in runtime
+ * and the interest is not limited to typical lock but to every
+ * syncronization primitives.
+ *
+ * The following ideas were borrowed from Lockdep:
+ *
+ *    1) Use a graph to track relationship between classes.
+ *    2) Prevent performance regression using hash.
+ *
+ * The following items were enhanced from Lockdep:
+ *
+ *    1) Cover more deadlock cases.
+ *    2) Allow muliple reports.
+ *
+ * TODO: Both Lockdep and Dept should co-exist until Dept is considered
+ * stable. Then the dependency check routine shoud be replaced with Dept
+ * after. It should finally look like:
+ *
+ * As is:
+ *
+ *    Lockdep
+ *    +-----------------------------------------+
+ *    | Lock usage correctness check            | <-> locks
+ *    |                                         |
+ *    | Dependency check                        |
+ *    | (by tracking lock aquisition order)     |
+ *    +-----------------------------------------+
+ *
+ *    Dept
+ *    +-----------------------------------------+
+ *    | Dependency check                        | <-> waits/events
+ *    | (by tracking wait and event context)    |     (covering locks)
+ *    +-----------------------------------------+
+ *
+ * To be:
+ *
+ *    Lockdep (Suggest to rename.)
+ *    +-----------------------------------------+
+ *    | Lock usage correctness check            | <-> locks
+ *    +-----------------------------------------+
+ *
+ *    Dept
+ *    +-----------------------------------------+
+ *    | Dependency check                        | <-> waits/events
+ *    | (by tracking wait and event context)    |     (covering locks)
+ *    +-----------------------------------------+
+ *
+ * ---
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your ootion) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, you can access it online at
+ * http://www.gnu.org/licenses/gpl-2.0.html.
+ */
+
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/sched.h>
+#include <linux/stacktrace.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/hash.h>
+#include <linux/dept.h>
+#include <linux/utsname.h>
+
+static int dept_stop;
+static int dept_per_cpu_ready;
+
+/*
+ * Make all operations using DEPT_WARN_ON() fail on oops_in_progress and
+ * prevent warning message.
+ */
+#define DEPT_WARN_ON_ONCE(c)						\
+	({								\
+		int __ret = 1;						\
+		if (likely(!oops_in_progress))				\
+			__ret = WARN_ONCE(c, "DEPT_WARN_ON_ONCE: " #c);	\
+		__ret;							\
+	})
+
+#define DEPT_WARN_ONCE(s...)						\
+	({								\
+		if (likely(!oops_in_progress))				\
+			WARN_ONCE(1, "DEPT_WARN_ONCE: " s);		\
+	})
+
+#define DEPT_WARN_ON(c)							\
+	({								\
+		int __ret = 1;						\
+		if (likely(!oops_in_progress))				\
+			__ret = WARN(c, "DEPT_WARN_ON: " #c);		\
+		__ret;							\
+	})
+
+#define DEPT_WARN(s...)							\
+	({								\
+		if (likely(!oops_in_progress))				\
+			WARN(1, "DEPT_WARN: " s);			\
+	})
+
+#define DEPT_STOP(s...)							\
+	({								\
+		WRITE_ONCE(dept_stop, 1);				\
+		if (likely(!oops_in_progress))				\
+			WARN(1, "DEPT_STOP: " s);			\
+	})
+
+static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
+
+/*
+ * Dept internal engine should be careful in using outside functions
+ * e.g. printk at reporting since that kind of usage might cause
+ * untrackable deadlock.
+ */
+static atomic_t dept_outworld = ATOMIC_INIT(0);
+
+static inline void dept_outworld_enter(void)
+{
+	atomic_inc(&dept_outworld);
+}
+
+static inline void dept_outworld_exit(void)
+{
+	atomic_dec(&dept_outworld);
+}
+
+static inline bool dept_outworld_entered(void)
+{
+	return atomic_read(&dept_outworld);
+}
+
+static inline bool dept_lock(void)
+{
+	while (!arch_spin_trylock(&dept_spin))
+		if (unlikely(dept_outworld_entered()))
+			return false;
+	return true;
+}
+
+static inline void dept_unlock(void)
+{
+	arch_spin_unlock(&dept_spin);
+}
+
+/*
+ * whether to stack-trace on every wait or every ecxt
+ */
+static bool rich_stack = true;
+
+enum bfs_ret {
+	DEPT_BFS_CONTINUE,
+	DEPT_BFS_CONTINUE_REV,
+	DEPT_BFS_DONE,
+	DEPT_BFS_SKIP,
+};
+
+/*
+ * The irq wait is in unknown state. Should identify the state.
+ */
+#define DEPT_IWAIT_UNKNOWN ((void *)1)
+
+static inline bool before(unsigned int a, unsigned int b)
+{
+	return (int)(a - b) < 0;
+}
+
+static inline bool valid_stack(struct dept_stack *s)
+{
+	return s && s->nr > 0;
+}
+
+static inline bool valid_class(struct dept_class *c)
+{
+	return c->key;
+}
+
+static inline void invalidate_class(struct dept_class *c)
+{
+	c->key = 0UL;
+}
+
+static inline struct dept_class *dep_fc(struct dept_dep *d)
+{
+	return d->ecxt->class;
+}
+
+static inline struct dept_class *dep_tc(struct dept_dep *d)
+{
+	return d->wait->class;
+}
+
+static inline const char *irq_str(int irq)
+{
+	if (irq == DEPT_SIRQ)
+		return "softirq";
+	if (irq == DEPT_HIRQ)
+		return "hardirq";
+	return "(unknown)";
+}
+
+static inline struct dept_task *dept_task(void)
+{
+	return &current->dept_task;
+}
+
+/*
+ * Pool
+ * =====================================================================
+ * Dept maintains pools to provide objects in a safe way.
+ *
+ *    1) Static pool is used at the beginning of booting time.
+ *    2) Local pool is tried first before the static pool. Objects that
+ *       have been freed will be placed.
+ */
+
+enum object_t {
+#define OBJECT(id, nr) OBJECT_##id,
+	#include "dept_object.h"
+#undef  OBJECT
+	OBJECT_NR,
+};
+
+#define OBJECT(id, nr)							\
+static struct dept_##id spool_##id[nr];					\
+static DEFINE_PER_CPU(struct llist_head, lpool_##id);
+	#include "dept_object.h"
+#undef  OBJECT
+
+static struct dept_pool pool[OBJECT_NR] = {
+#define OBJECT(id, nr) {						\
+	.name = #id,							\
+	.obj_sz = sizeof(struct dept_##id),				\
+	.obj_nr = ATOMIC_INIT(nr),					\
+	.node_off = offsetof(struct dept_##id, pool_node),		\
+	.spool = spool_##id,						\
+	.lpool = &lpool_##id, },
+	#include "dept_object.h"
+#undef  OBJECT
+};
+
+/*
+ * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
+ * enabled because Dept never race with NMI by nesting control.
+ */
+static void *from_pool(enum object_t t)
+{
+	struct dept_pool *p;
+	struct llist_head *h;
+	struct llist_node *n;
+
+	/*
+	 * llist_del_first() doesn't allow concurrent access e.g.
+	 * between process and IRQ context.
+	 */
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return NULL;
+
+	p = &pool[t];
+
+	/*
+	 * Try local pool first.
+	 */
+	if (likely(dept_per_cpu_ready))
+		h = this_cpu_ptr(p->lpool);
+	else
+		h = &p->boot_pool;
+
+	n = llist_del_first(h);
+	if (n)
+		return (void *)n - p->node_off;
+
+	/*
+	 * Try static pool.
+	 */
+	if (atomic_read(&p->obj_nr) > 0) {
+		int idx = atomic_dec_return(&p->obj_nr);
+		if (idx >= 0)
+			return p->spool + (idx * p->obj_sz);
+	}
+
+	DEPT_WARN_ONCE("Pool(%s) is empty.\n", p->name);
+	return NULL;
+}
+
+static void to_pool(void *o, enum object_t t)
+{
+	struct dept_pool *p = &pool[t];
+	struct llist_head *h;
+
+	preempt_disable();
+	if (likely(dept_per_cpu_ready))
+		h = this_cpu_ptr(p->lpool);
+	else
+		h = &p->boot_pool;
+
+	llist_add(o + p->node_off, h);
+	preempt_enable();
+}
+
+#define OBJECT(id, nr)							\
+static void (*ctor_##id)(struct dept_##id *a);				\
+static void (*dtor_##id)(struct dept_##id *a);				\
+static inline struct dept_##id *new_##id(void)				\
+{									\
+	struct dept_##id *a;						\
+									\
+	a = (struct dept_##id *)from_pool(OBJECT_##id);			\
+	if (unlikely(!a))						\
+		return NULL;						\
+									\
+	atomic_set(&a->ref, 1);						\
+									\
+	if (ctor_##id)							\
+		ctor_##id(a);						\
+									\
+	return a;							\
+}									\
+									\
+static inline struct dept_##id *get_##id(struct dept_##id *a)		\
+{									\
+	atomic_inc(&a->ref);						\
+	return a;							\
+}									\
+									\
+static inline void put_##id(struct dept_##id *a)			\
+{									\
+	if (!atomic_dec_return(&a->ref)) {				\
+		if (dtor_##id)						\
+			dtor_##id(a);					\
+		to_pool(a, OBJECT_##id);				\
+	}								\
+}									\
+									\
+static inline void del_##id(struct dept_##id *a)			\
+{									\
+	put_##id(a);							\
+}									\
+									\
+static inline bool id##_refered(struct dept_##id *a, int expect)	\
+{									\
+	return a && atomic_read(&a->ref) > expect;			\
+}
+#include "dept_object.h"
+#undef  OBJECT
+
+#define SET_CONSTRUCTOR(id, f) \
+static void (*ctor_##id)(struct dept_##id *a) = f;
+
+static void initialize_dep(struct dept_dep *d)
+{
+	INIT_LIST_HEAD(&d->bfs_node);
+	INIT_LIST_HEAD(&d->dep_node);
+	INIT_LIST_HEAD(&d->dep_rev_node);
+}
+SET_CONSTRUCTOR(dep, initialize_dep);
+
+static void initialize_class(struct dept_class *c)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		c->iwait_dist[i] = INT_MAX;
+		WRITE_ONCE(c->iecxt[i], NULL);
+		WRITE_ONCE(c->iwait[i], NULL);
+	}
+	c->bfs_gen = 0U;
+
+	INIT_LIST_HEAD(&c->all_node);
+	INIT_LIST_HEAD(&c->dep_head);
+	INIT_LIST_HEAD(&c->dep_rev_head);
+}
+SET_CONSTRUCTOR(class, initialize_class);
+
+static void initialize_ecxt(struct dept_ecxt *e)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		e->enirq_stack[i] = NULL;
+		e->enirq_ip[i] = 0UL;
+	}
+	e->ecxt_ip = 0UL;
+	e->ecxt_stack = NULL;
+	e->enirqf = 0UL;
+	e->event_stack = NULL;
+}
+SET_CONSTRUCTOR(ecxt, initialize_ecxt);
+
+static void initialize_wait(struct dept_wait *w)
+{
+	w->irqf = 0UL;
+	w->stack = NULL;
+}
+SET_CONSTRUCTOR(wait, initialize_wait);
+
+static void initialize_stack(struct dept_stack *s)
+{
+	s->nr = 0;
+}
+SET_CONSTRUCTOR(stack, initialize_stack);
+#undef  SET_CONSTRUCTOR
+
+#define SET_DESTRUCTOR(id, f) \
+static void (*dtor_##id)(struct dept_##id *a) = f;
+
+static void destroy_dep(struct dept_dep *d)
+{
+	if (d->ecxt)
+		put_ecxt(d->ecxt);
+	if (d->wait)
+		put_wait(d->wait);
+}
+SET_DESTRUCTOR(dep, destroy_dep);
+
+static void destroy_ecxt(struct dept_ecxt *e)
+{
+	int i;
+
+	for (i = 0; i < DEPT_IRQS_NR; i++)
+		if (e->enirq_stack[i])
+			put_stack(e->enirq_stack[i]);
+	if (e->class)
+		put_class(e->class);
+	if (e->ecxt_stack)
+		put_stack(e->ecxt_stack);
+	if (e->event_stack)
+		put_stack(e->event_stack);
+}
+SET_DESTRUCTOR(ecxt, destroy_ecxt);
+
+static void destroy_wait(struct dept_wait *w)
+{
+	if (w->class)
+		put_class(w->class);
+	if (w->stack)
+		put_stack(w->stack);
+}
+SET_DESTRUCTOR(wait, destroy_wait);
+#undef  SET_DESTRUCTOR
+
+/*
+ * Caching and hashing
+ * =====================================================================
+ * Dept makes use of caching and hashing to improve performance. Each
+ * object can be obtained in O(1) with its key.
+ *
+ * NOTE: Currently we assume all the objects in the hashs will never be
+ * removed. Implement it when needed.
+ */
+
+/*
+ * Some information might be lost but it's only for hashing key.
+ */
+static inline unsigned long mix(unsigned long a, unsigned long b)
+{
+	int halfbits = sizeof(unsigned long) * 8 / 2;
+	unsigned long halfmask = (1UL << halfbits) - 1UL;
+	return (a << halfbits) | (b & halfmask);
+}
+
+static bool cmp_dep(struct dept_dep *d1, struct dept_dep *d2)
+{
+	return dep_fc(d1)->key == dep_fc(d2)->key &&
+	       dep_tc(d1)->key == dep_tc(d2)->key;
+}
+
+static unsigned long key_dep(struct dept_dep *d)
+{
+	return mix(dep_fc(d)->key, dep_tc(d)->key);
+}
+
+static bool cmp_class(struct dept_class *c1, struct dept_class *c2)
+{
+	return c1->key == c2->key;
+}
+
+static unsigned long key_class(struct dept_class *c)
+{
+	return c->key;
+}
+
+#define HASH(id, bits)							\
+static struct hlist_head table_##id[1UL << bits];			\
+									\
+static inline struct hlist_head *head_##id(struct dept_##id *a)		\
+{									\
+	return table_##id + hash_long(key_##id(a), bits);		\
+}									\
+									\
+static inline struct dept_##id *hash_lookup_##id(struct dept_##id *a)	\
+{									\
+	struct dept_##id *b;						\
+	hlist_for_each_entry_rcu(b, head_##id(a), hash_node)		\
+		if (cmp_##id(a, b))					\
+			return b;					\
+	return NULL;							\
+}									\
+									\
+static inline void hash_add_##id(struct dept_##id *a)			\
+{									\
+	hlist_add_head_rcu(&a->hash_node, head_##id(a));		\
+}									\
+									\
+static inline void hash_del_##id(struct dept_##id *a)			\
+{									\
+	hlist_del_rcu(&a->hash_node);					\
+}
+#include "dept_hash.h"
+#undef  HASH
+
+static inline struct dept_dep *dep(struct dept_class *fc,
+				   struct dept_class *tc)
+{
+	struct dept_ecxt dum_e = { .class = fc };
+	struct dept_wait dum_w = { .class = tc };
+	struct dept_dep  dum_d = { .ecxt = &dum_e, .wait = &dum_w };
+	return hash_lookup_dep(&dum_d);
+}
+
+static inline struct dept_class *class(unsigned long key)
+{
+	struct dept_class dum_c = { .key = key };
+	return hash_lookup_class(&dum_c);
+}
+
+/*
+ * Report
+ * =====================================================================
+ * Dept prints useful information to help debuging on detection of
+ * problematic dependency.
+ */
+
+static inline void print_ip_stack(unsigned long ip, struct dept_stack *s)
+{
+	if (ip)
+		print_ip_sym(KERN_WARNING, ip);
+
+	if (valid_stack(s)) {
+		printk("stacktrace:\n");
+		stack_trace_print(s->raw, s->nr, 5);
+	}
+
+	if (!ip && !valid_stack(s))
+		printk("(N/A)\n");
+}
+
+#define print_spc(spc, fmt, ...)					\
+	printk("%*c" fmt, (spc) * 4, ' ', ##__VA_ARGS__)
+
+static void print_diagram(struct dept_dep *d)
+{
+	struct dept_ecxt *e = d->ecxt;
+	struct dept_wait *w = d->wait;
+	struct dept_class *fc = dep_fc(d);
+	struct dept_class *tc = dep_tc(d);
+	unsigned long irqf;
+	int irq;
+	bool firstline = true;
+	int spc = 1;
+	const char *w_fn = w->wait_fn  ?: "(unknown)";
+	const char *e_fn = e->event_fn ?: "(unknown)";
+	const char *c_fn = e->ecxt_fn ?: "(unknown)";
+
+	irqf = e->enirqf & w->irqf;
+
+	if (!irqf) {
+		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc->name, fc->sub);
+		print_spc(spc, "[W] %s(%s:%d)\n", w_fn, tc->name, tc->sub);
+		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc->name, fc->sub);
+	}
+
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		if (!firstline)
+			printk("\nor\n\n");
+		firstline = false;
+
+		print_spc(spc, "[S] %s(%s:%d)\n", c_fn, fc->name, fc->sub);
+		print_spc(spc, "    <%s interrupt>\n", irq_str(irq));
+		print_spc(spc + 1, "[W] %s(%s:%d)\n", w_fn, tc->name, tc->sub);
+		print_spc(spc, "[E] %s(%s:%d)\n", e_fn, fc->name, fc->sub);
+	}
+}
+
+static void print_dep(struct dept_dep *d)
+{
+	struct dept_ecxt *e = d->ecxt;
+	struct dept_wait *w = d->wait;
+	struct dept_class *fc = dep_fc(d);
+	struct dept_class *tc = dep_tc(d);
+	unsigned long irqf;
+	int irq;
+	const char *w_fn = w->wait_fn  ?: "(unknown)";
+	const char *e_fn = e->event_fn ?: "(unknown)";
+	const char *c_fn = e->ecxt_fn ?: "(unknown)";
+
+	irqf = e->enirqf & w->irqf;
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		printk("%s has been enabled:\n", irq_str(irq));
+		print_ip_stack(e->enirq_ip[irq], e->enirq_stack[irq]);
+		printk("\n");
+	}
+
+	printk("[S] %s(%s:%d):\n", c_fn, fc->name, fc->sub);
+	print_ip_stack(e->ecxt_ip, e->ecxt_stack);
+	printk("\n");
+
+	printk("[W] %s(%s:%d):\n", w_fn, tc->name, tc->sub);
+	print_ip_stack(w->ip, w->stack);
+	printk("\n");
+
+	printk("[E] %s(%s:%d):\n", e_fn, fc->name, fc->sub);
+	print_ip_stack(e->event_ip, e->event_stack);
+}
+
+static void save_current_stack(int skip);
+
+/*
+ * Print all classes in a circle.
+ */
+static void print_circle(struct dept_class *c)
+{
+	struct dept_class *fc = c->bfs_parent;
+	struct dept_class *tc = c;
+	int i;
+
+	dept_outworld_enter();
+	save_current_stack(6);
+
+	printk("===================================================\n");
+	printk("Dept: Circular dependency has been detected.\n");
+	printk("%s %.*s %s\n", init_utsname()->release,
+		(int)strcspn(init_utsname()->version, " "),
+		init_utsname()->version,
+		print_tainted());
+	printk("---------------------------------------------------\n");
+	printk("summary\n");
+	printk("---------------------------------------------------\n");
+
+	if (fc == tc)
+		printk("*** AA DEADLOCK ***\n\n");
+	else
+		printk("*** DEADLOCK ***\n\n");
+
+	i = 0;
+	do {
+		struct dept_dep *d = dep(fc, tc);
+
+		printk("context %c\n", 'A' + (i++));
+		print_diagram(d);
+		if (fc != c)
+			printk("\n");
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	printk("\n");
+	printk("[S]: start of the event context\n");
+	printk("[W]: the wait blocked\n");
+	printk("[E]: the event not reachable\n");
+
+	i = 0;
+	do {
+		struct dept_dep *d = dep(fc, tc);
+
+		printk("---------------------------------------------------\n");
+		printk("context %c's detail\n", 'A' + i);
+		printk("---------------------------------------------------\n");
+		printk("context %c\n", 'A' + (i++));
+		print_diagram(d);
+		printk("\n");
+		print_dep(d);
+
+		tc = fc;
+		fc = fc->bfs_parent;
+	} while (tc != c);
+
+	printk("---------------------------------------------------\n");
+	printk("information that might be helpful\n");
+	printk("---------------------------------------------------\n");
+	dump_stack();
+
+	dept_outworld_exit();
+}
+
+/*
+ * BFS(Breadth First Search)
+ * =====================================================================
+ * Whenever a new dependency is added into the graph, search the graph
+ * for a new circular dependency.
+ */
+
+static inline void enqueue(struct list_head *h, struct dept_dep *d)
+{
+	list_add_tail(&d->bfs_node, h);
+}
+
+static inline struct dept_dep *dequeue(struct list_head *h)
+{
+	struct dept_dep *d;
+	d = list_first_entry(h, struct dept_dep, bfs_node);
+	list_del(&d->bfs_node);
+	return d;
+}
+
+static inline bool empty(struct list_head *h)
+{
+	return list_empty(h);
+}
+
+static void extend_queue(struct list_head *h, struct dept_class *cur)
+{
+	struct dept_dep *d;
+
+	list_for_each_entry(d, &cur->dep_head, dep_node) {
+		struct dept_class *next = dep_tc(d);
+		if (cur->bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_gen = cur->bfs_gen;
+		next->bfs_dist = cur->bfs_dist + 1;
+		next->bfs_parent = cur;
+		enqueue(h, d);
+	}
+}
+
+static void extend_queue_rev(struct list_head *h, struct dept_class *cur)
+{
+	struct dept_dep *d;
+
+	list_for_each_entry(d, &cur->dep_rev_head, dep_rev_node) {
+		struct dept_class *next = dep_fc(d);
+		if (cur->bfs_gen == next->bfs_gen)
+			continue;
+		next->bfs_gen = cur->bfs_gen;
+		next->bfs_dist = cur->bfs_dist + 1;
+		next->bfs_parent = cur;
+		enqueue(h, d);
+	}
+}
+
+typedef enum bfs_ret bfs_f(struct dept_dep *d, void *in, void **out);
+static unsigned int bfs_gen;
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void bfs(struct dept_class *c, bfs_f *cb, void *in, void **out)
+{
+	LIST_HEAD(q);
+	enum bfs_ret ret;
+
+	if (DEPT_WARN_ON(!cb))
+		return;
+
+	/*
+	 * Avoid zero bfs_gen.
+	 */
+	bfs_gen = bfs_gen + 1 ?: 1;
+
+	c->bfs_gen = bfs_gen;
+	c->bfs_dist = 0;
+	c->bfs_parent = c;
+
+	ret = cb(NULL, in, out);
+	if (ret == DEPT_BFS_DONE)
+		return;
+	if (ret == DEPT_BFS_SKIP)
+		return;
+	if (ret == DEPT_BFS_CONTINUE)
+		extend_queue(&q, c);
+	if (ret == DEPT_BFS_CONTINUE_REV)
+		extend_queue_rev(&q, c);
+
+	while (!empty(&q)) {
+		struct dept_dep *d = dequeue(&q);
+
+		ret = cb(d, in, out);
+		if (ret == DEPT_BFS_DONE)
+			break;
+		if (ret == DEPT_BFS_SKIP)
+			continue;
+		if (ret == DEPT_BFS_CONTINUE)
+			extend_queue(&q, dep_tc(d));
+		if (ret == DEPT_BFS_CONTINUE_REV)
+			extend_queue_rev(&q, dep_fc(d));
+	}
+
+	while (!empty(&q))
+		dequeue(&q);
+}
+
+/*
+ * Main operations
+ * =====================================================================
+ * Add dependencies - Each new dependency is added into the graph and
+ * checked if it forms a circular dependency.
+ *
+ * Track waits - Waits are queued into the ring buffer for later use to
+ * generate appropriate dependencies with cross-event.
+ *
+ * Track event contexts(ecxt) - Event contexts are pushed into local
+ * stack for later use to generate appropriate dependencies with waits.
+ */
+
+static inline unsigned long cur_enirqf(void);
+static inline int cur_irq(void);
+static inline unsigned int cur_ctxt_id(void);
+
+static inline struct dept_stack *get_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+	return s ? get_stack(s) : NULL;
+}
+
+static inline void prepare_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+	/*
+	 * The reference counter would be 1 when no one refers to the
+	 * dept_stack.
+	 */
+	const int expect_ref = 1;
+
+	/*
+	 * The dept_stack is already ready.
+	 */
+	if (s && !stack_refered(s, expect_ref)) {
+		s->nr = 0;
+		return;
+	}
+
+	if (s)
+		put_stack(s);
+
+	s = dept_task()->stack = new_stack();
+	if (!s)
+		return;
+
+	get_stack(s);
+	del_stack(s);
+}
+
+static void save_current_stack(int skip)
+{
+	struct dept_stack *s = dept_task()->stack;
+
+	if (!s)
+		return;
+	if (valid_stack(s))
+		return;
+
+	s->nr = stack_trace_save(s->raw, DEPT_MAX_STACK_ENTRY, skip);
+}
+
+static void finish_current_stack(void)
+{
+	struct dept_stack *s = dept_task()->stack;
+	/*
+	 * The reference counter would be 1 when no one refers to the
+	 * dept_stack.
+	 */
+	const int expect_ref = 1;
+
+	if (s && stack_refered(s, expect_ref))
+		save_current_stack(2);
+}
+
+/*
+ * FIXME: For now, disable Lockdep while Dept is working.
+ *
+ * Both Lockdep and Dept report it on a deadlock detection using
+ * printk taking the risk of another deadlock that might be caused by
+ * locks of console or printk between inside and outside of them.
+ *
+ * For Dept, it's no problem since multiple reports are allowed. But it
+ * would be a bad idea for Lockdep since it will stop even on a singe
+ * report. So we need to prevent Lockdep from its reporting the risk
+ * Dept would take when reporting something.
+ */
+#include <linux/lockdep.h>
+
+void dept_off(void)
+{
+	dept_task()->recursive++;
+	lockdep_off();
+}
+
+void dept_on(void)
+{
+	dept_task()->recursive--;
+	lockdep_on();
+}
+
+static inline unsigned long dept_enter(void)
+{
+	unsigned long flags;
+	raw_local_irq_save(flags);
+	dept_off();
+	prepare_current_stack();
+	return flags;
+}
+
+static inline void dept_exit(unsigned long flags)
+{
+	finish_current_stack();
+	dept_on();
+	raw_local_irq_restore(flags);
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static struct dept_dep *__add_dep(struct dept_ecxt *e,
+				  struct dept_wait *w)
+{
+	struct dept_dep *d;
+
+	if (!valid_class(e->class) || !valid_class(w->class))
+		return NULL;
+
+	if (dep(e->class, w->class))
+		return NULL;
+
+	d = new_dep();
+	if (unlikely(!d))
+		return NULL;
+
+	d->ecxt = get_ecxt(e);
+	d->wait = get_wait(w);
+
+	/*
+	 * Add the dependency into hash and graph.
+	 */
+	hash_add_dep(d);
+	list_add(&d->dep_node    , &dep_fc(d)->dep_head    );
+	list_add(&d->dep_rev_node, &dep_tc(d)->dep_rev_head);
+	return d;
+}
+
+static enum bfs_ret cb_check_dl(struct dept_dep *d,
+				void *in, void **out)
+{
+	struct dept_dep *new = (struct dept_dep *)in;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d) {
+		dep_tc(new)->bfs_parent = dep_fc(new);
+
+		if (dep_tc(new) != dep_fc(new))
+			return DEPT_BFS_CONTINUE;
+
+		/*
+		 * AA circle does not make additional deadlock. We don't
+		 * have to continue this BFS search.
+		 */
+		print_circle(dep_tc(new));
+		return DEPT_BFS_DONE;
+	}
+
+	/*
+	 * Allow multiple reports.
+	 */
+	if (dep_tc(d) == dep_fc(new))
+		print_circle(dep_tc(new));
+
+	return DEPT_BFS_CONTINUE;
+}
+
+static inline void check_dl(struct dept_dep *d)
+{
+	bfs(dep_tc(d), cb_check_dl, (void *)d, NULL);
+}
+
+static void add_dep(struct dept_ecxt *e, struct dept_wait *w)
+{
+	struct dept_dep *d;
+
+	if (dep(e->class, w->class))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	d = __add_dep(e, w);
+	if (d)
+		check_dl(d);
+	dept_unlock();
+}
+
+static enum bfs_ret cb_prop_iwait(struct dept_dep *d,
+				  void *in, void **out)
+{
+	int irq = *(int *)in;
+	struct dept_class *fc;
+	struct dept_class *tc;
+	struct dept_dep *new;
+
+	if (DEPT_WARN_ON(!out))
+		return DEPT_BFS_DONE;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d)
+		return DEPT_BFS_CONTINUE;
+
+	fc = dep_fc(d);
+	tc = dep_tc(d);
+
+	if (tc->iwait_dist[irq] <= tc->bfs_dist)
+		return DEPT_BFS_CONTINUE;
+
+	tc->iwait_dist[irq] = tc->bfs_dist;
+	WRITE_ONCE(tc->iwait[irq], fc->iwait[irq]);
+
+	if (!tc->iecxt[irq])
+		return DEPT_BFS_CONTINUE;
+
+	new = __add_dep(tc->iecxt[irq], tc->iwait[irq]);
+	if (!new)
+		return DEPT_BFS_CONTINUE;
+
+	*out = new;
+	return DEPT_BFS_DONE;
+}
+
+static void propagate_iwait(struct dept_class *c, int irq)
+{
+	struct dept_dep *new;
+	do {
+		new = NULL;
+		bfs(c, cb_prop_iwait, (void *)&irq, (void **)&new);
+
+		/*
+		 * Deadlock detected. Let check_dl() report it.
+		 */
+		if (new)
+			check_dl(new);
+	} while (new);
+}
+
+static enum bfs_ret cb_find_iwait(struct dept_dep *d, void *in, void **out)
+{
+	int irq = *(int *)in;
+	struct dept_wait *w;
+
+	if (DEPT_WARN_ON(!out))
+		return DEPT_BFS_DONE;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d)
+		return DEPT_BFS_CONTINUE_REV;
+
+	w = dep_fc(d)->iwait[irq];
+	if (!w || w == DEPT_IWAIT_UNKNOWN)
+		return DEPT_BFS_CONTINUE_REV;
+
+	*out = w;
+	return DEPT_BFS_DONE;
+}
+
+static struct dept_wait *find_iwait(struct dept_class *c, int irq)
+{
+	struct dept_wait *w = NULL;
+	bfs(c, cb_find_iwait, (void *)&irq, (void **)&w);
+	return w;
+}
+
+static void add_iecxt(struct dept_ecxt *e, int irq, bool stack)
+{
+	/*
+	 * This access is safe since we ensure e->class has set locally.
+	 */
+	struct dept_class *c = e->class;
+	struct dept_task *dt = dept_task();
+
+	e->enirqf |= (1UL << irq);
+
+	if (READ_ONCE(c->iecxt[irq]))
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	if (c->iecxt[irq])
+		goto unlock;
+	WRITE_ONCE(c->iecxt[irq], get_ecxt(e));
+
+	/*
+	 * Should be NULL since it's the first time that these
+	 * enirq_{ip,stack}[irq] have ever set.
+	 */
+	DEPT_WARN_ON(e->enirq_ip[irq]);
+	DEPT_WARN_ON(e->enirq_stack[irq]);
+
+	e->enirq_ip[irq] = dt->enirq_ip[irq];
+	if (stack)
+		e->enirq_stack[irq] = get_current_stack();
+
+	if (c->iwait[irq] == DEPT_IWAIT_UNKNOWN) {
+		struct dept_wait *w = find_iwait(c, irq);
+		WRITE_ONCE(c->iwait[irq], w);
+
+		/*
+		 * Deadlock detected. Let propagate_iwait() report it.
+		 */
+		if (w)
+			propagate_iwait(w->class, irq);
+	} else if (c->iwait[irq]) {
+		struct dept_dep *d = __add_dep(e, c->iwait[irq]);
+
+		/*
+		 * Deadlock detected. Let check_dl() report it.
+		 */
+		if (d)
+			check_dl(d);
+	}
+unlock:
+	dept_unlock();
+}
+
+static void add_iwait(struct dept_wait *w, int irq)
+{
+	struct dept_class *c = w->class;
+	struct dept_wait *iw;
+
+	w->irqf |= (1UL << irq);
+
+	iw = READ_ONCE(c->iwait[irq]);
+	if (iw && READ_ONCE(iw->class) == c)
+		return;
+
+	if (unlikely(!dept_lock()))
+		return;
+
+	iw = c->iwait[irq];
+	if (iw && iw->class == c)
+		goto unlock;
+
+	c->iwait_dist[irq] = 0;
+	WRITE_ONCE(c->iwait[irq], get_wait(w));
+
+	if (c->iecxt[irq]) {
+		struct dept_dep *d = __add_dep(c->iecxt[irq], w);
+
+		/*
+		 * Deadlock detected. Let check_dl() report it.
+		 */
+		if (d)
+			check_dl(d);
+	}
+	propagate_iwait(c, irq);
+unlock:
+	dept_unlock();
+}
+
+static inline struct dept_wait_hist *hist(int pos)
+{
+	struct dept_task *dt = dept_task();
+	return dt->wait_hist + (pos % DEPT_MAX_WAIT_HIST);
+}
+
+static inline int hist_pos_next(void)
+{
+	struct dept_task *dt = dept_task();
+	return dt->wait_hist_pos % DEPT_MAX_WAIT_HIST;
+}
+
+static inline void hist_advance(void)
+{
+	struct dept_task *dt = dept_task();
+	dt->wait_hist_pos++;
+	dt->wait_hist_pos %= DEPT_MAX_WAIT_HIST;
+}
+
+static inline struct dept_wait_hist *new_hist(void)
+{
+	struct dept_wait_hist *wh = hist(hist_pos_next());
+	hist_advance();
+	return wh;
+}
+
+static void add_hist(struct dept_wait *w, unsigned int wg, unsigned int ctxt_id)
+{
+	struct dept_wait_hist *wh = new_hist();
+
+	if (likely(wh->wait))
+		put_wait(wh->wait);
+
+	wh->wait = get_wait(w);
+	wh->wgen = wg;
+	wh->ctxt_id = ctxt_id;
+}
+
+static atomic_t wgen = ATOMIC_INIT(1);
+
+static unsigned int add_wait(struct dept_class *c, unsigned long ip,
+			     const char *w_fn, int ne)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_wait *w;
+	unsigned int wg = 0U;
+	int irq;
+	int i;
+
+	w = new_wait();
+	if (unlikely(!w))
+		return 0U;
+
+	WRITE_ONCE(w->class, get_class(c));
+	w->ip = ip;
+	w->wait_fn = w_fn;
+	w->stack = get_current_stack();
+
+	irq = cur_irq();
+	if (irq < DEPT_IRQS_NR)
+		add_iwait(w, irq);
+
+	/*
+	 * Avoid adding dependency between user aware nested ecxt and
+	 * wait.
+	 */
+	for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+		eh = dt->ecxt_held + i;
+		if (eh->ecxt->class != c || eh->nest == ne)
+			break;
+	}
+
+	for (; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+		eh = dt->ecxt_held + i;
+		add_dep(eh->ecxt, w);
+		if (eh->with_wait)
+			break;
+	}
+
+	if (!wait_refered(w, 1) && !rich_stack) {
+		if (w->stack)
+			put_stack(w->stack);
+		w->stack = NULL;
+	}
+
+	/*
+	 * Avoid zero wgen.
+	 */
+	wg = atomic_inc_return(&wgen) ?: atomic_inc_return(&wgen);
+	add_hist(w, wg, cur_ctxt_id());
+
+	del_wait(w);
+	return wg;
+}
+
+static void add_ecxt(void *obj, struct dept_class *c, bool with_wait,
+		     unsigned long ip, const char *c_fn, const char *e_fn,
+		     int ne)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_ecxt_held *eh;
+	struct dept_ecxt *e;
+	unsigned long irqf;
+	int irq;
+
+	if (DEPT_WARN_ON(dt->ecxt_held_pos == DEPT_MAX_ECXT_HELD))
+		return;
+
+	e = new_ecxt();
+	if (unlikely(!e))
+		return;
+
+	e->class = get_class(c);
+	e->ecxt_ip = ip;
+	e->ecxt_stack = ip && rich_stack ? get_current_stack() : NULL;
+	e->event_fn = e_fn;
+	e->ecxt_fn = c_fn;
+
+	eh = dt->ecxt_held + (dt->ecxt_held_pos++);
+	eh->ecxt = get_ecxt(e);
+	eh->key = (unsigned long)obj;
+	eh->with_wait = with_wait;
+	eh->wgen = atomic_read(&wgen);
+	eh->nest = ne;
+
+	irqf = cur_enirqf();
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR)
+		add_iecxt(e, irq, false);
+
+	del_ecxt(e);
+}
+
+static int find_ecxt_pos(unsigned long key, bool newfirst)
+{
+	struct dept_task *dt = dept_task();
+	int i;
+
+	if (newfirst) {
+		for (i = dt->ecxt_held_pos - 1; i >= 0; i--)
+			if (dt->ecxt_held[i].key == key)
+				return i;
+	} else {
+		for (i = 0; i < dt->ecxt_held_pos; i++)
+			if (dt->ecxt_held[i].key == key)
+				return i;
+	}
+	return -1;
+}
+
+static void pop_ecxt(void *obj)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long key = (unsigned long)obj;
+	int pos;
+	int i;
+
+	/*
+	 * TODO: WARN on pos == -1.
+	 */
+	pos = find_ecxt_pos(key, true);
+	if (pos == -1)
+		return;
+
+	put_ecxt(dt->ecxt_held[pos].ecxt);
+	dt->ecxt_held_pos--;
+
+	for (i = pos; i < dt->ecxt_held_pos; i++)
+		dt->ecxt_held[i] = dt->ecxt_held[i + 1];
+}
+
+static inline bool good_hist(struct dept_wait_hist *wh, unsigned int wg)
+{
+	return wh->wait != NULL && before(wg, wh->wgen);
+}
+
+/*
+ * Binary-search the ring buffer for the earliest valid wait.
+ */
+static int find_hist_pos(unsigned int wg)
+{
+	int oldest;
+	int l;
+	int r;
+	int pos;
+
+	oldest = hist_pos_next();
+	if (unlikely(good_hist(hist(oldest), wg))) {
+		DEPT_WARN_ONCE("Need to expand the ring buffer.\n");
+		return oldest;
+	}
+
+	l = oldest + 1;
+	r = oldest + DEPT_MAX_WAIT_HIST - 1;
+	for (pos = (l + r) / 2; l <= r; pos = (l + r) / 2) {
+		struct dept_wait_hist *p = hist(pos - 1);
+		struct dept_wait_hist *wh = hist(pos);
+
+		if (!good_hist(p, wg) && good_hist(wh, wg))
+			return pos % DEPT_MAX_WAIT_HIST;
+		if (good_hist(wh, wg))
+			r = pos - 1;
+		else
+			l = pos + 1;
+	}
+	return -1;
+}
+
+static void do_event(void *obj, struct dept_class *c, unsigned int wg,
+		     unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_wait_hist *wh;
+	struct dept_ecxt_held *eh;
+	unsigned long key = (unsigned long)obj;
+	unsigned int ctxt_id;
+	int end;
+	int pos;
+	int i;
+
+	/*
+	 * The event was triggered before wait.
+	 */
+	if (!wg)
+		return;
+
+	pos = find_ecxt_pos(key, false);
+	if (pos == -1)
+		return;
+
+	eh = dt->ecxt_held + pos;
+	eh->ecxt->event_ip = ip;
+	eh->ecxt->event_stack = get_current_stack();
+
+	/*
+	 * The ecxt already has done what it needs.
+	 */
+	if (!before(wg, eh->wgen))
+		return;
+
+	pos = find_hist_pos(wg);
+	if (pos == -1)
+		return;
+
+	ctxt_id = cur_ctxt_id();
+	end = hist_pos_next();
+	end = end > pos ? end : end + DEPT_MAX_WAIT_HIST;
+	for (wh = hist(pos); pos < end; wh = hist(++pos)) {
+		if (wh->ctxt_id == ctxt_id)
+			add_dep(eh->ecxt, wh->wait);
+		if (!before(wh->wgen, eh->wgen))
+			break;
+	}
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		if (before(dt->wgen_enirq[i], wg))
+			continue;
+		add_iecxt(eh->ecxt, i, false);
+	}
+}
+
+static enum bfs_ret cb_clean_iwait(struct dept_dep *d, void *in, void **out)
+{
+	struct dept_class *c = (struct dept_class *)in;
+	struct dept_class *tc;
+	bool skip = true;
+	int i;
+
+	/*
+	 * initial condition for this BFS search
+	 */
+	if (!d)
+		return DEPT_BFS_CONTINUE;
+
+	tc = dep_tc(d);
+
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		if (tc->iwait[i] != c->iwait[i])
+			continue;
+		WRITE_ONCE(tc->iwait[i], DEPT_IWAIT_UNKNOWN);
+		tc->iwait_dist[i] = INT_MAX;
+		skip = false;
+	}
+
+	if (skip)
+		return DEPT_BFS_SKIP;
+
+	return DEPT_BFS_CONTINUE;
+}
+
+static void clean_iwait(struct dept_class *c)
+{
+	bfs(c, cb_clean_iwait, (void *)c, NULL);
+}
+
+static void del_dep_rcu(struct rcu_head *rh)
+{
+	struct dept_dep *d = container_of(rh, struct dept_dep, rh);
+
+	preempt_disable();
+	del_dep(d);
+	preempt_enable();
+}
+
+/*
+ * NOTE: Must be called with dept_lock held.
+ */
+static void disconnect_class(struct dept_class *c)
+{
+	struct dept_dep *d, *n;
+	int i;
+
+	clean_iwait(c);
+	for (i = 0; i < DEPT_IRQS_NR; i++) {
+		struct dept_ecxt *e = c->iecxt[i];
+		struct dept_wait *w = c->iwait[i];
+		if (e)
+			put_ecxt(e);
+		if (w && w->class == c)
+			put_wait(w);
+		WRITE_ONCE(c->iecxt[i], NULL);
+		WRITE_ONCE(c->iwait[i], NULL);
+	}
+
+	list_for_each_entry_safe(d, n, &c->dep_head, dep_node) {
+		list_del_rcu(&d->dep_node);
+		list_del_rcu(&d->dep_rev_node);
+		hash_del_dep(d);
+		call_rcu(&d->rh, del_dep_rcu);
+	}
+
+	list_for_each_entry_safe(d, n, &c->dep_rev_head, dep_rev_node) {
+		list_del_rcu(&d->dep_node);
+		list_del_rcu(&d->dep_rev_node);
+		hash_del_dep(d);
+		call_rcu(&d->rh, del_dep_rcu);
+	}
+}
+
+/*
+ * IRQ context control
+ * =====================================================================
+ * Whether a wait is in {hard,soft}-IRQ context or whether
+ * {hard,soft}-IRQ has been enabled on the way to an event is very
+ * important to check dependency. All those things should be tracked.
+ */
+
+static inline unsigned long cur_enirqf(void)
+{
+	struct dept_task *dt = dept_task();
+	int he = dt->hardirqs_enabled;
+	int se = dt->softirqs_enabled;
+	if (he)
+		return DEPT_HIRQF | (se ? DEPT_SIRQF : 0UL);
+	return 0UL;
+}
+
+static inline int cur_irq(void)
+{
+	if (lockdep_softirq_context(current))
+		return DEPT_SIRQ;
+	if (lockdep_hardirq_context())
+		return DEPT_HIRQ;
+	return DEPT_IRQS_NR;
+}
+
+static inline unsigned int cur_ctxt_id(void)
+{
+	struct dept_task *dt = dept_task();
+	int irq = cur_irq();
+
+	/*
+	 * Normal process context
+	 */
+	if (irq == DEPT_IRQS_NR)
+		return 0U;
+
+	return dt->irq_id[irq] | (1UL << irq);
+}
+
+static void enirq_transition(int irq)
+{
+	struct dept_task *dt = dept_task();
+	int i;
+
+	/*
+	 * READ wgen >= wgen of an event with IRQ enabled has been
+	 * observed on the way to the event means, the IRQ can cut in
+	 * within the ecxt. Used for cross-event detection.
+	 *
+	 *    wait context	event context(ecxt)
+	 *    ------------	-------------------
+	 *    wait event
+	 *       WRITE wgen
+	 *			observe IRQ enabled
+	 *			   READ wgen
+	 *			   keep the wgen locally
+	 *
+	 *			on the event
+	 *			   check the local wgen
+	 */
+	dt->wgen_enirq[irq] = atomic_read(&wgen);
+
+	for (i = dt->ecxt_held_pos - 1; i >= 0; i--) {
+		struct dept_ecxt_held *eh;
+		eh = dt->ecxt_held + i;
+		add_iecxt(eh->ecxt, irq, true);
+	}
+}
+
+static void enirq_update(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long irqf;
+	unsigned long prev;
+	int irq;
+
+	prev = dt->eff_enirqf;
+	irqf = cur_enirqf();
+	dt->eff_enirqf = irqf;
+
+	/*
+	 * Do enirq_transition() only on an OFF -> ON transition.
+	 */
+	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
+		unsigned long flags;
+
+		if (prev & (1UL << irq))
+			continue;
+
+		flags = dept_enter();
+		dt->enirq_ip[irq] = ip;
+		enirq_transition(irq);
+		dept_exit(flags);
+	}
+}
+
+/*
+ * Ensure it has been called on OFF -> ON transition.
+ */
+void dept_enable_softirq(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (DEPT_WARN_ON(early_boot_irqs_disabled))
+		return;
+
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return;
+
+	dt->softirqs_enabled = true;
+	enirq_update(ip);
+}
+
+/*
+ * Ensure it has been called on OFF -> ON transition.
+ */
+void dept_enable_hardirq(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (DEPT_WARN_ON(early_boot_irqs_disabled))
+		return;
+
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return;
+
+	dt->hardirqs_enabled = true;
+	enirq_update(ip);
+}
+
+/*
+ * Ensure it has been called on ON -> OFF transition.
+ */
+void dept_disable_softirq(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return;
+
+	dt->softirqs_enabled = false;
+	enirq_update(ip);
+}
+
+/*
+ * Ensure it has been called on ON -> OFF transition.
+ */
+void dept_disable_hardirq(unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (DEPT_WARN_ON(!irqs_disabled()))
+		return;
+
+	dt->hardirqs_enabled = false;
+	enirq_update(ip);
+}
+
+/*
+ * Ensure it's the outmost softirq context.
+ */
+void dept_softirq_enter(void)
+{
+	struct dept_task *dt = dept_task();
+	dt->irq_id[DEPT_SIRQ] += (1UL << DEPT_IRQS_NR);
+}
+
+/*
+ * Ensure it's the outmost hardirq context.
+ */
+void dept_hardirq_enter(void)
+{
+	struct dept_task *dt = dept_task();
+	dt->irq_id[DEPT_HIRQ] += (1UL << DEPT_IRQS_NR);
+}
+
+/*
+ * Dept API
+ * =====================================================================
+ * Main Dept APIs.
+ */
+
+static inline void clean_dept_key(struct dept_key *k)
+{
+	int i;
+
+	for (i = 0; i < DEPT_MAX_SUBCLASSES_CACHE; i++)
+		k->classes[i] = NULL;
+}
+
+static inline void copy_dept_key(struct dept_key *dst,
+				 struct dept_key *src)
+{
+	int i;
+
+	for (i = 0; i < DEPT_MAX_SUBCLASSES_CACHE; i++)
+		WRITE_ONCE(dst->classes[i], READ_ONCE(src->classes[i]));
+}
+
+void dept_map_init(struct dept_map *m, struct dept_key *k, int sub,
+		   const char *n, enum dept_type t)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	if (k && sub >= 0 && sub < DEPT_MAX_SUBCLASSES_USR) {
+		m->keys = k;
+		copy_dept_key(&m->keys_local, k);
+		m->sub_usr = sub;
+	} else {
+		m->keys = NULL;
+		DEPT_WARN_ON(sub < 0 || sub >= DEPT_MAX_SUBCLASSES_USR);
+	}
+
+	m->name = n;
+	m->wgen = 0U;
+	m->type = m->keys ? t : DEPT_TYPE_NO_CHECK;
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_init);
+
+void dept_map_reinit(struct dept_map *m, struct dept_key *k, int sub,
+		     const char *n)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	if (k && k != m->keys) {
+		m->keys = k;
+		copy_dept_key(&m->keys_local, k);
+	}
+
+	if (sub >= 0 && sub < DEPT_MAX_SUBCLASSES_USR)
+		m->sub_usr = sub;
+
+	if (n)
+		m->name = n;
+
+	m->wgen = 0;
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_reinit);
+
+void dept_map_nocheck(struct dept_map *m)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+	m->type = DEPT_TYPE_NO_CHECK;
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_map_nocheck);
+
+static LIST_HEAD(classes);
+
+static inline bool within(const void *addr, void *start, unsigned long size)
+{
+	return addr >= start && addr < start + size;
+}
+
+void dept_free_range(void *start, unsigned int sz)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_class *c, *n;
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * dept_free_range() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_free_range() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()));
+
+	list_for_each_entry_safe(c, n, &classes, all_node) {
+		if (!within((void *)c->key, start, sz) &&
+		    !within(c->name, start, sz))
+			continue;
+
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		invalidate_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+	dept_unlock();
+	dept_exit(flags);
+
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
+}
+
+static inline struct dept_key *map_key(struct dept_map *m)
+{
+	if (likely(m->keys))
+		return m->keys;
+
+	/*
+	 * Use the embedded struct dept_key instance as key in case no
+	 * key has been assigned yet e.g. statically defined lock.
+	 */
+	if (m->type != DEPT_TYPE_NO_CHECK)
+		m->keys = &m->keys_local;
+
+	return m->keys;
+}
+
+static inline int subevent_nr(enum dept_type t)
+{
+	if (t == DEPT_TYPE_RW)
+		return 2;
+	else
+		return 1;
+}
+
+static inline int map_sub(struct dept_map *m, int e)
+{
+	/*
+	 * Make the best use of >dept_key.classes caching.
+	 */
+	if (subevent_nr(m->type) > 1)
+		return m->sub_usr * DEPT_MAX_SUBCLASSES_EVT + e;
+	else
+		return m->sub_usr + e * DEPT_MAX_SUBCLASSES_USR;
+}
+
+static struct dept_class *check_new_class(struct dept_key *local,
+					  struct dept_key *k, int sub,
+					  const char *n)
+{
+	struct dept_class *c = NULL;
+
+	if (DEPT_WARN_ON(sub >= DEPT_MAX_SUBCLASSES))
+		return NULL;
+
+	if (DEPT_WARN_ON(!k))
+		return NULL;
+
+	if (sub < DEPT_MAX_SUBCLASSES_CACHE)
+		c = READ_ONCE(local->classes[sub]);
+
+	if (c)
+		return c;
+
+	if (sub < DEPT_MAX_SUBCLASSES_CACHE)
+		c = READ_ONCE(k->classes[sub]);
+
+	if (c)
+		goto caching;
+
+	c = class((unsigned long)k->subkeys + sub);
+	if (c)
+		goto caching;
+
+	if (unlikely(!dept_lock()))
+		return NULL;
+
+	c = class((unsigned long)k->subkeys + sub);
+	if (unlikely(c))
+		goto unlock;
+
+	c = new_class();
+	if (unlikely(!c))
+		goto unlock;
+
+	c->name = n;
+	c->sub = sub;
+	c->key = (unsigned long)(k->subkeys + sub);
+	hash_add_class(c);
+	list_add(&c->all_node, &classes);
+
+	if (sub < DEPT_MAX_SUBCLASSES_CACHE)
+		WRITE_ONCE(k->classes[sub], c);
+unlock:
+	dept_unlock();
+caching:
+	if (local != k && sub < DEPT_MAX_SUBCLASSES_CACHE && c)
+		WRITE_ONCE(local->classes[sub], c);
+
+	return c;
+}
+
+void dept_wait(struct dept_map *m, unsigned long w_f, unsigned long ip,
+	       const char *w_fn, int ne)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int e;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (m->type == DEPT_TYPE_NO_CHECK)
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * Be as conservative as possible. In case of mulitple waits for
+	 * a single dept_map, we are going to keep only the last wait's
+	 * wgen for simplicity - keeping all wgens seems overengineering.
+	 *
+	 * Of course, it might cause missing some dependencies that
+	 * would rarely, probabily never, happen but it helps avoid
+	 * false positive report.
+	 */
+	for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+
+		c = check_new_class(&m->keys_local, map_key(m),
+				    map_sub(m, e), m->name);
+		if (!c)
+			continue;
+
+		WRITE_ONCE(m->wgen, add_wait(c, ip, w_fn, ne));
+	}
+
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_wait);
+
+void dept_wait_ecxt_enter(struct dept_map *m, unsigned long w_f,
+			  unsigned long e_f, unsigned long ip,
+			  const char *w_fn, const char *c_fn, const char *e_fn,
+			  int ne)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int e;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (m->type == DEPT_TYPE_NO_CHECK)
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * Be as conservative as possible. In case of mulitple waits for
+	 * a single dept_map, we are going to keep only the last wait's
+	 * wgen for simplicity - keeping all wgens seems overengineering.
+	 *
+	 * Of course, it might cause missing some dependencies that
+	 * would rarely, probabily never, happen but it helps avoid
+	 * false positive report.
+	 */
+	for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+
+		c = check_new_class(&m->keys_local, map_key(m),
+				    map_sub(m, e), m->name);
+		if (!c)
+			continue;
+
+		WRITE_ONCE(m->wgen, add_wait(c, ip, w_fn, ne));
+	}
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+
+		c = check_new_class(&m->keys_local, map_key(m),
+				    map_sub(m, e), m->name);
+		if (!c)
+			continue;
+
+		add_ecxt(m, c, true, ip, c_fn, e_fn, ne);
+	}
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_wait_ecxt_enter);
+
+void dept_ecxt_enter(struct dept_map *m, unsigned long e_f, unsigned long ip,
+		     const char *c_fn, const char *e_fn, int ne)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int e;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (m->type == DEPT_TYPE_NO_CHECK)
+		return;
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+
+		c = check_new_class(&m->keys_local, map_key(m),
+				    map_sub(m, e), m->name);
+		if (!c)
+			continue;
+
+		add_ecxt(m, c, false, ip, c_fn, e_fn, ne);
+	}
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_enter);
+
+void dept_event(struct dept_map *m, unsigned long e_f, unsigned long ip,
+		const char *e_fn)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int e;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (m->type == DEPT_TYPE_NO_CHECK)
+		return;
+
+	flags = dept_enter();
+
+	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
+		struct dept_class *c;
+
+		c = check_new_class(&m->keys_local, map_key(m),
+				    map_sub(m, e), m->name);
+		if (!c)
+			continue;
+
+		add_ecxt(m, c, false, 0UL, NULL, e_fn, 0);
+		do_event(m, c, READ_ONCE(m->wgen), ip);
+		pop_ecxt(m);
+	}
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_event);
+
+void dept_ecxt_exit(struct dept_map *m, unsigned long ip)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	if (m->type == DEPT_TYPE_NO_CHECK)
+		return;
+
+	flags = dept_enter();
+	pop_ecxt(m);
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_ecxt_exit);
+
+struct dept_map *dept_top_map(void)
+{
+	struct dept_task *dt = dept_task();
+	struct dept_map *m;
+	unsigned long flags;
+	int pos;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return NULL;
+
+	flags = dept_enter();
+	pos = dt->ecxt_held_pos;
+	m = pos ? (struct dept_map *)dt->ecxt_held[pos - 1].key : NULL;
+	dept_exit(flags);
+
+	return m;
+}
+EXPORT_SYMBOL_GPL(dept_top_map);
+
+void dept_task_exit(struct task_struct *t)
+{
+	struct dept_task *dt = &t->dept_task;
+	int i;
+
+	raw_local_irq_disable();
+
+	if (dt->stack)
+		put_stack(dt->stack);
+
+	for (i = 0; i < dt->ecxt_held_pos; i++)
+		put_ecxt(dt->ecxt_held[i].ecxt);
+
+	for (i = 0; i < DEPT_MAX_WAIT_HIST; i++)
+		if (dt->wait_hist[i].wait)
+			put_wait(dt->wait_hist[i].wait);
+
+	dept_off();
+
+	raw_local_irq_enable();
+}
+
+void dept_task_init(struct task_struct *t)
+{
+	memset(&t->dept_task, 0x0, sizeof(struct dept_task));
+}
+
+void dept_key_init(struct dept_key *k)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int sub;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * dept_key_init() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_key_init() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()));
+
+	for (sub = 0; sub < DEPT_MAX_SUBCLASSES; sub++) {
+		struct dept_class *c;
+
+		c = class((unsigned long)k->subkeys + sub);
+		if (!c)
+			continue;
+
+		DEPT_STOP("The class(%s/%d) has not been removed.\n",
+			  c->name, sub);
+		break;
+	}
+
+	clean_dept_key(k);
+	dept_unlock();
+	dept_exit(flags);
+}
+EXPORT_SYMBOL_GPL(dept_key_init);
+
+void dept_key_destroy(struct dept_key *k)
+{
+	struct dept_task *dt = dept_task();
+	unsigned long flags;
+	int sub;
+
+	if (READ_ONCE(dept_stop) || dt->recursive)
+		return;
+
+	flags = dept_enter();
+
+	/*
+	 * dept_key_destroy() should not fail.
+	 *
+	 * FIXME: Should be fixed if dept_key_destroy() causes deadlock
+	 * with dept_lock().
+	 */
+	while (unlikely(!dept_lock()));
+
+	for (sub = 0; sub < DEPT_MAX_SUBCLASSES; sub++) {
+		struct dept_class *c;
+
+		c = class((unsigned long)k->subkeys + sub);
+		if (!c)
+			continue;
+
+		hash_del_class(c);
+		disconnect_class(c);
+		list_del(&c->all_node);
+		invalidate_class(c);
+
+		/*
+		 * Actual deletion will happen on the rcu callback
+		 * that has been added in disconnect_class().
+		 */
+		del_class(c);
+	}
+
+	dept_unlock();
+	dept_exit(flags);
+
+	/*
+	 * Wait until even lockless hash_lookup_class() for the class
+	 * returns NULL.
+	 */
+	might_sleep();
+	synchronize_rcu();
+}
+EXPORT_SYMBOL_GPL(dept_key_destroy);
+
+static void move_llist(struct llist_head *to, struct llist_head *from)
+{
+	struct llist_node *first = llist_del_all(from);
+	struct llist_node *last;
+
+	if (!first)
+		return;
+
+	for (last = first; last->next; last = last->next);
+	llist_add_batch(first, last, to);
+}
+
+static void migrate_per_cpu_pool(void)
+{
+	const int boot_cpu = 0;
+	int i;
+
+	/*
+	 * The boot CPU has been using the temperal local pool so far.
+	 * From now on that per_cpu areas have been ready, use the
+	 * per_cpu local pool instead.
+	 */
+	DEPT_WARN_ON(smp_processor_id() != boot_cpu);
+	for (i = 0; i < OBJECT_NR; i++) {
+		struct llist_head *from;
+		struct llist_head *to;
+
+		from = &pool[i].boot_pool;
+		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
+		move_llist(to, from);
+	}
+}
+
+#define B2KB(B) ((B) / 1024)
+
+/*
+ * Should be called after setup_per_cpu_areas() and before no non-boot
+ * CPUs have been on.
+ */
+void __init dept_init(void)
+{
+	size_t mem_total = 0;
+
+	local_irq_disable();
+	dept_per_cpu_ready = 1;
+	migrate_per_cpu_pool();
+	local_irq_enable();
+
+#define OBJECT(id, nr) mem_total += sizeof(struct dept_##id) * nr;
+	#include "dept_object.h"
+#undef  OBJECT
+#define HASH(id, bits) mem_total += sizeof(struct hlist_head) * (1UL << bits);
+	#include "dept_hash.h"
+#undef  HASH
+
+	printk("DEPendency Tracker: Copyright (c) 2020 LG Electronics, Inc., Byungchul Park\n");
+	printk("... DEPT_MAX_STACK_ENTRY: %d\n", DEPT_MAX_STACK_ENTRY);
+	printk("... DEPT_MAX_WAIT_HIST  : %d\n", DEPT_MAX_WAIT_HIST  );
+	printk("... DEPT_MAX_ECXT_HELD  : %d\n", DEPT_MAX_ECXT_HELD  );
+	printk("... DEPT_MAX_SUBCLASSES : %d\n", DEPT_MAX_SUBCLASSES );
+#define OBJECT(id, nr)							\
+	printk("... memory used by %s: %zu KB\n",			\
+	       #id, B2KB(sizeof(struct dept_##id) * nr));
+	#include "dept_object.h"
+#undef  OBJECT
+#define HASH(id, bits)							\
+	printk("... hash list head used by %s: %zu KB\n",		\
+	       #id, B2KB(sizeof(struct hlist_head) * (1UL << bits)));
+	#include "dept_hash.h"
+#undef  HASH
+	printk("... total memory used by objects and hashs: %zu KB\n", B2KB(mem_total));
+	printk("... per task memory footprint: %zu bytes\n", sizeof(struct dept_task));
+}
diff --git a/kernel/dependency/dept_hash.h b/kernel/dependency/dept_hash.h
new file mode 100644
index 0000000..7c3bea0
--- /dev/null
+++ b/kernel/dependency/dept_hash.h
@@ -0,0 +1,9 @@
+/*
+ * HASH(id, bits)
+ *
+ * id  : Id for the object of struct dept_##id.
+ * bits: 1UL << bits is the hash table size.
+ */
+
+HASH(dep	, 12)
+HASH(class	, 12)
diff --git a/kernel/dependency/dept_object.h b/kernel/dependency/dept_object.h
new file mode 100644
index 0000000..a204f14
--- /dev/null
+++ b/kernel/dependency/dept_object.h
@@ -0,0 +1,12 @@
+/*
+ * OBJECT(id, nr)
+ *
+ * id: Id for the object of struct dept_##id.
+ * nr: # of the object that should be kept in the pool.
+ */
+
+OBJECT(dep	,1024 * 4)
+OBJECT(class	,1024 * 4)
+OBJECT(stack	,1024 * 16)
+OBJECT(ecxt	,1024 * 4)
+OBJECT(wait	,1024 * 8)
diff --git a/kernel/exit.c b/kernel/exit.c
index 733e80f..e11f154 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -854,6 +854,7 @@ void __noreturn do_exit(long code)
 	exit_tasks_rcu_finish();
 
 	lockdep_free_task(tsk);
+	dept_task_exit(tsk);
 	do_task_dead();
 }
 EXPORT_SYMBOL_GPL(do_exit);
diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360..9d00042 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -95,6 +95,7 @@
 #include <linux/stackleak.h>
 #include <linux/kasan.h>
 #include <linux/scs.h>
+#include <linux/dept.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2027,6 +2028,7 @@ static __latent_entropy struct task_struct *copy_process(
 #ifdef CONFIG_LOCKDEP
 	lockdep_init_task(p);
 #endif
+	dept_task_init(p);
 
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
diff --git a/kernel/module.c b/kernel/module.c
index 1c5cff3..4dc6350 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2253,6 +2253,7 @@ static void free_module(struct module *mod)
 
 	/* Free lock-classes; relies on the preceding sync_rcu(). */
 	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	dept_free_range(mod->core_layout.base, mod->core_layout.size);
 
 	/* Finally, free the core (containing the module structure) */
 	module_memfree(mod->core_layout.base);
@@ -4004,6 +4005,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
  free_module:
 	/* Free lock-classes; relies on the preceding sync_rcu() */
 	lockdep_free_key_range(mod->core_layout.base, mod->core_layout.size);
+	dept_free_range(mod->core_layout.base, mod->core_layout.size);
 
 	module_deallocate(mod, info);
  free_copy:
diff --git a/kernel/softirq.c b/kernel/softirq.c
index bf88d7f6..42d1f51 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -132,7 +132,7 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 	 * Were softirqs turned off above:
 	 */
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		lockdep_softirqs_off(ip);
+		trace_softirqs_off_caller(ip);
 	raw_local_irq_restore(flags);
 
 	if (preempt_count() == cnt) {
@@ -153,7 +153,7 @@ static void __local_bh_enable(unsigned int cnt)
 		trace_preempt_on(CALLER_ADDR0, get_lock_parent_ip());
 
 	if (softirq_count() == (cnt & SOFTIRQ_MASK))
-		lockdep_softirqs_on(_RET_IP_);
+		trace_softirqs_on_caller(_RET_IP_);
 
 	__preempt_count_sub(cnt);
 }
@@ -180,7 +180,7 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	 * Are softirqs going to be turned on now:
 	 */
 	if (softirq_count() == SOFTIRQ_DISABLE_OFFSET)
-		lockdep_softirqs_on(ip);
+		trace_softirqs_on_caller(ip);
 	/*
 	 * Keep preemption disabled until we are done with
 	 * softirq processing:
diff --git a/kernel/trace/trace_preemptirq.c b/kernel/trace/trace_preemptirq.c
index f493804..19cafdfb 100644
--- a/kernel/trace/trace_preemptirq.c
+++ b/kernel/trace/trace_preemptirq.c
@@ -19,6 +19,18 @@
 /* Per-cpu variable to prevent redundant calls when IRQs already off */
 static DEFINE_PER_CPU(int, tracing_irq_cpu);
 
+void trace_softirqs_on_caller(unsigned long ip)
+{
+	lockdep_softirqs_on(ip);
+	dept_enable_softirq(ip);
+}
+
+void trace_softirqs_off_caller(unsigned long ip)
+{
+	lockdep_softirqs_off(ip);
+	dept_disable_softirq(ip);
+}
+
 /*
  * Like trace_hardirqs_on() but without the lockdep invocation. This is
  * used in the low level entry code where the ordering vs. RCU is important
@@ -33,6 +45,7 @@ void trace_hardirqs_on_prepare(void)
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
+	dept_enable_hardirq(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_on_prepare);
 NOKPROBE_SYMBOL(trace_hardirqs_on_prepare);
@@ -45,6 +58,7 @@ void trace_hardirqs_on(void)
 		tracer_hardirqs_on(CALLER_ADDR0, CALLER_ADDR1);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
+	dept_enable_hardirq(CALLER_ADDR0);
 
 	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	lockdep_hardirqs_on(CALLER_ADDR0);
@@ -66,7 +80,7 @@ void trace_hardirqs_off_finish(void)
 		if (!in_nmi())
 			trace_irq_disable(CALLER_ADDR0, CALLER_ADDR1);
 	}
-
+	dept_disable_hardirq(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_finish);
 NOKPROBE_SYMBOL(trace_hardirqs_off_finish);
@@ -81,6 +95,7 @@ void trace_hardirqs_off(void)
 		if (!in_nmi())
 			trace_irq_disable_rcuidle(CALLER_ADDR0, CALLER_ADDR1);
 	}
+	dept_disable_hardirq(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off);
 NOKPROBE_SYMBOL(trace_hardirqs_off);
@@ -93,6 +108,7 @@ __visible void trace_hardirqs_on_caller(unsigned long caller_addr)
 		tracer_hardirqs_on(CALLER_ADDR0, caller_addr);
 		this_cpu_write(tracing_irq_cpu, 0);
 	}
+	dept_enable_hardirq(CALLER_ADDR0);
 
 	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 	lockdep_hardirqs_on(CALLER_ADDR0);
@@ -110,6 +126,7 @@ __visible void trace_hardirqs_off_caller(unsigned long caller_addr)
 		if (!in_nmi())
 			trace_irq_disable_rcuidle(CALLER_ADDR0, caller_addr);
 	}
+	dept_disable_hardirq(CALLER_ADDR0);
 }
 EXPORT_SYMBOL(trace_hardirqs_off_caller);
 NOKPROBE_SYMBOL(trace_hardirqs_off_caller);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0c781f9..0c757e8 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1146,6 +1146,21 @@ config DEBUG_PREEMPT
 
 menu "Lock Debugging (spinlocks, mutexes, etc...)"
 
+config DEPT
+	bool "Dependency tracking"
+	depends on DEBUG_KERNEL
+	select DEBUG_LOCK_ALLOC
+	select TRACE_IRQFLAGS
+	select STACKTRACE
+	select FRAME_POINTER if !MIPS && !PPC && !ARM && !S390 && !MICROBLAZE && !ARC && !X86
+	select KALLSYMS
+	select KALLSYMS_ALL
+	default n
+	help
+	  Check dependencies between wait and event and report it if
+	  deadlock possibility has been detected. Multiple reports are
+	  allowed if there are more than a single problem.
+
 config LOCK_DEBUGGING_SUPPORT
 	bool
 	depends on TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
1.9.1


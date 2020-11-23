Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC4B2C04B2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgKWLiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:10 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:53424 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728864AbgKWLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:09 -0500
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
Subject: [RFC 2/6] dept: Apply Dept to spinlock
Date:   Mon, 23 Nov 2020 20:36:28 +0900
Message-Id: <1606131392-22645-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
References: <20201123110527.GB9464@X58A-UD3R>
 <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by spinlock.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/dept.h             |  4 +++-
 include/linux/llist.h            |  9 +--------
 include/linux/spinlock.h         | 42 ++++++++++++++++++++++++++++++++++++----
 include/linux/spinlock_api_smp.h | 15 ++++++++++++--
 include/linux/spinlock_types.h   | 37 ++++++++++++++++++++++++++++++-----
 include/linux/types.h            |  8 ++++++++
 kernel/locking/spinlock.c        |  6 +++++-
 kernel/locking/spinlock_debug.c  |  4 +++-
 kernel/sched/core.c              |  2 ++
 9 files changed, 105 insertions(+), 22 deletions(-)

diff --git a/include/linux/dept.h b/include/linux/dept.h
index 7fe1e04..baf3519 100644
--- a/include/linux/dept.h
+++ b/include/linux/dept.h
@@ -14,7 +14,9 @@
 #ifdef CONFIG_DEPT
 
 #include <linux/list.h>
-#include <linux/llist.h>
+#include <linux/types.h>
+
+struct task_struct;
 
 #define DEPT_MAX_STACK_ENTRY		16
 #define DEPT_MAX_WAIT_HIST		16
diff --git a/include/linux/llist.h b/include/linux/llist.h
index 2e9c721..e0c88d5 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -50,14 +50,7 @@
 
 #include <linux/atomic.h>
 #include <linux/kernel.h>
-
-struct llist_head {
-	struct llist_node *first;
-};
-
-struct llist_node {
-	struct llist_node *next;
-};
+#include <linux/types.h>
 
 #define LLIST_HEAD_INIT(name)	{ NULL }
 #define LLIST_HEAD(name)	struct llist_head name = LLIST_HEAD_INIT(name)
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index f2f12d7..4c5c76e 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -92,15 +92,47 @@
 # include <linux/spinlock_up.h>
 #endif
 
+#ifdef CONFIG_DEPT
+#define dept_spin_init(m, k, s, n)		dept_map_init(m, k, s, n, DEPT_TYPE_SPIN)
+#define dept_spin_reinit(m, k, s, n)		dept_map_reinit(m, k, s, n)
+#define dept_spin_nocheck(m)			dept_map_nocheck(m)
+#define dept_spin_lock(m, e_fn, ip)		dept_wait_ecxt_enter(m, 1UL, 1UL, ip, __func__, __func__, e_fn, 0)
+#define dept_spin_lock_nest(m, n_m, ip)		WARN_ON(dept_top_map() != (n_m))
+#define dept_spin_lock_nested(m, ne, e_fn, ip)	dept_wait_ecxt_enter(m, 1UL, 1UL, ip, __func__, __func__, e_fn, ne)
+#define dept_spin_trylock(m, e_fn, ip)		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, 0)
+#define dept_spin_unlock(m, ip)			dept_ecxt_exit(m, ip)
+#define dept_spin_enter(m, e_fn, ip)		dept_ecxt_enter(m, 1UL, ip, "spin_lock_enter", e_fn, 0)
+#define dept_spin_exit(m, ip)			dept_ecxt_exit(m, ip)
+#define dept_spin_switch_nested(m, ne, ip)				\
+	do {								\
+		dept_ecxt_exit(m, ip);					\
+		dept_ecxt_enter(m, 1UL, ip, __func__, "spin_switch_nested", ne);\
+	} while (0)
+#else
+#define dept_spin_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_spin_reinit(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_spin_nocheck(m)			do { } while (0)
+#define dept_spin_lock(m, e_fn, ip)		do { } while (0)
+#define dept_spin_lock_nest(m, n_m, ip)		do { } while (0)
+#define dept_spin_lock_nested(m, ne, e_fn, ip)	do { } while (0)
+#define dept_spin_trylock(m, e_fn, ip)		do { } while (0)
+#define dept_spin_unlock(m, ip)			do { } while (0)
+#define dept_spin_enter(m, e_fn, ip)		do { } while (0)
+#define dept_spin_exit(m, ip)			do { } while (0)
+#define dept_spin_switch_nested(m, ne, ip)	do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
-				   struct lock_class_key *key, short inner);
+				   struct lock_class_key *key,
+				   struct dept_key *dkey, short inner);
 
 # define raw_spin_lock_init(lock)					\
 do {									\
 	static struct lock_class_key __key;				\
+	static struct dept_key __dkey;					\
 									\
-	__raw_spin_lock_init((lock), #lock, &__key, LD_WAIT_SPIN);	\
+	__raw_spin_lock_init((lock), #lock, &__key, &__dkey, LD_WAIT_SPIN); \
 } while (0)
 
 #else
@@ -231,7 +263,8 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 # define raw_spin_lock_nest_lock(lock, nest_lock)			\
 	 do {								\
 		 typecheck(struct lockdep_map *, &(nest_lock)->dep_map);\
-		 _raw_spin_lock_nest_lock(lock, &(nest_lock)->dep_map);	\
+		 typecheck(struct dept_map *, &(nest_lock)->dmap);	\
+		 _raw_spin_lock_nest_lock(lock, &(nest_lock)->dep_map, &(nest_lock)->dmap); \
 	 } while (0)
 #else
 /*
@@ -334,9 +367,10 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
 # define spin_lock_init(lock)					\
 do {								\
 	static struct lock_class_key __key;			\
+	static struct dept_key __dkey;				\
 								\
 	__raw_spin_lock_init(spinlock_check(lock),		\
-			     #lock, &__key, LD_WAIT_CONFIG);	\
+			     #lock, &__key, &__dkey, LD_WAIT_CONFIG); \
 } while (0)
 
 #else
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 19a9be9..56afa5a 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -23,8 +23,8 @@
 void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
 								__acquires(lock);
 void __lockfunc
-_raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
-								__acquires(lock);
+_raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map,
+		struct dept_map *dmap)				__acquires(lock);
 void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 								__acquires(lock);
@@ -88,6 +88,7 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 	preempt_disable();
 	if (do_raw_spin_trylock(lock)) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		dept_spin_trylock(&lock->dmap, "__raw_spin_unlock", _RET_IP_);
 		return 1;
 	}
 	preempt_enable();
@@ -108,6 +109,8 @@ static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
 	local_irq_save(flags);
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_spin_lock(&lock->dmap, "__raw_spin_unlock_irqrestore", _RET_IP_);
+
 	/*
 	 * On lockdep we dont want the hand-coded irq-enable of
 	 * do_raw_spin_lock_flags() code, because lockdep assumes
@@ -126,6 +129,7 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 	local_irq_disable();
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_spin_lock(&lock->dmap, "__raw_spin_unlock_irq", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
@@ -133,6 +137,7 @@ static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_spin_lock(&lock->dmap, "__raw_spin_unlock_bh", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
@@ -140,6 +145,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
 	preempt_disable();
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_spin_lock(&lock->dmap, "__raw_spin_unlock", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
@@ -148,6 +154,7 @@ static inline void __raw_spin_lock(raw_spinlock_t *lock)
 static inline void __raw_spin_unlock(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
+	dept_spin_unlock(&lock->dmap, _RET_IP_);
 	do_raw_spin_unlock(lock);
 	preempt_enable();
 }
@@ -156,6 +163,7 @@ static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 					    unsigned long flags)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
+	dept_spin_unlock(&lock->dmap, _RET_IP_);
 	do_raw_spin_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -164,6 +172,7 @@ static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
 static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
+	dept_spin_unlock(&lock->dmap, _RET_IP_);
 	do_raw_spin_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -172,6 +181,7 @@ static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
+	dept_spin_unlock(&lock->dmap, _RET_IP_);
 	do_raw_spin_unlock(lock);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
@@ -181,6 +191,7 @@ static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	if (do_raw_spin_trylock(lock)) {
 		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		dept_spin_trylock(&lock->dmap, "__raw_spin_unlock_bh", _RET_IP_);
 		return 1;
 	}
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
diff --git a/include/linux/spinlock_types.h b/include/linux/spinlock_types.h
index b981caa..f180d71 100644
--- a/include/linux/spinlock_types.h
+++ b/include/linux/spinlock_types.h
@@ -16,6 +16,7 @@
 #endif
 
 #include <linux/lockdep_types.h>
+#include <linux/dept.h>
 
 typedef struct raw_spinlock {
 	arch_spinlock_t raw_lock;
@@ -26,6 +27,7 @@
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
+	struct dept_map dmap;
 } raw_spinlock_t;
 
 #define SPINLOCK_MAGIC		0xdead4ead
@@ -37,17 +39,33 @@
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_SPIN,	\
-	}
+	},
 # define SPIN_DEP_MAP_INIT(lockname)			\
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
-	}
+	},
 #else
 # define RAW_SPIN_DEP_MAP_INIT(lockname)
 # define SPIN_DEP_MAP_INIT(lockname)
 #endif
 
+#ifdef CONFIG_DEPT
+# define RAW_SPIN_DMAP_INIT(lockname)			\
+	.dmap = {					\
+		.name = #lockname,			\
+		.type = DEPT_TYPE_SPIN,			\
+	},
+# define SPIN_DMAP_INIT(lockname)			\
+	.dmap = {					\
+		.name = #lockname,			\
+		.type = DEPT_TYPE_SPIN,			\
+	},
+#else
+# define RAW_SPIN_DMAP_INIT(lockname)
+# define SPIN_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
 # define SPIN_DEBUG_INIT(lockname)		\
 	.magic = SPINLOCK_MAGIC,		\
@@ -61,7 +79,8 @@
 	{					\
 	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
 	SPIN_DEBUG_INIT(lockname)		\
-	RAW_SPIN_DEP_MAP_INIT(lockname) }
+	RAW_SPIN_DEP_MAP_INIT(lockname)		\
+	RAW_SPIN_DMAP_INIT(lockname) }
 
 #define __RAW_SPIN_LOCK_UNLOCKED(lockname)	\
 	(raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
@@ -73,11 +92,18 @@
 		struct raw_spinlock rlock;
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-# define LOCK_PADSIZE (offsetof(struct raw_spinlock, dep_map))
+#define LOCK_PADSIZE (offsetof(struct raw_spinlock, dep_map))
 		struct {
 			u8 __padding[LOCK_PADSIZE];
 			struct lockdep_map dep_map;
 		};
+#undef LOCK_PADSIZE
+#define LOCK_PADSIZE (offsetof(struct raw_spinlock, dmap))
+		struct {
+			u8 __padding_for_dept[LOCK_PADSIZE];
+			struct dept_map dmap;
+		};
+#undef LOCK_PADSIZE
 #endif
 	};
 } spinlock_t;
@@ -86,7 +112,8 @@
 	{					\
 	.raw_lock = __ARCH_SPIN_LOCK_UNLOCKED,	\
 	SPIN_DEBUG_INIT(lockname)		\
-	SPIN_DEP_MAP_INIT(lockname) }
+	SPIN_DEP_MAP_INIT(lockname)		\
+	SPIN_DMAP_INIT(lockname) }
 
 #define __SPIN_LOCK_INITIALIZER(lockname) \
 	{ { .rlock = ___SPIN_LOCK_INITIALIZER(lockname) } }
diff --git a/include/linux/types.h b/include/linux/types.h
index a147977..0b058f5 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -187,6 +187,14 @@ struct hlist_node {
 	struct hlist_node *next, **pprev;
 };
 
+struct llist_head {
+	struct llist_node *first;
+};
+
+struct llist_node {
+	struct llist_node *next;
+};
+
 struct ustat {
 	__kernel_daddr_t	f_tfree;
 	__kernel_ino_t		f_tinode;
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index 0ff0838..e838e0e 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -359,6 +359,7 @@ void __lockfunc _raw_spin_lock_nested(raw_spinlock_t *lock, int subclass)
 {
 	preempt_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	dept_spin_lock_nested(&lock->dmap, subclass, "_raw_spin_unlock", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 EXPORT_SYMBOL(_raw_spin_lock_nested);
@@ -371,6 +372,7 @@ unsigned long __lockfunc _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock,
 	local_irq_save(flags);
 	preempt_disable();
 	spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	dept_spin_lock_nested(&lock->dmap, subclass, "_raw_spin_unlock_irqrestore", _RET_IP_);
 	LOCK_CONTENDED_FLAGS(lock, do_raw_spin_trylock, do_raw_spin_lock,
 				do_raw_spin_lock_flags, &flags);
 	return flags;
@@ -378,10 +380,12 @@ unsigned long __lockfunc _raw_spin_lock_irqsave_nested(raw_spinlock_t *lock,
 EXPORT_SYMBOL(_raw_spin_lock_irqsave_nested);
 
 void __lockfunc _raw_spin_lock_nest_lock(raw_spinlock_t *lock,
-				     struct lockdep_map *nest_lock)
+				     struct lockdep_map *nest_lock,
+				     struct dept_map *nest_dmap)
 {
 	preempt_disable();
 	spin_acquire_nest(&lock->dep_map, 0, 0, nest_lock, _RET_IP_);
+	dept_spin_lock_nest(&lock->dmap, nest_dmap, _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 EXPORT_SYMBOL(_raw_spin_lock_nest_lock);
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index b9d9308..03e6812 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -14,7 +14,8 @@
 #include <linux/export.h>
 
 void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
-			  struct lock_class_key *key, short inner)
+			  struct lock_class_key *key,
+			  struct dept_key *dkey, short inner)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -22,6 +23,7 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map_wait(&lock->dep_map, name, key, 0, inner);
+	dept_spin_init(&lock->dmap, dkey, 0, name);
 #endif
 	lock->raw_lock = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
 	lock->magic = SPINLOCK_MAGIC;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2d95dc3..f11ef3d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3500,6 +3500,7 @@ static inline void finish_task(struct task_struct *prev)
 	 */
 	rq_unpin_lock(rq, rf);
 	spin_release(&rq->lock.dep_map, _THIS_IP_);
+	dept_spin_exit(&rq->lock.dmap, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
 	rq->lock.owner = next;
@@ -3514,6 +3515,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
+	dept_spin_enter(&rq->lock.dmap, "raw_spin_inlock_irq", _THIS_IP_);
 	raw_spin_unlock_irq(&rq->lock);
 }
 
-- 
1.9.1


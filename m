Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD87A28B563
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 15:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbgJLNAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 09:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbgJLNAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 09:00:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0787FC0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 06:00:10 -0700 (PDT)
Date:   Mon, 12 Oct 2020 12:59:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602507608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0RR2LtFlQNkd1SK+jZ1uWQP50s9sge3E1IS8Op4eD3U=;
        b=mKGqUZ4m5MxoLZqeUTKz27pGOenx9kffBNZMe97C/+OWSo8bheYi5iwwqV1VFYq0OvevC+
        fFloQcFMrrF5AgWbyKY01K4T4auAbmIDmFoZL//7kPGVmuw+Otay1cn7/nzHl4Sin/vne9
        Wg9elNnBDNrtCScZc2cSGYCoJqYoZ2jvA5dcZtmevAul7LU3oyLidd0DAnggj3BXCL2SC9
        6w8Rniyqi5WbtjcYEq1NlJBH/16zluBScKX/QqT+Ib7bnNDaKluageN1OST7ePNOlBsq6N
        qf5FvzqFuqOumGwFRN6BIsQk69iHZXJN/yBbE8ahyxt/SyFc6UiII2+L9ME4XQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602507608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0RR2LtFlQNkd1SK+jZ1uWQP50s9sge3E1IS8Op4eD3U=;
        b=gW8iASWKn5+8HeQNPFC93ylXN/19lU99Ygm4bEoMGnCIAh/anuGYYpvwucb8G3ICaBVaRu
        K9MC8qd3e7VKJOCA==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] core/debugobjects for 5.10-rc1
Message-ID: <160250758161.26264.880601562259119308.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest core/debugobjects branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-debugobjects-2020-10-12

up to:  88451f2cd3ce: debugobjects: Free per CPU pool after CPU unplug

A small set of updates for debug objects:

 - Make all debug object descriptors constant. There is no reason to have
   them writeable.

 - Free the per CPU object pool after CPU unplug to avoid memory waste.

Thanks,

	tglx

------------------>
Stephen Boyd (2):
      debugobjects: Allow debug_obj_descr to be const
      treewide: Make all debug_obj_descriptors const

Zqiang (1):
      debugobjects: Free per CPU pool after CPU unplug


 drivers/gpu/drm/i915/i915_active.c   |  2 +-
 drivers/gpu/drm/i915/i915_sw_fence.c |  2 +-
 include/linux/cpuhotplug.h           |  1 +
 include/linux/debugobjects.h         | 32 ++++++++++-----------
 kernel/rcu/rcu.h                     |  2 +-
 kernel/rcu/update.c                  |  2 +-
 kernel/time/hrtimer.c                |  4 +--
 kernel/time/timer.c                  |  4 +--
 kernel/workqueue.c                   |  4 +--
 lib/debugobjects.c                   | 55 ++++++++++++++++++++++++++----------
 lib/percpu_counter.c                 |  4 +--
 11 files changed, 69 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index d960d0be5bd2..839bd53df6e9 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -81,7 +81,7 @@ static void *active_debug_hint(void *addr)
 	return (void *)ref->active ?: (void *)ref->retire ?: (void *)ref;
 }
 
-static struct debug_obj_descr active_debug_desc = {
+static const struct debug_obj_descr active_debug_desc = {
 	.name = "i915_active",
 	.debug_hint = active_debug_hint,
 };
diff --git a/drivers/gpu/drm/i915/i915_sw_fence.c b/drivers/gpu/drm/i915/i915_sw_fence.c
index 4cd2038cbe35..038d4c6884c5 100644
--- a/drivers/gpu/drm/i915/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/i915_sw_fence.c
@@ -34,7 +34,7 @@ static void *i915_sw_fence_debug_hint(void *addr)
 
 #ifdef CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS
 
-static struct debug_obj_descr i915_sw_fence_debug_descr = {
+static const struct debug_obj_descr i915_sw_fence_debug_descr = {
 	.name = "i915_sw_fence",
 	.debug_hint = i915_sw_fence_debug_hint,
 };
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index bf9181cef444..6f524bbf71a2 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -36,6 +36,7 @@ enum cpuhp_state {
 	CPUHP_X86_MCE_DEAD,
 	CPUHP_VIRT_NET_DEAD,
 	CPUHP_SLUB_DEAD,
+	CPUHP_DEBUG_OBJ_DEAD,
 	CPUHP_MM_WRITEBACK_DEAD,
 	CPUHP_MM_VMSTAT_DEAD,
 	CPUHP_SOFTIRQ_DEAD,
diff --git a/include/linux/debugobjects.h b/include/linux/debugobjects.h
index afc416e5dcab..8d2dde23e9fb 100644
--- a/include/linux/debugobjects.h
+++ b/include/linux/debugobjects.h
@@ -30,7 +30,7 @@ struct debug_obj {
 	enum debug_obj_state	state;
 	unsigned int		astate;
 	void			*object;
-	struct debug_obj_descr	*descr;
+	const struct debug_obj_descr *descr;
 };
 
 /**
@@ -64,14 +64,14 @@ struct debug_obj_descr {
 };
 
 #ifdef CONFIG_DEBUG_OBJECTS
-extern void debug_object_init      (void *addr, struct debug_obj_descr *descr);
+extern void debug_object_init      (void *addr, const struct debug_obj_descr *descr);
 extern void
-debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr);
-extern int debug_object_activate  (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_deactivate(void *addr, struct debug_obj_descr *descr);
-extern void debug_object_destroy   (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_free      (void *addr, struct debug_obj_descr *descr);
-extern void debug_object_assert_init(void *addr, struct debug_obj_descr *descr);
+debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr);
+extern int debug_object_activate  (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_destroy   (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_free      (void *addr, const struct debug_obj_descr *descr);
+extern void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr);
 
 /*
  * Active state:
@@ -79,26 +79,26 @@ extern void debug_object_assert_init(void *addr, struct debug_obj_descr *descr);
  * - Must return to 0 before deactivation.
  */
 extern void
-debug_object_active_state(void *addr, struct debug_obj_descr *descr,
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next);
 
 extern void debug_objects_early_init(void);
 extern void debug_objects_mem_init(void);
 #else
 static inline void
-debug_object_init      (void *addr, struct debug_obj_descr *descr) { }
+debug_object_init      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr) { }
+debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr) { }
 static inline int
-debug_object_activate  (void *addr, struct debug_obj_descr *descr) { return 0; }
+debug_object_activate  (void *addr, const struct debug_obj_descr *descr) { return 0; }
 static inline void
-debug_object_deactivate(void *addr, struct debug_obj_descr *descr) { }
+debug_object_deactivate(void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_destroy   (void *addr, struct debug_obj_descr *descr) { }
+debug_object_destroy   (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_free      (void *addr, struct debug_obj_descr *descr) { }
+debug_object_free      (void *addr, const struct debug_obj_descr *descr) { }
 static inline void
-debug_object_assert_init(void *addr, struct debug_obj_descr *descr) { }
+debug_object_assert_init(void *addr, const struct debug_obj_descr *descr) { }
 
 static inline void debug_objects_early_init(void) { }
 static inline void debug_objects_mem_init(void) { }
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index cf66a3ccd757..e01cba5e4b52 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -167,7 +167,7 @@ static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
 # define STATE_RCU_HEAD_READY	0
 # define STATE_RCU_HEAD_QUEUED	1
 
-extern struct debug_obj_descr rcuhead_debug_descr;
+extern const struct debug_obj_descr rcuhead_debug_descr;
 
 static inline int debug_rcu_head_queue(struct rcu_head *head)
 {
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index 2de49b5d8dd2..3e0f4bcb558f 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -469,7 +469,7 @@ void destroy_rcu_head_on_stack(struct rcu_head *head)
 }
 EXPORT_SYMBOL_GPL(destroy_rcu_head_on_stack);
 
-struct debug_obj_descr rcuhead_debug_descr = {
+const struct debug_obj_descr rcuhead_debug_descr = {
 	.name = "rcu_head",
 	.is_static_object = rcuhead_is_static_object,
 };
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 95b6a708b040..3624b9b5835d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -342,7 +342,7 @@ EXPORT_SYMBOL_GPL(ktime_add_safe);
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
-static struct debug_obj_descr hrtimer_debug_descr;
+static const struct debug_obj_descr hrtimer_debug_descr;
 
 static void *hrtimer_debug_hint(void *addr)
 {
@@ -401,7 +401,7 @@ static bool hrtimer_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr hrtimer_debug_descr = {
+static const struct debug_obj_descr hrtimer_debug_descr = {
 	.name		= "hrtimer",
 	.debug_hint	= hrtimer_debug_hint,
 	.fixup_init	= hrtimer_fixup_init,
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index a50364df1054..8b17cf28e54b 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -611,7 +611,7 @@ static void internal_add_timer(struct timer_base *base, struct timer_list *timer
 
 #ifdef CONFIG_DEBUG_OBJECTS_TIMERS
 
-static struct debug_obj_descr timer_debug_descr;
+static const struct debug_obj_descr timer_debug_descr;
 
 static void *timer_debug_hint(void *addr)
 {
@@ -707,7 +707,7 @@ static bool timer_fixup_assert_init(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr timer_debug_descr = {
+static const struct debug_obj_descr timer_debug_descr = {
 	.name			= "timer_list",
 	.debug_hint		= timer_debug_hint,
 	.is_static_object	= timer_is_static_object,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c41c3c17b86a..ac088ce6059b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -427,7 +427,7 @@ static void show_pwq(struct pool_workqueue *pwq);
 
 #ifdef CONFIG_DEBUG_OBJECTS_WORK
 
-static struct debug_obj_descr work_debug_descr;
+static const struct debug_obj_descr work_debug_descr;
 
 static void *work_debug_hint(void *addr)
 {
@@ -477,7 +477,7 @@ static bool work_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr work_debug_descr = {
+static const struct debug_obj_descr work_debug_descr = {
 	.name		= "work_struct",
 	.debug_hint	= work_debug_hint,
 	.is_static_object = work_is_static_object,
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index fe4557955d97..9e14ae02306b 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/hash.h>
 #include <linux/kmemleak.h>
+#include <linux/cpu.h>
 
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
@@ -90,7 +91,7 @@ static int			debug_objects_pool_size __read_mostly
 				= ODEBUG_POOL_SIZE;
 static int			debug_objects_pool_min_level __read_mostly
 				= ODEBUG_POOL_MIN_LEVEL;
-static struct debug_obj_descr	*descr_test  __read_mostly;
+static const struct debug_obj_descr *descr_test  __read_mostly;
 static struct kmem_cache	*obj_cache __read_mostly;
 
 /*
@@ -223,7 +224,7 @@ static struct debug_obj *__alloc_object(struct hlist_head *list)
  * Must be called with interrupts disabled.
  */
 static struct debug_obj *
-alloc_object(void *addr, struct debug_bucket *b, struct debug_obj_descr *descr)
+alloc_object(void *addr, struct debug_bucket *b, const struct debug_obj_descr *descr)
 {
 	struct debug_percpu_free *percpu_pool = this_cpu_ptr(&percpu_obj_pool);
 	struct debug_obj *obj;
@@ -433,6 +434,25 @@ static void free_object(struct debug_obj *obj)
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+static int object_cpu_offline(unsigned int cpu)
+{
+	struct debug_percpu_free *percpu_pool;
+	struct hlist_node *tmp;
+	struct debug_obj *obj;
+
+	/* Remote access is safe as the CPU is dead already */
+	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
+	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
+		hlist_del(&obj->node);
+		kmem_cache_free(obj_cache, obj);
+	}
+	percpu_pool->obj_free = 0;
+
+	return 0;
+}
+#endif
+
 /*
  * We run out of memory. That means we probably have tons of objects
  * allocated.
@@ -475,7 +495,7 @@ static struct debug_bucket *get_bucket(unsigned long addr)
 
 static void debug_print_object(struct debug_obj *obj, char *msg)
 {
-	struct debug_obj_descr *descr = obj->descr;
+	const struct debug_obj_descr *descr = obj->descr;
 	static int limit;
 
 	if (limit < 5 && descr != descr_test) {
@@ -529,7 +549,7 @@ static void debug_object_is_on_stack(void *addr, int onstack)
 }
 
 static void
-__debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
+__debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
 {
 	enum debug_obj_state state;
 	bool check_stack = false;
@@ -587,7 +607,7 @@ __debug_object_init(void *addr, struct debug_obj_descr *descr, int onstack)
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_init(void *addr, struct debug_obj_descr *descr)
+void debug_object_init(void *addr, const struct debug_obj_descr *descr)
 {
 	if (!debug_objects_enabled)
 		return;
@@ -602,7 +622,7 @@ EXPORT_SYMBOL_GPL(debug_object_init);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_init_on_stack(void *addr, struct debug_obj_descr *descr)
+void debug_object_init_on_stack(void *addr, const struct debug_obj_descr *descr)
 {
 	if (!debug_objects_enabled)
 		return;
@@ -617,7 +637,7 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
  * @descr:	pointer to an object specific debug description structure
  * Returns 0 for success, -EINVAL for check failed.
  */
-int debug_object_activate(void *addr, struct debug_obj_descr *descr)
+int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -695,7 +715,7 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_deactivate(void *addr, struct debug_obj_descr *descr)
+void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
 	struct debug_obj *obj;
@@ -747,7 +767,7 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_destroy(void *addr, struct debug_obj_descr *descr)
+void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -797,7 +817,7 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_free(void *addr, struct debug_obj_descr *descr)
+void debug_object_free(void *addr, const struct debug_obj_descr *descr)
 {
 	enum debug_obj_state state;
 	struct debug_bucket *db;
@@ -838,7 +858,7 @@ EXPORT_SYMBOL_GPL(debug_object_free);
  * @addr:	address of the object
  * @descr:	pointer to an object specific debug description structure
  */
-void debug_object_assert_init(void *addr, struct debug_obj_descr *descr)
+void debug_object_assert_init(void *addr, const struct debug_obj_descr *descr)
 {
 	struct debug_bucket *db;
 	struct debug_obj *obj;
@@ -886,7 +906,7 @@ EXPORT_SYMBOL_GPL(debug_object_assert_init);
  * @next:	state to move to if expected state is found
  */
 void
-debug_object_active_state(void *addr, struct debug_obj_descr *descr,
+debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
 			  unsigned int expect, unsigned int next)
 {
 	struct debug_bucket *db;
@@ -934,7 +954,7 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
 static void __debug_check_no_obj_freed(const void *address, unsigned long size)
 {
 	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
-	struct debug_obj_descr *descr;
+	const struct debug_obj_descr *descr;
 	enum debug_obj_state state;
 	struct debug_bucket *db;
 	struct hlist_node *tmp;
@@ -1052,7 +1072,7 @@ struct self_test {
 	unsigned long	dummy2[3];
 };
 
-static __initdata struct debug_obj_descr descr_type_test;
+static __initconst const struct debug_obj_descr descr_type_test;
 
 static bool __init is_static_object(void *addr)
 {
@@ -1177,7 +1197,7 @@ check_results(void *addr, enum debug_obj_state state, int fixups, int warnings)
 	return res;
 }
 
-static __initdata struct debug_obj_descr descr_type_test = {
+static __initconst const struct debug_obj_descr descr_type_test = {
 	.name			= "selftest",
 	.is_static_object	= is_static_object,
 	.fixup_init		= fixup_init,
@@ -1367,6 +1387,11 @@ void __init debug_objects_mem_init(void)
 	} else
 		debug_objects_selftest();
 
+#ifdef CONFIG_HOTPLUG_CPU
+	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
+					object_cpu_offline);
+#endif
+
 	/*
 	 * Increase the thresholds for allocating and freeing objects
 	 * according to the number of possible CPUs available in the system.
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index a2345de90e93..f61689a96e85 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -17,7 +17,7 @@ static DEFINE_SPINLOCK(percpu_counters_lock);
 
 #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
 
-static struct debug_obj_descr percpu_counter_debug_descr;
+static const struct debug_obj_descr percpu_counter_debug_descr;
 
 static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
 {
@@ -33,7 +33,7 @@ static bool percpu_counter_fixup_free(void *addr, enum debug_obj_state state)
 	}
 }
 
-static struct debug_obj_descr percpu_counter_debug_descr = {
+static const struct debug_obj_descr percpu_counter_debug_descr = {
 	.name		= "percpu_counter",
 	.fixup_free	= percpu_counter_fixup_free,
 };


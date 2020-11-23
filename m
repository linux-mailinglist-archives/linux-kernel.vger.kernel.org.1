Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB852C04B4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgKWLiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:14 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:54444 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728934AbgKWLiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:12 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 23 Nov 2020 20:38:06 +0900
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
Subject: [RFC 3/6] dept: Apply Dept to mutex families
Date:   Mon, 23 Nov 2020 20:36:29 +0900
Message-Id: <1606131392-22645-3-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
References: <20201123110527.GB9464@X58A-UD3R>
 <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by mutex families.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 drivers/base/bus.c                            |  5 +-
 drivers/base/class.c                          |  5 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.c    |  5 +-
 drivers/gpu/drm/i915/i915_active.c            |  5 +-
 drivers/gpu/drm/i915/intel_wakeref.c          |  5 +-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c    |  5 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  5 +-
 drivers/net/team/team.c                       |  5 +-
 include/linux/mutex.h                         | 45 ++++++++++++--
 include/linux/rtmutex.h                       | 18 ++++--
 include/linux/ww_mutex.h                      | 10 ++-
 kernel/locking/mutex-debug.c                  |  4 +-
 kernel/locking/mutex-debug.h                  |  3 +-
 kernel/locking/mutex.c                        | 88 ++++++++++++++++++++-------
 kernel/locking/mutex.h                        |  2 +-
 kernel/locking/rtmutex-debug.c                |  4 +-
 kernel/locking/rtmutex-debug.h                |  2 +-
 kernel/locking/rtmutex.c                      | 23 +++++--
 kernel/locking/rtmutex.h                      |  2 +-
 lib/locking-selftest.c                        | 12 ++--
 net/netfilter/ipvs/ip_vs_sync.c               |  5 +-
 21 files changed, 200 insertions(+), 58 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 886e905..12288e3 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -845,7 +845,10 @@ int bus_register(struct bus_type *bus)
 	}
 
 	INIT_LIST_HEAD(&priv->interfaces);
-	__mutex_init(&priv->mutex, "subsys mutex", key);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&priv->mutex, "subsys mutex", key, NULL);
 	klist_init(&priv->klist_devices, klist_devices_get, klist_devices_put);
 	klist_init(&priv->klist_drivers, NULL, NULL);
 
diff --git a/drivers/base/class.c b/drivers/base/class.c
index bcd410e..c52ee21a 100644
--- a/drivers/base/class.c
+++ b/drivers/base/class.c
@@ -163,7 +163,10 @@ int __class_register(struct class *cls, struct lock_class_key *key)
 	klist_init(&cp->klist_devices, klist_class_dev_get, klist_class_dev_put);
 	INIT_LIST_HEAD(&cp->interfaces);
 	kset_init(&cp->glue_dirs);
-	__mutex_init(&cp->mutex, "subsys mutex", key);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&cp->mutex, "subsys mutex", key, NULL);
 	error = kobject_set_name(&cp->subsys.kobj, "%s", cls->name);
 	if (error) {
 		kfree(cp);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index c8421fd..0ecde29 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -53,7 +53,10 @@ void i915_gem_object_init(struct drm_i915_gem_object *obj,
 			  const struct drm_i915_gem_object_ops *ops,
 			  struct lock_class_key *key)
 {
-	__mutex_init(&obj->mm.lock, ops->name ?: "obj->mm.lock", key);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&obj->mm.lock, ops->name ?: "obj->mm.lock", key, NULL);
 
 	spin_lock_init(&obj->vma.lock);
 	INIT_LIST_HEAD(&obj->vma.list);
diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index d960d0b..49a6972 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -297,7 +297,10 @@ void __i915_active_init(struct i915_active *ref,
 
 	init_llist_head(&ref->preallocated_barriers);
 	atomic_set(&ref->count, 0);
-	__mutex_init(&ref->mutex, "i915_active", mkey);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&ref->mutex, "i915_active", mkey, NULL);
 	__i915_active_fence_init(&ref->excl, NULL, excl_retire);
 	INIT_WORK(&ref->work, active_work);
 #if IS_ENABLED(CONFIG_LOCKDEP)
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index dfd87d0..1fcbecf 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -101,7 +101,10 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 	wf->rpm = rpm;
 	wf->ops = ops;
 
-	__mutex_init(&wf->mutex, "wakeref.mutex", &key->mutex);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&wf->mutex, "wakeref.mutex", &key->mutex, NULL);
 	atomic_set(&wf->count, 0);
 	wf->wakeref = 0;
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
index 49d468b..f968d62 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/subdev.c
@@ -218,7 +218,10 @@
 	subdev->device = device;
 	subdev->index = index;
 
-	__mutex_init(&subdev->mutex, name, &nvkm_subdev_lock_class[index]);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&subdev->mutex, name, &nvkm_subdev_lock_class[index], NULL);
 	subdev->debug = nvkm_dbgopt(device->dbgopt, name);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
index 710f3f8..f5602c6a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c
@@ -1048,7 +1048,10 @@ struct nvkm_vma *
 	vmm->debug = mmu->subdev.debug;
 	kref_init(&vmm->kref);
 
-	__mutex_init(&vmm->mutex, "&vmm->mutex", key ? key : &_key);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&vmm->mutex, "&vmm->mutex", key ? key : &_key, NULL);
 
 	/* Locate the smallest page size supported by the backend, it will
 	 * have the the deepest nesting of page tables.
diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index bcc4a4c..0292404 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -1646,7 +1646,10 @@ static int team_init(struct net_device *dev)
 	netif_carrier_off(dev);
 
 	lockdep_register_key(&team->team_lock_key);
-	__mutex_init(&team->lock, "team->team_lock_key", &team->team_lock_key);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&team->lock, "team->team_lock_key", &team->team_lock_key, NULL);
 	netdev_lockdep_set_classes(dev);
 
 	return 0;
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index dcd185c..14018db 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -63,6 +63,7 @@ struct mutex {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
+	struct dept_map		dmap;
 };
 
 struct ww_class;
@@ -76,6 +77,26 @@ struct ww_mutex {
 #endif
 };
 
+#ifdef CONFIG_DEPT
+#define dept_mutex_init(m, k, s, n)		dept_map_init(m, k, s, n, DEPT_TYPE_MUTEX)
+#define dept_mutex_reinit(m, k, s, n)		dept_map_reinit(m, k, s, n)
+#define dept_mutex_nocheck(m)			dept_map_nocheck(m)
+#define dept_mutex_lock(m, e_fn, ip)		dept_wait_ecxt_enter(m, 1UL, 1UL, ip, __func__, __func__, e_fn, 0)
+#define dept_mutex_lock_nest(m, n_m, ip)	WARN_ON(dept_top_map() != (n_m))
+#define dept_mutex_lock_nested(m, ne, e_fn, ip)	dept_wait_ecxt_enter(m, 1UL, 1UL, ip, __func__, __func__, e_fn, ne)
+#define dept_mutex_trylock(m, e_fn, ip)		dept_ecxt_enter(m, 1UL, ip, __func__, e_fn, 0)
+#define dept_mutex_unlock(m, ip)		dept_ecxt_exit(m, ip)
+#else
+#define dept_mutex_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_mutex_reinit(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_mutex_nocheck(m)			do { } while (0)
+#define dept_mutex_lock(m, e_fn, ip)		do { } while (0)
+#define dept_mutex_lock_nest(m, n_m, ip)	do { } while (0)
+#define dept_mutex_lock_nested(m, ne, e_fn, ip)	do { } while (0)
+#define dept_mutex_trylock(m, e_fn, ip)		do { } while (0)
+#define dept_mutex_unlock(m, ip)		do { } while (0)
+#endif
+
 /*
  * This is the control structure for tasks blocked on mutex,
  * which resides on the blocked task's kernel stack:
@@ -115,8 +136,9 @@ static inline void mutex_destroy(struct mutex *lock) {}
 #define mutex_init(mutex)						\
 do {									\
 	static struct lock_class_key __key;				\
+	static struct dept_key __dkey;					\
 									\
-	__mutex_init((mutex), #mutex, &__key);				\
+	__mutex_init((mutex), #mutex, &__key, &__dkey);			\
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -129,18 +151,30 @@ static inline void mutex_destroy(struct mutex *lock) {}
 # define __DEP_MAP_MUTEX_INITIALIZER(lockname)
 #endif
 
+#ifdef CONFIG_DEPT
+# define __DMAP_MUTEX_INITIALIZER(lockname)			\
+		, .dmap = {					\
+			.name = #lockname,			\
+			.type = DEPT_TYPE_MUTEX,		\
+		}
+#else
+# define __DMAP_MUTEX_INITIALIZER(lockname)
+#endif
+
 #define __MUTEX_INITIALIZER(lockname) \
 		{ .owner = ATOMIC_LONG_INIT(0) \
 		, .wait_lock = __SPIN_LOCK_UNLOCKED(lockname.wait_lock) \
 		, .wait_list = LIST_HEAD_INIT(lockname.wait_list) \
 		__DEBUG_MUTEX_INITIALIZER(lockname) \
-		__DEP_MAP_MUTEX_INITIALIZER(lockname) }
+		__DEP_MAP_MUTEX_INITIALIZER(lockname) \
+		__DMAP_MUTEX_INITIALIZER(lockname) }
 
 #define DEFINE_MUTEX(mutexname) \
 	struct mutex mutexname = __MUTEX_INITIALIZER(mutexname)
 
 extern void __mutex_init(struct mutex *lock, const char *name,
-			 struct lock_class_key *key);
+			 struct lock_class_key *key,
+			 struct dept_key *dkey);
 
 /**
  * mutex_is_locked - is the mutex locked
@@ -156,7 +190,7 @@ extern void __mutex_init(struct mutex *lock, const char *name,
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
-extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock);
+extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock, struct dept_map *nest_dmap);
 
 extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
 					unsigned int subclass);
@@ -172,7 +206,8 @@ extern int __must_check mutex_lock_killable_nested(struct mutex *lock,
 #define mutex_lock_nest_lock(lock, nest_lock)				\
 do {									\
 	typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
-	_mutex_lock_nest_lock(lock, &(nest_lock)->dep_map);		\
+	typecheck(struct dept_map *, &(nest_lock)->dmap);	\
+	_mutex_lock_nest_lock(lock, &(nest_lock)->dep_map, &(nest_lock)->dmap); \
 } while (0)
 
 #else
diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 6fd615a..cb81460 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -40,6 +40,7 @@ struct rt_mutex {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
 #endif
+	struct dept_map		dmap;
 };
 
 struct rt_mutex_waiter;
@@ -65,13 +66,14 @@ struct rt_mutex {
 # define rt_mutex_init(mutex) \
 do { \
 	static struct lock_class_key __key; \
-	__rt_mutex_init(mutex, __func__, &__key); \
+	static struct dept_key __dkey; \
+	__rt_mutex_init(mutex, __func__, &__key, &__dkey); \
 } while (0)
 
  extern void rt_mutex_debug_task_free(struct task_struct *tsk);
 #else
 # define __DEBUG_RT_MUTEX_INITIALIZER(mutexname)
-# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL)
+# define rt_mutex_init(mutex)			__rt_mutex_init(mutex, NULL, NULL, NULL)
 # define rt_mutex_debug_task_free(t)			do { } while (0)
 #endif
 
@@ -82,12 +84,20 @@ struct rt_mutex {
 #define __DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)
 #endif
 
+#ifdef CONFIG_DEPT
+#define __DMAP_RT_MUTEX_INITIALIZER(mutexname) \
+	, .dmap = { .name = #mutexname, .type = DEPT_TYPE_MUTEX }
+#else
+#define __DMAP_RT_MUTEX_INITIALIZER(mutexname)
+#endif
+
 #define __RT_MUTEX_INITIALIZER(mutexname) \
 	{ .wait_lock = __RAW_SPIN_LOCK_UNLOCKED(mutexname.wait_lock) \
 	, .waiters = RB_ROOT_CACHED \
 	, .owner = NULL \
 	__DEBUG_RT_MUTEX_INITIALIZER(mutexname) \
-	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname)}
+	__DEP_MAP_RT_MUTEX_INITIALIZER(mutexname) \
+	__DMAP_RT_MUTEX_INITIALIZER(mutexname) }
 
 #define DEFINE_RT_MUTEX(mutexname) \
 	struct rt_mutex mutexname = __RT_MUTEX_INITIALIZER(mutexname)
@@ -103,7 +113,7 @@ static inline int rt_mutex_is_locked(struct rt_mutex *lock)
 	return lock->owner != NULL;
 }
 
-extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
+extern void __rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key, struct dept_key *dkey);
 extern void rt_mutex_destroy(struct rt_mutex *lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 850424e..8304e49 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -23,6 +23,8 @@ struct ww_class {
 	atomic_long_t stamp;
 	struct lock_class_key acquire_key;
 	struct lock_class_key mutex_key;
+	struct dept_key acquire_dkey;
+	struct dept_key mutex_dkey;
 	const char *acquire_name;
 	const char *mutex_name;
 	unsigned int is_wait_die;
@@ -42,6 +44,7 @@ struct ww_acquire_ctx {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
+	struct dept_map dmap;
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	unsigned int deadlock_inject_interval;
 	unsigned int deadlock_inject_countdown;
@@ -87,7 +90,8 @@ struct ww_acquire_ctx {
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
 {
-	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
+	__mutex_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key,
+			&ww_class->mutex_dkey);
 	lock->ctx = NULL;
 #ifdef CONFIG_DEBUG_MUTEXES
 	lock->ww_class = ww_class;
@@ -136,6 +140,9 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 	lockdep_init_map(&ctx->dep_map, ww_class->acquire_name,
 			 &ww_class->acquire_key, 0);
 	mutex_acquire(&ctx->dep_map, 0, 0, _RET_IP_);
+	dept_mutex_init(&ctx->dmap, &ww_class->acquire_dkey, 0,
+			ww_class->acquire_name);
+	dept_mutex_lock(&ctx->dmap, "ww_acquire_fini", _RET_IP_);
 #endif
 #ifdef CONFIG_DEBUG_WW_MUTEX_SLOWPATH
 	ctx->deadlock_inject_interval = 1;
@@ -175,6 +182,7 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
 {
 #ifdef CONFIG_DEBUG_MUTEXES
 	mutex_release(&ctx->dep_map, _THIS_IP_);
+	dept_mutex_unlock(&ctx->dmap, _THIS_IP_);
 
 	DEBUG_LOCKS_WARN_ON(ctx->acquired);
 	if (!IS_ENABLED(CONFIG_PROVE_LOCKING))
diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index a7276aa..dae269e 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -78,7 +78,8 @@ void debug_mutex_unlock(struct mutex *lock)
 }
 
 void debug_mutex_init(struct mutex *lock, const char *name,
-		      struct lock_class_key *key)
+		      struct lock_class_key *key,
+		      struct dept_key *dkey)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -86,6 +87,7 @@ void debug_mutex_init(struct mutex *lock, const char *name,
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_SLEEP);
+	dept_mutex_init(&lock->dmap, dkey, 0, name);
 #endif
 	lock->magic = lock;
 }
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 1edd3f4..153c680 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -26,4 +26,5 @@ extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
-			     struct lock_class_key *key);
+			     struct lock_class_key *key,
+			     struct dept_key *dkey);
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce5..27f03ad 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -37,7 +37,8 @@
 #endif
 
 void
-__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key)
+__mutex_init(struct mutex *lock, const char *name, struct lock_class_key *key,
+		struct dept_key *dkey)
 {
 	atomic_long_set(&lock->owner, 0);
 	spin_lock_init(&lock->wait_lock);
@@ -46,7 +47,7 @@
 	osq_lock_init(&lock->osq);
 #endif
 
-	debug_mutex_init(lock, name, key);
+	debug_mutex_init(lock, name, key, dkey);
 }
 EXPORT_SYMBOL(__mutex_init);
 
@@ -1098,46 +1099,82 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 
 static int __sched
 __mutex_lock(struct mutex *lock, long state, unsigned int subclass,
-	     struct lockdep_map *nest_lock, unsigned long ip)
+	     struct lockdep_map *nest_lock, struct dept_map *nest_dmap,
+	     unsigned long ip)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
+	int ret;
+
+	/*
+	 * TODO: Wrong dependency between this mutex and inner spinlock
+	 * inside __mutex_lock_common() will be added into Dept. For now,
+	 * let's allow it for simplicity.
+	 */
+	if (nest_dmap)
+		dept_mutex_lock_nest(&lock->dmap, nest_dmap, ip);
+	else
+		dept_mutex_lock_nested(&lock->dmap, subclass, "__mutex_unlock", ip);
+
+	ret = __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
+
+	if (!nest_dmap && ret)
+		dept_mutex_unlock(&lock->dmap, _THIS_IP_);
+
+	return ret;
 }
 
 static int __sched
 __ww_mutex_lock(struct mutex *lock, long state, unsigned int subclass,
-		struct lockdep_map *nest_lock, unsigned long ip,
-		struct ww_acquire_ctx *ww_ctx)
+		struct lockdep_map *nest_lock, struct dept_map *nest_dmap,
+		unsigned long ip, struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, true);
+	int ret;
+
+	/*
+	 * TODO: Wrong dependency between this mutex and inner spinlock
+	 * inside __mutex_lock_common() will be added into Dept. For now,
+	 * let's allow it for simplicity.
+	 */
+	if (nest_dmap)
+		dept_mutex_lock_nest(&lock->dmap, nest_dmap, ip);
+	else
+		dept_mutex_lock_nested(&lock->dmap, subclass, "__mutex_unlock", ip);
+
+	ret = __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, true);
+
+	if (!nest_dmap && ret)
+		dept_mutex_unlock(&lock->dmap, _THIS_IP_);
+
+	return ret;
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 void __sched
 mutex_lock_nested(struct mutex *lock, unsigned int subclass)
 {
-	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, _RET_IP_);
+	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, subclass, NULL, NULL, _RET_IP_);
 }
 
 EXPORT_SYMBOL_GPL(mutex_lock_nested);
 
 void __sched
-_mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest)
+_mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest,
+		struct dept_map *nest_dmap)
 {
-	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, nest, _RET_IP_);
+	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, nest, nest_dmap, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(_mutex_lock_nest_lock);
 
 int __sched
 mutex_lock_killable_nested(struct mutex *lock, unsigned int subclass)
 {
-	return __mutex_lock(lock, TASK_KILLABLE, subclass, NULL, _RET_IP_);
+	return __mutex_lock(lock, TASK_KILLABLE, subclass, NULL, NULL, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
 
 int __sched
 mutex_lock_interruptible_nested(struct mutex *lock, unsigned int subclass)
 {
-	return __mutex_lock(lock, TASK_INTERRUPTIBLE, subclass, NULL, _RET_IP_);
+	return __mutex_lock(lock, TASK_INTERRUPTIBLE, subclass, NULL, NULL, _RET_IP_);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 
@@ -1145,12 +1182,16 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 {
 	int token;
+	int ret;
 
 	might_sleep();
 
 	token = io_schedule_prepare();
-	__mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
+	dept_mutex_lock_nested(&lock->dmap, subclass, "mutex_unlock", _RET_IP_);
+	ret = __mutex_lock_common(lock, TASK_UNINTERRUPTIBLE,
 			    subclass, NULL, _RET_IP_, NULL, 0);
+	if (ret)
+		dept_mutex_unlock(&lock->dmap, _THIS_IP_);
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
@@ -1188,7 +1229,8 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 
 	might_sleep();
 	ret =  __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE,
-			       0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
+			       0, ctx ? &ctx->dep_map : NULL,
+			       ctx ? &ctx->dmap : NULL, _RET_IP_,
 			       ctx);
 	if (!ret && ctx && ctx->acquired > 1)
 		return ww_mutex_deadlock_injection(lock, ctx);
@@ -1204,7 +1246,8 @@ void __sched ww_mutex_unlock(struct ww_mutex *lock)
 
 	might_sleep();
 	ret = __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE,
-			      0, ctx ? &ctx->dep_map : NULL, _RET_IP_,
+			      0, ctx ? &ctx->dep_map : NULL,
+			      ctx ? &ctx->dmap : NULL, _RET_IP_,
 			      ctx);
 
 	if (!ret && ctx && ctx->acquired > 1)
@@ -1226,6 +1269,7 @@ static noinline void __sched __mutex_unlock_slowpath(struct mutex *lock, unsigne
 	unsigned long owner;
 
 	mutex_release(&lock->dep_map, ip);
+	dept_mutex_unlock(&lock->dmap, ip);
 
 	/*
 	 * Release the lock before (potentially) taking the spinlock such that
@@ -1361,26 +1405,26 @@ void __sched mutex_lock_io(struct mutex *lock)
 static noinline void __sched
 __mutex_lock_slowpath(struct mutex *lock)
 {
-	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, _RET_IP_);
+	__mutex_lock(lock, TASK_UNINTERRUPTIBLE, 0, NULL, NULL, _RET_IP_);
 }
 
 static noinline int __sched
 __mutex_lock_killable_slowpath(struct mutex *lock)
 {
-	return __mutex_lock(lock, TASK_KILLABLE, 0, NULL, _RET_IP_);
+	return __mutex_lock(lock, TASK_KILLABLE, 0, NULL, NULL, _RET_IP_);
 }
 
 static noinline int __sched
 __mutex_lock_interruptible_slowpath(struct mutex *lock)
 {
-	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, _RET_IP_);
+	return __mutex_lock(lock, TASK_INTERRUPTIBLE, 0, NULL, NULL, _RET_IP_);
 }
 
 static noinline int __sched
 __ww_mutex_lock_slowpath(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 {
 	return __ww_mutex_lock(&lock->base, TASK_UNINTERRUPTIBLE, 0, NULL,
-			       _RET_IP_, ctx);
+			       NULL, _RET_IP_, ctx);
 }
 
 static noinline int __sched
@@ -1388,7 +1432,7 @@ void __sched mutex_lock_io(struct mutex *lock)
 					    struct ww_acquire_ctx *ctx)
 {
 	return __ww_mutex_lock(&lock->base, TASK_INTERRUPTIBLE, 0, NULL,
-			       _RET_IP_, ctx);
+			       NULL, _RET_IP_, ctx);
 }
 
 #endif
@@ -1416,8 +1460,10 @@ int __sched mutex_trylock(struct mutex *lock)
 #endif
 
 	locked = __mutex_trylock(lock);
-	if (locked)
+	if (locked) {
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		dept_mutex_trylock(&lock->dmap, "mutex_unlock", _RET_IP_);
+	}
 
 	return locked;
 }
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 1c2287d..8b3eabb 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -17,7 +17,7 @@
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
-#define debug_mutex_init(lock, name, key)		do { } while (0)
+#define debug_mutex_init(lock, name, key, dkey)		do { } while (0)
 
 static inline void
 debug_mutex_lock_common(struct mutex *lock, struct mutex_waiter *waiter)
diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index 36e6910..1c35321 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -167,7 +167,8 @@ void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter)
 	memset(waiter, 0x22, sizeof(*waiter));
 }
 
-void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key)
+void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key,
+			 struct dept_key *dkey)
 {
 	/*
 	 * Make sure we are not reinitializing a held lock:
@@ -177,6 +178,7 @@ void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_cl
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_init_map(&lock->dep_map, name, key, 0);
+	dept_mutex_init(&lock->dmap, dkey, 0, name);
 #endif
 }
 
diff --git a/kernel/locking/rtmutex-debug.h b/kernel/locking/rtmutex-debug.h
index fc54971..4e88416 100644
--- a/kernel/locking/rtmutex-debug.h
+++ b/kernel/locking/rtmutex-debug.h
@@ -12,7 +12,7 @@
 
 extern void debug_rt_mutex_init_waiter(struct rt_mutex_waiter *waiter);
 extern void debug_rt_mutex_free_waiter(struct rt_mutex_waiter *waiter);
-extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key);
+extern void debug_rt_mutex_init(struct rt_mutex *lock, const char *name, struct lock_class_key *key, struct dept_key *dkey);
 extern void debug_rt_mutex_lock(struct rt_mutex *lock);
 extern void debug_rt_mutex_unlock(struct rt_mutex *lock);
 extern void debug_rt_mutex_proxy_lock(struct rt_mutex *lock,
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cfdd5b9..893629c 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1467,6 +1467,7 @@ static inline void __rt_mutex_lock(struct rt_mutex *lock, unsigned int subclass)
 	might_sleep();
 
 	mutex_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
+	dept_mutex_lock_nested(&lock->dmap, subclass, "__rt_mutex_unlock", _RET_IP_);
 	rt_mutex_fastlock(lock, TASK_UNINTERRUPTIBLE, rt_mutex_slowlock);
 }
 
@@ -1513,9 +1514,12 @@ int __sched rt_mutex_lock_interruptible(struct rt_mutex *lock)
 	might_sleep();
 
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_mutex_lock(&lock->dmap, "rt_mutex_unlock", _RET_IP_);
 	ret = rt_mutex_fastlock(lock, TASK_INTERRUPTIBLE, rt_mutex_slowlock);
-	if (ret)
+	if (ret) {
 		mutex_release(&lock->dep_map, _RET_IP_);
+		dept_mutex_unlock(&lock->dmap, _RET_IP_);
+	}
 
 	return ret;
 }
@@ -1555,11 +1559,14 @@ int __sched __rt_mutex_futex_trylock(struct rt_mutex *lock)
 	might_sleep();
 
 	mutex_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_mutex_lock(&lock->dmap, "rt_mutex_unlock", _RET_IP_);
 	ret = rt_mutex_timed_fastlock(lock, TASK_INTERRUPTIBLE, timeout,
 				       RT_MUTEX_MIN_CHAINWALK,
 				       rt_mutex_slowlock);
-	if (ret)
+	if (ret) {
 		mutex_release(&lock->dep_map, _RET_IP_);
+		dept_mutex_unlock(&lock->dmap, _RET_IP_);
+	}
 
 	return ret;
 }
@@ -1584,8 +1591,10 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 		return 0;
 
 	ret = rt_mutex_fasttrylock(lock, rt_mutex_slowtrylock);
-	if (ret)
+	if (ret) {
 		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		dept_mutex_trylock(&lock->dmap, "rt_mutex_unlock", _RET_IP_);
+	}
 
 	return ret;
 }
@@ -1599,6 +1608,7 @@ int __sched rt_mutex_trylock(struct rt_mutex *lock)
 void __sched rt_mutex_unlock(struct rt_mutex *lock)
 {
 	mutex_release(&lock->dep_map, _RET_IP_);
+	dept_mutex_unlock(&lock->dmap, _RET_IP_);
 	rt_mutex_fastunlock(lock, rt_mutex_slowunlock);
 }
 EXPORT_SYMBOL_GPL(rt_mutex_unlock);
@@ -1671,14 +1681,15 @@ void rt_mutex_destroy(struct rt_mutex *lock)
  * Initializing of a locked rt lock is not allowed
  */
 void __rt_mutex_init(struct rt_mutex *lock, const char *name,
-		     struct lock_class_key *key)
+		     struct lock_class_key *key,
+		     struct dept_key *dkey)
 {
 	lock->owner = NULL;
 	raw_spin_lock_init(&lock->wait_lock);
 	lock->waiters = RB_ROOT_CACHED;
 
 	if (name && key)
-		debug_rt_mutex_init(lock, name, key);
+		debug_rt_mutex_init(lock, name, key, dkey);
 }
 EXPORT_SYMBOL_GPL(__rt_mutex_init);
 
@@ -1699,7 +1710,7 @@ void __rt_mutex_init(struct rt_mutex *lock, const char *name,
 void rt_mutex_init_proxy_locked(struct rt_mutex *lock,
 				struct task_struct *proxy_owner)
 {
-	__rt_mutex_init(lock, NULL, NULL);
+	__rt_mutex_init(lock, NULL, NULL, NULL);
 	debug_rt_mutex_proxy_lock(lock, proxy_owner);
 	rt_mutex_set_owner(lock, proxy_owner);
 }
diff --git a/kernel/locking/rtmutex.h b/kernel/locking/rtmutex.h
index 732f96a..976b1a0 100644
--- a/kernel/locking/rtmutex.h
+++ b/kernel/locking/rtmutex.h
@@ -18,7 +18,7 @@
 #define debug_rt_mutex_proxy_lock(l,p)			do { } while (0)
 #define debug_rt_mutex_proxy_unlock(l)			do { } while (0)
 #define debug_rt_mutex_unlock(l)			do { } while (0)
-#define debug_rt_mutex_init(m, n, k)			do { } while (0)
+#define debug_rt_mutex_init(m, n, k, dk)		do { } while (0)
 #define debug_rt_mutex_deadlock(d, a ,l)		do { } while (0)
 #define debug_rt_mutex_print_deadlock(w)		do { } while (0)
 #define debug_rt_mutex_reset_waiter(w)			do { } while (0)
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 14f44f5..34f3b85 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -155,12 +155,12 @@ static void init_shared_classes(void)
 #ifdef CONFIG_RT_MUTEXES
 	static struct lock_class_key rt_X, rt_Y, rt_Z;
 
-	__rt_mutex_init(&rtmutex_X1, __func__, &rt_X);
-	__rt_mutex_init(&rtmutex_X2, __func__, &rt_X);
-	__rt_mutex_init(&rtmutex_Y1, __func__, &rt_Y);
-	__rt_mutex_init(&rtmutex_Y2, __func__, &rt_Y);
-	__rt_mutex_init(&rtmutex_Z1, __func__, &rt_Z);
-	__rt_mutex_init(&rtmutex_Z2, __func__, &rt_Z);
+	__rt_mutex_init(&rtmutex_X1, __func__, &rt_X, NULL);
+	__rt_mutex_init(&rtmutex_X2, __func__, &rt_X, NULL);
+	__rt_mutex_init(&rtmutex_Y1, __func__, &rt_Y, NULL);
+	__rt_mutex_init(&rtmutex_Y2, __func__, &rt_Y, NULL);
+	__rt_mutex_init(&rtmutex_Z1, __func__, &rt_Z, NULL);
+	__rt_mutex_init(&rtmutex_Z2, __func__, &rt_Z, NULL);
 #endif
 
 	init_class_X(&lock_X1, &rwlock_X1, &mutex_X1, &rwsem_X1);
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 2b8abbf..f76fac8 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -2034,7 +2034,10 @@ int stop_sync_thread(struct netns_ipvs *ipvs, int state)
  */
 int __net_init ip_vs_sync_net_init(struct netns_ipvs *ipvs)
 {
-	__mutex_init(&ipvs->sync_mutex, "ipvs->sync_mutex", &__ipvs_sync_key);
+	/*
+	 * TODO: Initialize the mutex with a valid dept_key.
+	 */
+	__mutex_init(&ipvs->sync_mutex, "ipvs->sync_mutex", &__ipvs_sync_key, NULL);
 	spin_lock_init(&ipvs->sync_lock);
 	spin_lock_init(&ipvs->sync_buff_lock);
 	return 0;
-- 
1.9.1


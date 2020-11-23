Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE32C04B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgKWLiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:38:11 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:53440 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728305AbgKWLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:38:11 -0500
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
Subject: [RFC 4/6] dept: Apply Dept to rwlock
Date:   Mon, 23 Nov 2020 20:36:30 +0900
Message-Id: <1606131392-22645-4-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
References: <20201123110527.GB9464@X58A-UD3R>
 <1606131392-22645-1-git-send-email-byungchul.park@lge.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Makes Dept able to track dependencies by rwlock.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 include/linux/rwlock.h          | 32 ++++++++++++++++++++++++++++++--
 include/linux/rwlock_api_smp.h  | 18 ++++++++++++++++++
 include/linux/rwlock_types.h    | 19 ++++++++++++++++---
 kernel/locking/spinlock_debug.c |  4 +++-
 4 files changed, 67 insertions(+), 6 deletions(-)

diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index 3dcd617..f633341 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -16,18 +16,46 @@
 
 #ifdef CONFIG_DEBUG_SPINLOCK
   extern void __rwlock_init(rwlock_t *lock, const char *name,
-			    struct lock_class_key *key);
+			    struct lock_class_key *key,
+			    struct dept_key *dkey);
 # define rwlock_init(lock)					\
 do {								\
 	static struct lock_class_key __key;			\
+	static struct dept_key __dkey;				\
 								\
-	__rwlock_init((lock), #lock, &__key);			\
+	__rwlock_init((lock), #lock, &__key, &__dkey);		\
 } while (0)
 #else
 # define rwlock_init(lock)					\
 	do { *(lock) = __RW_LOCK_UNLOCKED(lock); } while (0)
 #endif
 
+#ifdef CONFIG_DEPT
+#define DEPT_EVT_R		1UL
+#define DEPT_EVT_W		(1UL << 1)
+#define DEPT_EVT_RW		(DEPT_EVT_R | DEPT_EVT_W)
+
+#define dept_rw_init(m, k, s, n)		dept_map_init(m, k, s, n, DEPT_TYPE_RW)
+#define dept_rw_reinit(m, k, s, n)		dept_map_reinit(m, k, s, n)
+#define dept_rw_nocheck(m)			dept_map_nocheck(m)
+#define dept_write_lock(m, e_fn, ip)		dept_wait_ecxt_enter(m, DEPT_EVT_RW, DEPT_EVT_W, ip, __func__, __func__, e_fn, 0)
+#define dept_write_trylock(m, e_fn, ip)		dept_ecxt_enter(m, DEPT_EVT_W, ip, __func__, e_fn, 0)
+#define dept_write_unlock(m, ip)		dept_ecxt_exit(m, ip)
+#define dept_read_lock(m, e_fn, ip)		dept_wait_ecxt_enter(m, DEPT_EVT_W, DEPT_EVT_R, ip, __func__, __func__, e_fn, 0)
+#define dept_read_trylock(m, e_fn, ip)		dept_ecxt_enter(m, DEPT_EVT_R, ip, __func__, e_fn, 0)
+#define dept_read_unlock(m, ip)			dept_ecxt_exit(m, ip)
+#else
+#define dept_rw_init(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_rw_reinit(m, k, s, n)		do { (void)(n); (void)(k); } while (0)
+#define dept_rw_nocheck(m)			do { } while (0)
+#define dept_write_lock(m, e_fn, ip)		do { } while (0)
+#define dept_write_trylock(m, e_fn, ip)		do { } while (0)
+#define dept_write_unlock(m, ip)		do { } while (0)
+#define dept_read_lock(m, e_fn, ip)		do { } while (0)
+#define dept_read_trylock(m, e_fn, ip)		do { } while (0)
+#define dept_read_unlock(m, ip)			do { } while (0)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
  extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
 #define do_raw_read_lock_flags(lock, flags) do_raw_read_lock(lock)
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index abfb53a..2003104 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -119,6 +119,7 @@ static inline int __raw_read_trylock(rwlock_t *lock)
 	preempt_disable();
 	if (do_raw_read_trylock(lock)) {
 		rwlock_acquire_read(&lock->dep_map, 0, 1, _RET_IP_);
+		dept_read_trylock(&lock->dmap, "__raw_read_unlock", _RET_IP_);
 		return 1;
 	}
 	preempt_enable();
@@ -130,6 +131,7 @@ static inline int __raw_write_trylock(rwlock_t *lock)
 	preempt_disable();
 	if (do_raw_write_trylock(lock)) {
 		rwlock_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		dept_write_trylock(&lock->dmap, "__raw_write_unlock", _RET_IP_);
 		return 1;
 	}
 	preempt_enable();
@@ -147,6 +149,7 @@ static inline void __raw_read_lock(rwlock_t *lock)
 {
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_read_lock(&lock->dmap, "__raw_read_unlock", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
 }
 
@@ -157,6 +160,7 @@ static inline unsigned long __raw_read_lock_irqsave(rwlock_t *lock)
 	local_irq_save(flags);
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_read_lock(&lock->dmap, "__raw_read_unlock_irqrestore", _RET_IP_);
 	LOCK_CONTENDED_FLAGS(lock, do_raw_read_trylock, do_raw_read_lock,
 			     do_raw_read_lock_flags, &flags);
 	return flags;
@@ -167,6 +171,7 @@ static inline void __raw_read_lock_irq(rwlock_t *lock)
 	local_irq_disable();
 	preempt_disable();
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_read_lock(&lock->dmap, "__raw_read_unlock_irq", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
 }
 
@@ -174,6 +179,7 @@ static inline void __raw_read_lock_bh(rwlock_t *lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire_read(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_read_lock(&lock->dmap, "__raw_read_unlock_bh", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_read_trylock, do_raw_read_lock);
 }
 
@@ -184,6 +190,7 @@ static inline unsigned long __raw_write_lock_irqsave(rwlock_t *lock)
 	local_irq_save(flags);
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_write_lock(&lock->dmap, "__raw_write_unlock_irqrestore", _RET_IP_);
 	LOCK_CONTENDED_FLAGS(lock, do_raw_write_trylock, do_raw_write_lock,
 			     do_raw_write_lock_flags, &flags);
 	return flags;
@@ -194,6 +201,7 @@ static inline void __raw_write_lock_irq(rwlock_t *lock)
 	local_irq_disable();
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_write_lock(&lock->dmap, "__raw_write_unlock_irq", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
@@ -201,6 +209,7 @@ static inline void __raw_write_lock_bh(rwlock_t *lock)
 {
 	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_write_lock(&lock->dmap, "__raw_write_unlock_bh", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
@@ -208,6 +217,7 @@ static inline void __raw_write_lock(rwlock_t *lock)
 {
 	preempt_disable();
 	rwlock_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	dept_write_lock(&lock->dmap, "__raw_write_unlock", _RET_IP_);
 	LOCK_CONTENDED(lock, do_raw_write_trylock, do_raw_write_lock);
 }
 
@@ -216,6 +226,7 @@ static inline void __raw_write_lock(rwlock_t *lock)
 static inline void __raw_write_unlock(rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_write_unlock(&lock->dmap, _RET_IP_);
 	do_raw_write_unlock(lock);
 	preempt_enable();
 }
@@ -223,6 +234,7 @@ static inline void __raw_write_unlock(rwlock_t *lock)
 static inline void __raw_read_unlock(rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_read_unlock(&lock->dmap, _RET_IP_);
 	do_raw_read_unlock(lock);
 	preempt_enable();
 }
@@ -231,6 +243,7 @@ static inline void __raw_read_unlock(rwlock_t *lock)
 __raw_read_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_read_unlock(&lock->dmap, _RET_IP_);
 	do_raw_read_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -239,6 +252,7 @@ static inline void __raw_read_unlock(rwlock_t *lock)
 static inline void __raw_read_unlock_irq(rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_read_unlock(&lock->dmap, _RET_IP_);
 	do_raw_read_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -247,6 +261,7 @@ static inline void __raw_read_unlock_irq(rwlock_t *lock)
 static inline void __raw_read_unlock_bh(rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_read_unlock(&lock->dmap, _RET_IP_);
 	do_raw_read_unlock(lock);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
@@ -255,6 +270,7 @@ static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
 					     unsigned long flags)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_write_unlock(&lock->dmap, _RET_IP_);
 	do_raw_write_unlock(lock);
 	local_irq_restore(flags);
 	preempt_enable();
@@ -263,6 +279,7 @@ static inline void __raw_write_unlock_irqrestore(rwlock_t *lock,
 static inline void __raw_write_unlock_irq(rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_write_unlock(&lock->dmap, _RET_IP_);
 	do_raw_write_unlock(lock);
 	local_irq_enable();
 	preempt_enable();
@@ -271,6 +288,7 @@ static inline void __raw_write_unlock_irq(rwlock_t *lock)
 static inline void __raw_write_unlock_bh(rwlock_t *lock)
 {
 	rwlock_release(&lock->dep_map, _RET_IP_);
+	dept_write_unlock(&lock->dmap, _RET_IP_);
 	do_raw_write_unlock(lock);
 	__local_bh_enable_ip(_RET_IP_, SOFTIRQ_LOCK_OFFSET);
 }
diff --git a/include/linux/rwlock_types.h b/include/linux/rwlock_types.h
index 3bd03e1..1e79ea7 100644
--- a/include/linux/rwlock_types.h
+++ b/include/linux/rwlock_types.h
@@ -17,6 +17,7 @@
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif
+	struct dept_map dmap;
 } rwlock_t;
 
 #define RWLOCK_MAGIC		0xdeaf1eed
@@ -26,22 +27,34 @@
 	.dep_map = {							\
 		.name = #lockname,					\
 		.wait_type_inner = LD_WAIT_CONFIG,			\
-	}
+	},
 #else
 # define RW_DEP_MAP_INIT(lockname)
 #endif
 
+#ifdef CONFIG_DEPT
+# define RW_DMAP_INIT(lockname)						\
+	.dmap = {							\
+		.name = #lockname,					\
+		.type = DEPT_TYPE_RW,					\
+	},
+#else
+# define RW_DMAP_INIT(lockname)
+#endif
+
 #ifdef CONFIG_DEBUG_SPINLOCK
 #define __RW_LOCK_UNLOCKED(lockname)					\
 	(rwlock_t)	{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
 				.magic = RWLOCK_MAGIC,			\
 				.owner = SPINLOCK_OWNER_INIT,		\
 				.owner_cpu = -1,			\
-				RW_DEP_MAP_INIT(lockname) }
+				RW_DEP_MAP_INIT(lockname)		\
+				RW_DMAP_INIT(lockname) }
 #else
 #define __RW_LOCK_UNLOCKED(lockname) \
 	(rwlock_t)	{	.raw_lock = __ARCH_RW_LOCK_UNLOCKED,	\
-				RW_DEP_MAP_INIT(lockname) }
+				RW_DEP_MAP_INIT(lockname)		\
+				RW_DMAP_INIT(lockname) }
 #endif
 
 #define DEFINE_RWLOCK(x)	rwlock_t x = __RW_LOCK_UNLOCKED(x)
diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 03e6812..f4deecb 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -34,7 +34,8 @@ void __raw_spin_lock_init(raw_spinlock_t *lock, const char *name,
 EXPORT_SYMBOL(__raw_spin_lock_init);
 
 void __rwlock_init(rwlock_t *lock, const char *name,
-		   struct lock_class_key *key)
+		   struct lock_class_key *key,
+		   struct dept_key *dkey)
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	/*
@@ -42,6 +43,7 @@ void __rwlock_init(rwlock_t *lock, const char *name,
 	 */
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));
 	lockdep_init_map_wait(&lock->dep_map, name, key, 0, LD_WAIT_CONFIG);
+	dept_rw_init(&lock->dmap, dkey, 0, name);
 #endif
 	lock->raw_lock = (arch_rwlock_t) __ARCH_RW_LOCK_UNLOCKED;
 	lock->magic = RWLOCK_MAGIC;
-- 
1.9.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DFD2D5EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391846AbgLJOvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389614AbgLJOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:22 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC0AC0617B0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=WIKhXHtt21NjGacC/MEU7TgtGWPrQ8tpk3ZcKnVmE9Y=; b=lEGlvkeavqd48RfOEzg9l3Ya8R
        3U8z4atpypIMQyjEGms7QUs4irA3KuglzH+/l8yRW2le/D0CTMqEb3DfUe3WwGcH9ZTFQbbOpBKvO
        yu7d91DBxKLkIXlv9NSWFLCFp0T/tKnVEkcvZpI7bjqUflxR3k3YY2oaS+TCyhH5+OzFBLwg7VNch
        F5eJ5J55Gp91g5fGtdrM343fWl1P6mc0RkWiwc4ZidcOsgNZAABtA0VFylZdWZToV+wTMkCtMs9N7
        78NSTB1+Ynpvu/2YTCbOup/rMVm8pPcNr5Bdl3niPVcAULmwlhZg+L8416l9/nfDsbrhUnaT3Yvhr
        gXQ9U4Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF5-00042u-U4; Thu, 10 Dec 2020 14:48:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DBA7D3003D8;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C87CD2BAB36D3; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144619.744787821@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:42:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 2/6] locking/lockdep: Mark local_lock_t
References: <20201210144254.583402167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The local_lock_t's are special, because they cannot form IRQ
inversions, make sure we can tell them apart from the rest of the
locks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/local_lock_internal.h |    5 ++++-
 include/linux/lockdep.h             |   15 ++++++++++++---
 include/linux/lockdep_types.h       |   18 ++++++++++++++----
 kernel/locking/lockdep.c            |   16 +++++++++-------
 4 files changed, 39 insertions(+), 15 deletions(-)

--- a/include/linux/local_lock_internal.h
+++ b/include/linux/local_lock_internal.h
@@ -18,6 +18,7 @@ typedef struct {
 	.dep_map = {					\
 		.name = #lockname,			\
 		.wait_type_inner = LD_WAIT_CONFIG,	\
+		.lock_type = LD_LOCK_PERCPU,			\
 	}
 #else
 # define LL_DEP_MAP_INIT(lockname)
@@ -30,7 +31,9 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
-	lockdep_init_map_wait(&(lock)->dep_map, #lock, &__key, 0, LD_WAIT_CONFIG);\
+	lockdep_init_map_type(&(lock)->dep_map, #lock, &__key, 0, \
+			      LD_WAIT_CONFIG, LD_WAIT_INV,	\
+			      LD_LOCK_PERCPU);			\
 } while (0)
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -185,12 +185,19 @@ extern void lockdep_unregister_key(struc
  * to lockdep:
  */
 
-extern void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
-	struct lock_class_key *key, int subclass, short inner, short outer);
+extern void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
+	struct lock_class_key *key, int subclass, u8 inner, u8 outer, u8 lock_type);
+
+static inline void
+lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
+{
+	lockdep_init_map_type(lock, name, key, subclass, inner, LD_WAIT_INV, LD_LOCK_NORMAL);
+}
 
 static inline void
 lockdep_init_map_wait(struct lockdep_map *lock, const char *name,
-		      struct lock_class_key *key, int subclass, short inner)
+		      struct lock_class_key *key, int subclass, u8 inner)
 {
 	lockdep_init_map_waits(lock, name, key, subclass, inner, LD_WAIT_INV);
 }
@@ -340,6 +347,8 @@ static inline void lockdep_set_selftest_
 # define lock_set_class(l, n, k, s, i)		do { } while (0)
 # define lock_set_subclass(l, s, i)		do { } while (0)
 # define lockdep_init()				do { } while (0)
+# define lockdep_init_map_type(lock, name, key, sub, inner, outer) \
+		do { (void)(name); (void)(key); } while (0)
 # define lockdep_init_map_waits(lock, name, key, sub, inner, outer) \
 		do { (void)(name); (void)(key); } while (0)
 # define lockdep_init_map_wait(lock, name, key, sub, inner) \
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -30,6 +30,12 @@ enum lockdep_wait_type {
 	LD_WAIT_MAX,		/* must be last */
 };
 
+enum lockdep_lock_type {
+	LD_LOCK_NORMAL = 0,	/* normal, catch all */
+	LD_LOCK_PERCPU,		/* percpu */
+	LD_LOCK_MAX,
+};
+
 #ifdef CONFIG_LOCKDEP
 
 /*
@@ -119,8 +125,10 @@ struct lock_class {
 	int				name_version;
 	const char			*name;
 
-	short				wait_type_inner;
-	short				wait_type_outer;
+	u8				wait_type_inner;
+	u8				wait_type_outer;
+	u8				lock_type;
+	/* u8				hole; */
 
 #ifdef CONFIG_LOCK_STAT
 	unsigned long			contention_point[LOCKSTAT_POINTS];
@@ -169,8 +177,10 @@ struct lockdep_map {
 	struct lock_class_key		*key;
 	struct lock_class		*class_cache[NR_LOCKDEP_CACHING_CLASSES];
 	const char			*name;
-	short				wait_type_outer; /* can be taken in this context */
-	short				wait_type_inner; /* presents this context */
+	u8				wait_type_outer; /* can be taken in this context */
+	u8				wait_type_inner; /* presents this context */
+	u8				lock_type;
+	/* u8				hole; */
 #ifdef CONFIG_LOCK_STAT
 	int				cpu;
 	unsigned long			ip;
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1290,6 +1290,7 @@ register_lock_class(struct lockdep_map *
 	class->name_version = count_matching_names(class);
 	class->wait_type_inner = lock->wait_type_inner;
 	class->wait_type_outer = lock->wait_type_outer;
+	class->lock_type = lock->lock_type;
 	/*
 	 * We use RCU's safe list-add method to make
 	 * parallel walking of the hash-list safe:
@@ -4503,9 +4504,9 @@ print_lock_invalid_wait_context(struct t
  */
 static int check_wait_context(struct task_struct *curr, struct held_lock *next)
 {
-	short next_inner = hlock_class(next)->wait_type_inner;
-	short next_outer = hlock_class(next)->wait_type_outer;
-	short curr_inner;
+	u8 next_inner = hlock_class(next)->wait_type_inner;
+	u8 next_outer = hlock_class(next)->wait_type_outer;
+	u8 curr_inner;
 	int depth;
 
 	if (!next_inner || next->trylock)
@@ -4532,7 +4533,7 @@ static int check_wait_context(struct tas
 
 	for (; depth < curr->lockdep_depth; depth++) {
 		struct held_lock *prev = curr->held_locks + depth;
-		short prev_inner = hlock_class(prev)->wait_type_inner;
+		u8 prev_inner = hlock_class(prev)->wait_type_inner;
 
 		if (prev_inner) {
 			/*
@@ -4581,9 +4582,9 @@ static inline int check_wait_context(str
 /*
  * Initialize a lock instance's lock-class mapping info:
  */
-void lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
+void lockdep_init_map_type(struct lockdep_map *lock, const char *name,
 			    struct lock_class_key *key, int subclass,
-			    short inner, short outer)
+			    u8 inner, u8 outer, u8 lock_type)
 {
 	int i;
 
@@ -4606,6 +4607,7 @@ void lockdep_init_map_waits(struct lockd
 
 	lock->wait_type_outer = outer;
 	lock->wait_type_inner = inner;
+	lock->lock_type = lock_type;
 
 	/*
 	 * No key, no joy, we need to hash something.
@@ -4640,7 +4642,7 @@ void lockdep_init_map_waits(struct lockd
 		raw_local_irq_restore(flags);
 	}
 }
-EXPORT_SYMBOL_GPL(lockdep_init_map_waits);
+EXPORT_SYMBOL_GPL(lockdep_init_map_type);
 
 struct lock_class_key __lockdep_no_validate__;
 EXPORT_SYMBOL_GPL(__lockdep_no_validate__);



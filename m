Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B405251656
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 12:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729760AbgHYKNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 06:13:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58952 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729722AbgHYKNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598350395;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8YRUElCANYqueIHKQEuA7zWSQUNv4C8v5DZ6dHOdCs=;
        b=elcT0phYcLcntt+oWak+U4SoKselvBA1oqJz3LcvujkXVbApRjxswgmZwUldnvaPCfRsHl
        3s1rANeSBmitVn+HiQVL1cNiJfcdaIVZXEvTuDleJFeSR0CMVBjO27hKLqDzXiB4szy+vg
        Xty/fxEE05pz9yu/V78KWC2BNt1AwOQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-T33FpbLAMRSd5M4kQm4GWw-1; Tue, 25 Aug 2020 06:13:13 -0400
X-MC-Unique: T33FpbLAMRSd5M4kQm4GWw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E93A91074662;
        Tue, 25 Aug 2020 10:13:11 +0000 (UTC)
Received: from localhost (ovpn-13-7.pek2.redhat.com [10.72.13.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4DA8F80927;
        Tue, 25 Aug 2020 10:13:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
        Tejun Heo <tj@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/2] percpu_ref: reduce memory footprint of percpu_ref in fast path
Date:   Tue, 25 Aug 2020 18:12:47 +0800
Message-Id: <20200825101248.8027-2-ming.lei@redhat.com>
In-Reply-To: <20200825101248.8027-1-ming.lei@redhat.com>
References: <20200825101248.8027-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'struct percpu_ref' is often embedded into one user structure, and the
instance is usually referenced in fast path, however actually only
'percpu_count_ptr' is needed in fast path.

So move other fields into one new structure of 'percpu_ref_data', and
allocate it dynamically via kzalloc(), then memory footprint of
'percpu_ref' in fast path is reduced a lot and becomes suitable to put
into hot cacheline of user structure.

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 include/linux/percpu-refcount.h   |  43 +++++++++----
 lib/percpu-refcount.c             | 101 ++++++++++++++++++++----------
 3 files changed, 99 insertions(+), 47 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 2f7c25fea44a..8490fdb9c91e 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -499,7 +499,7 @@ static int rvt_check_refs(struct rvt_mregion *mr, const char *t)
 		rvt_pr_err(rdi,
 			   "%s timeout mr %p pd %p lkey %x refcount %ld\n",
 			   t, mr, mr->pd, mr->lkey,
-			   atomic_long_read(&mr->refcount.count));
+			   atomic_long_read(&mr->refcount.data->count));
 		rvt_get_mr(mr);
 		return -EBUSY;
 	}
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 87d8a38bdea1..3082c01e544e 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -63,9 +63,10 @@ typedef void (percpu_ref_func_t)(struct percpu_ref *);
 enum {
 	__PERCPU_REF_ATOMIC	= 1LU << 0,	/* operating in atomic mode */
 	__PERCPU_REF_DEAD	= 1LU << 1,	/* (being) killed */
+	__PERCPU_REF_DESTROYED	= 1LU << 2,	/* destroyed */
 	__PERCPU_REF_ATOMIC_DEAD = __PERCPU_REF_ATOMIC | __PERCPU_REF_DEAD,
 
-	__PERCPU_REF_FLAG_BITS	= 2,
+	__PERCPU_REF_FLAG_BITS	= 3,
 };
 
 /* @flags for percpu_ref_init() */
@@ -92,18 +93,23 @@ enum {
 	PERCPU_REF_ALLOW_REINIT	= 1 << 2,
 };
 
-struct percpu_ref {
+struct percpu_ref_data {
 	atomic_long_t		count;
+	bool			force_atomic:1;
+	bool			allow_reinit:1;
+	percpu_ref_func_t	*release;
+	percpu_ref_func_t	*confirm_switch;
+	struct rcu_head		rcu;
+	struct percpu_ref	*ref;
+};
+
+struct percpu_ref {
 	/*
 	 * The low bit of the pointer indicates whether the ref is in percpu
 	 * mode; if set, then get/put will manipulate the atomic_t.
 	 */
 	unsigned long		percpu_count_ptr;
-	percpu_ref_func_t	*release;
-	percpu_ref_func_t	*confirm_switch;
-	bool			force_atomic:1;
-	bool			allow_reinit:1;
-	struct rcu_head		rcu;
+	struct percpu_ref_data  *data;
 };
 
 int __must_check percpu_ref_init(struct percpu_ref *ref,
@@ -191,7 +197,7 @@ static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_add(*percpu_count, nr);
 	else
-		atomic_long_add(nr, &ref->count);
+		atomic_long_add(nr, &ref->data->count);
 
 	rcu_read_unlock();
 }
@@ -231,7 +237,7 @@ static inline bool percpu_ref_tryget_many(struct percpu_ref *ref,
 		this_cpu_add(*percpu_count, nr);
 		ret = true;
 	} else {
-		ret = atomic_long_add_unless(&ref->count, nr, 0);
+		ret = atomic_long_add_unless(&ref->data->count, nr, 0);
 	}
 
 	rcu_read_unlock();
@@ -279,7 +285,7 @@ static inline bool percpu_ref_tryget_live(struct percpu_ref *ref)
 		this_cpu_inc(*percpu_count);
 		ret = true;
 	} else if (!(ref->percpu_count_ptr & __PERCPU_REF_DEAD)) {
-		ret = atomic_long_inc_not_zero(&ref->count);
+		ret = atomic_long_inc_not_zero(&ref->data->count);
 	}
 
 	rcu_read_unlock();
@@ -305,8 +311,8 @@ static inline void percpu_ref_put_many(struct percpu_ref *ref, unsigned long nr)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_sub(*percpu_count, nr);
-	else if (unlikely(atomic_long_sub_and_test(nr, &ref->count)))
-		ref->release(ref);
+	else if (unlikely(atomic_long_sub_and_test(nr, &ref->data->count)))
+		ref->data->release(ref);
 
 	rcu_read_unlock();
 }
@@ -353,7 +359,18 @@ static inline bool percpu_ref_is_zero(struct percpu_ref *ref)
 
 	if (__ref_is_percpu(ref, &percpu_count))
 		return false;
-	return !atomic_long_read(&ref->count);
+
+	if (ref->percpu_count_ptr & __PERCPU_REF_DESTROYED)
+		return true;
+
+	/*
+	 * Order reading __PERCPU_REF_DESTROYED and reading ref->data.
+	 * Its pair is smp_wmb() in percpu_ref_exit(). We might be called
+	 * after percpu_ref_exit() returns.
+	 */
+	smp_rmb();
+
+	return !atomic_long_read(&ref->data->count);
 }
 
 #endif
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 0ba686b8fe57..8e0fef87f2ed 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/wait.h>
+#include <linux/slab.h>
 #include <linux/percpu-refcount.h>
 
 /*
@@ -64,18 +65,25 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	size_t align = max_t(size_t, 1 << __PERCPU_REF_FLAG_BITS,
 			     __alignof__(unsigned long));
 	unsigned long start_count = 0;
+	struct percpu_ref_data *data;
 
 	ref->percpu_count_ptr = (unsigned long)
 		__alloc_percpu_gfp(sizeof(unsigned long), align, gfp);
 	if (!ref->percpu_count_ptr)
 		return -ENOMEM;
 
-	ref->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
-	ref->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
+	data = kzalloc(sizeof(*ref->data), GFP_KERNEL);
+	if (!data) {
+		free_percpu((void __percpu *)ref->percpu_count_ptr);
+		return -ENOMEM;
+	}
+
+	data->force_atomic = flags & PERCPU_REF_INIT_ATOMIC;
+	data->allow_reinit = flags & PERCPU_REF_ALLOW_REINIT;
 
 	if (flags & (PERCPU_REF_INIT_ATOMIC | PERCPU_REF_INIT_DEAD)) {
 		ref->percpu_count_ptr |= __PERCPU_REF_ATOMIC;
-		ref->allow_reinit = true;
+		data->allow_reinit = true;
 	} else {
 		start_count += PERCPU_COUNT_BIAS;
 	}
@@ -85,14 +93,28 @@ int percpu_ref_init(struct percpu_ref *ref, percpu_ref_func_t *release,
 	else
 		start_count++;
 
-	atomic_long_set(&ref->count, start_count);
+	atomic_long_set(&data->count, start_count);
 
-	ref->release = release;
-	ref->confirm_switch = NULL;
+	data->release = release;
+	data->confirm_switch = NULL;
+	data->ref = ref;
+	ref->data = data;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(percpu_ref_init);
 
+static void __percpu_ref_exit(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
+
+	if (percpu_count) {
+		/* non-NULL confirm_switch indicates switching in progress */
+		WARN_ON_ONCE(ref->data->confirm_switch);
+		free_percpu(percpu_count);
+		ref->percpu_count_ptr = __PERCPU_REF_ATOMIC_DEAD;
+	}
+}
+
 /**
  * percpu_ref_exit - undo percpu_ref_init()
  * @ref: percpu_ref to exit
@@ -105,27 +127,34 @@ EXPORT_SYMBOL_GPL(percpu_ref_init);
  */
 void percpu_ref_exit(struct percpu_ref *ref)
 {
-	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
+	struct percpu_ref_data *data = ref->data;
 
-	if (percpu_count) {
-		/* non-NULL confirm_switch indicates switching in progress */
-		WARN_ON_ONCE(ref->confirm_switch);
-		free_percpu(percpu_count);
-		ref->percpu_count_ptr = __PERCPU_REF_ATOMIC_DEAD;
-	}
+	__percpu_ref_exit(ref);
+	ref->percpu_count_ptr |= __PERCPU_REF_DESTROYED;
+
+	/*
+	 * Order setting __PERCPU_REF_DESTROYED and clearing ref->data.
+	 * Its pair is smp_read() in percpu_ref_is_zero() which could
+	 * be run after percpu_ref_exit() returns.
+	 */
+	smp_wmb();
+	ref->data = NULL;
+	kfree(data);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_exit);
 
 static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 {
-	struct percpu_ref *ref = container_of(rcu, struct percpu_ref, rcu);
+	struct percpu_ref_data *data = container_of(rcu,
+			struct percpu_ref_data, rcu);
+	struct percpu_ref *ref = data->ref;
 
-	ref->confirm_switch(ref);
-	ref->confirm_switch = NULL;
+	data->confirm_switch(ref);
+	data->confirm_switch = NULL;
 	wake_up_all(&percpu_ref_switch_waitq);
 
-	if (!ref->allow_reinit)
-		percpu_ref_exit(ref);
+	if (!data->allow_reinit)
+		__percpu_ref_exit(ref);
 
 	/* drop ref from percpu_ref_switch_to_atomic() */
 	percpu_ref_put(ref);
@@ -133,7 +162,9 @@ static void percpu_ref_call_confirm_rcu(struct rcu_head *rcu)
 
 static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 {
-	struct percpu_ref *ref = container_of(rcu, struct percpu_ref, rcu);
+	struct percpu_ref_data *data = container_of(rcu,
+			struct percpu_ref_data, rcu);
+	struct percpu_ref *ref = data->ref;
 	unsigned long __percpu *percpu_count = percpu_count_ptr(ref);
 	unsigned long count = 0;
 	int cpu;
@@ -142,7 +173,7 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 		count += *per_cpu_ptr(percpu_count, cpu);
 
 	pr_debug("global %lu percpu %lu\n",
-		 atomic_long_read(&ref->count), count);
+		 atomic_long_read(&data->count), count);
 
 	/*
 	 * It's crucial that we sum the percpu counters _before_ adding the sum
@@ -156,11 +187,11 @@ static void percpu_ref_switch_to_atomic_rcu(struct rcu_head *rcu)
 	 * reaching 0 before we add the percpu counts. But doing it at the same
 	 * time is equivalent and saves us atomic operations:
 	 */
-	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &ref->count);
+	atomic_long_add((long)count - PERCPU_COUNT_BIAS, &data->count);
 
-	WARN_ONCE(atomic_long_read(&ref->count) <= 0,
+	WARN_ONCE(atomic_long_read(&data->count) <= 0,
 		  "percpu ref (%ps) <= 0 (%ld) after switching to atomic",
-		  ref->release, atomic_long_read(&ref->count));
+		  data->release, atomic_long_read(&data->count));
 
 	/* @ref is viewed as dead on all CPUs, send out switch confirmation */
 	percpu_ref_call_confirm_rcu(rcu);
@@ -186,10 +217,11 @@ static void __percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 	 * Non-NULL ->confirm_switch is used to indicate that switching is
 	 * in progress.  Use noop one if unspecified.
 	 */
-	ref->confirm_switch = confirm_switch ?: percpu_ref_noop_confirm_switch;
+	ref->data->confirm_switch = confirm_switch ?:
+		percpu_ref_noop_confirm_switch;
 
 	percpu_ref_get(ref);	/* put after confirmation */
-	call_rcu(&ref->rcu, percpu_ref_switch_to_atomic_rcu);
+	call_rcu(&ref->data->rcu, percpu_ref_switch_to_atomic_rcu);
 }
 
 static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
@@ -202,10 +234,10 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 	if (!(ref->percpu_count_ptr & __PERCPU_REF_ATOMIC))
 		return;
 
-	if (WARN_ON_ONCE(!ref->allow_reinit))
+	if (WARN_ON_ONCE(!ref->data->allow_reinit))
 		return;
 
-	atomic_long_add(PERCPU_COUNT_BIAS, &ref->count);
+	atomic_long_add(PERCPU_COUNT_BIAS, &ref->data->count);
 
 	/*
 	 * Restore per-cpu operation.  smp_store_release() is paired
@@ -223,6 +255,8 @@ static void __percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 				     percpu_ref_func_t *confirm_switch)
 {
+	struct percpu_ref_data *data = ref->data;
+
 	lockdep_assert_held(&percpu_ref_switch_lock);
 
 	/*
@@ -230,10 +264,10 @@ static void __percpu_ref_switch_mode(struct percpu_ref *ref,
 	 * its completion.  If the caller ensures that ATOMIC switching
 	 * isn't in progress, this function can be called from any context.
 	 */
-	wait_event_lock_irq(percpu_ref_switch_waitq, !ref->confirm_switch,
+	wait_event_lock_irq(percpu_ref_switch_waitq, !data->confirm_switch,
 			    percpu_ref_switch_lock);
 
-	if (ref->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
+	if (data->force_atomic || (ref->percpu_count_ptr & __PERCPU_REF_DEAD))
 		__percpu_ref_switch_to_atomic(ref, confirm_switch);
 	else
 		__percpu_ref_switch_to_percpu(ref);
@@ -266,7 +300,7 @@ void percpu_ref_switch_to_atomic(struct percpu_ref *ref,
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	ref->force_atomic = true;
+	ref->data->force_atomic = true;
 	__percpu_ref_switch_mode(ref, confirm_switch);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
@@ -284,7 +318,7 @@ EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic);
 void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref)
 {
 	percpu_ref_switch_to_atomic(ref, NULL);
-	wait_event(percpu_ref_switch_waitq, !ref->confirm_switch);
+	wait_event(percpu_ref_switch_waitq, !ref->data->confirm_switch);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_switch_to_atomic_sync);
 
@@ -312,7 +346,7 @@ void percpu_ref_switch_to_percpu(struct percpu_ref *ref)
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	ref->force_atomic = false;
+	ref->data->force_atomic = false;
 	__percpu_ref_switch_mode(ref, NULL);
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
@@ -344,7 +378,8 @@ void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
 	WARN_ONCE(ref->percpu_count_ptr & __PERCPU_REF_DEAD,
-		  "%s called more than once on %ps!", __func__, ref->release);
+		  "%s called more than once on %ps!", __func__,
+		  ref->data->release);
 
 	ref->percpu_count_ptr |= __PERCPU_REF_DEAD;
 	__percpu_ref_switch_mode(ref, confirm_kill);
-- 
2.25.2


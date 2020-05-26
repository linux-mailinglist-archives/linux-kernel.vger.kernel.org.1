Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB0A1A6DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 23:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388803AbgDMVPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 17:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388795AbgDMVPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 17:15:19 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0EC0A3BE2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:15:19 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b10so8395736qtt.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 14:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sFzBP3XsNnuuCHr5wMMwXJLWeOTEdcIJdWdB9cgVCg=;
        b=ivO1xwBaKFV7Czd/ZtqiHp87oGFhluAO/sVOmwLb71tnJpO6AfBhUB1iBhZ2T5QOhI
         CYJReqTFKowfTKH5Qy1aNaDep/s8WaqG7mt8QynIvTaBdlgafbpME2wQ+kaBqazuZfEa
         udEAYNyrU7CEh29x3dqqIY7u5sYGIg/syiN6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9sFzBP3XsNnuuCHr5wMMwXJLWeOTEdcIJdWdB9cgVCg=;
        b=UYmJyIaCazX8DD/h87WRlacnfLYR492lOBCfgJk3nGME4BUYvkkeFHc7wpE2ftSzol
         rFZC1IHL7xKwZRgZrfgH7lsAQM10xnu6Lw5ZDXAEdv354/9tg8Q4AQAfhmB5LgD9b7Qq
         6XN9/om9VcBs8emUu75s5u+VAUOsivuMzEsXCVjGNwlOd/7QOQTgT8JJDJdDD1VMGYs7
         0JIFV/D4yH0MxRXHBcj9Lfnl7v/Uu04h+a7pFFIUu1mspADr2mjnPDzVXdSg9eM91vDd
         biZnbEM2GufCSqZlowU/h79id1tj2GMdSa31Dvj+ZIqaYtDBJ/UhvrDdlp3m41rJQieg
         7r/Q==
X-Gm-Message-State: AGi0PuZ0gdh0TegUDF7iJQhs+U4qCUmUcKQm9w8Br2CBxMQEJut85mIV
        iqj+gpFzeTNl6MlMVHev8L/RrueQXA0=
X-Google-Smtp-Source: APiQypIN+tiKQY4j81Q/FHQP82VUbKTIvkd4eSM2r2xSuCPyUSgZu1BVEo2Fhhx52lBRwAucYyOzYQ==
X-Received: by 2002:ac8:3025:: with SMTP id f34mr13506504qte.219.1586812517806;
        Mon, 13 Apr 2020 14:15:17 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r9sm8957328qke.5.2020.04.13.14.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 14:15:17 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH RFC] rcu/tree: Refactor object allocation and try harder for array allocation
Date:   Mon, 13 Apr 2020 17:15:04 -0400
Message-Id: <20200413211504.108086-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a small code refactor and also removes the restriction that
headless kfree_rcu() users cannot sleep for allocation of the per-cpu
array where their pointers will be placed . Since they are always called
in a sleepable context, we can use this information to try harder during
the array allocation stage to allocate the per-cpu array.

Also there is a possible bug-fix for a migration scenario where a
kfree_rcu() headless user can get migrated during the
sleepable-allocation and end up on another CPU and restoring the wrong
CPU's flags. To remedy this, we store only the IRQ state on the stack
and save/restore IRQ state from there. Sure, for the headless case we
don't need to restore flags. But the code saving/restoring state is
common between headless and with-head kfree_rcu() variants, so it
handles all scenarios sampling/restoring just the IRQ state and not
saving/restoring all the flags.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---

This is just RFC and is based on top of Vlad's latest patches:
https://lkml.org/lkml/2020/4/2/383

The git tree containing this patch is at:
https://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git/log/?h=rcu/dev

(This patch will be a part of a much large series in the future).


 kernel/rcu/tree.c | 150 +++++++++++++++++++++++++++++++---------------
 1 file changed, 103 insertions(+), 47 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 744d04d8b7724..2e0eaec929059 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3104,11 +3104,95 @@ static void kfree_rcu_monitor(struct work_struct *work)
 		spin_unlock_irqrestore(&krcp->lock, flags);
 }
 
+static inline struct kfree_rcu_cpu *krc_this_cpu_lock(bool irqs_disabled)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	// For safely calling this_cpu_ptr().
+	if (!irqs_disabled)
+		local_irq_disable();
+
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, bool irqs_disabled)
+{
+	if (likely(krcp->initialized))
+		spin_unlock(&krcp->lock);
+
+	if (!irqs_disabled)
+		local_irq_enable();
+}
+
+// alloc_object_locked - Try to allocate an object of size while dropping the lock.
+//
+// @size: Size of the object to internally allocate for kfree_rcu().
+// @slab: Do we allocate on slab or using buddy.
+// @can_sleep: Was kfree_rcu() called in sleepable context?
+// @krcp: The pointer to krcp. Needed if when relocking, we got migrated.
+//
+// Caveats:
+//
+// 1. Per-cpu krc's lock must be held with interrupts disabled.
+//
+// 2. Failure to allocate returns NULL and does not cause a warning.
+//
+// 3. Caller is responsible for using the correct free() APIs. If size == PAGE_SIZE,
+//    then free_page() should be called for freeing. Otherwise kfree().
+//
+static inline void *alloc_object_locked(size_t size, bool slab, bool can_sleep,
+					struct kfree_rcu_cpu **krcpp)
+{
+	void *ptr;
+	gfp_t gfp_flags, wmark_flags, reclaim_flags;
+	struct kfree_rcu_cpu *krcp = *krcpp;
+
+	WARN_ON_ONCE(size == PAGE_SIZE && slab);
+
+	// Decompose the flags:
+	// wmark_flags   - affect the watermark to control reserve access.
+	// reclaim_flags - these effect how reclaim works but would
+	//                 have no-affect in atomic or nowait context.
+	wmark_flags = (__GFP_HIGH | __GFP_ATOMIC);
+	reclaim_flags = (__GFP_RETRY_MAYFAIL);
+
+	// These flags will be common to all allocations, whether we want to
+	// wait or sleep or reclaim will be controlled with additional flags
+	// later during the actual allocation.
+	gfp_flags = (wmark_flags | reclaim_flags | __GFP_NOWARN);
+
+	// First, do an allocation without waiting.
+	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_NOWAIT)
+				  : (void *)kmalloc(size, gfp_flags | GFP_NOWAIT);
+	// If we cannot sleep, we are done.
+	if (ptr || !can_sleep)
+		return ptr;
+
+	// Now try to do it with more relaxed flags, we may enter direct-reclaim.
+	//
+	// IRQs were not enabled since can_sleep == true. So there's no need to
+	// save/restore flags.
+	krc_this_cpu_unlock(krcp, false);
+	ptr = (size == PAGE_SIZE) ? (void *)__get_free_page(gfp_flags | GFP_KERNEL)
+				  : (void *)kmalloc(size, gfp_flags | GFP_KERNEL);
+
+	// Take it back. We may have got migrated here.
+	*krcpp = krc_this_cpu_lock(false);
+
+	return ptr;
+}
+
 static inline bool
-kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
+kvfree_call_rcu_add_ptr_to_bulk(void *ptr, bool can_sleep, struct kfree_rcu_cpu **krcpp)
 {
 	struct kvfree_rcu_bulk_data *bnode;
 	int idx;
+	struct kfree_rcu_cpu *krcp = *krcpp;
 
 	if (unlikely(!krcp->initialized))
 		return false;
@@ -3121,9 +3205,11 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 			krcp->bkvhead[idx]->nr_records ==
 				KVFREE_BULK_MAX_ENTR) {
 		bnode = xchg(&krcp->bkvcache[idx], NULL);
-		if (!bnode)
+		if (!bnode) {
 			bnode = (struct kvfree_rcu_bulk_data *)
-				__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
+				alloc_object_locked(PAGE_SIZE, false /* use buddy */,
+						    can_sleep, krcpp);
+		}
 
 		/* Switch to emergency path. */
 		if (unlikely(!bnode))
@@ -3144,14 +3230,15 @@ kvfree_call_rcu_add_ptr_to_bulk(struct kfree_rcu_cpu *krcp, void *ptr)
 	return true;
 }
 
-static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
+static inline struct rcu_head *attach_rcu_head_to_object(void *obj,
+			       struct kfree_rcu_cpu **krcpp)
 {
 	unsigned long *ptr;
 
-	/* Try hard to get the memory. */
-	ptr = kmalloc(sizeof(unsigned long *) +
-		sizeof(struct rcu_head), GFP_KERNEL | __GFP_ATOMIC |
-			__GFP_HIGH | __GFP_RETRY_MAYFAIL | __GFP_NOWARN);
+	// Allocate rcu_head on the slab.
+	ptr = alloc_object_locked(sizeof(unsigned long *) + sizeof(struct rcu_head),
+				  true /* slab */, true /* headless, so can sleep */,
+				  krcpp);
 	if (!ptr)
 		return NULL;
 
@@ -3159,27 +3246,6 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
 	return ((struct rcu_head *) ++ptr);
 }
 
-static inline struct kfree_rcu_cpu *
-krc_this_cpu_lock(unsigned long *flags)
-{
-	struct kfree_rcu_cpu *krcp;
-
-	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	if (likely(krcp->initialized))
-		spin_lock(&krcp->lock);
-
-	return krcp;
-}
-
-static inline void
-krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
-{
-	if (likely(krcp->initialized))
-		spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
-}
-
 /*
  * Queue a request for lazy invocation of appropriate free routine after a
  * grace period. Please note there are three paths are maintained, two are the
@@ -3195,10 +3261,9 @@ krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
  */
 void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	unsigned long flags;
 	struct kfree_rcu_cpu *krcp;
 	bool expedited_drain = false;
-	bool success;
+	bool success, irqs_disabled;
 	void *ptr;
 
 	if (head) {
@@ -3216,7 +3281,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		ptr = (unsigned long *) func;
 	}
 
-	krcp = krc_this_cpu_lock(&flags);
+	irqs_disabled = irqs_disabled();
+	krcp = krc_this_cpu_lock(irqs_disabled);
 
 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
@@ -3229,23 +3295,14 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 		goto unlock_return;
 	}
 
-	/*
-	 * Under high memory pressure GFP_NOWAIT can fail,
-	 * in that case the emergency path is maintained.
-	 */
-	success = kvfree_call_rcu_add_ptr_to_bulk(krcp, ptr);
+	// Allow sleeping here only if headless
+	success = kvfree_call_rcu_add_ptr_to_bulk(ptr, !head /* can_sleep */, &krcp);
 	if (!success) {
 		/* Is headless object? */
 		if (head == NULL) {
-			/* Drop the lock. */
-			krc_this_cpu_unlock(krcp, flags);
-
-			head = attach_rcu_head_to_object(ptr);
+			head = attach_rcu_head_to_object(ptr, &krcp);
 			if (head == NULL)
-				goto inline_return;
-
-			/* Take it back. */
-			krcp = krc_this_cpu_lock(&flags);
+				goto unlock_return;
 
 			/*
 			 * Tag the headless object. Such objects have a back-pointer
@@ -3280,9 +3337,8 @@ void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 unlock_return:
-	krc_this_cpu_unlock(krcp, flags);
+	krc_this_cpu_unlock(krcp, irqs_disabled);
 
-inline_return:
 	/*
 	 * High memory pressure, so inline kvfree() after
 	 * synchronize_rcu(). We can do it from might_sleep()
-- 
2.26.0.110.g2183baf09c-goog

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29EA2D5E9C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbgLJOvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389333AbgLJOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A976C06179C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=TxH5r6xdf8p2qO6a6ZzIhK9cBsXAyK8PWvzotlwC7g4=; b=duD4Tl5t3h4KhjGlhZLGxGKr/0
        zf9knlGQ8dQs3urVw2lMRVwj1ru2RqpC4PtY8oUGBrDBbpaO7Dg7iK7VvFI/TEcu/vAO9Rk3NdOXf
        I/CD/ZgxWsfLFc+BY3qurVobk1O08wVJRfxDBGwcPClKWxOEq2J40Pqy9+JG8rVIfvvGblEHSaetj
        Iy4L6opH/vnxWaB5Ibq97rLHa3hJpJw4Mtk7I66FyUwXroWjbsL+T2Ba/sqqymKju5ZANrzy6O6Zv
        ptlTlCBpGO9UlrKzC70MkYOLGmLYzDHeHf5k3u320Len1by9RJhwjMCkgQP9ZvfzJlkf7taIAWK5C
        UwW4G0Lw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF5-00042e-5q; Thu, 10 Dec 2020 14:48:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EF8C7306E07;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D60332BAB36D7; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144619.932119864@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:42:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 5/6] locking/lockdep: Exclude local_lock_t from IRQ inversions
References: <20201210144254.583402167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

The purpose of local_lock_t is to abstract: preempt_disable() /
local_bh_disable() / local_irq_disable(). These are the traditional
means of gaining access to per-cpu data, but are fundamentally
non-preemptible.

local_lock_t provides a per-cpu lock, that on !PREEMPT_RT reduces to
no-ops, just like regular spinlocks do on UP.

This gives rise to:

	CPU0			CPU1

	local_lock(B)		spin_lock_irq(A)
	<IRQ>
	  spin_lock(A)		local_lock(B)

Where lockdep then figures things will lock up; which would be true if
B were any other kind of lock. However this is a false positive, no
such deadlock actually exists.

For !RT the above local_lock(B) is preempt_disable(), and there's
obviously no deadlock; alternatively, CPU0's B != CPU1's B.

For RT the argument is that since local_lock() nests inside
spin_lock(), it cannot be used in hardirq context, and therefore CPU0
cannot in fact happen. Even though B is a real lock, it is a
preemptible lock and any threaded-irq would simply schedule out and
let the preempted task (which holds B) continue such that the task on
CPU1 can make progress, after which the threaded-irq resumes and can
finish.

This means that we can never form an IRQ inversion on a local_lock
dependency, so terminate the graph walk when looking for IRQ
inversions when we encounter one.

One consequence is that (for LOCKDEP_SMALL) when we look for redundant
dependencies, A -> B is not redundant in the presence of A -> L -> B.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
[peterz: Changelog]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   57 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 4 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2200,6 +2200,44 @@ static inline bool usage_match(struct lo
 		return !!((entry->class->usage_mask & LOCKF_IRQ) & *(unsigned long *)mask);
 }
 
+static inline bool usage_skip(struct lock_list *entry, void *mask)
+{
+	/*
+	 * Skip local_lock() for irq inversion detection.
+	 *
+	 * For !RT, local_lock() is not a real lock, so it won't carry any
+	 * dependency.
+	 *
+	 * For RT, an irq inversion happens when we have lock A and B, and on
+	 * some CPU we can have:
+	 *
+	 *	lock(A);
+	 *	<interrupted>
+	 *	  lock(B);
+	 *
+	 * where lock(B) cannot sleep, and we have a dependency B -> ... -> A.
+	 *
+	 * Now we prove local_lock() cannot exist in that dependency. First we
+	 * have the observation for any lock chain L1 -> ... -> Ln, for any
+	 * 1 <= i <= n, Li.inner_wait_type <= L1.inner_wait_type, otherwise
+	 * wait context check will complain. And since B is not a sleep lock,
+	 * therefore B.inner_wait_type >= 2, and since the inner_wait_type of
+	 * local_lock() is 3, which is greater than 2, therefore there is no
+	 * way the local_lock() exists in the dependency B -> ... -> A.
+	 *
+	 * As a result, we will skip local_lock(), when we search for irq
+	 * inversion bugs.
+	 */
+	if (entry->class->lock_type == LD_LOCK_PERCPU) {
+		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
+			return false;
+
+		return true;
+	}
+
+	return false;
+}
+
 /*
  * Find a node in the forwards-direction dependency sub-graph starting
  * at @root->class that matches @bit.
@@ -2215,7 +2253,7 @@ find_usage_forwards(struct lock_list *ro
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, NULL, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, usage_skip, target_entry);
 
 	return result;
 }
@@ -2232,7 +2270,7 @@ find_usage_backwards(struct lock_list *r
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, &usage_mask, usage_match, NULL, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, usage_skip, target_entry);
 
 	return result;
 }
@@ -2597,7 +2635,7 @@ static int check_irq_usage(struct task_s
 	 */
 	bfs_init_rootb(&this, prev);
 
-	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL, NULL);
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, usage_skip, NULL);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;
@@ -2664,6 +2702,12 @@ static inline int check_irq_usage(struct
 {
 	return 1;
 }
+
+static inline bool usage_skip(struct lock_list *entry, void *mask)
+{
+	return false;
+}
+
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
 #ifdef CONFIG_LOCKDEP_SMALL
@@ -2697,7 +2741,12 @@ check_redundant(struct held_lock *src, s
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
+	/*
+	 * Note: we skip local_lock() for redundant check, because as the
+	 * comment in usage_skip(), A -> local_lock() -> B and A -> B are not
+	 * the same.
+	 */
+	ret = check_path(target, &src_entry, hlock_equal, usage_skip, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);



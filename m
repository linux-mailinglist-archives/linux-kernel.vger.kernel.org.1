Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A252D5EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389977AbgLJPFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391674AbgLJOtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:10 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F7EC061793
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=Nmd9hy8CWfpcsrV3uIlj5rMjlgTuEHK6nWF6jExS5RE=; b=YKV3v69zRTupeVGYKgrgm3mP/4
        q5xaW1lZlPn/ceSaInN2/mG6ybjxQMO0BMbEdf9ub/7XCqfODlQdVbWZicshvp/+GVqvqzBCPUjt7
        yBzzd1jSdPMjlJW3kmQAyD04NVJ0x24E+KhYBeGNhtbdkfR6EzgEU7pvfpLmU1Y5cE4iMIAecFj22
        cV6Yq7sMBHg7v9WWZZsFvUImxdumOv3gWTTn6BruNdCf3m/QWdZl2JulZxjaOztjoNAlH/mgzU08z
        ErNuYdc2cGul+i8rp66Q2Z3FnBeR8wuXeJ5x6whLY8NaFUhRCy2NrraaAjw0Wsgx8iLvV89NBJ8Dk
        vAXyZt6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF4-00044K-9d; Thu, 10 Dec 2020 14:48:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E3D823069B1;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id CE0962BAB36D5; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144619.807467620@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:42:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 3/6] locking/lockdep: Add a skip() function to __bfs()
References: <20201210144254.583402167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boqun Feng <boqun.feng@gmail.com>

Some __bfs() walks will have additional iteration constraints (beyond
the path being strong). Provide an additional function to allow
terminating graph walks.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   65 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 10 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1672,6 +1672,7 @@ static inline struct lock_list *__bfs_ne
 static enum bfs_result __bfs(struct lock_list *source_entry,
 			     void *data,
 			     bool (*match)(struct lock_list *entry, void *data),
+			     bool (*skip)(struct lock_list *entry, void *data),
 			     struct lock_list **target_entry,
 			     int offset)
 {
@@ -1732,7 +1733,12 @@ static enum bfs_result __bfs(struct lock
 		/*
 		 * Step 3: we haven't visited this and there is a strong
 		 *         dependency path to this, so check with @match.
+		 *         If @skip is provide and returns true, we skip this
+		 *         lock (and any path this lock is in).
 		 */
+		if (skip && skip(lock, data))
+			continue;
+
 		if (match(lock, data)) {
 			*target_entry = lock;
 			return BFS_RMATCH;
@@ -1775,9 +1781,10 @@ static inline enum bfs_result
 __bfs_forwards(struct lock_list *src_entry,
 	       void *data,
 	       bool (*match)(struct lock_list *entry, void *data),
+	       bool (*skip)(struct lock_list *entry, void *data),
 	       struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
+	return __bfs(src_entry, data, match, skip, target_entry,
 		     offsetof(struct lock_class, locks_after));
 
 }
@@ -1786,9 +1793,10 @@ static inline enum bfs_result
 __bfs_backwards(struct lock_list *src_entry,
 		void *data,
 		bool (*match)(struct lock_list *entry, void *data),
+	       bool (*skip)(struct lock_list *entry, void *data),
 		struct lock_list **target_entry)
 {
-	return __bfs(src_entry, data, match, target_entry,
+	return __bfs(src_entry, data, match, skip, target_entry,
 		     offsetof(struct lock_class, locks_before));
 
 }
@@ -2019,7 +2027,7 @@ static unsigned long __lockdep_count_for
 	unsigned long  count = 0;
 	struct lock_list *target_entry;
 
-	__bfs_forwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_forwards(this, (void *)&count, noop_count, NULL, &target_entry);
 
 	return count;
 }
@@ -2044,7 +2052,7 @@ static unsigned long __lockdep_count_bac
 	unsigned long  count = 0;
 	struct lock_list *target_entry;
 
-	__bfs_backwards(this, (void *)&count, noop_count, &target_entry);
+	__bfs_backwards(this, (void *)&count, noop_count, NULL, &target_entry);
 
 	return count;
 }
@@ -2072,11 +2080,12 @@ unsigned long lockdep_count_backward_dep
 static noinline enum bfs_result
 check_path(struct held_lock *target, struct lock_list *src_entry,
 	   bool (*match)(struct lock_list *entry, void *data),
+	   bool (*skip)(struct lock_list *entry, void *data),
 	   struct lock_list **target_entry)
 {
 	enum bfs_result ret;
 
-	ret = __bfs_forwards(src_entry, target, match, target_entry);
+	ret = __bfs_forwards(src_entry, target, match, skip, target_entry);
 
 	if (unlikely(bfs_error(ret)))
 		print_bfs_bug(ret);
@@ -2103,7 +2112,7 @@ check_noncircular(struct held_lock *src,
 
 	debug_atomic_inc(nr_cyclic_checks);
 
-	ret = check_path(target, &src_entry, hlock_conflict, &target_entry);
+	ret = check_path(target, &src_entry, hlock_conflict, NULL, &target_entry);
 
 	if (unlikely(ret == BFS_RMATCH)) {
 		if (!*trace) {
@@ -2152,7 +2161,7 @@ check_redundant(struct held_lock *src, s
 
 	debug_atomic_inc(nr_redundant_checks);
 
-	ret = check_path(target, &src_entry, hlock_equal, &target_entry);
+	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
 
 	if (ret == BFS_RMATCH)
 		debug_atomic_inc(nr_redundant);
@@ -2246,7 +2291,7 @@ find_usage_forwards(struct lock_list *ro
 
 	debug_atomic_inc(nr_find_usage_forwards_checks);
 
-	result = __bfs_forwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_forwards(root, &usage_mask, usage_match, NULL, target_entry);
 
 	return result;
 }
@@ -2263,7 +2308,7 @@ find_usage_backwards(struct lock_list *r
 
 	debug_atomic_inc(nr_find_usage_backwards_checks);
 
-	result = __bfs_backwards(root, &usage_mask, usage_match, target_entry);
+	result = __bfs_backwards(root, &usage_mask, usage_match, NULL, target_entry);
 
 	return result;
 }
@@ -2628,7 +2673,7 @@ static int check_irq_usage(struct task_s
 	 */
 	bfs_init_rootb(&this, prev);
 
-	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL);
+	ret = __bfs_backwards(&this, &usage_mask, usage_accumulate, NULL, NULL);
 	if (bfs_error(ret)) {
 		print_bfs_bug(ret);
 		return 0;



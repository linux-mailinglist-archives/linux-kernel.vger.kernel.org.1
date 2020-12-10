Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5B72D5EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgLJPDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 10:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgLJOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:49:21 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B60AC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OCtXDf4eX14WnkrWJCBzAyJ+r/R3bQzEewQSvRgyLXY=; b=sgUWdxllUevkYpi3+rF3DhNm7T
        IfXkXICrkeXHhJYxH3YXSTaDVFPrxCDSIVJYBfyDnvXiprOigPJ6wya1lrqUWFRGVj/+cd+UI9myr
        bern2WFgtKLXksS0jRFOlYUPHjuLXAzk55HgLigSWwcGnZ+VoLJP+oldtLCX2nZaQa3C+cOXbaEwp
        M1pZbHsNupLXga6lB+RcmDVTeI0fOc2Km4WYCInldTsl/xkKEZwNoqDbeVHyzyh/3gyv6vbqPTwgW
        6d8Qc4XEZM9j3Cn5j0rHqcDOSFcsdoUcEG/CPEjptdn939UdabpA+CfOI9ydfxJSqeLjvKgu87H+D
        kYJJKzew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1knNF5-00042g-7E; Thu, 10 Dec 2020 14:48:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E2F3F3059C6;
        Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id D1F5B2BAB36D6; Thu, 10 Dec 2020 15:48:25 +0100 (CET)
Message-ID: <20201210144619.870033538@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 10 Dec 2020 15:42:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        bigeasy@linutronix.de, peterz@infradead.org
Subject: [PATCH 4/6] locking/lockdep: Clean up check_redundant() a bit
References: <20201210144254.583402167@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for adding an TRACE_IRQFLAGS dependent skip function to
check_redundant(), move it below the TRACE_IRQFLAGS #ifdef.

While there, provide a stub function to reduce #ifdef usage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/lockdep.c |   91 +++++++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 42 deletions(-)

--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -2130,46 +2130,6 @@ check_noncircular(struct held_lock *src,
 	return ret;
 }
 
-#ifdef CONFIG_LOCKDEP_SMALL
-/*
- * Check that the dependency graph starting at <src> can lead to
- * <target> or not. If it can, <src> -> <target> dependency is already
- * in the graph.
- *
- * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
- * any error appears in the bfs search.
- */
-static noinline enum bfs_result
-check_redundant(struct held_lock *src, struct held_lock *target)
-{
-	enum bfs_result ret;
-	struct lock_list *target_entry;
-	struct lock_list src_entry;
-
-	bfs_init_root(&src_entry, src);
-	/*
-	 * Special setup for check_redundant().
-	 *
-	 * To report redundant, we need to find a strong dependency path that
-	 * is equal to or stronger than <src> -> <target>. So if <src> is E,
-	 * we need to let __bfs() only search for a path starting at a -(E*)->,
-	 * we achieve this by setting the initial node's ->only_xr to true in
-	 * that case. And if <prev> is S, we set initial ->only_xr to false
-	 * because both -(S*)-> (equal) and -(E*)-> (stronger) are redundant.
-	 */
-	src_entry.only_xr = src->read == 0;
-
-	debug_atomic_inc(nr_redundant_checks);
-
-	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
-
-	if (ret == BFS_RMATCH)
-		debug_atomic_inc(nr_redundant);
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_TRACE_IRQFLAGS
 
 /*
@@ -2706,6 +2666,55 @@ static inline int check_irq_usage(struct
 }
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
+#ifdef CONFIG_LOCKDEP_SMALL
+/*
+ * Check that the dependency graph starting at <src> can lead to
+ * <target> or not. If it can, <src> -> <target> dependency is already
+ * in the graph.
+ *
+ * Return BFS_RMATCH if it does, or BFS_RMATCH if it does not, return BFS_E* if
+ * any error appears in the bfs search.
+ */
+static noinline enum bfs_result
+check_redundant(struct held_lock *src, struct held_lock *target)
+{
+	enum bfs_result ret;
+	struct lock_list *target_entry;
+	struct lock_list src_entry;
+
+	bfs_init_root(&src_entry, src);
+	/*
+	 * Special setup for check_redundant().
+	 *
+	 * To report redundant, we need to find a strong dependency path that
+	 * is equal to or stronger than <src> -> <target>. So if <src> is E,
+	 * we need to let __bfs() only search for a path starting at a -(E*)->,
+	 * we achieve this by setting the initial node's ->only_xr to true in
+	 * that case. And if <prev> is S, we set initial ->only_xr to false
+	 * because both -(S*)-> (equal) and -(E*)-> (stronger) are redundant.
+	 */
+	src_entry.only_xr = src->read == 0;
+
+	debug_atomic_inc(nr_redundant_checks);
+
+	ret = check_path(target, &src_entry, hlock_equal, NULL, &target_entry);
+
+	if (ret == BFS_RMATCH)
+		debug_atomic_inc(nr_redundant);
+
+	return ret;
+}
+
+#else
+
+static inline enum bfs_result
+check_redundant(struct held_lock *src, struct held_lock *target)
+{
+	return BFS_RNOMATCH;
+}
+
+#endif
+
 static void inc_chains(int irq_context)
 {
 	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
@@ -2926,7 +2935,6 @@ check_prev_add(struct task_struct *curr,
 		}
 	}
 
-#ifdef CONFIG_LOCKDEP_SMALL
 	/*
 	 * Is the <prev> -> <next> link redundant?
 	 */
@@ -2935,7 +2943,6 @@ check_prev_add(struct task_struct *curr,
 		return 0;
 	else if (ret == BFS_RMATCH)
 		return 2;
-#endif
 
 	if (!*trace) {
 		*trace = save_trace();



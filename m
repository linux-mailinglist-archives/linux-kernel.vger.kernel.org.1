Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CAA30370D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:06:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732423AbhAZHGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730133AbhAYPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BA0C061797
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=tEySvZgT9wppVDTHDNYWfBCWQtOh8KxHvKl8O4iU35k=; b=fl2NVlc42EQ2DzR3e5MsaF+LdM
        57XA9Pzev55E32RD6W5PAD63PMQW/z/zliNyctEdM+jGjd9HRmI9SyGgl212PMFzMz2C4H7/J3Qwz
        5VOtBtZMYboNmeV6Rk5plzReiOiRT+FqLCb/WMEG1rUSE74kFJcb12LZNdfocxiod7UwZ5LTm1yeo
        xGmdtsmAd39jdJSFYEwSopYb2Se4VRR7FWv8jy0x1BTMykJRMiQ9H35DRGUqZ5UzH5IVv2+xDXLP9
        QUf8R7+XeiBC+Pu4kaXUNXh4HZdSYECKYarN0DHDNPV7AWvelRtpxoYOeEqhk72hgvm/brR3KLBcr
        CMVMCQfQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l43Zr-0000Cb-Jg; Mon, 25 Jan 2021 15:14:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD4E630769C;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7BFBA2B6D76CF; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151314.967657926@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 6/7] rbtree, rtmutex: Use rb_add_cached()
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce rbtree boiler plate by using the new helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/locking/rtmutex.c |   54 +++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 36 deletions(-)

--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -267,27 +267,18 @@ rt_mutex_waiter_equal(struct rt_mutex_wa
 	return 1;
 }
 
+#define __node_2_waiter(node) \
+	rb_entry((node), struct rt_mutex_waiter, tree_entry)
+
+static inline bool __waiter_less(struct rb_node *a, const struct rb_node *b)
+{
+	return rt_mutex_waiter_less(__node_2_waiter(a), __node_2_waiter(b));
+}
+
 static void
 rt_mutex_enqueue(struct rt_mutex *lock, struct rt_mutex_waiter *waiter)
 {
-	struct rb_node **link = &lock->waiters.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct rt_mutex_waiter *entry;
-	bool leftmost = true;
-
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct rt_mutex_waiter, tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&waiter->tree_entry, parent, link);
-	rb_insert_color_cached(&waiter->tree_entry, &lock->waiters, leftmost);
+	rb_add_cached(&waiter->tree_entry, &lock->waiters, __waiter_less);
 }
 
 static void
@@ -300,27 +291,18 @@ rt_mutex_dequeue(struct rt_mutex *lock,
 	RB_CLEAR_NODE(&waiter->tree_entry);
 }
 
+#define __node_2_pi_waiter(node) \
+	rb_entry((node), struct rt_mutex_waiter, pi_tree_entry)
+
+static inline bool __pi_waiter_less(struct rb_node *a, const struct rb_node *b)
+{
+	return rt_mutex_waiter_less(__node_2_pi_waiter(a), __node_2_pi_waiter(b));
+}
+
 static void
 rt_mutex_enqueue_pi(struct task_struct *task, struct rt_mutex_waiter *waiter)
 {
-	struct rb_node **link = &task->pi_waiters.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct rt_mutex_waiter *entry;
-	bool leftmost = true;
-
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct rt_mutex_waiter, pi_tree_entry);
-		if (rt_mutex_waiter_less(waiter, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&waiter->pi_tree_entry, parent, link);
-	rb_insert_color_cached(&waiter->pi_tree_entry, &task->pi_waiters, leftmost);
+	rb_add_cached(&waiter->pi_tree_entry, &task->pi_waiters, __pi_waiter_less);
 }
 
 static void



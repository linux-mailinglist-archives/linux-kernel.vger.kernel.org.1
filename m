Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839FD1BE2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgD2PiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgD2Ph5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:37:57 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91008C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=OwXDNyv82OCBoww/yglDafwQ7gsijDLa2rCC7eiHY0M=; b=fvxr1pe6+qVv6ih9kLiY6ROsE5
        jkqkssMNGQJt9J57+RwluupqaRTgHn2+OL1Deter02pnrbBUKE5eZrX4Z9vMk4Pz5tirpanZAxd6S
        ez5CLGggP44LakXHMcpzNhlZTALy5LYoJOHkamNDNRgWHMGn6fLBjbABAP8WBOIp2CR8D0rHe9wid
        b0zd7ny43WH5rkq+m4MOP6JCVfvQD+87Bhdn0n8voQCbajfwTUSBRUqT/IwVVZZmD0g39y6P2kjUj
        RcNgz+l9xF/8NWpOW3k9RzyRDQpIs61g2XZamE79/tCoDPBxnU0TQvn79VeiPvficuA87DgDtmt1V
        E3+aR8Sw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTomG-00028Y-38; Wed, 29 Apr 2020 15:37:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 66C6C306E0D;
        Wed, 29 Apr 2020 17:37:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E5641236D79F5; Wed, 29 Apr 2020 17:37:31 +0200 (CEST)
Message-Id: <20200429153549.312048012@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 29 Apr 2020 17:33:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [RFC][PATCH 6/7] rbtree, rtmutex: Use rb_add_cached()
References: <20200429153258.563269446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
+	rb_add_cached(&lock->waiters, &waiter->tree_entry, __waiter_less);
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
+	rb_add_cached(&task->pi_waiters, &waiter->pi_tree_entry, __pi_waiter_less);
 }
 
 static void



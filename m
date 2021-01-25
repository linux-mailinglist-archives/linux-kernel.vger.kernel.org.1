Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 703E8303712
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbhAZHG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:06:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbhAYPmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:12 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305AEC061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=RNbLoAodo8rvQTJnofGWBMDOeFZZC6fir1k3cjfmIsY=; b=DJCLP7QRVqIjJAaTMRmHFeHfnM
        ruNrMnh46ozxBiRcnkcDsZYoHsniQRfJyW7SOpkeS7jfYRJFnlnBFv+X+TNiAbL+UDIn12zNencxz
        huhmxIdv1hr2DLGTSpqOv5MlMOYNeF81NlH/ToVdMPYRHJZDclB39TrWKJASY1FyornUj96XCcL7/
        PxyJq8T7eEg7yBp0bVGjX4vs9gfGt+/bI6pHu9fLPTlzmM3sU/IunrVccHTChmVvYAfpy+zAuKZZ2
        QstAnZAWrP0MTCBudWcalIKtrbjQNmkgWAdDZ5+DCm4h9/6zFJ/Tc8v7S5tpLfhi6MtQ2YYxpLLld
        ekkfvQOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l43Zq-0000C3-0D; Mon, 25 Jan 2021 15:14:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81037305E21;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 6D48B2B6D76CC; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151314.731665604@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:56 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 3/7] rbtree, sched/deadline: Use rb_add_cached()
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce rbtree boiler plate by using the new helpers.

Make rb_add_cached() / rb_erase_cached() return a pointer to the
leftmost node to aid in updating additional state.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/rbtree.h  |   18 ++++++++---
 kernel/sched/deadline.c |   77 +++++++++++++++++-------------------------------
 2 files changed, 42 insertions(+), 53 deletions(-)

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -141,12 +141,18 @@ static inline void rb_insert_color_cache
 	rb_insert_color(node, &root->rb_root);
 }
 
-static inline void rb_erase_cached(struct rb_node *node,
-				   struct rb_root_cached *root)
+
+static inline struct rb_node *
+rb_erase_cached(struct rb_node *node, struct rb_root_cached *root)
 {
+	struct rb_node *leftmost = NULL;
+
 	if (root->rb_leftmost == node)
-		root->rb_leftmost = rb_next(node);
+		leftmost = root->rb_leftmost = rb_next(node);
+
 	rb_erase(node, &root->rb_root);
+
+	return leftmost;
 }
 
 static inline void rb_replace_node_cached(struct rb_node *victim,
@@ -179,8 +185,10 @@ static inline void rb_replace_node_cache
  * @node: node to insert
  * @tree: leftmost cached tree to insert @node into
  * @less: operator defining the (partial) node order
+ *
+ * Returns @node when it is the new leftmost, or NULL.
  */
-static __always_inline void
+static __always_inline struct rb_node *
 rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
 	      bool (*less)(struct rb_node *, const struct rb_node *))
 {
@@ -200,6 +208,8 @@ rb_add_cached(struct rb_node *node, stru
 
 	rb_link_node(node, parent, link);
 	rb_insert_color_cached(node, tree, leftmost);
+
+	return leftmost ? node : NULL;
 }
 
 /**
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -517,58 +517,44 @@ static void dec_dl_migration(struct sche
 	update_dl_migration(dl_rq);
 }
 
+#define __node_2_pdl(node) \
+	rb_entry((node), struct task_struct, pushable_dl_tasks)
+
+static inline bool __pushable_less(struct rb_node *a, const struct rb_node *b)
+{
+	return dl_entity_preempt(&__node_2_pdl(a)->dl, &__node_2_pdl(b)->dl);
+}
+
 /*
  * The list of pushable -deadline task is not a plist, like in
  * sched_rt.c, it is an rb-tree with tasks ordered by deadline.
  */
 static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
-	struct dl_rq *dl_rq = &rq->dl;
-	struct rb_node **link = &dl_rq->pushable_dl_tasks_root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct task_struct *entry;
-	bool leftmost = true;
+	struct rb_node *leftmost;
 
 	BUG_ON(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
 
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct task_struct,
-				 pushable_dl_tasks);
-		if (dl_entity_preempt(&p->dl, &entry->dl))
-			link = &parent->rb_left;
-		else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
+	leftmost = rb_add_cached(&p->pushable_dl_tasks,
+				 &rq->dl.pushable_dl_tasks_root,
+				 __pushable_less);
 	if (leftmost)
-		dl_rq->earliest_dl.next = p->dl.deadline;
-
-	rb_link_node(&p->pushable_dl_tasks, parent, link);
-	rb_insert_color_cached(&p->pushable_dl_tasks,
-			       &dl_rq->pushable_dl_tasks_root, leftmost);
+		rq->dl.earliest_dl.next = p->dl.deadline;
 }
 
 static void dequeue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
 	struct dl_rq *dl_rq = &rq->dl;
+	struct rb_root_cached *root = &dl_rq->pushable_dl_tasks_root;
+	struct rb_node *leftmost;
 
 	if (RB_EMPTY_NODE(&p->pushable_dl_tasks))
 		return;
 
-	if (dl_rq->pushable_dl_tasks_root.rb_leftmost == &p->pushable_dl_tasks) {
-		struct rb_node *next_node;
-
-		next_node = rb_next(&p->pushable_dl_tasks);
-		if (next_node) {
-			dl_rq->earliest_dl.next = rb_entry(next_node,
-				struct task_struct, pushable_dl_tasks)->dl.deadline;
-		}
-	}
+	leftmost = rb_erase_cached(&p->pushable_dl_tasks, root);
+	if (leftmost)
+		dl_rq->earliest_dl.next = __node_2_pdl(leftmost)->dl.deadline;
 
-	rb_erase_cached(&p->pushable_dl_tasks, &dl_rq->pushable_dl_tasks_root);
 	RB_CLEAR_NODE(&p->pushable_dl_tasks);
 }
 
@@ -1478,29 +1464,21 @@ void dec_dl_tasks(struct sched_dl_entity
 	dec_dl_migration(dl_se, dl_rq);
 }
 
+#define __node_2_dle(node) \
+	rb_entry((node), struct sched_dl_entity, rb_node)
+
+static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
+{
+	return dl_time_before(__node_2_dle(a)->deadline, __node_2_dle(b)->deadline);
+}
+
 static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rb_node **link = &dl_rq->root.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_dl_entity *entry;
-	int leftmost = 1;
 
 	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
 
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_dl_entity, rb_node);
-		if (dl_time_before(dl_se->deadline, entry->deadline))
-			link = &parent->rb_left;
-		else {
-			link = &parent->rb_right;
-			leftmost = 0;
-		}
-	}
-
-	rb_link_node(&dl_se->rb_node, parent, link);
-	rb_insert_color_cached(&dl_se->rb_node, &dl_rq->root, leftmost);
+	rb_add_cached(&dl_se->rb_node, &dl_rq->root, __dl_less);
 
 	inc_dl_tasks(dl_se, dl_rq);
 }
@@ -1513,6 +1491,7 @@ static void __dequeue_dl_entity(struct s
 		return;
 
 	rb_erase_cached(&dl_se->rb_node, &dl_rq->root);
+
 	RB_CLEAR_NODE(&dl_se->rb_node);
 
 	dec_dl_tasks(dl_se, dl_rq);



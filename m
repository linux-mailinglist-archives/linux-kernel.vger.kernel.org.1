Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63D303709
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389395AbhAZHEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730151AbhAYPkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:40:06 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04CC0617A9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=p225bOB5VMtJbqg7SmeC67IH1dLjYb+jLZ8dBC0vKqU=; b=FACR22qG5NmV+wiBAhDPRWmYTj
        ZkJ8VH0b1wUxCxJGLXHzjBQshOS6ICX3wmZ1ec888SuK/FwLPIyEqmp2d72MQG3Yisd7Bd2SKnhmD
        juElPp0TkdG848SGpt4FuCIaQQF4z8NmboOHZXkvAvC91M/utCRorm/oQ6HV9Zah/mv8HiJeMH3Eo
        5ZcRtyPHxl/cMmIL1gKiHYVTwfBWu5sSNiyWjpl2uG0vcEDIl3dFznj9sS2R35vcFTqQxBdkt69QY
        ZFPyKKCIYbuLitOtad/bdpchzcWo4IwVqwLLyGBGhyLJA+7s/tnNjAjUsqW+cJjliwP1hrJLz+JYB
        TS8jFVXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l43Zq-004KsQ-3u; Mon, 25 Jan 2021 15:14:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7C4763059DD;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 681282B6D76CA; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151314.654744782@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 2/7] rbtree, sched/fair: Use rb_add_cached()
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce rbtree boiler plate by using the new helper function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/fair.c |   46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -533,12 +533,15 @@ static inline u64 min_vruntime(u64 min_v
 	return min_vruntime;
 }
 
-static inline int entity_before(struct sched_entity *a,
+static inline bool entity_before(struct sched_entity *a,
 				struct sched_entity *b)
 {
 	return (s64)(a->vruntime - b->vruntime) < 0;
 }
 
+#define __node_2_se(node) \
+	rb_entry((node), struct sched_entity, run_node)
+
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr = cfs_rq->curr;
@@ -554,8 +557,7 @@ static void update_min_vruntime(struct c
 	}
 
 	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se;
-		se = rb_entry(leftmost, struct sched_entity, run_node);
+		struct sched_entity *se = __node_2_se(leftmost);
 
 		if (!curr)
 			vruntime = se->vruntime;
@@ -571,37 +573,17 @@ static void update_min_vruntime(struct c
 #endif
 }
 
+static inline bool __entity_less(struct rb_node *a, const struct rb_node *b)
+{
+	return entity_before(__node_2_se(a), __node_2_se(b));
+}
+
 /*
  * Enqueue an entity into the rb-tree:
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	struct rb_node **link = &cfs_rq->tasks_timeline.rb_root.rb_node;
-	struct rb_node *parent = NULL;
-	struct sched_entity *entry;
-	bool leftmost = true;
-
-	/*
-	 * Find the right place in the rbtree:
-	 */
-	while (*link) {
-		parent = *link;
-		entry = rb_entry(parent, struct sched_entity, run_node);
-		/*
-		 * We dont care about collisions. Nodes with
-		 * the same key stay together.
-		 */
-		if (entity_before(se, entry)) {
-			link = &parent->rb_left;
-		} else {
-			link = &parent->rb_right;
-			leftmost = false;
-		}
-	}
-
-	rb_link_node(&se->run_node, parent, link);
-	rb_insert_color_cached(&se->run_node,
-			       &cfs_rq->tasks_timeline, leftmost);
+	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
@@ -616,7 +598,7 @@ struct sched_entity *__pick_first_entity
 	if (!left)
 		return NULL;
 
-	return rb_entry(left, struct sched_entity, run_node);
+	return __node_2_se(left);
 }
 
 static struct sched_entity *__pick_next_entity(struct sched_entity *se)
@@ -626,7 +608,7 @@ static struct sched_entity *__pick_next_
 	if (!next)
 		return NULL;
 
-	return rb_entry(next, struct sched_entity, run_node);
+	return __node_2_se(next);
 }
 
 #ifdef CONFIG_SCHED_DEBUG
@@ -637,7 +619,7 @@ struct sched_entity *__pick_last_entity(
 	if (!last)
 		return NULL;
 
-	return rb_entry(last, struct sched_entity, run_node);
+	return __node_2_se(last);
 }
 
 /**************************************************************



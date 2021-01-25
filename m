Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6A5302725
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbhAYPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 10:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730295AbhAYPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:43:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA89BC0617AA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=+N3dQkYlLxs8i5hcB6leniGln0+8d1xqIFyV5mhxTpI=; b=OopwtapzenrrG4wXlecz8UY5uB
        j3Q1yJoI7JE9T+aT6cA1l3LN+cUxdphHloMAT3dZlvDEOnc7W2hhJB3x/fPSOt7z0uEsdaINlCEh2
        0QevigKwZXqTIQLlrPlII4H6ZF3Vu6AK7gJ6o3Zg2aGPjnghHvezvOFyYgYpDXYeSFO6Vm71iH8MD
        /F4bCbTlB6hrzoo8EWxJpewopbRs6A1tN5iS/CnjJQBsuAtF1cGPmQEMa7PMbUXna2dS9+6XIb6KO
        6XzLMWHj4zHMG8kiQ7g4/i+OZPRsSKa185sNuB+vVnkhcbe5CiWAFkY1rFr5Ch9c0aKxVTctqGNES
        WYCNy6Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l43Zp-004KsO-1s; Mon, 25 Jan 2021 15:14:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 872AB3070D5;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 7257B2B6D76CD; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151314.808569647@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org, Tejun Heo <tj@kernel.org>
Subject: [PATCH v2 4/7] rbtree, perf: Use new rbtree helpers
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce rbtree boiler plate by using the new helpers.

One noteworthy change is unification of the various (partial) compare
functions. We construct a subtree match by forcing the sub-order to
always match, see __group_cmp().

Due to 'const' we had to touch cgroup_id().

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/cgroup.h |    4 
 kernel/events/core.c   |  201 ++++++++++++++++++++++---------------------------
 2 files changed, 95 insertions(+), 110 deletions(-)

--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -307,7 +307,7 @@ void css_task_iter_end(struct css_task_i
  * Inline functions.
  */
 
-static inline u64 cgroup_id(struct cgroup *cgrp)
+static inline u64 cgroup_id(const struct cgroup *cgrp)
 {
 	return cgrp->kn->id;
 }
@@ -701,7 +701,7 @@ void cgroup_path_from_kernfs_id(u64 id,
 struct cgroup_subsys_state;
 struct cgroup;
 
-static inline u64 cgroup_id(struct cgroup *cgrp) { return 1; }
+static inline u64 cgroup_id(const struct cgroup *cgrp) { return 1; }
 static inline void css_get(struct cgroup_subsys_state *css) {}
 static inline void css_put(struct cgroup_subsys_state *css) {}
 static inline int cgroup_attach_task_all(struct task_struct *from,
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1575,50 +1575,91 @@ static void perf_event_groups_init(struc
 	groups->index = 0;
 }
 
+static inline struct cgroup *event_cgroup(const struct perf_event *event)
+{
+	struct cgroup *cgroup = NULL;
+
+#ifdef CONFIG_CGROUP_PERF
+	if (event->cgrp)
+		cgroup = event->cgrp->css.cgroup;
+#endif
+
+	return cgroup;
+}
+
 /*
  * Compare function for event groups;
  *
  * Implements complex key that first sorts by CPU and then by virtual index
  * which provides ordering when rotating groups for the same CPU.
  */
-static bool
-perf_event_groups_less(struct perf_event *left, struct perf_event *right)
-{
-	if (left->cpu < right->cpu)
-		return true;
-	if (left->cpu > right->cpu)
-		return false;
+static __always_inline int
+perf_event_groups_cmp(const int left_cpu, const struct cgroup *left_cgroup,
+		      const u64 left_group_index, const struct perf_event *right)
+{
+	if (left_cpu < right->cpu)
+		return -1;
+	if (left_cpu > right->cpu)
+		return 1;
 
 #ifdef CONFIG_CGROUP_PERF
-	if (left->cgrp != right->cgrp) {
-		if (!left->cgrp || !left->cgrp->css.cgroup) {
-			/*
-			 * Left has no cgroup but right does, no cgroups come
-			 * first.
-			 */
-			return true;
-		}
-		if (!right->cgrp || !right->cgrp->css.cgroup) {
-			/*
-			 * Right has no cgroup but left does, no cgroups come
-			 * first.
-			 */
-			return false;
-		}
-		/* Two dissimilar cgroups, order by id. */
-		if (left->cgrp->css.cgroup->kn->id < right->cgrp->css.cgroup->kn->id)
-			return true;
+	{
+		const struct cgroup *right_cgroup = event_cgroup(right);
+
+		if (left_cgroup != right_cgroup) {
+			if (!left_cgroup) {
+				/*
+				 * Left has no cgroup but right does, no
+				 * cgroups come first.
+				 */
+				return -1;
+			}
+			if (!right_cgroup) {
+				/*
+				 * Right has no cgroup but left does, no
+				 * cgroups come first.
+				 */
+				return 1;
+			}
+			/* Two dissimilar cgroups, order by id. */
+			if (cgroup_id(left_cgroup) < cgroup_id(right_cgroup))
+				return -1;
 
-		return false;
+			return 1;
+		}
 	}
 #endif
 
-	if (left->group_index < right->group_index)
-		return true;
-	if (left->group_index > right->group_index)
-		return false;
+	if (left_group_index < right->group_index)
+		return -1;
+	if (left_group_index > right->group_index)
+		return 1;
+
+	return 0;
+}
+
+#define __node_2_pe(node) \
+	rb_entry((node), struct perf_event, group_node)
 
-	return false;
+static inline bool __group_less(struct rb_node *a, const struct rb_node *b)
+{
+	struct perf_event *e = __node_2_pe(a);
+	return perf_event_groups_cmp(e->cpu, event_cgroup(e), e->group_index,
+				     __node_2_pe(b)) < 0;
+}
+
+struct __group_key {
+	int cpu;
+	struct cgroup *cgroup;
+};
+
+static inline int __group_cmp(const void *key, const struct rb_node *node)
+{
+	const struct __group_key *a = key;
+	const struct perf_event *b = __node_2_pe(node);
+
+	/* partial/subtree match: @cpu, @cgroup; ignore: @group_index */
+	return perf_event_groups_cmp(a->cpu, a->cgroup, b->group_index, b);
 }
 
 /*
@@ -1630,27 +1671,9 @@ static void
 perf_event_groups_insert(struct perf_event_groups *groups,
 			 struct perf_event *event)
 {
-	struct perf_event *node_event;
-	struct rb_node *parent;
-	struct rb_node **node;
-
 	event->group_index = ++groups->index;
 
-	node = &groups->tree.rb_node;
-	parent = *node;
-
-	while (*node) {
-		parent = *node;
-		node_event = container_of(*node, struct perf_event, group_node);
-
-		if (perf_event_groups_less(event, node_event))
-			node = &parent->rb_left;
-		else
-			node = &parent->rb_right;
-	}
-
-	rb_link_node(&event->group_node, parent, node);
-	rb_insert_color(&event->group_node, &groups->tree);
+	rb_add(&event->group_node, &groups->tree, __group_less);
 }
 
 /*
@@ -1698,45 +1721,17 @@ static struct perf_event *
 perf_event_groups_first(struct perf_event_groups *groups, int cpu,
 			struct cgroup *cgrp)
 {
-	struct perf_event *node_event = NULL, *match = NULL;
-	struct rb_node *node = groups->tree.rb_node;
-#ifdef CONFIG_CGROUP_PERF
-	u64 node_cgrp_id, cgrp_id = 0;
-
-	if (cgrp)
-		cgrp_id = cgrp->kn->id;
-#endif
-
-	while (node) {
-		node_event = container_of(node, struct perf_event, group_node);
-
-		if (cpu < node_event->cpu) {
-			node = node->rb_left;
-			continue;
-		}
-		if (cpu > node_event->cpu) {
-			node = node->rb_right;
-			continue;
-		}
-#ifdef CONFIG_CGROUP_PERF
-		node_cgrp_id = 0;
-		if (node_event->cgrp && node_event->cgrp->css.cgroup)
-			node_cgrp_id = node_event->cgrp->css.cgroup->kn->id;
-
-		if (cgrp_id < node_cgrp_id) {
-			node = node->rb_left;
-			continue;
-		}
-		if (cgrp_id > node_cgrp_id) {
-			node = node->rb_right;
-			continue;
-		}
-#endif
-		match = node_event;
-		node = node->rb_left;
-	}
+	struct __group_key key = {
+		.cpu = cpu,
+		.cgroup = cgrp,
+	};
+	struct rb_node *node;
+
+	node = rb_find_first(&key, &groups->tree, __group_cmp);
+	if (node)
+		return __node_2_pe(node);
 
-	return match;
+	return NULL;
 }
 
 /*
@@ -1745,27 +1740,17 @@ perf_event_groups_first(struct perf_even
 static struct perf_event *
 perf_event_groups_next(struct perf_event *event)
 {
-	struct perf_event *next;
-#ifdef CONFIG_CGROUP_PERF
-	u64 curr_cgrp_id = 0;
-	u64 next_cgrp_id = 0;
-#endif
+	struct __group_key key = {
+		.cpu = event->cpu,
+		.cgroup = event_cgroup(event),
+	};
+	struct rb_node *next;
+
+	next = rb_next_match(&key, &event->group_node, __group_cmp);
+	if (next)
+		return __node_2_pe(next);
 
-	next = rb_entry_safe(rb_next(&event->group_node), typeof(*event), group_node);
-	if (next == NULL || next->cpu != event->cpu)
-		return NULL;
-
-#ifdef CONFIG_CGROUP_PERF
-	if (event->cgrp && event->cgrp->css.cgroup)
-		curr_cgrp_id = event->cgrp->css.cgroup->kn->id;
-
-	if (next->cgrp && next->cgrp->css.cgroup)
-		next_cgrp_id = next->cgrp->css.cgroup->kn->id;
-
-	if (curr_cgrp_id != next_cgrp_id)
-		return NULL;
-#endif
-	return next;
+	return NULL;
 }
 
 /*



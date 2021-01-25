Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F31303730
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389355AbhAZHI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730246AbhAYPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2340C061351
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UsLO6yHAqa2gGRsR3PWXfwYZlmZaECLWthqE36P4FKc=; b=FY4UL1/wz90xFQ1t+cq6FiLDbj
        6l/93oTFaz2K9dQvrdXV9YYpuCO9K5tnsbQyyVFaGGge60JPUI/MJVIfZf6Qa5PxApUhTTZV/xpMz
        HLuU6yE0QjthZ7f5a0FDG9J3uznKeey985OZuSY2vso3YiNIGaiViB31+9gUe1mPZ+XnhHmfLiP7i
        IhVj1k89dkHVoMR3y1QZt286VW2YOyIySFMsxy5LcDpnMOpYLL24/9qojH64zDuZXRELLnXPmC5A0
        9pA+g7VrG3qOtyrILNzB9aqQWUzrXoHfbPYDH6JVEh/oIG2E3Ty1ltk4KJCPUl8bReHAbL7/uQbHs
        AdeNf4AA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l43Zq-004KsR-MN; Mon, 25 Jan 2021 15:15:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD4753075F1;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 75D1B200843C0; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151314.888570583@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 5/7] rbtree, uprobes: Use rbtree helpers
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce rbtree boilerplate by using the new helpers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/uprobes.c |   82 +++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 42 deletions(-)

--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -619,41 +619,56 @@ static void put_uprobe(struct uprobe *up
 	}
 }
 
-static int match_uprobe(struct uprobe *l, struct uprobe *r)
+static __always_inline
+int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
+	       const struct uprobe *r)
 {
-	if (l->inode < r->inode)
+	if (l_inode < r->inode)
 		return -1;
 
-	if (l->inode > r->inode)
+	if (l_inode > r->inode)
 		return 1;
 
-	if (l->offset < r->offset)
+	if (l_offset < r->offset)
 		return -1;
 
-	if (l->offset > r->offset)
+	if (l_offset > r->offset)
 		return 1;
 
 	return 0;
 }
 
+#define __node_2_uprobe(node) \
+	rb_entry((node), struct uprobe, rb_node)
+
+struct __uprobe_key {
+	struct inode *inode;
+	loff_t offset;
+};
+
+static inline int __uprobe_cmp_key(const void *key, const struct rb_node *b)
+{
+	const struct __uprobe_key *a = key;
+	return uprobe_cmp(a->inode, a->offset, __node_2_uprobe(b));
+}
+
+static inline int __uprobe_cmp(struct rb_node *a, const struct rb_node *b)
+{
+	struct uprobe *u = __node_2_uprobe(a);
+	return uprobe_cmp(u->inode, u->offset, __node_2_uprobe(b));
+}
+
 static struct uprobe *__find_uprobe(struct inode *inode, loff_t offset)
 {
-	struct uprobe u = { .inode = inode, .offset = offset };
-	struct rb_node *n = uprobes_tree.rb_node;
-	struct uprobe *uprobe;
-	int match;
+	struct __uprobe_key key = {
+		.inode = inode,
+		.offset = offset,
+	};
+	struct rb_node *node = rb_find(&key, &uprobes_tree, __uprobe_cmp_key);
+
+	if (node)
+		return __node_2_uprobe(node);
 
-	while (n) {
-		uprobe = rb_entry(n, struct uprobe, rb_node);
-		match = match_uprobe(&u, uprobe);
-		if (!match)
-			return get_uprobe(uprobe);
-
-		if (match < 0)
-			n = n->rb_left;
-		else
-			n = n->rb_right;
-	}
 	return NULL;
 }
 
@@ -674,32 +689,15 @@ static struct uprobe *find_uprobe(struct
 
 static struct uprobe *__insert_uprobe(struct uprobe *uprobe)
 {
-	struct rb_node **p = &uprobes_tree.rb_node;
-	struct rb_node *parent = NULL;
-	struct uprobe *u;
-	int match;
-
-	while (*p) {
-		parent = *p;
-		u = rb_entry(parent, struct uprobe, rb_node);
-		match = match_uprobe(uprobe, u);
-		if (!match)
-			return get_uprobe(u);
-
-		if (match < 0)
-			p = &parent->rb_left;
-		else
-			p = &parent->rb_right;
+	struct rb_node *node;
 
-	}
+	node = rb_find_add(&uprobe->rb_node, &uprobes_tree, __uprobe_cmp);
+	if (node)
+		return get_uprobe(__node_2_uprobe(node));
 
-	u = NULL;
-	rb_link_node(&uprobe->rb_node, parent, p);
-	rb_insert_color(&uprobe->rb_node, &uprobes_tree);
 	/* get access + creation ref */
 	refcount_set(&uprobe->ref, 2);
-
-	return u;
+	return NULL;
 }
 
 /*



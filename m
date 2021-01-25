Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68066303733
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 08:13:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389448AbhAZHLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 02:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbhAYPm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:42:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E3C0617AB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 07:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FrkyJH9N2oXi9xY7KULXItjsoY9MYakLxxRqHjbSlIs=; b=ZzUo6aUMmQcKVV4QcXLLN+urHX
        CLRs1AqltZupLhua90/snOC5DFdvQjnvmcMWtiFf4NMn/dl7AhOxmDC18cQzoeZQU3NpR9HPiA0rG
        fGs6GeC3lulst8ymGegBjblZSeC74PP4F60Jo5GlxNBRQAQKUfiQv5EF3qG79lY1i12Y6I/gPOk8s
        nmP401xYN0qch1p5QVvjngrkAANopkTJadgJEvZPm8li1pTDzxjUg5uOuK8kLRj/jDB8uKHja4AJe
        J41CSV9TIuv2TtOfkr313eMqeU9PEilEyoaIf3P+j4ZJeYXac8wtLh9TlAdplzB5iSFX8XC1NP40+
        yKSjY3zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l43Zq-004KsP-3n; Mon, 25 Jan 2021 15:15:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7E1AA305C22;
        Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 63FB4200E5328; Mon, 25 Jan 2021 16:14:47 +0100 (CET)
Message-ID: <20210125151314.569403269@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 25 Jan 2021 16:09:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     walken@google.com, dave@stgolabs.net, mingo@kernel.org,
        tglx@linutronix.de, oleg@redhat.com, irogers@google.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Subject: [PATCH v2 1/7] rbtree: Add generic add and find helpers
References: <20210125150953.679129361@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've always been bothered by the endless (fragile) boilerplate for
rbtree, and I recently wrote some rbtree helpers for objtool and
figured I should lift them into the kernel and use them more widely.

Provide:

partial-order; less() based:
 - rb_add(): add a new entry to the rbtree
 - rb_add_cached(): like rb_add(), but for a rb_root_cached

total-order; cmp() based:
 - rb_find(): find an entry in an rbtree
 - rb_find_add(): find an entry, and add if not found

 - rb_find_first(): find the first (leftmost) matching entry
 - rb_next_match(): continue from rb_find_first()
 - rb_for_each(): iterate a sub-tree using the previous two

Inlining and constant propagation should see the compiler inline the
whole thing, including the various compare functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Michel Lespinasse <walken@google.com>
---
 include/linux/rbtree.h       |  190 ++++++++++++++++++++++++++++++++++++++++++
 tools/include/linux/rbtree.h |  192 ++++++++++++++++++++++++++++++++++++++++++-
 tools/objtool/elf.c          |   73 ++--------------
 3 files changed, 392 insertions(+), 63 deletions(-)

--- a/include/linux/rbtree.h
+++ b/include/linux/rbtree.h
@@ -158,4 +158,194 @@ static inline void rb_replace_node_cache
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
+/*
+ * The below helper functions use 2 operators with 3 different
+ * calling conventions. The operators are related like:
+ *
+ *	comp(a->key,b) < 0  := less(a,b)
+ *	comp(a->key,b) > 0  := less(b,a)
+ *	comp(a->key,b) == 0 := !less(a,b) && !less(b,a)
+ *
+ * If these operators define a partial order on the elements we make no
+ * guarantee on which of the elements matching the key is found. See
+ * rb_find().
+ *
+ * The reason for this is to allow the find() interface without requiring an
+ * on-stack dummy object, which might not be feasible due to object size.
+ */
+
+/**
+ * rb_add_cached() - insert @node into the leftmost cached tree @tree
+ * @node: node to insert
+ * @tree: leftmost cached tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
+	      bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+}
+
+/**
+ * rb_add() - insert @node into @tree
+ * @node: node to insert
+ * @tree: tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add(struct rb_node *node, struct rb_root *tree,
+       bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+/**
+ * rb_find_add() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add(struct rb_node *node, struct rb_root *tree,
+	    int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
+ * rb_find() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find(const void *key, const struct rb_root *tree,
+	int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = node->rb_left;
+		else if (c > 0)
+			node = node->rb_right;
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
+/**
+ * rb_find_first() - find the first @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the leftmost node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_first(const void *key, const struct rb_root *tree,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+/**
+ * rb_next_match() - find the next @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the next node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_next_match(const void *key, struct rb_node *node,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+/**
+ * rb_for_each() - iterates a subtree matching @key
+ * @node: iterator
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ */
+#define rb_for_each(node, key, tree, cmp) \
+	for ((node) = rb_find_first((key), (tree), (cmp)); \
+	     (node); (node) = rb_next_match((key), (node), (cmp)))
+
 #endif	/* _LINUX_RBTREE_H */
--- a/tools/include/linux/rbtree.h
+++ b/tools/include/linux/rbtree.h
@@ -152,4 +152,194 @@ static inline void rb_replace_node_cache
 	rb_replace_node(victim, new, &root->rb_root);
 }
 
-#endif /* __TOOLS_LINUX_PERF_RBTREE_H */
+/*
+ * The below helper functions use 2 operators with 3 different
+ * calling conventions. The operators are related like:
+ *
+ *	comp(a->key,b) < 0  := less(a,b)
+ *	comp(a->key,b) > 0  := less(b,a)
+ *	comp(a->key,b) == 0 := !less(a,b) && !less(b,a)
+ *
+ * If these operators define a partial order on the elements we make no
+ * guarantee on which of the elements matching the key is found. See
+ * rb_find().
+ *
+ * The reason for this is to allow the find() interface without requiring an
+ * on-stack dummy object, which might not be feasible due to object size.
+ */
+
+/**
+ * rb_add_cached() - insert @node into the leftmost cached tree @tree
+ * @node: node to insert
+ * @tree: leftmost cached tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add_cached(struct rb_node *node, struct rb_root_cached *tree,
+	      bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_root.rb_node;
+	struct rb_node *parent = NULL;
+	bool leftmost = true;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent)) {
+			link = &parent->rb_left;
+		} else {
+			link = &parent->rb_right;
+			leftmost = false;
+		}
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color_cached(node, tree, leftmost);
+}
+
+/**
+ * rb_add() - insert @node into @tree
+ * @node: node to insert
+ * @tree: tree to insert @node into
+ * @less: operator defining the (partial) node order
+ */
+static __always_inline void
+rb_add(struct rb_node *node, struct rb_root *tree,
+       bool (*less)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+
+	while (*link) {
+		parent = *link;
+		if (less(node, parent))
+			link = &parent->rb_left;
+		else
+			link = &parent->rb_right;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+}
+
+/**
+ * rb_find_add() - find equivalent @node in @tree, or add @node
+ * @node: node to look-for / insert
+ * @tree: tree to search / modify
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @node, or NULL when no match is found and @node
+ * is inserted.
+ */
+static __always_inline struct rb_node *
+rb_find_add(struct rb_node *node, struct rb_root *tree,
+	    int (*cmp)(struct rb_node *, const struct rb_node *))
+{
+	struct rb_node **link = &tree->rb_node;
+	struct rb_node *parent = NULL;
+	int c;
+
+	while (*link) {
+		parent = *link;
+		c = cmp(node, parent);
+
+		if (c < 0)
+			link = &parent->rb_left;
+		else if (c > 0)
+			link = &parent->rb_right;
+		else
+			return parent;
+	}
+
+	rb_link_node(node, parent, link);
+	rb_insert_color(node, tree);
+	return NULL;
+}
+
+/**
+ * rb_find() - find @key in tree @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining the node order
+ *
+ * Returns the rb_node matching @key or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find(const void *key, const struct rb_root *tree,
+	int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c < 0)
+			node = node->rb_left;
+		else if (c > 0)
+			node = node->rb_right;
+		else
+			return node;
+	}
+
+	return NULL;
+}
+
+/**
+ * rb_find_first() - find the first @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the leftmost node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_find_first(const void *key, const struct rb_root *tree,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	struct rb_node *node = tree->rb_node;
+	struct rb_node *match = NULL;
+
+	while (node) {
+		int c = cmp(key, node);
+
+		if (c <= 0) {
+			if (!c)
+				match = node;
+			node = node->rb_left;
+		} else if (c > 0) {
+			node = node->rb_right;
+		}
+	}
+
+	return match;
+}
+
+/**
+ * rb_next_match() - find the next @key in @tree
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ *
+ * Returns the next node matching @key, or NULL.
+ */
+static __always_inline struct rb_node *
+rb_next_match(const void *key, struct rb_node *node,
+	      int (*cmp)(const void *key, const struct rb_node *))
+{
+	node = rb_next(node);
+	if (node && cmp(key, node))
+		node = NULL;
+	return node;
+}
+
+/**
+ * rb_for_each() - iterates a subtree matching @key
+ * @node: iterator
+ * @key: key to match
+ * @tree: tree to search
+ * @cmp: operator defining node order
+ */
+#define rb_for_each(node, key, tree, cmp) \
+	for ((node) = rb_find_first((key), (tree), (cmp)); \
+	     (node); (node) = rb_next_match((key), (node), (cmp)))
+
+#endif	/* __TOOLS_LINUX_PERF_RBTREE_H */
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -43,75 +43,24 @@ static void elf_hash_init(struct hlist_h
 #define elf_hash_for_each_possible(name, obj, member, key)			\
 	hlist_for_each_entry(obj, &name[hash_min(key, elf_hash_bits())], member)
 
-static void rb_add(struct rb_root *tree, struct rb_node *node,
-		   int (*cmp)(struct rb_node *, const struct rb_node *))
-{
-	struct rb_node **link = &tree->rb_node;
-	struct rb_node *parent = NULL;
-
-	while (*link) {
-		parent = *link;
-		if (cmp(node, parent) < 0)
-			link = &parent->rb_left;
-		else
-			link = &parent->rb_right;
-	}
-
-	rb_link_node(node, parent, link);
-	rb_insert_color(node, tree);
-}
-
-static struct rb_node *rb_find_first(const struct rb_root *tree, const void *key,
-			       int (*cmp)(const void *key, const struct rb_node *))
-{
-	struct rb_node *node = tree->rb_node;
-	struct rb_node *match = NULL;
-
-	while (node) {
-		int c = cmp(key, node);
-		if (c <= 0) {
-			if (!c)
-				match = node;
-			node = node->rb_left;
-		} else if (c > 0) {
-			node = node->rb_right;
-		}
-	}
-
-	return match;
-}
-
-static struct rb_node *rb_next_match(struct rb_node *node, const void *key,
-				    int (*cmp)(const void *key, const struct rb_node *))
-{
-	node = rb_next(node);
-	if (node && cmp(key, node))
-		node = NULL;
-	return node;
-}
-
-#define rb_for_each(tree, node, key, cmp) \
-	for ((node) = rb_find_first((tree), (key), (cmp)); \
-	     (node); (node) = rb_next_match((node), (key), (cmp)))
-
-static int symbol_to_offset(struct rb_node *a, const struct rb_node *b)
+static bool symbol_to_offset(struct rb_node *a, const struct rb_node *b)
 {
 	struct symbol *sa = rb_entry(a, struct symbol, node);
 	struct symbol *sb = rb_entry(b, struct symbol, node);
 
 	if (sa->offset < sb->offset)
-		return -1;
+		return true;
 	if (sa->offset > sb->offset)
-		return 1;
+		return false;
 
 	if (sa->len < sb->len)
-		return -1;
+		return true;
 	if (sa->len > sb->len)
-		return 1;
+		return false;
 
 	sa->alias = sb;
 
-	return 0;
+	return false;
 }
 
 static int symbol_by_offset(const void *key, const struct rb_node *node)
@@ -165,7 +114,7 @@ struct symbol *find_symbol_by_offset(str
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->offset == offset && s->type != STT_SECTION)
@@ -179,7 +128,7 @@ struct symbol *find_func_by_offset(struc
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->offset == offset && s->type == STT_FUNC)
@@ -193,7 +142,7 @@ struct symbol *find_symbol_containing(co
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->type != STT_SECTION)
@@ -207,7 +156,7 @@ struct symbol *find_func_containing(stru
 {
 	struct rb_node *node;
 
-	rb_for_each(&sec->symbol_tree, node, &offset, symbol_by_offset) {
+	rb_for_each(node, &offset, &sec->symbol_tree, symbol_by_offset) {
 		struct symbol *s = rb_entry(node, struct symbol, node);
 
 		if (s->type == STT_FUNC)
@@ -439,7 +388,7 @@ static int read_symbols(struct elf *elf)
 		sym->offset = sym->sym.st_value;
 		sym->len = sym->sym.st_size;
 
-		rb_add(&sym->sec->symbol_tree, &sym->node, symbol_to_offset);
+		rb_add(&sym->node, &sym->sec->symbol_tree, symbol_to_offset);
 		pnode = rb_prev(&sym->node);
 		if (pnode)
 			entry = &rb_entry(pnode, struct symbol, node)->list;



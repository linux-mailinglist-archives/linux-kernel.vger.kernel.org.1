Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3042F848B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbhAOSgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:36:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:56104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbhAOSgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:36:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CE96EACAD;
        Fri, 15 Jan 2021 18:35:53 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm, slub: splice cpu and page freelists in deactivate_slab()
Date:   Fri, 15 Jan 2021 19:35:43 +0100
Message-Id: <20210115183543.15097-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In deactivate_slab() we currently move all but one objects on the cpu freelist
to the page freelist one by one using the costly cmpxchg_double() operation.
Then we unfreeze the page while moving the last object on page freelist, with
a final cmpxchg_double().

This can be optimized to avoid the cmpxchg_double() per object. Just count the
objects on cpu freelist (to adjust page->inuse properly) and also remember the
last object in the chain. Then splice page->freelist to the last object and
effectively add the whole cpu freelist to page->freelist while unfreezing the
page, with a single cmpxchg_double().

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
Hi,

I stumbled on the optimization while pondering over what to do with the percpu
partial list memory wastage [1], but it should be useful on its own. I haven't
run any measurements yet, but eliminating cmpxchg_double() operations should be
obviously faster [TM]. Passed some basic testing, including hardened freelist
and slub_debug.

[1] https://lore.kernel.org/linux-mm/CAG48ez2Qx5K1Cab-m8BdSibp6wLTip6ro4=-umR7BLsEgjEYzA@mail.gmail.com/

 mm/slub.c | 59 ++++++++++++++++++++++---------------------------------
 1 file changed, 24 insertions(+), 35 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0d4bdf6783ee..c3141aa962be 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2167,9 +2167,9 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 {
 	enum slab_modes { M_NONE, M_PARTIAL, M_FULL, M_FREE };
 	struct kmem_cache_node *n = get_node(s, page_to_nid(page));
-	int lock = 0;
+	int lock = 0, free_delta = 0;
 	enum slab_modes l = M_NONE, m = M_NONE;
-	void *nextfree;
+	void *nextfree, *freelist_iter, *freelist_tail;
 	int tail = DEACTIVATE_TO_HEAD;
 	struct page new;
 	struct page old;
@@ -2180,45 +2180,34 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	}
 
 	/*
-	 * Stage one: Free all available per cpu objects back
-	 * to the page freelist while it is still frozen. Leave the
-	 * last one.
-	 *
-	 * There is no need to take the list->lock because the page
-	 * is still frozen.
+	 * Stage one: Count the objects on cpu's freelist as free_delta and
+	 * remember the last object in freelist_tail for later splicing.
 	 */
-	while (freelist && (nextfree = get_freepointer(s, freelist))) {
-		void *prior;
-		unsigned long counters;
+	freelist_tail = NULL;
+	freelist_iter = freelist;
+	while (freelist_iter) {
+		nextfree = get_freepointer(s, freelist_iter);
 
 		/*
 		 * If 'nextfree' is invalid, it is possible that the object at
-		 * 'freelist' is already corrupted.  So isolate all objects
-		 * starting at 'freelist'.
+		 * 'freelist_iter' is already corrupted.  So isolate all objects
+		 * starting at 'freelist_iter' by skipping them.
 		 */
-		if (freelist_corrupted(s, page, &freelist, nextfree))
+		if (freelist_corrupted(s, page, &freelist_iter, nextfree))
 			break;
 
-		do {
-			prior = page->freelist;
-			counters = page->counters;
-			set_freepointer(s, freelist, prior);
-			new.counters = counters;
-			new.inuse--;
-			VM_BUG_ON(!new.frozen);
+		freelist_tail = freelist_iter;
+		free_delta++;
 
-		} while (!__cmpxchg_double_slab(s, page,
-			prior, counters,
-			freelist, new.counters,
-			"drain percpu freelist"));
-
-		freelist = nextfree;
+		freelist_iter = nextfree;
 	}
 
 	/*
-	 * Stage two: Ensure that the page is unfrozen while the
-	 * list presence reflects the actual number of objects
-	 * during unfreeze.
+	 * Stage two: Unfreeze the page while splicing the per-cpu
+	 * freelist to the head of page's freelist.
+	 *
+	 * Ensure that the page is unfrozen while the list presence
+	 * reflects the actual number of objects during unfreeze. 
 	 *
 	 * We setup the list membership and then perform a cmpxchg
 	 * with the count. If there is a mismatch then the page
@@ -2231,15 +2220,15 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
 	 */
 redo:
 
-	old.freelist = page->freelist;
-	old.counters = page->counters;
+	old.freelist = READ_ONCE(page->freelist);
+	old.counters = READ_ONCE(page->counters);
 	VM_BUG_ON(!old.frozen);
 
 	/* Determine target state of the slab */
 	new.counters = old.counters;
-	if (freelist) {
-		new.inuse--;
-		set_freepointer(s, freelist, old.freelist);
+	if (freelist_tail) {
+		new.inuse -= free_delta;
+		set_freepointer(s, freelist_tail, old.freelist);
 		new.freelist = freelist;
 	} else
 		new.freelist = old.freelist;
-- 
2.29.2


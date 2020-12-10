Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F032E2D60CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392107AbgLJQB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:01:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:49092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392170AbgLJQBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:01:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A4ABFAE2E;
        Thu, 10 Dec 2020 16:00:34 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm, slab, slub: clear the slab_cache field when freeing page
Date:   Thu, 10 Dec 2020 17:00:20 +0100
Message-Id: <20201210160020.21562-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page allocator expects that page->mapping is NULL for a page being freed.
SLAB and SLUB use the slab_cache field which is in union with mapping, but
before freeing the page, the field is referenced with the "mapping" name when
set to NULL.

It's IMHO more correct (albeit functionally the same) to use the slab_cache
name as that's the field we use in SL*B, and document why we clear it in a
comment (we don't clear fields such as s_mem or freelist, as page allocator
doesn't care about those). While using the 'mapping' name would automagically
keep the code correct if the unions in struct page changed, such changes should
be done consciously and needed changes evaluated - the comment should help with
that.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slab.c | 3 ++-
 mm/slub.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/slab.c b/mm/slab.c
index 72b6743bdccf..b667f03095f1 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1399,7 +1399,8 @@ static void kmem_freepages(struct kmem_cache *cachep, struct page *page)
 	__ClearPageSlabPfmemalloc(page);
 	__ClearPageSlab(page);
 	page_mapcount_reset(page);
-	page->mapping = NULL;
+	/* In union with page->mapping where page allocator expects NULL */
+	page->slab_cache = NULL;
 
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += 1 << order;
diff --git a/mm/slub.c b/mm/slub.c
index d3406ef65863..81c22f4c7e63 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1836,8 +1836,8 @@ static void __free_slab(struct kmem_cache *s, struct page *page)
 
 	__ClearPageSlabPfmemalloc(page);
 	__ClearPageSlab(page);
-
-	page->mapping = NULL;
+	/* In union with page->mapping where page allocator expects NULL */
+	page->slab_cache = NULL;
 	if (current->reclaim_state)
 		current->reclaim_state->reclaimed_slab += pages;
 	unaccount_slab_page(page, order, s);
-- 
2.29.2


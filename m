Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5381828737E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729882AbgJHLmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:42:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729865AbgJHLmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:42:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A7865AE1C;
        Thu,  8 Oct 2020 11:42:07 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 4/7] mm, page_alloc: simplify pageset_update()
Date:   Thu,  8 Oct 2020 13:41:58 +0200
Message-Id: <20201008114201.18824-5-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008114201.18824-1-vbabka@suse.cz>
References: <20201008114201.18824-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pageset_update() attempts to update pcplist's high and batch values in a way
that readers don't observe batch > high. It uses smp_wmb() to order the updates
in a way to achieve this. However, without proper pairing read barriers in
readers this guarantee doesn't hold, and there are no such barriers in
e.g. free_unref_page_commit().

Commit 88e8ac11d2ea ("mm, page_alloc: fix core hung in free_pcppages_bulk()")
already showed this is problematic, and solved this by ultimately only trusing
pcp->count of the current cpu with interrupts disabled.

The update dance with unpaired write barriers thus makes no sense. Replace
them with plain WRITE_ONCE to prevent store tearing, and document that the
values can change asynchronously and should not be trusted for correctness.

All current readers appear to be OK after 88e8ac11d2ea. Convert them to
READ_ONCE to prevent unnecessary read tearing, but mainly to alert anybody
making future changes to the code that special care is needed.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/page_alloc.c | 40 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f827b42a2475..f33c36312eb5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1344,7 +1344,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 {
 	int migratetype = 0;
 	int batch_free = 0;
-	int prefetch_nr = 0;
+	int prefetch_nr = READ_ONCE(pcp->batch);
 	bool isolated_pageblocks;
 	struct page *page, *tmp;
 	LIST_HEAD(head);
@@ -1395,8 +1395,10 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 			 * avoid excessive prefetching due to large count, only
 			 * prefetch buddy for the first pcp->batch nr of pages.
 			 */
-			if (prefetch_nr++ < pcp->batch)
+			if (prefetch_nr) {
 				prefetch_buddy(page);
+				prefetch_nr--;
+			}
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
@@ -3190,10 +3192,8 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
-	if (pcp->count >= pcp->high) {
-		unsigned long batch = READ_ONCE(pcp->batch);
-		free_pcppages_bulk(zone, batch, pcp);
-	}
+	if (pcp->count >= READ_ONCE(pcp->high))
+		free_pcppages_bulk(zone, READ_ONCE(pcp->batch), pcp);
 }
 
 /*
@@ -3378,7 +3378,7 @@ static struct page *__rmqueue_pcplist(struct zone *zone, int migratetype,
 	do {
 		if (list_empty(list)) {
 			pcp->count += rmqueue_bulk(zone, 0,
-					pcp->batch, list,
+					READ_ONCE(pcp->batch), list,
 					migratetype, alloc_flags);
 			if (unlikely(list_empty(list)))
 				return NULL;
@@ -6250,13 +6250,16 @@ static int zone_batchsize(struct zone *zone)
 }
 
 /*
- * pcp->high and pcp->batch values are related and dependent on one another:
- * ->batch must never be higher then ->high.
- * The following function updates them in a safe manner without read side
- * locking.
+ * pcp->high and pcp->batch values are related and generally batch is lower
+ * than high. They are also related to pcp->count such that count is lower
+ * than high, and as soon as it reaches high, the pcplist is flushed.
  *
- * Any new users of pcp->batch and pcp->high should ensure they can cope with
- * those fields changing asynchronously (acording to the above rule).
+ * However, guaranteeing these relations at all times would require e.g. write
+ * barriers here but also careful usage of read barriers at the read side, and
+ * thus be prone to error and bad for performance. Thus the update only prevents
+ * store tearing. Any new users of pcp->batch and pcp->high should ensure they
+ * can cope with those fields changing asynchronously, and fully trust only the
+ * pcp->count field on the local CPU with interrupts disabled.
  *
  * mutex_is_locked(&pcp_batch_high_lock) required when calling this function
  * outside of boot time (or some other assurance that no concurrent updaters
@@ -6265,15 +6268,8 @@ static int zone_batchsize(struct zone *zone)
 static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
 		unsigned long batch)
 {
-       /* start with a fail safe value for batch */
-	pcp->batch = 1;
-	smp_wmb();
-
-       /* Update high, then batch, in order */
-	pcp->high = high;
-	smp_wmb();
-
-	pcp->batch = batch;
+	WRITE_ONCE(pcp->batch, batch);
+	WRITE_ONCE(pcp->high, high);
 }
 
 static void pageset_init(struct per_cpu_pageset *p)
-- 
2.28.0


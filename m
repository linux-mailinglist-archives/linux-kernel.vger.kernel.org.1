Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C92274467
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIVOhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:46520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726692AbgIVOhY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 84F5EB145;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH 9/9] mm, page_alloc: optionally disable pcplists during page isolation
Date:   Tue, 22 Sep 2020 16:37:12 +0200
Message-Id: <20200922143712.12048-10-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page isolation can race with process freeing pages to pcplists in a way that
a page from isolated pageblock can end up on pcplist. This can be fixed by
repeated draining of pcplists, as done by patch "mm/memory_hotplug: drain
per-cpu pages again during memory offline" in [1].

David and Michal would prefer that this race was closed in a way that callers
of page isolation who need stronger guarantees don't need to repeatedly drain.
David suggested disabling pcplists usage completely during page isolation,
instead of repeatedly draining them.

To achieve this without adding special cases in alloc/free fastpath, we can use
the same approach as boot pagesets - when pcp->high is 0, any pcplist addition
will be immediately flushed.

The race can thus be closed by setting pcp->high to 0 and draining pcplists
once, before calling start_isolate_page_range(). The draining will serialize
after processes that already disabled interrupts and read the old value of
pcp->high in free_unref_page_commit(), and processes that have not yet disabled
interrupts, will observe pcp->high == 0 when they are rescheduled, and skip
pcplists. This guarantees no stray pages on pcplists in zones where isolation
happens.

This patch thus adds zone_pcplist_disable() and zone_pcplist_enable() functions
that page isolation users can call before start_isolate_page_range() and after
unisolating (or offlining) the isolated pages. A new zone->pcplist_disabled
atomic variable makes sure we disable only pcplists once and don't enable
them prematurely in case there are multiple users in parallel.

We however have to avoid external updates to high and batch by taking
pcp_batch_high_lock. To allow multiple isolations in parallel, change this lock
from mutex to rwsem.

Currently the only user of this functionality is offline_pages().

[1] https://lore.kernel.org/linux-mm/20200903140032.380431-1-pasha.tatashin@soleen.com/

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h         |  2 ++
 include/linux/page-isolation.h |  2 ++
 mm/internal.h                  |  4 ++++
 mm/memory_hotplug.c            | 28 ++++++++++++----------------
 mm/page_alloc.c                | 29 ++++++++++++++++++-----------
 mm/page_isolation.c            | 22 +++++++++++++++++++---
 6 files changed, 57 insertions(+), 30 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 7ad3f14dbe88..3c653d6348b1 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -536,6 +536,8 @@ struct zone {
 	 * of pageblock. Protected by zone->lock.
 	 */
 	unsigned long		nr_isolate_pageblock;
+	/* Track requests for disabling pcplists */
+	atomic_t		pcplist_disabled;
 #endif
 
 #ifdef CONFIG_MEMORY_HOTPLUG
diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 572458016331..1dec5d0f62a6 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -38,6 +38,8 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 void set_pageblock_migratetype(struct page *page, int migratetype);
 int move_freepages_block(struct zone *zone, struct page *page,
 				int migratetype, int *num_movable);
+void zone_pcplist_disable(struct zone *zone);
+void zone_pcplist_enable(struct zone *zone);
 
 /*
  * Changes migrate type in [start_pfn, end_pfn) to be MIGRATE_ISOLATE.
diff --git a/mm/internal.h b/mm/internal.h
index ea66ef45da6c..154e38e702dd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -7,6 +7,7 @@
 #ifndef __MM_INTERNAL_H
 #define __MM_INTERNAL_H
 
+#include <linux/rwsem.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/pagemap.h>
@@ -199,8 +200,11 @@ extern void post_alloc_hook(struct page *page, unsigned int order,
 					gfp_t gfp_flags);
 extern int user_min_free_kbytes;
 
+extern struct rw_semaphore pcp_batch_high_lock;
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
+extern void zone_update_pageset_high_and_batch(struct zone *zone,
+		unsigned long high, unsigned long batch);
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bbde415b558b..6fe9be550160 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1515,17 +1515,21 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	}
 	node = zone_to_nid(zone);
 
+	/*
+	 * Disable pcplists so that page isolation cannot race with freeing
+	 * in a way that pages from isolated pageblock are left on pcplists.
+	 */
+	zone_pcplist_disable(zone);
+
 	/* set above range as isolated */
 	ret = start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
 		reason = "failure to isolate range";
-		goto failed_removal;
+		goto failed_removal_pcplists_disabled;
 	}
 
-	__drain_all_pages(zone, true);
-
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
 	node_states_check_changes_offline(nr_pages, zone, &arg);
@@ -1575,20 +1579,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			goto failed_removal_isolated;
 		}
 
-		/*
-		 * per-cpu pages are drained after start_isolate_page_range, but
-		 * if there are still pages that are not free, make sure that we
-		 * drain again, because when we isolated range we might have
-		 * raced with another thread that was adding pages to pcp list.
-		 *
-		 * Forward progress should be still guaranteed because
-		 * pages on the pcp list can only belong to MOVABLE_ZONE
-		 * because has_unmovable_pages explicitly checks for
-		 * PageBuddy on freed pages on other zones.
-		 */
 		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
-		if (ret)
-			__drain_all_pages(zone, true);
+
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
@@ -1604,6 +1596,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	zone_pcplist_enable(zone);
+
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
 	zone->present_pages -= nr_pages;
@@ -1637,6 +1631,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 failed_removal_isolated:
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
+failed_removal_pcplists_disabled:
+	zone_pcplist_enable(zone);
 failed_removal:
 	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 33cc35d152b1..673d353f9311 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -78,7 +78,7 @@
 #include "page_reporting.h"
 
 /* prevent >1 _updater_ of zone percpu pageset ->high and ->batch fields */
-static DEFINE_MUTEX(pcp_batch_high_lock);
+DECLARE_RWSEM(pcp_batch_high_lock);
 #define MIN_PERCPU_PAGELIST_FRACTION	(8)
 
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
@@ -6230,6 +6230,18 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp->batch = BOOT_PAGESET_BATCH;
 }
 
+void zone_update_pageset_high_and_batch(struct zone *zone, unsigned long high,
+		unsigned long batch)
+{
+	struct per_cpu_pageset *p;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		p = per_cpu_ptr(zone->pageset, cpu);
+		pageset_update(&p->pcp, high, batch);
+	}
+}
+
 /*
  * Calculate and set new high and batch values for all per-cpu pagesets of a
  * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
@@ -6237,8 +6249,6 @@ static void pageset_init(struct per_cpu_pageset *p)
 static void zone_set_pageset_high_and_batch(struct zone *zone)
 {
 	unsigned long new_high, new_batch;
-	struct per_cpu_pageset *p;
-	int cpu;
 
 	if (percpu_pagelist_fraction) {
 		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
@@ -6259,10 +6269,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
 		return;
 	}
 
-	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
-		pageset_update(&p->pcp, new_high, new_batch);
-	}
+	zone_update_pageset_high_and_batch(zone, new_high, new_batch);
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
@@ -8024,7 +8031,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	int old_percpu_pagelist_fraction;
 	int ret;
 
-	mutex_lock(&pcp_batch_high_lock);
+	down_write(&pcp_batch_high_lock);
 	old_percpu_pagelist_fraction = percpu_pagelist_fraction;
 
 	ret = proc_dointvec_minmax(table, write, buffer, length, ppos);
@@ -8046,7 +8053,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 	for_each_populated_zone(zone)
 		zone_set_pageset_high_and_batch(zone);
 out:
-	mutex_unlock(&pcp_batch_high_lock);
+	up_write(&pcp_batch_high_lock);
 	return ret;
 }
 
@@ -8652,9 +8659,9 @@ EXPORT_SYMBOL(free_contig_range);
  */
 void __meminit zone_pcp_update(struct zone *zone)
 {
-	mutex_lock(&pcp_batch_high_lock);
+	down_write(&pcp_batch_high_lock);
 	zone_set_pageset_high_and_batch(zone);
-	mutex_unlock(&pcp_batch_high_lock);
+	up_write(&pcp_batch_high_lock);
 }
 
 void zone_pcp_reset(struct zone *zone)
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 57d8bc1e7760..c0e895e8f322 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -15,6 +15,22 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
 
+void zone_pcplist_disable(struct zone *zone)
+{
+	down_read(&pcp_batch_high_lock);
+	if (atomic_inc_return(&zone->pcplist_disabled) == 1) {
+		zone_update_pageset_high_and_batch(zone, 0, 1);
+		__drain_all_pages(zone, true);
+	}
+}
+
+void zone_pcplist_enable(struct zone *zone)
+{
+	if (atomic_dec_return(&zone->pcplist_disabled) == 0)
+		zone_update_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+	up_read(&pcp_batch_high_lock);
+}
+
 static int set_migratetype_isolate(struct page *page, int migratetype, int isol_flags)
 {
 	struct zone *zone = page_zone(page);
@@ -169,9 +185,9 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * A call to drain_all_pages() after isolation can flush most of them. However
  * in some cases pages might still end up on pcp lists and that would allow
  * for their allocation even when they are in fact isolated already. Depending
- * on how strong of a guarantee the caller needs, further drain_all_pages()
- * might be needed (e.g. __offline_pages will need to call it after check for
- * isolated range for a next retry).
+ * on how strong of a guarantee the caller needs, zone_pcplist_disable/enable()
+ * might be used to flush and disable pcplist before isolation and after
+ * unisolation.
  *
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
-- 
2.28.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE542AEDB6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgKKJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:28:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:37758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgKKJ22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:28:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DB20FAD5F;
        Wed, 11 Nov 2020 09:28:22 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3 7/7] mm, page_alloc: disable pcplists during memory offline
Date:   Wed, 11 Nov 2020 10:28:12 +0100
Message-Id: <20201111092812.11329-8-vbabka@suse.cz>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201111092812.11329-1-vbabka@suse.cz>
References: <20201111092812.11329-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory offlining relies on page isolation to guarantee a forward
progress because pages cannot be reused while they are isolated. But the
page isolation itself doesn't prevent from races while freed pages are
stored on pcp lists and thus can be reused.  This can be worked around by
repeated draining of pcplists, as done by commit 968318261221
("mm/memory_hotplug: drain per-cpu pages again during memory offline").

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

This patch thus adds zone_pcp_disable() and zone_pcp_enable() functions that
page isolation users can call before start_isolate_page_range() and after
unisolating (or offlining) the isolated pages.

Also, drain_all_pages() is optimized to only execute on cpus where pcplists are
not empty. The check can however race with a free to pcplist that has not yet
increased the pcp->count from 0 to 1. Thus make the drain optionally skip the
racy check and drain on all cpus, and use this option in zone_pcp_disable().

As we have to avoid external updates to high and batch while pcplists are
disabled, we take pcp_batch_high_lock in zone_pcp_disable() and release it in
zone_pcp_enable(). This also synchronizes multiple users of
zone_pcp_disable()/enable().

Currently the only user of this functionality is offline_pages().

Suggested-by: David Hildenbrand <david@redhat.com>
Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/internal.h       |  2 ++
 mm/memory_hotplug.c | 28 ++++++++----------
 mm/page_alloc.c     | 69 +++++++++++++++++++++++++++++++++++----------
 mm/page_isolation.c |  6 ++--
 4 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index c43ccdddb0f6..2966496680bc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -201,6 +201,8 @@ extern int user_min_free_kbytes;
 
 extern void zone_pcp_update(struct zone *zone);
 extern void zone_pcp_reset(struct zone *zone);
+extern void zone_pcp_disable(struct zone *zone);
+extern void zone_pcp_enable(struct zone *zone);
 
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3c494ab0d075..e0a561c550b3 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1491,17 +1491,21 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	}
 	node = zone_to_nid(zone);
 
+	/*
+	 * Disable pcplists so that page isolation cannot race with freeing
+	 * in a way that pages from isolated pageblock are left on pcplists.
+	 */
+	zone_pcp_disable(zone);
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
 
-	drain_all_pages(zone);
-
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
 	node_states_check_changes_offline(nr_pages, zone, &arg);
@@ -1551,20 +1555,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
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
-			drain_all_pages(zone);
+
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
@@ -1580,6 +1572,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
+	zone_pcp_enable(zone);
+
 	/* removal success */
 	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
 	zone->present_pages -= nr_pages;
@@ -1612,6 +1606,8 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 failed_removal_isolated:
 	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
 	memory_notify(MEM_CANCEL_OFFLINE, &arg);
+failed_removal_pcplists_disabled:
+	zone_pcp_enable(zone);
 failed_removal:
 	pr_debug("memory offlining [mem %#010llx-%#010llx] failed due to %s\n",
 		 (unsigned long long) start_pfn << PAGE_SHIFT,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2ec3e1e27169..ba4943727793 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3030,14 +3030,7 @@ static void drain_local_pages_wq(struct work_struct *work)
 	preempt_enable();
 }
 
-/*
- * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
- *
- * When zone parameter is non-NULL, spill just the single zone's pages.
- *
- * Note that this can be extremely slow as the draining happens in a workqueue.
- */
-void drain_all_pages(struct zone *zone)
+void __drain_all_pages(struct zone *zone, bool force_all_cpus)
 {
 	int cpu;
 
@@ -3076,7 +3069,13 @@ void drain_all_pages(struct zone *zone)
 		struct zone *z;
 		bool has_pcps = false;
 
-		if (zone) {
+		if (force_all_cpus) {
+			/*
+			 * The pcp.count check is racy, some callers need a
+			 * guarantee that no cpu is missed.
+			 */
+			has_pcps = true;
+		} else if (zone) {
 			pcp = per_cpu_ptr(zone->pageset, cpu);
 			if (pcp->pcp.count)
 				has_pcps = true;
@@ -3109,6 +3108,18 @@ void drain_all_pages(struct zone *zone)
 	mutex_unlock(&pcpu_drain_mutex);
 }
 
+/*
+ * Spill all the per-cpu pages from all CPUs back into the buddy allocator.
+ *
+ * When zone parameter is non-NULL, spill just the single zone's pages.
+ *
+ * Note that this can be extremely slow as the draining happens in a workqueue.
+ */
+void drain_all_pages(struct zone *zone)
+{
+	__drain_all_pages(zone, false);
+}
+
 #ifdef CONFIG_HIBERNATION
 
 /*
@@ -6308,6 +6319,18 @@ static void pageset_init(struct per_cpu_pageset *p)
 	pcp->batch = BOOT_PAGESET_BATCH;
 }
 
+void __zone_set_pageset_high_and_batch(struct zone *zone, unsigned long high,
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
@@ -6315,8 +6338,6 @@ static void pageset_init(struct per_cpu_pageset *p)
 static void zone_set_pageset_high_and_batch(struct zone *zone)
 {
 	unsigned long new_high, new_batch;
-	struct per_cpu_pageset *p;
-	int cpu;
 
 	if (percpu_pagelist_fraction) {
 		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
@@ -6336,10 +6357,7 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
 	zone->pageset_high = new_high;
 	zone->pageset_batch = new_batch;
 
-	for_each_possible_cpu(cpu) {
-		p = per_cpu_ptr(zone->pageset, cpu);
-		pageset_update(&p->pcp, new_high, new_batch);
-	}
+	__zone_set_pageset_high_and_batch(zone, new_high, new_batch);
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
@@ -8757,6 +8775,27 @@ void __meminit zone_pcp_update(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * Effectively disable pcplists for the zone by setting the high limit to 0
+ * and draining all cpus. A concurrent page freeing on another CPU that's about
+ * to put the page on pcplist will either finish before the drain and the page
+ * will be drained, or observe the new high limit and skip the pcplist.
+ *
+ * Must be paired with a call to zone_pcp_enable().
+ */
+void zone_pcp_disable(struct zone *zone)
+{
+	mutex_lock(&pcp_batch_high_lock);
+	__zone_set_pageset_high_and_batch(zone, 0, 1);
+	__drain_all_pages(zone, true);
+}
+
+void zone_pcp_enable(struct zone *zone)
+{
+	__zone_set_pageset_high_and_batch(zone, zone->pageset_high, zone->pageset_batch);
+	mutex_unlock(&pcp_batch_high_lock);
+}
+
 void zone_pcp_reset(struct zone *zone)
 {
 	unsigned long flags;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index feab446d1982..a254e1f370a3 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -174,9 +174,9 @@ __first_valid_page(unsigned long pfn, unsigned long nr_pages)
  * A call to drain_all_pages() after isolation can flush most of them. However
  * in some cases pages might still end up on pcp lists and that would allow
  * for their allocation even when they are in fact isolated already. Depending
- * on how strong of a guarantee the caller needs, further drain_all_pages()
- * might be needed (e.g. __offline_pages will need to call it after check for
- * isolated range for a next retry).
+ * on how strong of a guarantee the caller needs, zone_pcp_disable/enable()
+ * might be used to flush and disable pcplist before isolation and enable after
+ * unisolation.
  *
  * Return: 0 on success and -EBUSY if any part of range cannot be isolated.
  */
-- 
2.29.1


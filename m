Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB4327446A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgIVOht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46516 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726687AbgIVOhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6CB8BB12C;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 8/9] mm, page_alloc: drain all pcplists during memory offline
Date:   Tue, 22 Sep 2020 16:37:11 +0200
Message-Id: <20200922143712.12048-9-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drain_all_pages() is optimized to only execute on cpus where pcplists are not
empty. The check can however race with a free to pcplist that has not yet
increased the pcp->count from 0 to 1. Make the drain optionally skip the racy
check and drain on all cpus, and use it in memory offline context, where we
want to make sure no isolated pages are left behind on pcplists.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/gfp.h |  1 +
 mm/memory_hotplug.c |  4 ++--
 mm/page_alloc.c     | 29 ++++++++++++++++++++---------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 67a0774e080b..cc52c5cc9fab 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -592,6 +592,7 @@ extern void page_frag_free(void *addr);
 
 void page_alloc_init(void);
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
+void __drain_all_pages(struct zone *zone, bool page_isolation);
 void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
 
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 08f729922e18..bbde415b558b 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1524,7 +1524,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		goto failed_removal;
 	}
 
-	drain_all_pages(zone);
+	__drain_all_pages(zone, true);
 
 	arg.start_pfn = start_pfn;
 	arg.nr_pages = nr_pages;
@@ -1588,7 +1588,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		 */
 		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
 		if (ret)
-			drain_all_pages(zone);
+			__drain_all_pages(zone, true);
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4e37bc3f6077..33cc35d152b1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2960,14 +2960,7 @@ static void drain_local_pages_wq(struct work_struct *work)
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
 
@@ -3006,7 +2999,13 @@ void drain_all_pages(struct zone *zone)
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
@@ -3039,6 +3038,18 @@ void drain_all_pages(struct zone *zone)
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
-- 
2.28.0


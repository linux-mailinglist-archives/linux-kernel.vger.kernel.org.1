Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 394E6274464
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIVOhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:46406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgIVOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 01803B08C;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 2/9] mm, page_alloc: calculate pageset high and batch once per zone
Date:   Tue, 22 Sep 2020 16:37:05 +0200
Message-Id: <20200922143712.12048-3-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We currently call pageset_set_high_and_batch() for each possible cpu, which
repeats the same calculations of high and batch values.

Instead call the function just once per zone, and make it apply the calculated
values to all per-cpu pagesets of the zone.

This also allows removing the zone_pageset_init() and __zone_pcp_update()
wrappers.

No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index a163c5e561f2..26069c8d1b19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6219,13 +6219,14 @@ static void setup_pageset(struct per_cpu_pageset *p)
 }
 
 /*
- * Calculate and set new high and batch values for given per-cpu pageset of a
+ * Calculate and set new high and batch values for all per-cpu pagesets of a
  * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
  */
-static void pageset_set_high_and_batch(struct zone *zone,
-				       struct per_cpu_pageset *p)
+static void zone_set_pageset_high_and_batch(struct zone *zone)
 {
 	unsigned long new_high, new_batch;
+	struct per_cpu_pageset *p;
+	int cpu;
 
 	if (percpu_pagelist_fraction) {
 		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
@@ -6237,23 +6238,25 @@ static void pageset_set_high_and_batch(struct zone *zone,
 		new_high = 6 * new_batch;
 		new_batch = max(1UL, 1 * new_batch);
 	}
-	pageset_update(&p->pcp, new_high, new_batch);
-}
-
-static void __meminit zone_pageset_init(struct zone *zone, int cpu)
-{
-	struct per_cpu_pageset *pcp = per_cpu_ptr(zone->pageset, cpu);
 
-	pageset_init(pcp);
-	pageset_set_high_and_batch(zone, pcp);
+	for_each_possible_cpu(cpu) {
+		p = per_cpu_ptr(zone->pageset, cpu);
+		pageset_update(&p->pcp, new_high, new_batch);
+	}
 }
 
 void __meminit setup_zone_pageset(struct zone *zone)
 {
+	struct per_cpu_pageset *p;
 	int cpu;
+
 	zone->pageset = alloc_percpu(struct per_cpu_pageset);
-	for_each_possible_cpu(cpu)
-		zone_pageset_init(zone, cpu);
+	for_each_possible_cpu(cpu) {
+		p = per_cpu_ptr(zone->pageset, cpu);
+		pageset_init(p);
+	}
+
+	zone_set_pageset_high_and_batch(zone);
 }
 
 /*
@@ -7985,15 +7988,6 @@ int lowmem_reserve_ratio_sysctl_handler(struct ctl_table *table, int write,
 	return 0;
 }
 
-static void __zone_pcp_update(struct zone *zone)
-{
-	unsigned int cpu;
-
-	for_each_possible_cpu(cpu)
-		pageset_set_high_and_batch(zone,
-				per_cpu_ptr(zone->pageset, cpu));
-}
-
 /*
  * percpu_pagelist_fraction - changes the pcp->high for each zone on each
  * cpu.  It is the fraction of total pages in each zone that a hot per cpu
@@ -8026,7 +8020,7 @@ int percpu_pagelist_fraction_sysctl_handler(struct ctl_table *table, int write,
 		goto out;
 
 	for_each_populated_zone(zone)
-		__zone_pcp_update(zone);
+		zone_set_pageset_high_and_batch(zone);
 out:
 	mutex_unlock(&pcp_batch_high_lock);
 	return ret;
@@ -8633,7 +8627,7 @@ EXPORT_SYMBOL(free_contig_range);
 void __meminit zone_pcp_update(struct zone *zone)
 {
 	mutex_lock(&pcp_batch_high_lock);
-	__zone_pcp_update(zone);
+	zone_set_pageset_high_and_batch(zone);
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
-- 
2.28.0


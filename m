Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C0274462
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 16:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgIVOh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 10:37:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgIVOhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 10:37:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00BBCB039;
        Tue, 22 Sep 2020 14:37:57 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 1/9] mm, page_alloc: clean up pageset high and batch update
Date:   Tue, 22 Sep 2020 16:37:04 +0200
Message-Id: <20200922143712.12048-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922143712.12048-1-vbabka@suse.cz>
References: <20200922143712.12048-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The updates to pcplists' high and batch valued are handled by multiple
functions that make the calculations hard to follow. Consolidate everything
to pageset_set_high_and_batch() and remove pageset_set_batch() and
pageset_set_high() wrappers.

The only special case using one of the removed wrappers was:
build_all_zonelists_init()
  setup_pageset()
    pageset_set_batch()
which was hardcoding batch as 0, so we can just open-code a call to
pageset_update() with constant parameters instead.

No functional change.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 mm/page_alloc.c | 49 ++++++++++++++++++++-----------------------------
 1 file changed, 20 insertions(+), 29 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 60a0e94645a6..a163c5e561f2 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5823,7 +5823,7 @@ static void build_zonelists(pg_data_t *pgdat)
  * not check if the processor is online before following the pageset pointer.
  * Other parts of the kernel may not check if the zone is available.
  */
-static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch);
+static void setup_pageset(struct per_cpu_pageset *p);
 static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
@@ -5891,7 +5891,7 @@ build_all_zonelists_init(void)
 	 * (a chicken-egg dilemma).
 	 */
 	for_each_possible_cpu(cpu)
-		setup_pageset(&per_cpu(boot_pageset, cpu), 0);
+		setup_pageset(&per_cpu(boot_pageset, cpu));
 
 	mminit_verify_zonelist();
 	cpuset_init_current_mems_allowed();
@@ -6200,12 +6200,6 @@ static void pageset_update(struct per_cpu_pages *pcp, unsigned long high,
 	pcp->batch = batch;
 }
 
-/* a companion to pageset_set_high() */
-static void pageset_set_batch(struct per_cpu_pageset *p, unsigned long batch)
-{
-	pageset_update(&p->pcp, 6 * batch, max(1UL, 1 * batch));
-}
-
 static void pageset_init(struct per_cpu_pageset *p)
 {
 	struct per_cpu_pages *pcp;
@@ -6218,35 +6212,32 @@ static void pageset_init(struct per_cpu_pageset *p)
 		INIT_LIST_HEAD(&pcp->lists[migratetype]);
 }
 
-static void setup_pageset(struct per_cpu_pageset *p, unsigned long batch)
+static void setup_pageset(struct per_cpu_pageset *p)
 {
 	pageset_init(p);
-	pageset_set_batch(p, batch);
+	pageset_update(&p->pcp, 0, 1);
 }
 
 /*
- * pageset_set_high() sets the high water mark for hot per_cpu_pagelist
- * to the value high for the pageset p.
+ * Calculate and set new high and batch values for given per-cpu pageset of a
+ * zone, based on the zone's size and the percpu_pagelist_fraction sysctl.
  */
-static void pageset_set_high(struct per_cpu_pageset *p,
-				unsigned long high)
-{
-	unsigned long batch = max(1UL, high / 4);
-	if ((high / 4) > (PAGE_SHIFT * 8))
-		batch = PAGE_SHIFT * 8;
-
-	pageset_update(&p->pcp, high, batch);
-}
-
 static void pageset_set_high_and_batch(struct zone *zone,
-				       struct per_cpu_pageset *pcp)
+				       struct per_cpu_pageset *p)
 {
-	if (percpu_pagelist_fraction)
-		pageset_set_high(pcp,
-			(zone_managed_pages(zone) /
-				percpu_pagelist_fraction));
-	else
-		pageset_set_batch(pcp, zone_batchsize(zone));
+	unsigned long new_high, new_batch;
+
+	if (percpu_pagelist_fraction) {
+		new_high = zone_managed_pages(zone) / percpu_pagelist_fraction;
+		new_batch = max(1UL, new_high / 4);
+		if ((new_high / 4) > (PAGE_SHIFT * 8))
+			new_batch = PAGE_SHIFT * 8;
+	} else {
+		new_batch = zone_batchsize(zone);
+		new_high = 6 * new_batch;
+		new_batch = max(1UL, 1 * new_batch);
+	}
+	pageset_update(&p->pcp, new_high, new_batch);
 }
 
 static void __meminit zone_pageset_init(struct zone *zone, int cpu)
-- 
2.28.0


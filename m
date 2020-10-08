Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D3828737F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 13:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbgJHLmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 07:42:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729877AbgJHLmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 07:42:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD377B28E;
        Thu,  8 Oct 2020 11:42:07 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v2 5/7] mm, page_alloc: cache pageset high and batch in struct zone
Date:   Thu,  8 Oct 2020 13:41:59 +0200
Message-Id: <20201008114201.18824-6-vbabka@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008114201.18824-1-vbabka@suse.cz>
References: <20201008114201.18824-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All per-cpu pagesets for a zone use the same high and batch values, that are
duplicated there just for performance (locality) reasons. This patch adds the
same variables also to struct zone as a shared copy.

This will be useful later for making possible to disable pcplists temporarily
by setting high value to 0, while remembering the values for restoring them
later. But we can also immediately benefit from not updating pagesets of all
possible cpus in case the newly recalculated values (after sysctl change or
memory online/offline) are actually unchanged from the previous ones.

Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mmzone.h |  6 ++++++
 mm/page_alloc.c        | 17 +++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fb3bf696c05e..c63863794afc 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -470,6 +470,12 @@ struct zone {
 #endif
 	struct pglist_data	*zone_pgdat;
 	struct per_cpu_pageset __percpu *pageset;
+	/*
+	 * the high and batch values are copied to individual pagesets for
+	 * faster access
+	 */
+	int pageset_high;
+	int pageset_batch;
 
 #ifndef CONFIG_SPARSEMEM
 	/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f33c36312eb5..5b98dd5ab006 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5900,6 +5900,9 @@ static void build_zonelists(pg_data_t *pgdat)
  * Other parts of the kernel may not check if the zone is available.
  */
 static void pageset_init(struct per_cpu_pageset *p);
+/* These effectively disable the pcplists in the boot pageset completely */
+#define BOOT_PAGESET_HIGH	0
+#define BOOT_PAGESET_BATCH	1
 static DEFINE_PER_CPU(struct per_cpu_pageset, boot_pageset);
 static DEFINE_PER_CPU(struct per_cpu_nodestat, boot_nodestats);
 
@@ -6289,8 +6292,8 @@ static void pageset_init(struct per_cpu_pageset *p)
 	 * need to be as careful as pageset_update() as nobody can access the
 	 * pageset yet.
 	 */
-	pcp->high = 0;
-	pcp->batch = 1;
+	pcp->high = BOOT_PAGESET_HIGH;
+	pcp->batch = BOOT_PAGESET_BATCH;
 }
 
 /*
@@ -6314,6 +6317,14 @@ static void zone_set_pageset_high_and_batch(struct zone *zone)
 		new_batch = max(1UL, 1 * new_batch);
 	}
 
+	if (zone->pageset_high != new_high ||
+	    zone->pageset_batch != new_batch) {
+		zone->pageset_high = new_high;
+		zone->pageset_batch = new_batch;
+	} else {
+		return;
+	}
+
 	for_each_possible_cpu(cpu) {
 		p = per_cpu_ptr(zone->pageset, cpu);
 		pageset_update(&p->pcp, new_high, new_batch);
@@ -6374,6 +6385,8 @@ static __meminit void zone_pcp_init(struct zone *zone)
 	 * offset of a (static) per cpu variable into the per cpu area.
 	 */
 	zone->pageset = &boot_pageset;
+	zone->pageset_high = BOOT_PAGESET_HIGH;
+	zone->pageset_batch = BOOT_PAGESET_BATCH;
 
 	if (populated_zone(zone))
 		printk(KERN_DEBUG "  %s zone: %lu pages, LIFO batch:%u\n",
-- 
2.28.0


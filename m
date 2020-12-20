Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F34EA2DF470
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgLTI3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:29:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgLTI3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:29:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608452896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=Pz3SxzLemW3jpWj25a7YjBYZ6WYazAV05LqCKL8d3r0=;
        b=WGVhbHEXLo/MfgQLPPGbNL4RrVbAjsxHLwBbISSLfhz6C43Jq4Q4GmAk5YbiXswsPsfYNC
        60BR3/MeP3Bt7jRtivkIsrVFTHCXYPGntb1uTgTKQjY0oZtDUphHVbOadGMECyaFhq/xpW
        i3Oar02oWHnAr0meEFy95kUbiiChYKY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-h0fGvXBwM8mLljCxwHdx8A-1; Sun, 20 Dec 2020 03:28:14 -0500
X-MC-Unique: h0fGvXBwM8mLljCxwHdx8A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5DF11800D42;
        Sun, 20 Dec 2020 08:28:12 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D67AF60C13;
        Sun, 20 Dec 2020 08:28:06 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com,
        bhe@redhat.com
Subject: [PATCH v2 2/5] mm: rename memmap_init() and memmap_init_zone()
Date:   Sun, 20 Dec 2020 16:27:51 +0800
Message-Id: <20201220082754.6900-3-bhe@redhat.com>
In-Reply-To: <20201220082754.6900-1-bhe@redhat.com>
References: <20201220082754.6900-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current memmap_init_zone() only handles memory region inside one zone,
actually memmap_init() does the memmap init of one zone. So rename both of
them accordingly.

And also rename the function parameter 'range_start_pfn' and local variable
'range_end_pfn' of memmap_init() to zone_start_pfn/zone_end_pfn.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/ia64/include/asm/pgtable.h |  2 +-
 arch/ia64/mm/init.c             |  6 +++---
 include/linux/mm.h              |  2 +-
 mm/memory_hotplug.c             |  2 +-
 mm/page_alloc.c                 | 24 ++++++++++++------------
 5 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 779b6972aa84..dce2ff37df65 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -520,7 +520,7 @@ extern struct page *zero_page_memmap_ptr;
 
 #  ifdef CONFIG_VIRTUAL_MEM_MAP
   /* arch mem_map init routine is needed due to holes in a virtual mem_map */
-    extern void memmap_init (unsigned long size, int nid, unsigned long zone,
+    extern void memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 			     unsigned long start_pfn);
 #  endif /* CONFIG_VIRTUAL_MEM_MAP */
 # endif /* !__ASSEMBLY__ */
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index e76386a3479e..c8e68e92beb3 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -535,18 +535,18 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
 		    / sizeof(struct page));
 
 	if (map_start < map_end)
-		memmap_init_zone((unsigned long)(map_end - map_start),
+		memmap_init_range((unsigned long)(map_end - map_start),
 				 args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
 				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	return 0;
 }
 
 void __meminit
-memmap_init (unsigned long size, int nid, unsigned long zone,
+memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 	     unsigned long start_pfn)
 {
 	if (!vmem_map) {
-		memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
+		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
 				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	} else {
 		struct page *start;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 92e06ea053f4..f72c138c2272 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2432,7 +2432,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 #endif
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
-extern void memmap_init_zone(unsigned long, int, unsigned long,
+extern void memmap_init_range(unsigned long, int, unsigned long,
 		unsigned long, unsigned long, enum meminit_context,
 		struct vmem_altmap *, int migratetype);
 extern void setup_per_zone_wmarks(void);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..ddcb1cd24c60 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -713,7 +713,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * expects the zone spans the pfn range. All the pages in the range
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
-	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
+	memmap_init_range(nr_pages, nid, zone_idx(zone), start_pfn, 0,
 			 MEMINIT_HOTPLUG, altmap, migratetype);
 
 	set_zone_contiguous(zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 32645f2e7b96..4b46326099d9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6117,7 +6117,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
  * (usually MIGRATE_MOVABLE). Besides setting the migratetype, no related
  * zone stats (e.g., nr_isolate_pageblock) are touched.
  */
-void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
+void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone,
 		unsigned long start_pfn, unsigned long zone_end_pfn,
 		enum meminit_context context,
 		struct vmem_altmap *altmap, int migratetype)
@@ -6292,24 +6292,24 @@ static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
 }
 #endif
 
-void __init __weak memmap_init(unsigned long size, int nid,
+void __init __weak memmap_init_zone(unsigned long size, int nid,
 			       unsigned long zone,
-			       unsigned long range_start_pfn)
+			       unsigned long zone_start_pfn)
 {
 	unsigned long start_pfn, end_pfn, hole_start_pfn = 0;
-	unsigned long range_end_pfn = range_start_pfn + size;
+	unsigned long zone_end_pfn = zone_start_pfn + size;
 	u64 pgcnt = 0;
 	int i;
 
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
-		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
-		hole_start_pfn = clamp(hole_start_pfn, range_start_pfn,
-				       range_end_pfn);
+		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
+		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
+		hole_start_pfn = clamp(hole_start_pfn, zone_start_pfn,
+				       zone_end_pfn);
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
-			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
+			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 
@@ -6326,8 +6326,8 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	 * considered initialized. Make sure that memmap has a well defined
 	 * state.
 	 */
-	if (hole_start_pfn < range_end_pfn)
-		pgcnt += init_unavailable_range(hole_start_pfn, range_end_pfn,
+	if (hole_start_pfn < zone_end_pfn)
+		pgcnt += init_unavailable_range(hole_start_pfn, zone_end_pfn,
 						zone, nid);
 
 	if (pgcnt)
@@ -7039,7 +7039,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		set_pageblock_order();
 		setup_usemap(pgdat, zone, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
-		memmap_init(size, nid, j, zone_start_pfn);
+		memmap_init_zone(size, nid, j, zone_start_pfn);
 	}
 }
 
-- 
2.17.2


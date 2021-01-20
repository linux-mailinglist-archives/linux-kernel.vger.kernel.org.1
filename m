Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22AF52FCA23
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbhATEyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:54:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30666 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726590AbhATExy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611118346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=E+pKf6ifsL64+n4w/QJZpqUW/QGm/9GOqKGVG1uhig0=;
        b=bzpRb7wwcOg33EyI5LPRgi3fzwpqQVfSOf/A9twET3QmSykVvLgFHRCNqBXNs1qExp+htX
        6Bso7V2Br0KOnD2n38ugRPcl/PuY0DGD7xUXVwd9aEH6wWnM/dkono2kAoBteZzKFbI2ed
        RV+rxT4uZrtwh+e/fXI+wnkeno46gss=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-6yl-6SStPfuN6udWg5InMg-1; Tue, 19 Jan 2021 23:52:24 -0500
X-MC-Unique: 6yl-6SStPfuN6udWg5InMg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29573107ACE3;
        Wed, 20 Jan 2021 04:52:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24CC60D11;
        Wed, 20 Jan 2021 04:52:20 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v4 1/4] mm: rename memmap_init() and memmap_init_zone()
Date:   Wed, 20 Jan 2021 12:52:10 +0800
Message-Id: <20210120045213.6571-2-bhe@redhat.com>
In-Reply-To: <20210120045213.6571-1-bhe@redhat.com>
References: <20210120045213.6571-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current memmap_init_zone() only handles memory region inside one zone,
actually memmap_init() does the memmap init of one zone. So rename both of
them accordingly.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/ia64/include/asm/pgtable.h | 2 +-
 arch/ia64/mm/init.c             | 6 +++---
 include/linux/mm.h              | 2 +-
 mm/memory_hotplug.c             | 2 +-
 mm/page_alloc.c                 | 8 ++++----
 5 files changed, 10 insertions(+), 10 deletions(-)

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
index 3dac7bc667ee..56bb239f9150 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2398,7 +2398,7 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
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
index 44ec5594798d..42a1d2d2a87d 100644
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
@@ -6254,7 +6254,7 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	}
 }
 
-void __meminit __weak memmap_init(unsigned long size, int nid,
+void __meminit __weak memmap_init_zone(unsigned long size, int nid,
 				  unsigned long zone,
 				  unsigned long range_start_pfn)
 {
@@ -6268,7 +6268,7 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
-			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
+			memmap_init_range(size, nid, zone, start_pfn, range_end_pfn,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 	}
@@ -6978,7 +6978,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		set_pageblock_order();
 		setup_usemap(pgdat, zone, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
-		memmap_init(size, nid, j, zone_start_pfn);
+		memmap_init_zone(size, nid, j, zone_start_pfn);
 	}
 }
 
-- 
2.17.2


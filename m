Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BA62EA622
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 08:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbhAEHsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 02:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726979AbhAEHsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:48:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609832847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=NmizFIUcxnbFhZLwvyEyz/ycKmX/WhqDKmClMna0PAw=;
        b=Yhc/SbUkcRjej96kvxO5dl2aX5GIAqndz0NnlI1aZVRwtvmfQlPQBR2Z9fZhcRFSAl619K
        zo2xMGS9oez64v7zE7OjzeektYNLTrtdaUfQEt1AtxNSurJHdWBoepZFiAFAjH2nYnknUJ
        Qi7PXJmHxqTN791jbVDT5ms+oQfCu9s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-VCVKoS0LMUKSBTStlCuFFw-1; Tue, 05 Jan 2021 02:47:25 -0500
X-MC-Unique: VCVKoS0LMUKSBTStlCuFFw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB8E315730;
        Tue,  5 Jan 2021 07:47:23 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-56.pek2.redhat.com [10.72.13.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D7BC71CA2;
        Tue,  5 Jan 2021 07:47:20 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v3 2/4] mm: simplify parater of function memmap_init_zone()
Date:   Tue,  5 Jan 2021 15:47:06 +0800
Message-Id: <20210105074708.18483-3-bhe@redhat.com>
In-Reply-To: <20210105074708.18483-1-bhe@redhat.com>
References: <20210105074708.18483-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As David suggested, simply passing 'struct zone *zone' is enough. We can
get all needed information from 'struct zone*' easily.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/ia64/include/asm/pgtable.h |  3 +--
 arch/ia64/mm/init.c             | 12 +++++++-----
 mm/page_alloc.c                 | 20 ++++++++++----------
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index dce2ff37df65..2c81394a2430 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -520,8 +520,7 @@ extern struct page *zero_page_memmap_ptr;
 
 #  ifdef CONFIG_VIRTUAL_MEM_MAP
   /* arch mem_map init routine is needed due to holes in a virtual mem_map */
-    extern void memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-			     unsigned long start_pfn);
+    extern void memmap_init_zone(struct zone *zone);
 #  endif /* CONFIG_VIRTUAL_MEM_MAP */
 # endif /* !__ASSEMBLY__ */
 
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index c8e68e92beb3..ccbda1a74c95 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -541,12 +541,14 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
 	return 0;
 }
 
-void __meminit
-memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-	     unsigned long start_pfn)
+void __meminit memmap_init_zone(struct zone *zone)
 {
+	unsigned long size = zone->spanned_pages;
+	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+	unsigned long start_pfn = zone->zone_start_pfn;
+
 	if (!vmem_map) {
-		memmap_init_range(size, nid, zone, start_pfn, start_pfn + size,
+		memmap_init_range(size, nid, zone_id, start_pfn, start_pfn + size,
 				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	} else {
 		struct page *start;
@@ -556,7 +558,7 @@ memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		args.start = start;
 		args.end = start + size;
 		args.nid = nid;
-		args.zone = zone;
+		args.zone = zone_id;
 
 		efi_memmap_walk(virtual_memmap_init, &args);
 	}
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69ebf75be91c..b2a46ffdaf0b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6292,16 +6292,16 @@ static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
 }
 #endif
 
-void __init __weak memmap_init_zone(unsigned long size, int nid,
-			       unsigned long zone,
-			       unsigned long zone_start_pfn)
+void __init __weak memmap_init_zone(struct zone *zone)
 {
 	unsigned long start_pfn, end_pfn, hole_start_pfn = 0;
-	unsigned long zone_end_pfn = zone_start_pfn + size;
+	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+	unsigned long zone_start_pfn = zone->zone_start_pfn;
+	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
 	u64 pgcnt = 0;
-	int i;
 
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		unsigned long size;
 		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
 		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
 		hole_start_pfn = clamp(hole_start_pfn, zone_start_pfn,
@@ -6309,13 +6309,13 @@ void __init __weak memmap_init_zone(unsigned long size, int nid,
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
-			memmap_init_range(size, nid, zone, start_pfn, zone_end_pfn,
+			memmap_init_range(size, nid, zone_id, start_pfn, zone_end_pfn,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 
 		if (hole_start_pfn < start_pfn)
 			pgcnt += init_unavailable_range(hole_start_pfn,
-							start_pfn, zone, nid);
+							start_pfn, zone_id, nid);
 		hole_start_pfn = end_pfn;
 	}
 
@@ -6328,11 +6328,11 @@ void __init __weak memmap_init_zone(unsigned long size, int nid,
 	 */
 	if (hole_start_pfn < zone_end_pfn)
 		pgcnt += init_unavailable_range(hole_start_pfn, zone_end_pfn,
-						zone, nid);
+						zone_id, nid);
 
 	if (pgcnt)
 		pr_info("%s: Zeroed struct page in unavailable ranges: %lld\n",
-			zone_names[zone], pgcnt);
+			zone_names[zone_id], pgcnt);
 }
 
 static int zone_batchsize(struct zone *zone)
@@ -7039,7 +7039,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		set_pageblock_order();
 		setup_usemap(pgdat, zone, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
-		memmap_init_zone(size, nid, j, zone_start_pfn);
+		memmap_init_zone(zone);
 	}
 }
 
-- 
2.17.2


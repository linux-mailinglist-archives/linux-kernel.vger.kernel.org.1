Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6C02FCA24
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbhATEyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727140AbhATEx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611118351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=ke3XGHybhKQvBVwg6qVeORAnDY+WoAeWb1CV+X6NiBI=;
        b=PlHH9w9AC7Vukpu5Avq/01rH6Wkofk8giC1AFXe10YxCH4Eplu19ydvMzTbTwQz1KOIRFM
        R0asDDGKZpemXF87fg9grA0o2klE2XnYkKBRaQMhDnoPN335OEfx8yOnG+nVmW8DeJVStj
        WKtQ/TgxqkcziApcSEE7qxXv4STMNz8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-j9rXEzqWNRGaDF80a1HjRA-1; Tue, 19 Jan 2021 23:52:28 -0500
X-MC-Unique: j9rXEzqWNRGaDF80a1HjRA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DCD7800D53;
        Wed, 20 Jan 2021 04:52:27 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-59.pek2.redhat.com [10.72.12.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A66BF60D11;
        Wed, 20 Jan 2021 04:52:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com
Subject: [PATCH v4 2/4] mm: simplify parater of function memmap_init_zone()
Date:   Wed, 20 Jan 2021 12:52:11 +0800
Message-Id: <20210120045213.6571-3-bhe@redhat.com>
In-Reply-To: <20210120045213.6571-1-bhe@redhat.com>
References: <20210120045213.6571-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As David suggested, simply passing 'struct zone *zone' is enough. We can
get all needed information from 'struct zone*' easily.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/ia64/include/asm/pgtable.h |  3 +--
 arch/ia64/mm/init.c             | 12 +++++++-----
 mm/page_alloc.c                 | 24 +++++++++++-------------
 3 files changed, 19 insertions(+), 20 deletions(-)

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
index c8e68e92beb3..88fb44895408 100644
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
+	int nid = zone_to_nid(zone), zone_id = zone_idx(zone);
+	unsigned long start_pfn = zone->zone_start_pfn;
+	unsigned long size = zone->spanned_pages;
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
index 42a1d2d2a87d..cbb67d9c1b2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6254,23 +6254,21 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	}
 }
 
-void __meminit __weak memmap_init_zone(unsigned long size, int nid,
-				  unsigned long zone,
-				  unsigned long range_start_pfn)
+void __meminit __weak memmap_init_zone(struct zone *zone)
 {
+	unsigned long zone_start_pfn = zone->zone_start_pfn;
+	unsigned long zone_end_pfn = zone_start_pfn + zone->spanned_pages;
+	int i, nid = zone_to_nid(zone), zone_id = zone_idx(zone);
 	unsigned long start_pfn, end_pfn;
-	unsigned long range_end_pfn = range_start_pfn + size;
-	int i;
 
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
-		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
-		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+		start_pfn = clamp(start_pfn, zone_start_pfn, zone_end_pfn);
+		end_pfn = clamp(end_pfn, zone_start_pfn, zone_end_pfn);
 
-		if (end_pfn > start_pfn) {
-			size = end_pfn - start_pfn;
-			memmap_init_range(size, nid, zone, start_pfn, range_end_pfn,
-					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
-		}
+		if (end_pfn > start_pfn)
+			memmap_init_range(end_pfn - start_pfn, nid,
+					zone_id, start_pfn, zone_end_pfn,
+					MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	}
 }
 
@@ -6978,7 +6976,7 @@ static void __init free_area_init_core(struct pglist_data *pgdat)
 		set_pageblock_order();
 		setup_usemap(pgdat, zone, zone_start_pfn, size);
 		init_currently_empty_zone(zone, zone_start_pfn, size);
-		memmap_init_zone(size, nid, j, zone_start_pfn);
+		memmap_init_zone(zone);
 	}
 }
 
-- 
2.17.2


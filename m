Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872442DF46F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 09:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgLTI3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 03:29:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40271 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgLTI3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 03:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608452889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8cwNb7UuvFU+SGAIQwzPO4ei7OBB7T1IjZCQpah9t/Y=;
        b=U9vAQX6faQQYMCQ5p9hHIty8u8EmHH9dtckq/7tLKAUA7/k4HLDR6qwiw3QlSFifWcx/Vk
        UmSvtaOdLUoUKV9SYSOA91YgAhG09V+/fX5FUW26gLictwrsO5DgdmykRR9w8OExdg+PNp
        Jxrfe0049/mQfd6jCKY05Izk93QE8zU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-FNl_lZu2NqiGAJJFKh8zPQ-1; Sun, 20 Dec 2020 03:28:07 -0500
X-MC-Unique: FNl_lZu2NqiGAJJFKh8zPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45D1E801B12;
        Sun, 20 Dec 2020 08:28:06 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-22.pek2.redhat.com [10.72.12.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD52C60C13;
        Sun, 20 Dec 2020 08:28:02 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        gopakumarr@vmware.com, rppt@kernel.org, david@redhat.com,
        bhe@redhat.com
Subject: [PATCH v2 1/5] mm: memmap defer init dosn't work as expected
Date:   Sun, 20 Dec 2020 16:27:50 +0800
Message-Id: <20201220082754.6900-2-bhe@redhat.com>
In-Reply-To: <20201220082754.6900-1-bhe@redhat.com>
References: <20201220082754.6900-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VMware observed a performance regression during memmap init on their platform,
and bisected to commit 73a6e474cb376 ("mm: memmap_init: iterate over memblock
regions rather that check each PFN") causing it.

Before the commit:

  [0.033176] Normal zone: 1445888 pages used for memmap
  [0.033176] Normal zone: 89391104 pages, LIFO batch:63
  [0.035851] ACPI: PM-Timer IO Port: 0x448

With commit

  [0.026874] Normal zone: 1445888 pages used for memmap
  [0.026875] Normal zone: 89391104 pages, LIFO batch:63
  [2.028450] ACPI: PM-Timer IO Port: 0x448

The root cause is the current memmap defer init doesn't work as expected.
Before, memmap_init_zone() was used to do memmap init of one whole zone, to
initialize all low zones of one numa node, but defer memmap init of the
last zone in that numa node. However, since commit 73a6e474cb376, function
memmap_init() is adapted to iterater over memblock regions inside one zone,
then call memmap_init_zone() to do memmap init for each region.

E.g, on VMware's system, the memory layout is as below, there are two memory
regions in node 2. The current code will mistakenly initialize the whole 1st
region [mem 0xab00000000-0xfcffffffff], then do memmap defer to iniatialize
only one memmory section on the 2nd region [mem 0x10000000000-0x1033fffffff].
In fact, we only expect to see that there's only one memory section's memmap
initialized. That's why more time is costed at the time.

[    0.008842] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x0009ffff]
[    0.008842] ACPI: SRAT: Node 0 PXM 0 [mem 0x00100000-0xbfffffff]
[    0.008843] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x55ffffffff]
[    0.008844] ACPI: SRAT: Node 1 PXM 1 [mem 0x5600000000-0xaaffffffff]
[    0.008844] ACPI: SRAT: Node 2 PXM 2 [mem 0xab00000000-0xfcffffffff]
[    0.008845] ACPI: SRAT: Node 2 PXM 2 [mem 0x10000000000-0x1033fffffff]

Now, let's add a parameter 'zone_end_pfn' to memmap_init_zone() to pass
down the real zone end pfn so that defer_init() can use it to judge whether
defer need be taken in zone wide.

Fixes: commit 73a6e474cb376 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")
Reported-by: Rahul Gopakumar <gopakumarr@vmware.com>
Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: stable@vger.kernel.org
---
 arch/ia64/mm/init.c | 4 ++--
 include/linux/mm.h  | 5 +++--
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 8 +++++---
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 9b5acf8fb092..e76386a3479e 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -536,7 +536,7 @@ virtual_memmap_init(u64 start, u64 end, void *arg)
 
 	if (map_start < map_end)
 		memmap_init_zone((unsigned long)(map_end - map_start),
-				 args->nid, args->zone, page_to_pfn(map_start),
+				 args->nid, args->zone, page_to_pfn(map_start), page_to_pfn(map_end),
 				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	return 0;
 }
@@ -546,7 +546,7 @@ memmap_init (unsigned long size, int nid, unsigned long zone,
 	     unsigned long start_pfn)
 {
 	if (!vmem_map) {
-		memmap_init_zone(size, nid, zone, start_pfn,
+		memmap_init_zone(size, nid, zone, start_pfn, start_pfn + size,
 				 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 	} else {
 		struct page *start;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e4e5be20b0c2..92e06ea053f4 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2432,8 +2432,9 @@ extern int __meminit early_pfn_to_nid(unsigned long pfn);
 #endif
 
 extern void set_dma_reserve(unsigned long new_dma_reserve);
-extern void memmap_init_zone(unsigned long, int, unsigned long, unsigned long,
-		enum meminit_context, struct vmem_altmap *, int migratetype);
+extern void memmap_init_zone(unsigned long, int, unsigned long,
+		unsigned long, unsigned long, enum meminit_context,
+		struct vmem_altmap *, int migratetype);
 extern void setup_per_zone_wmarks(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index af41fb990820..f9d57b9be8c7 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -713,7 +713,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * expects the zone spans the pfn range. All the pages in the range
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
-	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
+	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
 			 MEMINIT_HOTPLUG, altmap, migratetype);
 
 	set_zone_contiguous(zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8cea0823b70e..32645f2e7b96 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -423,6 +423,8 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
 		return false;
 
+	if (NODE_DATA(nid)->first_deferred_pfn != ULONG_MAX)
+		return true;
 	/*
 	 * We start only with one section of pages, more pages are added as
 	 * needed until the rest of deferred pages are initialized.
@@ -6116,7 +6118,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
  * zone stats (e.g., nr_isolate_pageblock) are touched.
  */
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn,
+		unsigned long start_pfn, unsigned long zone_end_pfn,
 		enum meminit_context context,
 		struct vmem_altmap *altmap, int migratetype)
 {
@@ -6152,7 +6154,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context == MEMINIT_EARLY) {
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
-			if (defer_init(nid, pfn, end_pfn))
+			if (defer_init(nid, pfn, zone_end_pfn))
 				break;
 		}
 
@@ -6307,7 +6309,7 @@ void __init __weak memmap_init(unsigned long size, int nid,
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
-			memmap_init_zone(size, nid, zone, start_pfn,
+			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 
-- 
2.17.2


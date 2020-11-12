Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF882B07CE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgKLOwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:52:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727035AbgKLOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:52:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605192720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bzV3bwrk9rmrhHk6dkBFubq9MMmfsIRILK60dRXDqHE=;
        b=HPwS/u/gwmrShyAUuTSBIecSelvMxadUPQszFZPY300kfKrvynZDYARcsq3Ps2cYgigWD/
        JLmkUAl0rxcYNCVN4nlOCyFt8lC27pSkI7XYMMJBLuwpanNN4YpryJ2480JaTcQx6JpUA9
        E90NfWUgxSo5Ja3Ys91+DW1vzfyeC9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-4NEbsf6TPImicgyjjVl8zg-1; Thu, 12 Nov 2020 09:51:55 -0500
X-MC-Unique: 4NEbsf6TPImicgyjjVl8zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7530318CB720;
        Thu, 12 Nov 2020 14:51:53 +0000 (UTC)
Received: from localhost (ovpn-12-196.pek2.redhat.com [10.72.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6DBCC6198D;
        Thu, 12 Nov 2020 14:51:52 +0000 (UTC)
Date:   Thu, 12 Nov 2020 22:51:49 +0800
From:   "bhe@redhat.com" <bhe@redhat.com>
To:     Rahul Gopakumar <gopakumarr@vmware.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>,
        Yiu Cho Lau <lauyiuch@vmware.com>,
        Peter Jonasson <pjonasson@vmware.com>,
        Venkatesh Rajaram <rajaramv@vmware.com>
Subject: Re: Performance regressions in "boot_time" tests in Linux 5.8 Kernel
Message-ID: <20201112145149.GN8486@MiWiFi-R3L-srv>
References: <DM6PR05MB529281F914953691E0F52D1CA4070@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201013131735.GL25604@MiWiFi-R3L-srv>
 <DM6PR05MB52926FDAB0E58F5CFA2E892DA41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201020151814.GU25604@MiWiFi-R3L-srv>
 <DM6PR05MB529293AC2B077B5170FFE625A41F0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201022040440.GX25604@MiWiFi-R3L-srv>
 <DM6PR05MB5292D8B85FA9DDE263F6147AA41D0@DM6PR05MB5292.namprd05.prod.outlook.com>
 <DM6PR05MB5292DF14DF1C82FFE001AC24A4100@DM6PR05MB5292.namprd05.prod.outlook.com>
 <20201102143035.GA3177@MiWiFi-R3L-srv>
 <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="24zk1gE8NUlDmwG9"
Content-Disposition: inline
In-Reply-To: <DM6PR05MB5292FD196FF6B18DCB47CE25A4110@DM6PR05MB5292.namprd05.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 11/03/20 at 12:34pm, Rahul Gopakumar wrote:
> >> So, you mean with the draft patch applied, the initial performance
> regression goes away, just many page corruption errors with call trace
> are seen, right?
> 
> Yes, that's right.
> 
> >> And the performance regression is about 2sec delay in
> your system?
> 
> The delay due to this new page corruption issue is about
> 3 secs.
> 
> Here is the summary
> 
> * Initial problem - 2 secs
> * Draft patch - Fixes initial problem (recovers 2 secs) but
> brings in new page corruption issue (3 secs)
> 
> >> Could you tell how you setup vmware VM so that I can ask our QA for
> help to create a vmware VM for me to test?
> 
> * Use vSphere ESXi 6.7 or 7.0 GA.
> * Create VM using vSphere Web Client and specify 1TB VM Memory.
> * Install RHEL 8.1, that's the guest used in this test.

Can you try the attached draft patch?

> 
> With draft patch, you should be able to reproduce the issue.
> Let me know if you need more details.


--24zk1gE8NUlDmwG9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-mm-make-memmap-defer-init-only-take-effect-per-zone.patch"

From 24d9b1fe55d79892cac3478711af216d898c7159 Mon Sep 17 00:00:00 2001
From: Baoquan He <bhe@redhat.com>
Date: Tue, 13 Oct 2020 20:05:30 +0800
Subject: [PATCH v2] mm: make memmap defer init only take effect per zone

Deferred struct page init is designed to work in zone wide. However since
commit 73a6e474cb376 ("mm: memmap_init: iterate over memblock regions
rather that check each PFN"), the handling is mistakenly done in all memory
ranges inside one zone. Especially in those unmovable zones of multiple nodes,
memblock allocation split them into many memory ranges. This makes initialized
struct page more than expected in early stage, then increases much boot time.

Let's fix it to make the memmap defer init handled in zone wide, but not in
sub memor range of one zone.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/ia64/mm/init.c | 4 ++--
 include/linux/mm.h  | 5 +++--
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 8 +++++---
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index ef12e097f318..27ca549ff47e 100644
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
index dae8e599f6c1..f82e73fd5d61 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2439,8 +2439,9 @@ extern int __meminit __early_pfn_to_nid(unsigned long pfn,
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
index b44d4c7ba73b..f9a37e6abc1c 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -732,7 +732,7 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	 * expects the zone spans the pfn range. All the pages in the range
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
-	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
+	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn, 0,
 			 MEMINIT_HOTPLUG, altmap, migratetype);
 
 	set_zone_contiguous(zone);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fa6076e1a840..5e5b74e88d69 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -448,6 +448,8 @@ defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
 	if (end_pfn < pgdat_end_pfn(NODE_DATA(nid)))
 		return false;
 
+	if (NODE_DATA(nid)->first_deferred_pfn != ULONG_MAX)
+		return true;
 	/*
 	 * We start only with one section of pages, more pages are added as
 	 * needed until the rest of deferred pages are initialized.
@@ -6044,7 +6046,7 @@ overlap_memmap_init(unsigned long zone, unsigned long *pfn)
  * zone stats (e.g., nr_isolate_pageblock) are touched.
  */
 void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
-		unsigned long start_pfn,
+		unsigned long start_pfn, unsigned long zone_end_pfn,
 		enum meminit_context context,
 		struct vmem_altmap *altmap, int migratetype)
 {
@@ -6080,7 +6082,7 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
 		if (context == MEMINIT_EARLY) {
 			if (overlap_memmap_init(zone, &pfn))
 				continue;
-			if (defer_init(nid, pfn, end_pfn))
+			if (defer_init(nid, pfn, zone_end_pfn))
 				break;
 		}
 
@@ -6194,7 +6196,7 @@ void __meminit __weak memmap_init(unsigned long size, int nid,
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
-			memmap_init_zone(size, nid, zone, start_pfn,
+			memmap_init_zone(size, nid, zone, start_pfn, range_end_pfn,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 	}
-- 
2.17.2


--24zk1gE8NUlDmwG9--


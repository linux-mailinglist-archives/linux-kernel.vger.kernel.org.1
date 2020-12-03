Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634B2CCF14
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgLCGYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:24:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46400 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727773AbgLCGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606976594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AfTKax3S+iawkpGIIYdiYS/pWdHeM6vnD6uWxjF77lw=;
        b=WXPWQ0zagL55Oh8YYO62/aLoTlDtKIeAciGLrZ59kdboS6Y3eJBMWPf1yeb4PiRKex1GbD
        0a0pxejBwGnF8z0B0b5flsPn2jGPANYSTmKxSgrJXSjeJItdVzuRudvHCZc6DkVDFeYhkJ
        BXlqxweFDd/LhoRmDY5CyoD1kw8Y0mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454--cG4fF9MNo-0MDfWUUDkjw-1; Thu, 03 Dec 2020 01:23:09 -0500
X-MC-Unique: -cG4fF9MNo-0MDfWUUDkjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BF74803F4D;
        Thu,  3 Dec 2020 06:23:08 +0000 (UTC)
Received: from mail (ovpn-112-118.rdu2.redhat.com [10.10.112.118])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 099C75D6BA;
        Thu,  3 Dec 2020 06:23:03 +0000 (UTC)
Date:   Thu, 3 Dec 2020 01:23:02 -0500
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <X8iERlMGfNCLxab5@redhat.com>
References: <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
 <20201126174601.GT123287@linux.ibm.com>
 <20201129123257.GY123287@linux.ibm.com>
 <X8bjgw5LPAZrSrwp@redhat.com>
 <20201202173923.GM123287@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202173923.GM123287@linux.ibm.com>
User-Agent: Mutt/2.0.2 (2020-11-20)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 07:39:23PM +0200, Mike Rapoport wrote:
> Hmm, do you have any logs? It worked on my box and with various memory
> configurations in qemu.

It crashes in reserve_bootmem_region so no logs at all since the
serial console isn't active yet.

> I believe that the proper solution would be to have all the memory
> reserved by the firmware added to memblock.memory, like all other
> architectures do, but I'm not sure if we can easily and reliably
> determine what of E820 reserved types are actually backed by RAM.
> So this is not feasible as a short term solution.
> 
> My patch [1], though, is an immediate improvement and I think it's worth
> trying to fix off-by-one's that prevent your system from booting.
> 
> [1] https://lore.kernel.org/lkml/20201201181502.2340-1-rppt@kernel.org

Yes that's the patch I applied.

Relevant points after debugging:

1) can you try again with DEBUG_VM=y?

2) DEBUG_VM=y already enforces the memset(page, 0xff, sizeof(struct
   page)) on all struct pages allocated, exactly I was suggesting to
   do in the previous email. I wonder why we're not doing that even
   with DEBUG_VM=n, perhaps it's too slow for TiB systems. See
   page_init_poison().

3) given 2), your patch below by deleting "0,0" initialization
   achieves the debug feature to keep PagePoison forever on all
   uninitialized pages, imagine PagePoison is really
   NO_NODEID/NO_ZONEID and doesn't need handling other than a crash.
  
-		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);

4) because of the feature in 3) I now hit the PagePoison VM_BUG_ON
   because pfn 0 wasn't initialized when reserve_bootmem_region tries
   to call __SetPageReserved on a PagePoison page.

5) pfn 0 is the classical case where pfn 0 is in a reserved zone in
   memblock.reserve that doesn't overlap any memblock.memory zone.

   The memblock_start_of_DRAM moves the start of the DMA zone above
   the pfn 0, so then pfn 0 already ends up in the no zone land David
   mentioned where it's not trivial to decide to give it a zoneid if
   it's not even spanned in the zone.

   Not just the zoneid, there's not even a nid.

   So we have a pfn with no zoneid, and no nid, and not part of the
   zone ranges, not part of the nid ranges not part of the
   memory.memblock.

   We can't really skip the initialization of the the pfn 0, it has to
   get the zoneid 0 treatment or if pfn 1 ends up in compaction code,
   we'd crash again. (although we'd crash with a nice PagePoison(page)
   == true behavior)

The below fixes the issue and it boots fine again and the compaction
crash should be solved with both patches applied.

DMA      zone_start_pfn 0            zone_end_pfn() 4096         contiguous 1     
DMA32    zone_start_pfn 4096         zone_end_pfn() 524252       contiguous 1     
Normal   zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0     

500246 0x7a216000 0x1fff000000001000 reserved True pfn_valid True
500247 0x7a217000 0x1fff000000000000 reserved False pfn_valid True
500248 0x7a218000 0x1fff000000000000 reserved False pfn_valid True

==== quote from previous email ====
73a6e474cb376921a311786652782155eac2fdf0 this changed it:

DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguous 1
DMA32    zone_start_pfn 4096         zone_end_pfn() 524252       contiguous 0
Normal   zone_start_pfn 0            zone_end_pfn() 0            contiguous 0
Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguous 0

500246 0x7a216000 0xfff000000001000 reserved True
500247 0x7a217000 0x1fff000000000000 reserved False
500248 0x7a218000 0x1fff000000010200 reserved False ]
==== quote from previous email ====

From 89469f063c192ae70aea0bd6e1e2a7e99894e5b6 Mon Sep 17 00:00:00 2001
From: Andrea Arcangeli <aarcange@redhat.com>
Date: Wed, 2 Dec 2020 23:23:26 -0500
Subject: [PATCH 1/1] mm: initialize struct pages in reserved regions outside
 of the zone ranges

pfn 0 wasn't initialized and the PagePoison remained set when
reserve_bootmem_region() called __SetPageReserved, inducing a silent
boot failure with DEBUG_VM (and correctly so, because the crash
signaled the nodeid/nid of pfn 0 would be again wrong).

Without this change, the pfn 0 part of a memblock.reserved range,
isn't in any zone spanned range, nor in any nid spanned range, when we
initialize the memblock.memory holes pfn 0 won't be included because
it has no nid and no zoneid.

There's no enforcement that all memblock.reserved ranges must overlap
memblock.memory ranges, so the memblock.reserved ranges also require
an explicit initialization and the zones and nid ranges need to be
extended to include all memblock.reserved ranges with struct pages, or
they'll be left uninitialized with PagePoison as it happened to pfn 0.

Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
---
 include/linux/memblock.h | 17 +++++++++---
 mm/debug.c               |  3 ++-
 mm/memblock.c            |  4 +--
 mm/page_alloc.c          | 57 ++++++++++++++++++++++++++++++++--------
 4 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ef131255cedc..c8e30cd69564 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -251,7 +251,8 @@ static inline bool memblock_is_nomap(struct memblock_region *m)
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
-			  unsigned long *out_end_pfn, int *out_nid);
+			  unsigned long *out_end_pfn, int *out_nid,
+			  struct memblock_type *type);
 
 /**
  * for_each_mem_pfn_range - early memory pfn range iterator
@@ -263,9 +264,17 @@ void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
  *
  * Walks over configured memory ranges.
  */
-#define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		\
-	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid); \
-	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid))
+#define for_each_mem_pfn_range(i, nid, p_start, p_end, p_nid)		  \
+	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.memory);		  \
+	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.memory))
+
+#define for_each_res_pfn_range(i, nid, p_start, p_end, p_nid)		  \
+	for (i = -1, __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.reserved);		  \
+	     i >= 0; __next_mem_pfn_range(&i, nid, p_start, p_end, p_nid, \
+					  &memblock.reserved))
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
 void __next_mem_pfn_range_in_zone(u64 *idx, struct zone *zone,
diff --git a/mm/debug.c b/mm/debug.c
index ccca576b2899..6a1d534f5ffc 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -64,7 +64,8 @@ void __dump_page(struct page *page, const char *reason)
 	 * dump_page() when detected.
 	 */
 	if (page_poisoned) {
-		pr_warn("page:%px is uninitialized and poisoned", page);
+		pr_warn("page:%px pfn:%ld is uninitialized and poisoned",
+			page, page_to_pfn(page));
 		goto hex_only;
 	}
 
diff --git a/mm/memblock.c b/mm/memblock.c
index b68ee86788af..3964a5e8914f 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1198,9 +1198,9 @@ void __init_memblock __next_mem_range_rev(u64 *idx, int nid,
  */
 void __init_memblock __next_mem_pfn_range(int *idx, int nid,
 				unsigned long *out_start_pfn,
-				unsigned long *out_end_pfn, int *out_nid)
+				unsigned long *out_end_pfn, int *out_nid,
+				struct memblock_type *type)
 {
-	struct memblock_type *type = &memblock.memory;
 	struct memblock_region *r;
 	int r_nid;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ce2bdaabdf96..3eed49598d66 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1458,6 +1458,7 @@ static void __meminit init_reserved_page(unsigned long pfn)
 {
 	pg_data_t *pgdat;
 	int nid, zid;
+	bool found = false;
 
 	if (!early_page_uninitialised(pfn))
 		return;
@@ -1468,10 +1469,15 @@ static void __meminit init_reserved_page(unsigned long pfn)
 	for (zid = 0; zid < MAX_NR_ZONES; zid++) {
 		struct zone *zone = &pgdat->node_zones[zid];
 
-		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone))
+		if (pfn >= zone->zone_start_pfn && pfn < zone_end_pfn(zone)) {
+			found = true;
 			break;
+		}
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	if (likely(found))
+		__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	else
+		WARN_ON_ONCE(1);
 }
 #else
 static inline void init_reserved_page(unsigned long pfn)
@@ -6227,7 +6233,7 @@ void __init __weak memmap_init(unsigned long size, int nid,
 			       unsigned long zone,
 			       unsigned long range_start_pfn)
 {
-	unsigned long start_pfn, end_pfn, next_pfn = 0;
+	unsigned long start_pfn, end_pfn, prev_pfn = 0;
 	unsigned long range_end_pfn = range_start_pfn + size;
 	u64 pgcnt = 0;
 	int i;
@@ -6235,7 +6241,7 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
 		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
-		next_pfn = clamp(next_pfn, range_start_pfn, range_end_pfn);
+		prev_pfn = clamp(prev_pfn, range_start_pfn, range_end_pfn);
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
@@ -6243,10 +6249,10 @@ void __init __weak memmap_init(unsigned long size, int nid,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
 
-		if (next_pfn < start_pfn)
-			pgcnt += init_unavailable_range(next_pfn, start_pfn,
+		if (prev_pfn < start_pfn)
+			pgcnt += init_unavailable_range(prev_pfn, start_pfn,
 							zone, nid);
-		next_pfn = end_pfn;
+		prev_pfn = end_pfn;
 	}
 
 	/*
@@ -6256,12 +6262,31 @@ void __init __weak memmap_init(unsigned long size, int nid,
 	 * considered initialized. Make sure that memmap has a well defined
 	 * state.
 	 */
-	if (next_pfn < range_end_pfn)
-		pgcnt += init_unavailable_range(next_pfn, range_end_pfn,
+	if (prev_pfn < range_end_pfn)
+		pgcnt += init_unavailable_range(prev_pfn, range_end_pfn,
 						zone, nid);
 
+	/*
+	 * memblock.reserved isn't enforced to overlap with
+	 * memblock.memory so initialize the struct pages for
+	 * memblock.reserved too in case it wasn't overlapping.
+	 *
+	 * If any struct page associated with a memblock.reserved
+	 * range isn't overlapping with a zone range, it'll be left
+	 * uninitialized, ideally with PagePoison, and it'll be a more
+	 * easily detectable error.
+	 */
+	for_each_res_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
+		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
+		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+
+		if (end_pfn > start_pfn)
+			pgcnt += init_unavailable_range(start_pfn, end_pfn,
+							zone, nid);
+	}
+
 	if (pgcnt)
-		pr_info("%s: Zeroed struct page in unavailable ranges: %lld\n",
+		pr_info("%s: pages in unavailable ranges: %lld\n",
 			zone_names[zone], pgcnt);
 }
 
@@ -6499,6 +6524,10 @@ void __init get_pfn_range_for_nid(unsigned int nid,
 		*start_pfn = min(*start_pfn, this_start_pfn);
 		*end_pfn = max(*end_pfn, this_end_pfn);
 	}
+	for_each_res_pfn_range(i, nid, &this_start_pfn, &this_end_pfn, NULL) {
+		*start_pfn = min(*start_pfn, this_start_pfn);
+		*end_pfn = max(*end_pfn, this_end_pfn);
+	}
 
 	if (*start_pfn == -1UL)
 		*start_pfn = 0;
@@ -7126,7 +7155,13 @@ unsigned long __init node_map_pfn_alignment(void)
  */
 unsigned long __init find_min_pfn_with_active_regions(void)
 {
-	return PHYS_PFN(memblock_start_of_DRAM());
+	/*
+	 * reserved regions must be included so that their page
+	 * structure can be part of a zone and obtain a valid zoneid
+	 * before __SetPageReserved().
+	 */
+	return min(PHYS_PFN(memblock_start_of_DRAM()),
+		   PHYS_PFN(memblock.reserved.regions[0].base));
 }
 
 /*


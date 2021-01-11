Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550182F1FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 20:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404018AbhAKTlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 14:41:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:53866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbhAKTlS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 14:41:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0222922CAF;
        Mon, 11 Jan 2021 19:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610394037;
        bh=QSSqxmMBYWOWvJ0gjPg24CkQDuQmjj5I8Cxdpfz7z78=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snw6TIlWtpt0LTtlJWFZ0EyO6BYKcfUdhrdJVY/KLihtswohPUvOUGzZLhHoTO6w9
         yycm607VeTmcWBBbHXJChTAoWbpj72WJll6divf4NoohfRdBqJPBIoE3PVDnFpJFkL
         7FnnrZYAFMMf8vx0LZ9dvzrIGbstliX3DsZtfnSdkzXsOR+ha1D8tpi59dp3tnCkSv
         fBgRHJIqZbVnb+JRy/L+FQ2aR+XipLreSEkwqTV10CnI3rLtupIB/tUogCD70EgWtT
         0dfYyEY1s/Y1PQ8OjmrDzI3Ht/NDejo4QuOAWpbp5NS9Ul80i38WHbGdKXaGV3/Mg8
         Ck5oIM3+bYIkg==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Hildenbrand <david@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: [PATCH v3 2/2] mm: fix initialization of struct page for holes in memory layout
Date:   Mon, 11 Jan 2021 21:40:17 +0200
Message-Id: <20210111194017.22696-3-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210111194017.22696-1-rppt@kernel.org>
References: <20210111194017.22696-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There could be struct pages that are not backed by actual physical memory.
This can happen when the actual memory bank is not a multiple of
SECTION_SIZE or when an architecture does not register memory holes
reserved by the firmware as memblock.memory.

Such pages are currently initialized using init_unavailable_mem() function
that iterates through PFNs in holes in memblock.memory and if there is a
struct page corresponding to a PFN, the fields if this page are set to
default values and the page is marked as Reserved.

init_unavailable_mem() does not take into account zone and node the page
belongs to and sets both zone and node links in struct page to zero.

On a system that has firmware reserved holes in a zone above ZONE_DMA, for
instance in a configuration below:

	# grep -A1 E820 /proc/iomem
	7a17b000-7a216fff : Unknown E820 type
	7a217000-7bffffff : System RAM

unset zone link in struct page will trigger

	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);

because there are pages in both ZONE_DMA32 and ZONE_DMA (unset zone link in
struct page) in the same pageblock.

Update init_unavailable_mem() to use zone constraints defined by an
architecture to properly setup the zone link and use node ID of the
adjacent range in memblock.memory to set the node link.

Fixes: 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather that check each PFN")
Reported-by: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 mm/page_alloc.c | 84 +++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 34 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bdbec4c98173..0b56c3ca354e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7077,23 +7077,26 @@ void __init free_area_init_memoryless_node(int nid)
  * Initialize all valid struct pages in the range [spfn, epfn) and mark them
  * PageReserved(). Return the number of struct pages that were initialized.
  */
-static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
+static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn,
+					 int zone, int nid)
 {
-	unsigned long pfn;
+	unsigned long pfn, zone_spfn, zone_epfn;
 	u64 pgcnt = 0;
 
+	zone_spfn = arch_zone_lowest_possible_pfn[zone];
+	zone_epfn = arch_zone_highest_possible_pfn[zone];
+
+	spfn = clamp(spfn, zone_spfn, zone_epfn);
+	epfn = clamp(epfn, zone_spfn, zone_epfn);
+
 	for (pfn = spfn; pfn < epfn; pfn++) {
 		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
 			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
 				+ pageblock_nr_pages - 1;
 			continue;
 		}
-		/*
-		 * Use a fake node/zone (0) for now. Some of these pages
-		 * (in memblock.reserved but not in memblock.memory) will
-		 * get re-initialized via reserve_bootmem_region() later.
-		 */
-		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
+
+		__init_single_page(pfn_to_page(pfn), pfn, zone, nid);
 		__SetPageReserved(pfn_to_page(pfn));
 		pgcnt++;
 	}
@@ -7102,51 +7105,64 @@ static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
 }
 
 /*
- * Only struct pages that are backed by physical memory are zeroed and
- * initialized by going through __init_single_page(). But, there are some
- * struct pages which are reserved in memblock allocator and their fields
- * may be accessed (for example page_to_pfn() on some configuration accesses
- * flags). We must explicitly initialize those struct pages.
+ * Only struct pages that correspond to ranges defined by memblock.memory
+ * are zeroed and initialized by going through __init_single_page() during
+ * memmap_init().
+ *
+ * But, there could be struct pages that correspond to holes in
+ * memblock.memory. This can happen because of the following reasons:
+ * - phyiscal memory bank size is not necessarily the exact multiple of the
+ *   arbitrary section size
+ * - early reserved memory may not be listed in memblock.memory
+ * - memory layouts defined with memmap= kernel parameter may not align
+ *   nicely with memmap sections
  *
- * This function also addresses a similar issue where struct pages are left
- * uninitialized because the physical address range is not covered by
- * memblock.memory or memblock.reserved. That could happen when memblock
- * layout is manually configured via memmap=, or when the highest physical
- * address (max_pfn) does not end on a section boundary.
+ * Explicitly initialize those struct pages so that:
+ * - PG_Reserved is set
+ * - zone link is set accorging to the architecture constrains
+ * - node is set to node id of the next populated region except for the
+ *   trailing hole where last node id is used
  */
-static void __init init_unavailable_mem(void)
+static void __init init_zone_unavailable_mem(int zone)
 {
-	phys_addr_t start, end;
-	u64 i, pgcnt;
-	phys_addr_t next = 0;
+	unsigned long start, end;
+	int i, nid;
+	u64 pgcnt;
+	unsigned long next = 0;
 
 	/*
-	 * Loop through unavailable ranges not covered by memblock.memory.
+	 * Loop through holes in memblock.memory and initialize struct
+	 * pages corresponding to these holes
 	 */
 	pgcnt = 0;
-	for_each_mem_range(i, &start, &end) {
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start, &end, &nid) {
 		if (next < start)
-			pgcnt += init_unavailable_range(PFN_DOWN(next),
-							PFN_UP(start));
+			pgcnt += init_unavailable_range(next, start, zone, nid);
 		next = end;
 	}
 
 	/*
-	 * Early sections always have a fully populated memmap for the whole
-	 * section - see pfn_valid(). If the last section has holes at the
-	 * end and that section is marked "online", the memmap will be
-	 * considered initialized. Make sure that memmap has a well defined
-	 * state.
+	 * Last section may surpass the actual end of memory (e.g. we can
+	 * have 1Gb section and 512Mb of RAM pouplated).
+	 * Make sure that memmap has a well defined state in this case.
 	 */
-	pgcnt += init_unavailable_range(PFN_DOWN(next),
-					round_up(max_pfn, PAGES_PER_SECTION));
+	end = round_up(max_pfn, PAGES_PER_SECTION);
+	pgcnt += init_unavailable_range(next, end, zone, nid);
 
 	/*
 	 * Struct pages that do not have backing memory. This could be because
 	 * firmware is using some of this memory, or for some other reasons.
 	 */
 	if (pgcnt)
-		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
+		pr_info("Zone %s: zeroed struct page in unavailable ranges: %lld pages", zone_names[zone], pgcnt);
+}
+
+static void __init init_unavailable_mem(void)
+{
+	int zone;
+
+	for (zone = 0; zone < ZONE_MOVABLE; zone++)
+		init_zone_unavailable_mem(zone);
 }
 #else
 static inline void __init init_unavailable_mem(void)
-- 
2.28.0


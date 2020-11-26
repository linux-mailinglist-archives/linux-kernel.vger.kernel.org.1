Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E882C5AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404504AbgKZRqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 12:46:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404497AbgKZRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 12:46:20 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AQHXQV7067233;
        Thu, 26 Nov 2020 12:46:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=XfGL59d61N6kZEsInBPF3lzRmnFi1Tgn3N5bbBfLIK0=;
 b=Z5wO3Zm2I0/VeSTwVuZTzMujkhrb6vKeAfPdf4J4tNxNosQyROHkfZLsEABO2PmSnYxU
 xPFuYcUcC2i1IQRK2W2RFHpw4PBy9e8lF7MOeFp7VvnZjIGJdQV0HMwQeE/RD5+wtlya
 6m0BavqGIj6LTJubf6eXjaCLGejqAf78Miv1sXVlHToq34YpMKdE5EFl4AmJ8IHbjAjP
 RG4ZIA6DfEi9jTxRzSSE1XkZVkwpRoQGXAhXwIYVEZ/jwpXzK/DKE+TmqGfguu5K+ZyZ
 lvbbfR0bPaMYwePSsDbwbERVclfM+yQdW0/NCcez+lrkSwIIuZZiZEMkIM7enC641LH1 QQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352ccer2fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 12:46:10 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0AQHXjGU068998;
        Thu, 26 Nov 2020 12:46:10 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 352ccer2f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 12:46:09 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0AQHalYq004679;
        Thu, 26 Nov 2020 17:46:07 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 34yy8r3ag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 17:46:07 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0AQHk5Gp43844036
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Nov 2020 17:46:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42FE14C044;
        Thu, 26 Nov 2020 17:46:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E64FD4C046;
        Thu, 26 Nov 2020 17:46:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.183.229])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 26 Nov 2020 17:46:03 +0000 (GMT)
Date:   Thu, 26 Nov 2020 19:46:01 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set
 pageblock_skip on reserved pages
Message-ID: <20201126174601.GT123287@linux.ibm.com>
References: <X73s8fxDKPRD6wET@redhat.com>
 <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
 <X76iatgBErQH5El4@redhat.com>
 <a4cc62ba-8066-3e9c-cead-98cd74d313dd@redhat.com>
 <20201125210414.GO123287@linux.ibm.com>
 <X77OyM8utmWcq1Di@redhat.com>
 <20201126093602.GQ123287@linux.ibm.com>
 <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bb709a7-6100-aa5c-4125-7ed80c6d9643@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_06:2020-11-26,2020-11-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=5
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011260104
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 26, 2020 at 11:05:14AM +0100, David Hildenbrand wrote:
> On 26.11.20 10:36, Mike Rapoport wrote:
> > On Wed, Nov 25, 2020 at 04:38:16PM -0500, Andrea Arcangeli wrote:
> > 
> >> At best memory.reserved should be calculated automatically by the
> >> page_alloc.c based on the zone_start_pfn/zone_end_pfn and not passed
> >> by the e820 caller, instead of adding the memory_reserve call for type
> >> 20 we should delete the memory_reserve function.
> >  
> > memory.reserved cannot be calculated automatically. It represents all
> > the memory allocations made before page allocator is up. And as
> > memblock_reserve() is the most basic to allocate memory early at boot we
> > cannot really delete it ;-)
> > 
> > As for e820 and type 20, unless it is in memblock, page_alloc.c has no
> > way to properly initialize memmap for it. It can continue to guess, like
> > it does with init_unavailable_memory().
> 
> AFAIS, init_unavailable_mem() has to logic to setup *any* such struct
> page properly up - except the node/zid, because that's unknown at that
> time. It is documented that (big comment above init_unavailable_mem())

// The comment is a bit inaccurate, but that's another story :)

> which pages won't get initialized again. They *are* initialized, just
> the node/zone is "fake" - that's the real problem we seem to have.

Let's try to merge init_unavailable_memory() into memmap_init().
Than it'll be able to set zone/nid for those nasty pfns that BIOS
decided to keep to itself, like in Andrea's case and will also take care
of struct pages that do not really have a frame in DRAM, but are there
because of arbitrary section size.

Something like this:

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eaa227a479e4..072e94042a11 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6185,24 +6185,84 @@ static void __meminit zone_init_free_lists(struct zone *zone)
 	}
 }
 
-void __meminit __weak memmap_init(unsigned long size, int nid,
-				  unsigned long zone,
-				  unsigned long range_start_pfn)
+#if !defined(CONFIG_FLAT_NODE_MEM_MAP)
+/*
+ * Only struct pages that are backed by physical memory available to the
+ * kernel are zeroed and initialized by memmap_init_zone().
+ * But, there are some struct pages that are either reserved by firmware or
+ * do not correspond to physical page frames becuase actual memory bank is
+ * not a multiple of SECTION_SIZE. Fields of those struct pages may be
+ * accessed (for example page_to_pfn() on some configuration accesses
+ * flags) so we must explicitly initialize those struct pages.
+ */
+static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn,
+					 int zone, int node)
 {
-	unsigned long start_pfn, end_pfn;
+	unsigned long pfn;
+	u64 pgcnt = 0;
+
+	for (pfn = spfn; pfn < epfn; pfn++) {
+		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
+			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
+				+ pageblock_nr_pages - 1;
+			continue;
+		}
+		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
+		__SetPageReserved(pfn_to_page(pfn));
+		pgcnt++;
+	}
+
+	return pgcnt;
+}
+#else
+static inline u64 init_unavailable_range(unsigned long spfn, unsigned long epfn,
+					 int zone, int node)
+{
+	return 0;
+}
+#endif
+
+void __init __weak memmap_init(unsigned long size, int nid,
+			       unsigned long zone,
+			       unsigned long range_start_pfn)
+{
+	unsigned long start_pfn, end_pfn, next_pfn = 0;
 	unsigned long range_end_pfn = range_start_pfn + size;
+	u64 pgcnt = 0;
 	int i;
 
 	for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
 		start_pfn = clamp(start_pfn, range_start_pfn, range_end_pfn);
 		end_pfn = clamp(end_pfn, range_start_pfn, range_end_pfn);
+		next_pfn = clamp(next_pfn, range_start_pfn, range_end_pfn);
 
 		if (end_pfn > start_pfn) {
 			size = end_pfn - start_pfn;
 			memmap_init_zone(size, nid, zone, start_pfn,
 					 MEMINIT_EARLY, NULL, MIGRATE_MOVABLE);
 		}
+
+		if (next_pfn < start_pfn)
+			pgcnt += init_unavailable_range(next_pfn, start_pfn,
+							zone, nid);
+		next_pfn = end_pfn;
 	}
+
+	/*
+	 * Early sections always have a fully populated memmap for the whole
+	 * section - see pfn_valid(). If the last section has holes at the
+	 * end and that section is marked "online", the memmap will be
+	 * considered initialized. Make sure that memmap has a well defined
+	 * state.
+	 */
+	if (next_pfn < range_end_pfn)
+		pgcnt += init_unavailable_range(next_pfn, range_end_pfn,
+						zone, nid);
+
+	if (pgcnt)
+		pr_info("%s: Zeroed struct page in unavailable ranges: %lld\n",
+			zone_names[zone], pgcnt);
+
 }
 
 static int zone_batchsize(struct zone *zone)
@@ -6995,88 +7055,6 @@ void __init free_area_init_memoryless_node(int nid)
 	free_area_init_node(nid);
 }
 
-#if !defined(CONFIG_FLAT_NODE_MEM_MAP)
-/*
- * Initialize all valid struct pages in the range [spfn, epfn) and mark them
- * PageReserved(). Return the number of struct pages that were initialized.
- */
-static u64 __init init_unavailable_range(unsigned long spfn, unsigned long epfn)
-{
-	unsigned long pfn;
-	u64 pgcnt = 0;
-
-	for (pfn = spfn; pfn < epfn; pfn++) {
-		if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
-			pfn = ALIGN_DOWN(pfn, pageblock_nr_pages)
-				+ pageblock_nr_pages - 1;
-			continue;
-		}
-		/*
-		 * Use a fake node/zone (0) for now. Some of these pages
-		 * (in memblock.reserved but not in memblock.memory) will
-		 * get re-initialized via reserve_bootmem_region() later.
-		 */
-		__init_single_page(pfn_to_page(pfn), pfn, 0, 0);
-		__SetPageReserved(pfn_to_page(pfn));
-		pgcnt++;
-	}
-
-	return pgcnt;
-}
-
-/*
- * Only struct pages that are backed by physical memory are zeroed and
- * initialized by going through __init_single_page(). But, there are some
- * struct pages which are reserved in memblock allocator and their fields
- * may be accessed (for example page_to_pfn() on some configuration accesses
- * flags). We must explicitly initialize those struct pages.
- *
- * This function also addresses a similar issue where struct pages are left
- * uninitialized because the physical address range is not covered by
- * memblock.memory or memblock.reserved. That could happen when memblock
- * layout is manually configured via memmap=, or when the highest physical
- * address (max_pfn) does not end on a section boundary.
- */
-static void __init init_unavailable_mem(void)
-{
-	phys_addr_t start, end;
-	u64 i, pgcnt;
-	phys_addr_t next = 0;
-
-	/*
-	 * Loop through unavailable ranges not covered by memblock.memory.
-	 */
-	pgcnt = 0;
-	for_each_mem_range(i, &start, &end) {
-		if (next < start)
-			pgcnt += init_unavailable_range(PFN_DOWN(next),
-							PFN_UP(start));
-		next = end;
-	}
-
-	/*
-	 * Early sections always have a fully populated memmap for the whole
-	 * section - see pfn_valid(). If the last section has holes at the
-	 * end and that section is marked "online", the memmap will be
-	 * considered initialized. Make sure that memmap has a well defined
-	 * state.
-	 */
-	pgcnt += init_unavailable_range(PFN_DOWN(next),
-					round_up(max_pfn, PAGES_PER_SECTION));
-
-	/*
-	 * Struct pages that do not have backing memory. This could be because
-	 * firmware is using some of this memory, or for some other reasons.
-	 */
-	if (pgcnt)
-		pr_info("Zeroed struct page in unavailable ranges: %lld pages", pgcnt);
-}
-#else
-static inline void __init init_unavailable_mem(void)
-{
-}
-#endif /* !CONFIG_FLAT_NODE_MEM_MAP */
-
 #if MAX_NUMNODES > 1
 /*
  * Figure out the number of possible node ids.
@@ -7500,7 +7478,6 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	/* Initialise every node */
 	mminit_verify_pageflags_layout();
 	setup_nr_node_ids();
-	init_unavailable_mem();
 	for_each_online_node(nid) {
 		pg_data_t *pgdat = NODE_DATA(nid);
 		free_area_init_node(nid);


> I agree that this is sub-optimal, as such pages are impossible to detect
> (PageReserved is just not clear as discussed with Andrea). The basic
> question is how we want to proceed:
> 
> a) Make sure any online struct page has a valid nid/zid, and is spanned
> by the nid/zid.
> b) Use a fake nid that will bail out when used for page_zone() and
> page_pgdat(), and make pfn walkers detect that.
> 
> AFAIU, Andrea seems to prefer a). I thing b) might be easier in corner
> cases. Thoughts?

I'd also prefer (a). 

The hardware defines what physical addresses correspond to which node,
so for any populated DIMM (or soldered DRAM for that matter) we can
detect page <-> node relationship.

As for the struct pages that just "hang" in the end of a section (your
example with 4000M), the addresses of these pages still obey the same
rules, so again, we have page <-> node correspondence.

The zones are software construct but they also correspond to some
hardware defined restrictions - each zone has a maximal PFN that HW
allows. Here again we can always know which zone spans that or another
page.

We'd have to fix a couple of things to get there, though :)

> ---
> 
> The tricky thing for b) is to fix all call places that do a
> page_zone()/page_pgdat() without checking if they are allowed to do so.
> We would have to audit all callers of page_zone() / page_zone_id() /
> page_pgdat() ...
> 
> 
> E.g., using a pattern like
> mm/memory_hotplug.c:find_biggest_section_pfn() is fine
> 
> 
> if (unlikely(!pfn_to_online_page(pfn)))
> 	continue;
> if (unlikely(pfn_to_nid(pfn) != nid))
> 	continue;
> 
> 
> e.g., mm/page_alloc.c:__pageblock_pfn_to_page() would have to be adjusted
> 
> start_page = pfn_to_online_page(start_pfn);
> if (!start_page)
> 	return NULL;
> 
> // necessary to avoid ...
> if (page_to_nid(page) == NODE_INVALID)
> 	return NULL;
> 
> // page_zone() from bailing out
> if (page_zone(start_page) != zone)
> 	return NULL;
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

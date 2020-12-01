Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBB972CA1D0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgLALwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:52:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728316AbgLALwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:52:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EE465AD09;
        Tue,  1 Dec 2020 11:52:10 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 2/4] mm,memory_hotplug: Allocate memmap from the added memory range
Date:   Tue,  1 Dec 2020 12:51:56 +0100
Message-Id: <20201201115158.22638-3-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201201115158.22638-1-osalvador@suse.de>
References: <20201201115158.22638-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Physical memory hotadd has to allocate a memmap (struct page array) for
the newly added memory section. Currently, alloc_pages_node() is used
for those allocations.

This has some disadvantages:
 a) an existing memory is consumed for that purpose
    (eg: ~2MB per 128MB memory section on x86_64)
 b) if the whole node is movable then we have off-node struct pages
    which has performance drawbacks.
 c) It might be there are no PMD_ALIGNED chunks so memmap array gets
    populated with base pages.

This can be improved when CONFIG_SPARSEMEM_VMEMMAP is enabled.

Vmemap page tables can map arbitrary memory.
That means that we can simply use the beginning of each memory section and
map struct pages there.
struct pages which back the allocated space then just need to be treated
carefully.

Implementation wise we will reuse vmem_altmap infrastructure to override
the default allocator used by __populate_section_memmap.
Part of the implementation also relies on memory_block structure gaining
a new field which specifies the number of vmemmap_pages at the beginning.
This comes in handy as in {online,offline}_pages, all the isolation and
migration is being one on (buddy_start_pfn, end_pfn] range,
being buddy_start_pfn = start_pfn + nr_vmemmap_pages.

In this way, we have:

(start_pfn, buddy_start_pfn - 1] = Initialized and PageReserved
(buddy_start_pfn, end_pfn]       = Initialized and sent to buddy

Hot-remove:

 If the range was using memmap on memory (aka vmemmap pages),
 we construct an altmap structure so free_hugepage_table does
 the right thing and calls vmem_altmap_free instead of
 free_pagetable.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/base/memory.c          | 21 +++++---
 include/linux/memory.h         |  7 ++-
 include/linux/memory_hotplug.h | 12 +++--
 include/linux/memremap.h       |  2 +-
 mm/memory_hotplug.c            | 94 ++++++++++++++++++++++++++--------
 mm/page_alloc.c                |  4 +-
 6 files changed, 105 insertions(+), 35 deletions(-)

diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index 00a2f7191357..ed68fe267837 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -175,7 +175,7 @@ int memory_notify(unsigned long val, void *v)
  */
 static int
 memory_block_action(unsigned long start_section_nr, unsigned long action,
-		    int online_type, int nid)
+		    int online_type, int nid, unsigned long nr_vmemmap_pages)
 {
 	unsigned long start_pfn;
 	unsigned long nr_pages = PAGES_PER_SECTION * sections_per_block;
@@ -185,10 +185,11 @@ memory_block_action(unsigned long start_section_nr, unsigned long action,
 
 	switch (action) {
 	case MEM_ONLINE:
-		ret = online_pages(start_pfn, nr_pages, online_type, nid);
+		ret = online_pages(start_pfn, nr_pages, nr_vmemmap_pages,
+				   online_type, nid);
 		break;
 	case MEM_OFFLINE:
-		ret = offline_pages(start_pfn, nr_pages);
+		ret = offline_pages(start_pfn, nr_pages, nr_vmemmap_pages);
 		break;
 	default:
 		WARN(1, KERN_WARNING "%s(%ld, %ld) unknown action: "
@@ -211,7 +212,7 @@ static int memory_block_change_state(struct memory_block *mem,
 		mem->state = MEM_GOING_OFFLINE;
 
 	ret = memory_block_action(mem->start_section_nr, to_state,
-				  mem->online_type, mem->nid);
+				  mem->online_type, mem->nid, mem->nr_vmemmap_pages);
 
 	mem->state = ret ? from_state_req : to_state;
 
@@ -571,7 +572,8 @@ int register_memory(struct memory_block *memory)
 	return ret;
 }
 
-static int init_memory_block(unsigned long block_id, unsigned long state)
+static int init_memory_block(unsigned long block_id, unsigned long state,
+			     unsigned long nr_vmemmap_pages)
 {
 	struct memory_block *mem;
 	unsigned long start_pfn;
@@ -591,6 +593,7 @@ static int init_memory_block(unsigned long block_id, unsigned long state)
 	start_pfn = section_nr_to_pfn(mem->start_section_nr);
 	mem->phys_device = arch_get_memory_phys_device(start_pfn);
 	mem->nid = NUMA_NO_NODE;
+	mem->nr_vmemmap_pages = nr_vmemmap_pages;
 
 	ret = register_memory(mem);
 
@@ -610,7 +613,7 @@ static int add_memory_block(unsigned long base_section_nr)
 	if (section_count == 0)
 		return 0;
 	return init_memory_block(memory_block_id(base_section_nr),
-				 MEM_ONLINE);
+				 MEM_ONLINE, 0);
 }
 
 static void unregister_memory(struct memory_block *memory)
@@ -632,7 +635,8 @@ static void unregister_memory(struct memory_block *memory)
  *
  * Called under device_hotplug_lock.
  */
-int create_memory_block_devices(unsigned long start, unsigned long size)
+int create_memory_block_devices(unsigned long start, unsigned long size,
+				unsigned long vmemmap_pages)
 {
 	const unsigned long start_block_id = pfn_to_block_id(PFN_DOWN(start));
 	unsigned long end_block_id = pfn_to_block_id(PFN_DOWN(start + size));
@@ -645,9 +649,10 @@ int create_memory_block_devices(unsigned long start, unsigned long size)
 		return -EINVAL;
 
 	for (block_id = start_block_id; block_id != end_block_id; block_id++) {
-		ret = init_memory_block(block_id, MEM_OFFLINE);
+		ret = init_memory_block(block_id, MEM_OFFLINE, vmemmap_pages);
 		if (ret)
 			break;
+		vmemmap_pages = 0;
 	}
 	if (ret) {
 		end_block_id = block_id;
diff --git a/include/linux/memory.h b/include/linux/memory.h
index 439a89e758d8..b910d2aea879 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -30,6 +30,11 @@ struct memory_block {
 	int phys_device;		/* to which fru does this belong? */
 	struct device dev;
 	int nid;			/* NID for this memory block */
+	unsigned long nr_vmemmap_pages;	/*
+					 * Number of vmemmap pages. These pages
+					 * lay at the beginning of the memory
+					 * block.
+					 */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
@@ -81,7 +86,7 @@ static inline int memory_notify(unsigned long val, void *v)
 #else
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
-int create_memory_block_devices(unsigned long start, unsigned long size);
+int create_memory_block_devices(unsigned long start, unsigned long size, unsigned long vmemmap_pages);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index a54310abee79..b828ddf07682 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -121,11 +121,13 @@ extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
-			int online_type, int nid);
+			unsigned long nr_vmemmap_pages, int online_type,
+			int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
-				     unsigned long end_pfn);
+				     unsigned long end_pfn,
+				     unsigned long buddy_start_pfn);
 
 typedef void (*online_page_callback_t)(struct page *page, unsigned int order);
 
@@ -321,7 +323,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			 unsigned long nr_vmemmap_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 extern int offline_and_remove_memory(int nid, u64 start, u64 size);
@@ -329,7 +332,8 @@ extern int offline_and_remove_memory(int nid, u64 start, u64 size);
 #else
 static inline void try_offline_node(int nid) {}
 
-static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+				unsigned long nr_vmemmap_pages)
 {
 	return -EINVAL;
 }
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 86c6c368ce9b..3de5d482ac1a 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -17,7 +17,7 @@ struct device;
  * @alloc: track pages consumed, private to vmemmap_populate()
  */
 struct vmem_altmap {
-	const unsigned long base_pfn;
+	unsigned long base_pfn;
 	const unsigned long end_pfn;
 	const unsigned long reserve;
 	unsigned long free;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e3c310225a60..4b4708512f82 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -606,10 +606,12 @@ void generic_online_page(struct page *page, unsigned int order)
 }
 EXPORT_SYMBOL_GPL(generic_online_page);
 
-static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
+static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages,
+			       unsigned long buddy_start_pfn)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn;
+	unsigned int order;
 
 	/*
 	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
@@ -617,8 +619,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
 	 */
-	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
-		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
+	for (pfn = buddy_start_pfn; pfn < end_pfn; pfn += (1 << order)) {
+		order = MAX_ORDER - 1;
+		while (pfn & ((1 << order) - 1))
+			order--;
+		(*online_page_callback)(pfn_to_page(pfn), order);
+	}
 
 	/* mark all involved sections as online */
 	online_mem_sections(start_pfn, end_pfn);
@@ -678,6 +684,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
 
 }
+
 /*
  * Associate the pfn range with the given zone, initializing the memmaps
  * and resizing the pgdat/zone data to span the added pages. After this
@@ -777,9 +784,9 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 }
 
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
-		       int online_type, int nid)
+		       unsigned long nr_vmemmap_pages, int online_type, int nid)
 {
-	unsigned long flags;
+	unsigned long flags, buddy_start_pfn, buddy_nr_pages;
 	struct zone *zone;
 	int need_zonelists_rebuild = 0;
 	int ret;
@@ -790,11 +797,18 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
+	buddy_start_pfn = pfn + nr_vmemmap_pages;
+	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
+
 	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
 	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
-	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
+	if (nr_vmemmap_pages)
+		move_pfn_range_to_zone(zone, pfn, nr_vmemmap_pages, NULL,
+				       MIGRATE_UNMOVABLE);
+	move_pfn_range_to_zone(zone, buddy_start_pfn, buddy_nr_pages, NULL,
+			       MIGRATE_ISOLATE);
 
 	arg.start_pfn = pfn;
 	arg.nr_pages = nr_pages;
@@ -810,7 +824,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	 * onlining, such that undo_isolate_page_range() works correctly.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock += buddy_nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/*
@@ -823,7 +837,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		setup_zone_pageset(zone);
 	}
 
-	online_pages_range(pfn, nr_pages);
+	online_pages_range(pfn, nr_pages, buddy_start_pfn);
 	zone->present_pages += nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -836,7 +850,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone_pcp_update(zone);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+	undo_isolate_page_range(buddy_start_pfn,
+				buddy_start_pfn + buddy_nr_pages,
+				MIGRATE_MOVABLE);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -1034,6 +1050,7 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = PAGE_KERNEL };
+	struct vmem_altmap mhp_altmap = {};
 	u64 start, size;
 	bool new_node = false;
 	int ret;
@@ -1070,13 +1087,22 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error;
 	}
 
+	/*
+	 * Self hosted memmap array
+	 */
+	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
+		mhp_altmap.free = size >> PAGE_SHIFT;
+		mhp_altmap.base_pfn = start >> PAGE_SHIFT;
+		params.altmap = &mhp_altmap;
+	}
+
 	/* call arch's memory hotadd */
 	ret = arch_add_memory(nid, start, size, &params);
 	if (ret < 0)
 		goto error;
 
 	/* create memory block devices after memory was added */
-	ret = create_memory_block_devices(start, size);
+	ret = create_memory_block_devices(start, size, mhp_altmap.alloc);
 	if (ret) {
 		arch_remove_memory(nid, start, size, NULL);
 		goto error;
@@ -1472,10 +1498,11 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			unsigned long nr_vmemmap_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, system_ram_pages = 0;
+	unsigned long pfn, buddy_start_pfn, buddy_nr_pages, system_ram_pages = 0;
 	unsigned long flags;
 	struct zone *zone;
 	struct memory_notify arg;
@@ -1487,6 +1514,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
+	buddy_start_pfn = start_pfn + nr_vmemmap_pages;
+	buddy_nr_pages = nr_pages - nr_vmemmap_pages;
+
 	mem_hotplug_begin();
 
 	/*
@@ -1522,7 +1552,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	zone_pcp_disable(zone);
 
 	/* set above range as isolated */
-	ret = start_isolate_page_range(start_pfn, end_pfn,
+	ret = start_isolate_page_range(buddy_start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
@@ -1542,7 +1572,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	}
 
 	do {
-		pfn = start_pfn;
+		pfn = buddy_start_pfn;
 		do {
 			if (signal_pending(current)) {
 				ret = -EINTR;
@@ -1573,18 +1603,18 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		 * offlining actually in order to make hugetlbfs's object
 		 * counting consistent.
 		 */
-		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
+		ret = dissolve_free_huge_pages(buddy_start_pfn, end_pfn);
 		if (ret) {
 			reason = "failure to dissolve huge pages";
 			goto failed_removal_isolated;
 		}
 
-		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
+		ret = test_pages_isolated(buddy_start_pfn, end_pfn, MEMORY_OFFLINE);
 
 	} while (ret);
 
 	/* Mark all sections offline and remove free pages from the buddy. */
-	__offline_isolated_pages(start_pfn, end_pfn);
+	__offline_isolated_pages(start_pfn, end_pfn, buddy_start_pfn);
 	pr_info("Offlined Pages %ld\n", nr_pages);
 
 	/*
@@ -1593,13 +1623,13 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * of isolated pageblocks, memory onlining will properly revert this.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock -= buddy_nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	zone_pcp_enable(zone);
 
 	/* removal success */
-	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	adjust_managed_page_count(pfn_to_page(start_pfn), -buddy_nr_pages);
 	zone->present_pages -= nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -1659,6 +1689,16 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 	return 0;
 }
 
+static int get_memblock_vmemmap_pages_cb(struct memory_block *mem, void *arg)
+{
+	unsigned long *nr_vmemmap_pages = (unsigned long *)arg;
+	int ret = !mem->nr_vmemmap_pages;
+
+	if (!ret)
+		*nr_vmemmap_pages += mem->nr_vmemmap_pages;
+	return ret;
+}
+
 static int check_cpu_on_node(pg_data_t *pgdat)
 {
 	int cpu;
@@ -1733,6 +1773,9 @@ EXPORT_SYMBOL(try_offline_node);
 static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
+	struct vmem_altmap mhp_altmap = {};
+	struct vmem_altmap *altmap = NULL;
+	unsigned long nr_vmemmap_pages = 0;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -1745,6 +1788,17 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 	if (rc)
 		return rc;
 
+	/*
+	 * Prepare a vmem_altmap struct if we used it at hot-add, so
+	 * remove_pmd_table->free_hugepage_table does the right thing.
+	 */
+	(void)walk_memory_blocks(start, size, &nr_vmemmap_pages,
+	     get_memblock_vmemmap_pages_cb);
+	if (nr_vmemmap_pages) {
+		mhp_altmap.alloc = nr_vmemmap_pages;
+		altmap = &mhp_altmap;
+	}
+
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
 
@@ -1756,7 +1810,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 
 	mem_hotplug_begin();
 
-	arch_remove_memory(nid, start, size, NULL);
+	arch_remove_memory(nid, start, size, altmap);
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		memblock_free(start, size);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f91df593bf71..818fb0223c35 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8856,7 +8856,8 @@ void zone_pcp_reset(struct zone *zone)
  * All pages in the range must be in a single zone, must not contain holes,
  * must span full sections, and must be isolated before calling this function.
  */
-void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
+void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn,
+			      unsigned long buddy_start_pfn)
 {
 	unsigned long pfn = start_pfn;
 	struct page *page;
@@ -8867,6 +8868,7 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	offline_mem_sections(pfn, end_pfn);
 	zone = page_zone(pfn_to_page(pfn));
 	spin_lock_irqsave(&zone->lock, flags);
+	pfn = buddy_start_pfn;
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
 		/*
-- 
2.26.2


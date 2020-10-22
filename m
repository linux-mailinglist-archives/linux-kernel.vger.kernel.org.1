Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA0295F34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 14:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899189AbgJVM6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 08:58:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:60076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411014AbgJVM6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 08:58:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CDA64AEE7;
        Thu, 22 Oct 2020 12:58:43 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH 3/3] mm,memory_hotplug: Allocate memmap from the added memory range
Date:   Thu, 22 Oct 2020 14:58:35 +0200
Message-Id: <20201022125835.26396-4-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201022125835.26396-1-osalvador@suse.de>
References: <20201022125835.26396-1-osalvador@suse.de>
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
the default allocator used by __populate_section_memmap. Once the memmap is
allocated, we are going to need a way to mark altmap pfns used for the allocation.
If MHP_MEMMAP_ON_MEMORY flag was passed, we will set up the layout of the
altmap structure in add_memory_resouce(), and then we will call
mhp_mark_vmemmap_pages() to properly mark those pages.

Online/Offline:

 In the memory_block structure, a new field is created in order to
 store the number of vmemmap_pages.
 Having that around simplifies things a lot since in {online/offline}_pages
 we can know how much we have to skip forward until we have the first non-
 vmemmap page, for operations like isolation/migration/initialization.

Hot-remove:

 If the range was using memmap on memory (aka vmemmap pages),
 we construct an altmap structure so free_hugepage_table does
 the right thing and calls vmem_altmap_free instead of
 free_pagetable.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 drivers/acpi/acpi_memhotplug.c |   2 +-
 drivers/base/memory.c          |  21 +++--
 include/linux/memory.h         |   3 +-
 include/linux/memory_hotplug.h |  19 ++++-
 include/linux/memremap.h       |   2 +-
 mm/memory_hotplug.c            | 139 +++++++++++++++++++++++++++------
 mm/memremap.c                  |   5 +-
 mm/page_alloc.c                |   7 ++
 mm/sparse.c                    |  25 ++++++
 9 files changed, 180 insertions(+), 43 deletions(-)

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index b02fd51e5589..6b57bf90ca72 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -195,7 +195,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 			node = memory_add_physaddr_to_nid(info->start_addr);
 
 		result = __add_memory(node, info->start_addr, info->length,
-				      MHP_NONE);
+				      MEMHP_MEMMAP_ON_MEMORY);
 
 		/*
 		 * If the memory block has been used by the kernel, add_memory()
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index eef4ffb6122c..675974e39a84 100644
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
index 439a89e758d8..7cc93de5856c 100644
--- a/include/linux/memory.h
+++ b/include/linux/memory.h
@@ -30,6 +30,7 @@ struct memory_block {
 	int phys_device;		/* to which fru does this belong? */
 	struct device dev;
 	int nid;			/* NID for this memory block */
+	unsigned long nr_vmemmap_pages;	/* Number for vmemmap pages */
 };
 
 int arch_get_memory_phys_device(unsigned long start_pfn);
@@ -81,7 +82,7 @@ static inline int memory_notify(unsigned long val, void *v)
 #else
 extern int register_memory_notifier(struct notifier_block *nb);
 extern void unregister_memory_notifier(struct notifier_block *nb);
-int create_memory_block_devices(unsigned long start, unsigned long size);
+int create_memory_block_devices(unsigned long start, unsigned long size, unsigned long vmemmap_pages);
 void remove_memory_block_devices(unsigned long start, unsigned long size);
 extern void memory_dev_init(void);
 extern int memory_notify(unsigned long val, void *v);
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index dda2d0e5d1ba..740221f26d51 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -121,7 +121,8 @@ extern int zone_grow_waitqueues(struct zone *zone, unsigned long nr_pages);
 extern int add_one_highpage(struct page *page, int pfn, int bad_ppro);
 /* VM interface that may be used by firmware interface */
 extern int online_pages(unsigned long pfn, unsigned long nr_pages,
-			int online_type, int nid);
+			unsigned long nr_vmemmap_pages, int online_type,
+			int nid);
 extern struct zone *test_pages_in_a_zone(unsigned long start_pfn,
 					 unsigned long end_pfn);
 extern void __offline_isolated_pages(unsigned long start_pfn,
@@ -334,7 +335,8 @@ static inline void pgdat_resize_init(struct pglist_data *pgdat) {}
 #ifdef CONFIG_MEMORY_HOTREMOVE
 
 extern void try_offline_node(int nid);
-extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages);
+extern int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			 unsigned long nr_vmemmap_pages);
 extern int remove_memory(int nid, u64 start, u64 size);
 extern void __remove_memory(int nid, u64 start, u64 size);
 extern int offline_and_remove_memory(int nid, u64 start, u64 size);
@@ -342,7 +344,8 @@ extern int offline_and_remove_memory(int nid, u64 start, u64 size);
 #else
 static inline void try_offline_node(int nid) {}
 
-static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+static inline int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+				unsigned long nr_vmemmap_pages)
 {
 	return -EINVAL;
 }
@@ -369,10 +372,12 @@ extern int add_memory_driver_managed(int nid, u64 start, u64 size,
 				     mhp_t mhp_flags);
 extern void move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 				   unsigned long nr_pages,
+				   unsigned long nr_vmemmap_pages,
 				   struct vmem_altmap *altmap, int migratetype);
 extern void remove_pfn_range_from_zone(struct zone *zone,
 				       unsigned long start_pfn,
-				       unsigned long nr_pages);
+				       unsigned long nr_pages,
+				       unsigned long nr_vmemmap_pages);
 extern bool is_memblock_offlined(struct memory_block *mem);
 extern int sparse_add_section(int nid, unsigned long pfn,
 		unsigned long nr_pages, struct vmem_altmap *altmap);
@@ -383,6 +388,12 @@ extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 		unsigned long nr_pages);
+
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+extern void mhp_mark_vmemmap_pages(struct vmem_altmap *self);
+#else
+static inline void mhp_mark_vmemmap_pages(struct vmem_altmap *self) {}
+#endif
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
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
index b44d4c7ba73b..906e3b631edc 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -487,14 +487,15 @@ static void update_pgdat_span(struct pglist_data *pgdat)
 
 void __ref remove_pfn_range_from_zone(struct zone *zone,
 				      unsigned long start_pfn,
-				      unsigned long nr_pages)
+				      unsigned long nr_pages,
+				      unsigned long nr_vmemmap_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	struct pglist_data *pgdat = zone->zone_pgdat;
-	unsigned long pfn, cur_nr_pages, flags;
+	unsigned long pfn = start_pfn + nr_vmemmap_pages, cur_nr_pages, flags;
 
 	/* Poison struct pages because they are now uninitialized again. */
-	for (pfn = start_pfn; pfn < end_pfn; pfn += cur_nr_pages) {
+	for (; pfn < end_pfn; pfn += cur_nr_pages) {
 		cond_resched();
 
 		/* Select all remaining pages up to the next section boundary */
@@ -629,6 +630,7 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
 	unsigned long pfn;
+	unsigned int order;
 
 	/*
 	 * Online the pages in MAX_ORDER - 1 aligned chunks. The callback might
@@ -636,8 +638,12 @@ static void online_pages_range(unsigned long start_pfn, unsigned long nr_pages)
 	 * later). We account all pages as being online and belonging to this
 	 * zone ("present").
 	 */
-	for (pfn = start_pfn; pfn < end_pfn; pfn += MAX_ORDER_NR_PAGES)
-		(*online_page_callback)(pfn_to_page(pfn), MAX_ORDER - 1);
+	for (pfn = start_pfn; pfn < end_pfn; pfn += (1 << order)) {
+		order = MAX_ORDER - 1;
+		while (pfn & ((1 << order) - 1))
+			order--;
+		(*online_page_callback)(pfn_to_page(pfn), order);
+	}
 
 	/* mark all involved sections as online */
 	online_mem_sections(start_pfn, end_pfn);
@@ -697,6 +703,18 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
 
 }
+
+static void link_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+			       struct zone *zone, int nid)
+{
+	struct page *p = pfn_to_page(pfn);
+	enum zone_type z = zone_idx(zone);
+	unsigned long i;
+
+	for (i = 0; i < nr_pages; i++)
+		set_page_links(p + i, z, nid, pfn);
+}
+
 /*
  * Associate the pfn range with the given zone, initializing the memmaps
  * and resizing the pgdat/zone data to span the added pages. After this
@@ -708,6 +726,7 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
  */
 void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 				  unsigned long nr_pages,
+				  unsigned long nr_vmemmap_pages,
 				  struct vmem_altmap *altmap, int migratetype)
 {
 	struct pglist_data *pgdat = zone->zone_pgdat;
@@ -726,14 +745,22 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	resize_pgdat_range(pgdat, start_pfn, nr_pages);
 	pgdat_resize_unlock(pgdat, &flags);
 
+	if (nr_vmemmap_pages)
+		/*
+		 * Vmemmap pages are already initialized at hot-add state.
+		 * What is left is to link them to a node and a zone.
+		 */
+		link_vmemmap_pages(start_pfn, nr_vmemmap_pages, zone, nid);
+
 	/*
 	 * TODO now we have a visible range of pages which are not associated
 	 * with their zone properly. Not nice but set_pfnblock_flags_mask
 	 * expects the zone spans the pfn range. All the pages in the range
 	 * are reserved so nobody should be touching them so we should be safe
 	 */
-	memmap_init_zone(nr_pages, nid, zone_idx(zone), start_pfn,
-			 MEMINIT_HOTPLUG, altmap, migratetype);
+	memmap_init_zone(nr_pages - nr_vmemmap_pages, nid, zone_idx(zone),
+			 start_pfn + nr_vmemmap_pages, MEMINIT_HOTPLUG, altmap,
+			 migratetype);
 
 	set_zone_contiguous(zone);
 }
@@ -796,9 +823,9 @@ struct zone * zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 }
 
 int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
-		       int online_type, int nid)
+		       unsigned long nr_vmemmap_pages, int online_type, int nid)
 {
-	unsigned long flags;
+	unsigned long flags, valid_start_pfn, valid_nr_pages;
 	struct zone *zone;
 	int need_zonelists_rebuild = 0;
 	int ret;
@@ -809,11 +836,15 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 			 !IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
+	valid_start_pfn = pfn + nr_vmemmap_pages;
+	valid_nr_pages = nr_pages - nr_vmemmap_pages;
+
 	mem_hotplug_begin();
 
 	/* associate pfn range with the zone */
 	zone = zone_for_pfn_range(online_type, nid, pfn, nr_pages);
-	move_pfn_range_to_zone(zone, pfn, nr_pages, NULL, MIGRATE_ISOLATE);
+	move_pfn_range_to_zone(zone, pfn, nr_pages, nr_vmemmap_pages, NULL,
+			       MIGRATE_ISOLATE);
 
 	arg.start_pfn = pfn;
 	arg.nr_pages = nr_pages;
@@ -829,7 +860,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	 * onlining, such that undo_isolate_page_range() works correctly.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock += nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock += valid_nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/*
@@ -842,7 +873,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		setup_zone_pageset(zone);
 	}
 
-	online_pages_range(pfn, nr_pages);
+	online_pages_range(valid_start_pfn, valid_nr_pages);
 	zone->present_pages += nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -855,7 +886,9 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	zone_pcp_update(zone);
 
 	/* Basic onlining is complete, allow allocation of onlined pages. */
-	undo_isolate_page_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE);
+	undo_isolate_page_range(valid_start_pfn,
+				valid_start_pfn + valid_nr_pages,
+				MIGRATE_MOVABLE);
 
 	/*
 	 * Freshly onlined pages aren't shuffled (e.g., all pages are placed to
@@ -881,7 +914,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 		 (unsigned long long) pfn << PAGE_SHIFT,
 		 (((unsigned long long) pfn + nr_pages) << PAGE_SHIFT) - 1);
 	memory_notify(MEM_CANCEL_ONLINE, &arg);
-	remove_pfn_range_from_zone(zone, pfn, nr_pages);
+	remove_pfn_range_from_zone(zone, pfn, nr_pages, nr_vmemmap_pages);
 	mem_hotplug_done();
 	return ret;
 }
@@ -1030,6 +1063,14 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 	return device_online(&mem->dev);
 }
 
+static inline bool support_memmap_on_memory(unsigned long size)
+{
+        if (!IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) ||
+            size > memory_block_size_bytes())
+                return false;
+        return true;
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1039,6 +1080,7 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
 	struct mhp_params params = { .pgprot = PAGE_KERNEL };
+	struct vmem_altmap mhp_altmap = {};
 	u64 start, size;
 	bool new_node = false;
 	int ret;
@@ -1065,18 +1107,36 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error;
 	new_node = ret;
 
+	/*
+	 * Check whether we support memmap_on_memory
+	 */
+	if (!support_memmap_on_memory(size))
+		mhp_flags &= ~MEMHP_MEMMAP_ON_MEMORY;
+
+	/*
+	 * Self hosted memmap array
+	 */
+	if (mhp_flags & MEMHP_MEMMAP_ON_MEMORY) {
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
 	}
 
+	if (mhp_flags & MEMHP_MEMMAP_ON_MEMORY)
+		mhp_mark_vmemmap_pages(params.altmap);
+
 	if (new_node) {
 		/* If sysfs file of new node can't be created, cpu on the node
 		 * can't be hot-added. There is no rollback way now.
@@ -1467,10 +1527,11 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages,
+			unsigned long nr_vmemmap_pages)
 {
 	const unsigned long end_pfn = start_pfn + nr_pages;
-	unsigned long pfn, system_ram_pages = 0;
+	unsigned long pfn, valid_start_pfn, valid_nr_pages, system_ram_pages = 0;
 	unsigned long flags;
 	struct zone *zone;
 	struct memory_notify arg;
@@ -1482,6 +1543,9 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 			 !IS_ALIGNED(start_pfn | nr_pages, PAGES_PER_SECTION)))
 		return -EINVAL;
 
+	valid_start_pfn = start_pfn + nr_vmemmap_pages;
+	valid_nr_pages = nr_pages - nr_vmemmap_pages;
+
 	mem_hotplug_begin();
 
 	/*
@@ -1511,8 +1575,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	node = zone_to_nid(zone);
 
 	/* set above range as isolated */
-	ret = start_isolate_page_range(start_pfn, end_pfn,
-				       MIGRATE_MOVABLE,
+	ret = start_isolate_page_range(valid_start_pfn, end_pfn, MIGRATE_MOVABLE,
 				       MEMORY_OFFLINE | REPORT_FAILURE);
 	if (ret) {
 		reason = "failure to isolate range";
@@ -1531,7 +1594,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	}
 
 	do {
-		pfn = start_pfn;
+		pfn = valid_start_pfn;
 		do {
 			if (signal_pending(current)) {
 				ret = -EINTR;
@@ -1562,7 +1625,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		 * offlining actually in order to make hugetlbfs's object
 		 * counting consistent.
 		 */
-		ret = dissolve_free_huge_pages(start_pfn, end_pfn);
+		ret = dissolve_free_huge_pages(valid_start_pfn, end_pfn);
 		if (ret) {
 			reason = "failure to dissolve huge pages";
 			goto failed_removal_isolated;
@@ -1580,7 +1643,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 		 * because has_unmovable_pages explicitly checks for
 		 * PageBuddy on freed pages on other zones.
 		 */
-		ret = test_pages_isolated(start_pfn, end_pfn, MEMORY_OFFLINE);
+		ret = test_pages_isolated(valid_start_pfn, end_pfn, MEMORY_OFFLINE);
 		if (ret)
 			drain_all_pages(zone);
 	} while (ret);
@@ -1595,11 +1658,11 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	 * of isolated pageblocks, memory onlining will properly revert this.
 	 */
 	spin_lock_irqsave(&zone->lock, flags);
-	zone->nr_isolate_pageblock -= nr_pages / pageblock_nr_pages;
+	zone->nr_isolate_pageblock -= valid_nr_pages / pageblock_nr_pages;
 	spin_unlock_irqrestore(&zone->lock, flags);
 
 	/* removal success */
-	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	adjust_managed_page_count(pfn_to_page(start_pfn), -valid_nr_pages);
 	zone->present_pages -= nr_pages;
 
 	pgdat_resize_lock(zone->zone_pgdat, &flags);
@@ -1623,7 +1686,7 @@ int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 	writeback_set_ratelimit();
 
 	memory_notify(MEM_OFFLINE, &arg);
-	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
+	remove_pfn_range_from_zone(zone, start_pfn, nr_pages, nr_vmemmap_pages);
 	mem_hotplug_done();
 	return 0;
 
@@ -1657,6 +1720,16 @@ static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
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
@@ -1731,6 +1804,9 @@ EXPORT_SYMBOL(try_offline_node);
 static int __ref try_remove_memory(int nid, u64 start, u64 size)
 {
 	int rc = 0;
+	struct vmem_altmap mhp_altmap = {};
+	struct vmem_altmap *altmap = NULL;
+	unsigned long nr_vmemmap_pages = 0;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -1743,6 +1819,17 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
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
 
@@ -1754,7 +1841,7 @@ static int __ref try_remove_memory(int nid, u64 start, u64 size)
 
 	mem_hotplug_begin();
 
-	arch_remove_memory(nid, start, size, NULL);
+	arch_remove_memory(nid, start, size, altmap);
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		memblock_free(start, size);
diff --git a/mm/memremap.c b/mm/memremap.c
index 2bb276680837..f287599bb857 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -159,7 +159,8 @@ static void pageunmap_range(struct dev_pagemap *pgmap, int range_id)
 
 	mem_hotplug_begin();
 	remove_pfn_range_from_zone(page_zone(first_page), PHYS_PFN(range->start),
-				   PHYS_PFN(range_len(range)));
+				   PHYS_PFN(range_len(range)),
+				   0);
 	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
 		__remove_pages(PHYS_PFN(range->start),
 			       PHYS_PFN(range_len(range)), NULL);
@@ -286,7 +287,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 
 		zone = &NODE_DATA(nid)->node_zones[ZONE_DEVICE];
 		move_pfn_range_to_zone(zone, PHYS_PFN(range->start),
-				PHYS_PFN(range_len(range)), params->altmap,
+				PHYS_PFN(range_len(range)), 0, params->altmap,
 				MIGRATE_MOVABLE);
 	}
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e74ca22baaa1..043503fb8c6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8761,6 +8761,13 @@ void __offline_isolated_pages(unsigned long start_pfn, unsigned long end_pfn)
 	spin_lock_irqsave(&zone->lock, flags);
 	while (pfn < end_pfn) {
 		page = pfn_to_page(pfn);
+		/*
+		 * Skip vmemmap pages
+		 */
+		if (PageVmemmap(page)) {
+			pfn += vmemmap_nr_pages(page);
+			continue;
+		}
 		/*
 		 * The HWPoisoned page may be not in buddy system, and
 		 * page_count() is not 0.
diff --git a/mm/sparse.c b/mm/sparse.c
index 7bd23f9d6cef..d715bfa131ec 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -431,6 +431,31 @@ static void __init check_usemap_section_nr(int nid,
 #endif /* CONFIG_MEMORY_HOTREMOVE */
 
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
+void mhp_mark_vmemmap_pages(struct vmem_altmap *self)
+{
+	unsigned long pfn = self->base_pfn + self->reserve;
+	unsigned long nr_pages = self->alloc;
+	unsigned long nr_sects = self->free / PAGES_PER_SECTION;
+	unsigned long i;
+	struct page *head;
+
+	if (!nr_pages)
+		return;
+
+	memset(pfn_to_page(pfn), 0, sizeof(struct page) * nr_pages);
+
+	head = pfn_to_page(pfn);
+	for (i = 0; i < nr_pages; i++) {
+		struct page *p = head + i;
+
+		page_mapcount_reset(p);
+		__SetPageVmemmap(p);
+		p->vmemmap_head = (unsigned long)head;
+	}
+	head->vmemmap_sections = nr_sects;
+	head->vmemmap_pages = nr_pages;
+}
+
 static unsigned long __init section_map_size(void)
 {
 	return ALIGN(sizeof(struct page) * PAGES_PER_SECTION, PMD_SIZE);
-- 
2.26.2


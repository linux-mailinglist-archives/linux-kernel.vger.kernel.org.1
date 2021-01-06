Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 076372EB8CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 05:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbhAFEH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 23:07:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:24258 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbhAFEH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 23:07:59 -0500
IronPort-SDR: /IIqnBSNX/GrAdzrtKFNGJPbSZNu2nPro4j9DaCZl/2RoorpGgTDmSCjGidqaugMMPLDAPsxK2
 TJ02iyorNZbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="174649150"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="174649150"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 20:07:19 -0800
IronPort-SDR: e+sDCNSV2MhDTUEzx18vwR4XArqNgpEhsE18gdDaXtjByw1IZmyyMFOd0wY+1ByGRPlZ0/T22T
 pTPrRN9h5ITg==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="462546732"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 20:07:18 -0800
Subject: [PATCH] mm: Teach pfn_to_online_page() about ZONE_DEVICE section
 collisions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Jan 2021 20:07:18 -0800
Message-ID: <160990599013.2430134.11556277600719835946.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While pfn_to_online_page() is able to determine pfn_valid() at
subsection granularity it is not able to reliably determine if a given
pfn is also online if the section is mixed with ZONE_DEVICE pfns.

Update move_pfn_range_to_zone() to flag (SECTION_TAINT_ZONE_DEVICE) a
section that mixes ZONE_DEVICE pfns with other online pfns. With
SECTION_TAINT_ZONE_DEVICE to delineate, pfn_to_online_page() can fall
back to a slow-path check for ZONE_DEVICE pfns in an online section.

With this implementation of pfn_to_online_page() pfn-walkers mostly only
need to check section metadata to determine pfn validity. In the
rare case of mixed-zone sections the pfn-walker will skip offline
ZONE_DEVICE pfns as expected.

Other notes:

Because the collision case is rare, and for simplicity, the
SECTION_TAINT_ZONE_DEVICE flag is never cleared once set.

pfn_to_online_page() was already borderline too large to be a macro /
inline function, but the additional logic certainly pushed it over that
threshold, and so it is moved to an out-of-line helper.

Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Michal Hocko <mhocko@suse.com>
Reported-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

This compiles and passes the nvdimm unit tests, but I have not tested
with pfn walkers in the presence of ZONE_DEVICE collisions.


 include/linux/memory_hotplug.h |   17 +---------
 include/linux/mmzone.h         |   22 ++++++++----
 mm/memory_hotplug.c            |   71 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 15acce5ab106..3d99de0db2dd 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -16,22 +16,7 @@ struct resource;
 struct vmem_altmap;
 
 #ifdef CONFIG_MEMORY_HOTPLUG
-/*
- * Return page for the valid pfn only if the page is online. All pfn
- * walkers which rely on the fully initialized page->flags and others
- * should use this rather than pfn_valid && pfn_to_page
- */
-#define pfn_to_online_page(pfn)					   \
-({								   \
-	struct page *___page = NULL;				   \
-	unsigned long ___pfn = pfn;				   \
-	unsigned long ___nr = pfn_to_section_nr(___pfn);	   \
-								   \
-	if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
-	    pfn_valid_within(___pfn))				   \
-		___page = pfn_to_page(___pfn);			   \
-	___page;						   \
-})
+struct page *pfn_to_online_page(unsigned long pfn);
 
 /*
  * Types for free bootmem stored in page->lru.next. These have to be in
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index b593316bff3d..0b5c44f730b4 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1273,13 +1273,14 @@ extern size_t mem_section_usage_size(void);
  *      which results in PFN_SECTION_SHIFT equal 6.
  * To sum it up, at least 6 bits are available.
  */
-#define	SECTION_MARKED_PRESENT	(1UL<<0)
-#define SECTION_HAS_MEM_MAP	(1UL<<1)
-#define SECTION_IS_ONLINE	(1UL<<2)
-#define SECTION_IS_EARLY	(1UL<<3)
-#define SECTION_MAP_LAST_BIT	(1UL<<4)
-#define SECTION_MAP_MASK	(~(SECTION_MAP_LAST_BIT-1))
-#define SECTION_NID_SHIFT	3
+#define SECTION_MARKED_PRESENT		(1UL<<0)
+#define SECTION_HAS_MEM_MAP		(1UL<<1)
+#define SECTION_IS_ONLINE		(1UL<<2)
+#define SECTION_IS_EARLY		(1UL<<3)
+#define SECTION_TAINT_ZONE_DEVICE	(1UL<<4)
+#define SECTION_MAP_LAST_BIT		(1UL<<5)
+#define SECTION_MAP_MASK		(~(SECTION_MAP_LAST_BIT-1))
+#define SECTION_NID_SHIFT		3
 
 static inline struct page *__section_mem_map_addr(struct mem_section *section)
 {
@@ -1318,6 +1319,13 @@ static inline int online_section(struct mem_section *section)
 	return (section && (section->section_mem_map & SECTION_IS_ONLINE));
 }
 
+static inline int online_device_section(struct mem_section *section)
+{
+	unsigned long flags = SECTION_IS_ONLINE | SECTION_TAINT_ZONE_DEVICE;
+
+	return section && ((section->section_mem_map & flags) == flags);
+}
+
 static inline int online_section_nr(unsigned long nr)
 {
 	return online_section(__nr_to_section(nr));
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f9d57b9be8c7..9f36968e6188 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -300,6 +300,47 @@ static int check_hotplug_memory_addressable(unsigned long pfn,
 	return 0;
 }
 
+/*
+ * Return page for the valid pfn only if the page is online. All pfn
+ * walkers which rely on the fully initialized page->flags and others
+ * should use this rather than pfn_valid && pfn_to_page
+ */
+struct page *pfn_to_online_page(unsigned long pfn)
+{
+	unsigned long nr = pfn_to_section_nr(pfn);
+	struct dev_pagemap *pgmap;
+	struct mem_section *ms;
+
+	if (nr >= NR_MEM_SECTIONS)
+		return NULL;
+
+	ms = __nr_to_section(nr);
+
+	if (!online_section(ms))
+		return NULL;
+
+	if (!pfn_valid_within(pfn))
+		return NULL;
+
+	if (!online_device_section(ms))
+		return pfn_to_page(pfn);
+
+	/*
+	 * Slowpath: when ZONE_DEVICE collides with
+	 * ZONE_{NORMAL,MOVABLE} within the same section some pfns in
+	 * the section may be 'offline' but 'valid'. Only
+	 * get_dev_pagemap() can determine sub-section online status.
+	 */
+	pgmap = get_dev_pagemap(pfn, NULL);
+	put_dev_pagemap(pgmap);
+
+	/* The presence of a pgmap indicates ZONE_DEVICE offline pfn */
+	if (pgmap)
+		return NULL;
+	return pfn_to_page(pfn);
+}
+EXPORT_SYMBOL_GPL(pfn_to_online_page);
+
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -678,6 +719,27 @@ static void __meminit resize_pgdat_range(struct pglist_data *pgdat, unsigned lon
 	pgdat->node_spanned_pages = max(start_pfn + nr_pages, old_end_pfn) - pgdat->node_start_pfn;
 
 }
+
+static int zone_id(const struct zone *zone)
+{
+	struct pglist_data *pgdat = zone->zone_pgdat;
+
+	return zone - pgdat->node_zones;
+}
+
+static void section_taint_zone_device(struct zone *zone, unsigned long pfn)
+{
+	struct mem_section *ms = __nr_to_section(pfn_to_section_nr(pfn));
+
+	if (zone_id(zone) != ZONE_DEVICE)
+		return;
+
+	if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+		return;
+
+	ms->section_mem_map |= SECTION_TAINT_ZONE_DEVICE;
+}
+
 /*
  * Associate the pfn range with the given zone, initializing the memmaps
  * and resizing the pgdat/zone data to span the added pages. After this
@@ -707,6 +769,15 @@ void __ref move_pfn_range_to_zone(struct zone *zone, unsigned long start_pfn,
 	resize_pgdat_range(pgdat, start_pfn, nr_pages);
 	pgdat_resize_unlock(pgdat, &flags);
 
+	/*
+	 * Subsection population requires care in pfn_to_online_page().
+	 * Set the taint to enable the slow path detection of
+	 * ZONE_DEVICE pages in an otherwise  ZONE_{NORMAL,MOVABLE}
+	 * section.
+	 */
+	section_taint_zone_device(zone, start_pfn);
+	section_taint_zone_device(zone, start_pfn + nr_pages);
+
 	/*
 	 * TODO now we have a visible range of pages which are not associated
 	 * with their zone properly. Not nice but set_pfnblock_flags_mask


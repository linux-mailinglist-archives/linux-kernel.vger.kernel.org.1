Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2EA2BFE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 03:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKWC3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 21:29:17 -0500
Received: from foss.arm.com ([217.140.110.172]:51966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgKWC3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 21:29:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 810F91042;
        Sun, 22 Nov 2020 18:29:16 -0800 (PST)
Received: from p8cg001049571a15.arm.com (unknown [10.163.82.200])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6EA3A3F70D;
        Sun, 22 Nov 2020 18:29:14 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC 1/3] mm/hotplug: Pre-validate the address range with platform
Date:   Mon, 23 Nov 2020 07:58:47 +0530
Message-Id: <1606098529-7907-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces memhp_range_allowed() which gets called in various hotplug
paths. Then memhp_range_allowed() calls arch_get_addressable_range() via
memhp_get_pluggable_range(). This callback can be defined by the platform
to provide addressable physical range, depending on whether kernel linear
mapping is required or not. This mechanism will prevent platform specific
errors deep down during hotplug calls. While here, this drops now redundant
check_hotplug_memory_addressable() check in __add_pages().

Cc: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 include/linux/memory_hotplug.h | 51 ++++++++++++++++++++++++++++++++++
 mm/memory_hotplug.c            | 29 ++++++-------------
 mm/memremap.c                  |  9 +++++-
 3 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 551093b74596..2018c0201672 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
 #include <linux/bug.h>
+#include <linux/range.h>
 
 struct page;
 struct zone;
@@ -70,6 +71,56 @@ typedef int __bitwise mhp_t;
  */
 #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+/*
+ * Platforms should define arch_get_addressable_range() which provides
+ * addressable physical memory range depending upon whether the linear
+ * mapping is required or not. Returned address range must follow
+ *
+ * 1. range.start <= range.end
+ * 1. Must include end both points i.e range.start and range.end
+ *
+ * Nonetheless there is a fallback definition provided here providing
+ * maximum possible addressable physical range, irrespective of the
+ * linear mapping requirements.
+ */
+#ifndef arch_get_addressable_range
+static inline struct range arch_get_addressable_range(bool need_mapping)
+{
+	struct range memhp_range = {
+		.start = 0UL,
+		.end = -1ULL,
+	};
+	return memhp_range;
+}
+#endif
+
+static inline struct range memhp_get_pluggable_range(bool need_mapping)
+{
+	const u64 max_phys = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
+	struct range memhp_range = arch_get_addressable_range(need_mapping);
+
+	if (memhp_range.start > max_phys) {
+		memhp_range.start = 0;
+		memhp_range.end = 0;
+	}
+	memhp_range.end = min_t(u64, memhp_range.end, max_phys);
+	return memhp_range;
+}
+
+static inline bool memhp_range_allowed(u64 start, u64 size, bool need_mapping)
+{
+	struct range memhp_range = memhp_get_pluggable_range(need_mapping);
+	u64 end = start + size;
+
+	if ((start < end) && (start >= memhp_range.start) &&
+	   ((end - 1) <= memhp_range.end))
+		return true;
+
+	WARN(1, "Hotplug memory [%#llx-%#llx] exceeds maximum addressable range [%#llx-%#llx]\n",
+		start, end, memhp_range.start, memhp_range.end);
+	return false;
+}
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 63b2e46b6555..9efb6c8558ed 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -284,22 +284,6 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
 	return 0;
 }
 
-static int check_hotplug_memory_addressable(unsigned long pfn,
-					    unsigned long nr_pages)
-{
-	const u64 max_addr = PFN_PHYS(pfn + nr_pages) - 1;
-
-	if (max_addr >> MAX_PHYSMEM_BITS) {
-		const u64 max_allowed = (1ull << (MAX_PHYSMEM_BITS + 1)) - 1;
-		WARN(1,
-		     "Hotplugged memory exceeds maximum addressable address, range=%#llx-%#llx, maximum=%#llx\n",
-		     (u64)PFN_PHYS(pfn), max_addr, max_allowed);
-		return -E2BIG;
-	}
-
-	return 0;
-}
-
 /*
  * Reasonably generic function for adding memory.  It is
  * expected that archs that support memory hotplug will
@@ -317,10 +301,6 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
 	if (WARN_ON_ONCE(!params->pgprot.pgprot))
 		return -EINVAL;
 
-	err = check_hotplug_memory_addressable(pfn, nr_pages);
-	if (err)
-		return err;
-
 	if (altmap) {
 		/*
 		 * Validate altmap is within bounds of the total request
@@ -1109,6 +1089,9 @@ int __ref __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 	struct resource *res;
 	int ret;
 
+	if (!memhp_range_allowed(start, size, 1))
+		return -ERANGE;
+
 	res = register_memory_resource(start, size, "System RAM");
 	if (IS_ERR(res))
 		return PTR_ERR(res);
@@ -1123,6 +1106,9 @@ int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags)
 {
 	int rc;
 
+	if (!memhp_range_allowed(start, size, 1))
+		return -ERANGE;
+
 	lock_device_hotplug();
 	rc = __add_memory(nid, start, size, mhp_flags);
 	unlock_device_hotplug();
@@ -1163,6 +1149,9 @@ int add_memory_driver_managed(int nid, u64 start, u64 size,
 	    resource_name[strlen(resource_name) - 1] != ')')
 		return -EINVAL;
 
+	if (!memhp_range_allowed(start, size, 0))
+		return -ERANGE;
+
 	lock_device_hotplug();
 
 	res = register_memory_resource(start, size, resource_name);
diff --git a/mm/memremap.c b/mm/memremap.c
index 16b2fb482da1..388a34b068c1 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -188,6 +188,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	struct range *range = &pgmap->ranges[range_id];
 	struct dev_pagemap *conflict_pgmap;
 	int error, is_ram;
+	bool is_private = false;
 
 	if (WARN_ONCE(pgmap_altmap(pgmap) && range_id > 0,
 				"altmap not supported for multiple ranges\n"))
@@ -207,6 +208,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 		return -ENOMEM;
 	}
 
+	if (pgmap->type == MEMORY_DEVICE_PRIVATE)
+		is_private = true;
+
 	is_ram = region_intersects(range->start, range_len(range),
 		IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
 
@@ -230,6 +234,9 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	if (error)
 		goto err_pfn_remap;
 
+	if (!memhp_range_allowed(range->start, range_len(range), !is_private))
+		goto err_pfn_remap;
+
 	mem_hotplug_begin();
 
 	/*
@@ -243,7 +250,7 @@ static int pagemap_range(struct dev_pagemap *pgmap, struct mhp_params *params,
 	 * the CPU, we do want the linear mapping and thus use
 	 * arch_add_memory().
 	 */
-	if (pgmap->type == MEMORY_DEVICE_PRIVATE) {
+	if (is_private) {
 		error = add_pages(nid, PHYS_PFN(range->start),
 				PHYS_PFN(range_len(range)), params);
 	} else {
-- 
2.20.1


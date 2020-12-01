Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062192CA1CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 12:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgLALwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 06:52:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:43574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgLALww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 06:52:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 69443ACC4;
        Tue,  1 Dec 2020 11:52:10 +0000 (UTC)
From:   Oscar Salvador <osalvador@suse.de>
To:     david@redhat.com
Cc:     mhocko@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vbabka@suse.cz, pasha.tatashin@soleen.com,
        Oscar Salvador <osalvador@suse.de>
Subject: [RFC PATCH v3 1/4] mm,memory_hotplug: Add mhp_supports_memmap_on_memory
Date:   Tue,  1 Dec 2020 12:51:55 +0100
Message-Id: <20201201115158.22638-2-osalvador@suse.de>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20201201115158.22638-1-osalvador@suse.de>
References: <20201201115158.22638-1-osalvador@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mhp_supports_memmap_on_memory is meant to be used by the caller prior
to hot-adding memory in order to figure out whether it can enable
MHP_MEMMAP_ON_MEMORY or not.

Enabling MHP_MEMMAP_ON_MEMORY requires:

 - memmap_on_memory_enabled is set (by mhp_memmap_on_memory kernel boot option)
 - CONFIG_SPARSEMEM_VMEMMAP
 - architecture support for altmap
 - hot-added range spans a single memory block

Note that mhp_memmap_on_memory kernel boot option will be added in
a coming patch.

At the moment, only three architectures support passing altmap when
building the page tables: x86, POWERPC and ARM.
Define an arch_support_memmap_on_memory function on those architectures
that returns true, and define a __weak variant of it that will be used
on the others.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 arch/arm64/mm/mmu.c            |  5 +++++
 arch/powerpc/mm/mem.c          |  5 +++++
 arch/x86/mm/init_64.c          |  5 +++++
 include/linux/memory_hotplug.h | 10 ++++++++++
 mm/memory_hotplug.c            | 24 ++++++++++++++++++++++++
 5 files changed, 49 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 30c6dd02e706..8a33ac97dcbb 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1454,6 +1454,11 @@ static bool inside_linear_region(u64 start, u64 size)
 	       (start + size - 1) <= __pa(PAGE_END - 1);
 }
 
+bool arch_support_memmap_on_memory(void)
+{
+	return true;
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0694bdcce653..c5ef015c3189 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -181,6 +181,11 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 	__remove_pages(start_pfn, nr_pages, altmap);
 	arch_remove_linear_mapping(start, size);
 }
+
+bool arch_support_memmap_on_memory(void)
+{
+	return true;
+}
 #endif
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index b5a3fa4033d3..ffb9d87c77e8 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -860,6 +860,11 @@ int add_pages(int nid, unsigned long start_pfn, unsigned long nr_pages,
 	return ret;
 }
 
+bool arch_support_memmap_on_memory(void)
+{
+	return true;
+}
+
 int arch_add_memory(int nid, u64 start, u64 size,
 		    struct mhp_params *params)
 {
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 15acce5ab106..a54310abee79 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -70,6 +70,14 @@ typedef int __bitwise mhp_t;
  */
 #define MEMHP_MERGE_RESOURCE	((__force mhp_t)BIT(0))
 
+/*
+ * We want memmap (struct page array) to be self contained.
+ * To do so, we will use the beginning of the hot-added range to build
+ * the page tables for the memmap array that describes the entire range.
+ * Only selected architectures support it with SPARSE_VMEMMAP.
+ */
+#define MHP_MEMMAP_ON_MEMORY   ((__force mhp_t)BIT(1))
+
 /*
  * Extended parameters for memory hotplug:
  * altmap: alternative allocator for memmap array (optional)
@@ -129,6 +137,7 @@ extern int try_online_node(int nid);
 
 extern int arch_add_memory(int nid, u64 start, u64 size,
 			   struct mhp_params *params);
+extern bool arch_support_memmap_on_memory(void);
 extern u64 max_mem_size;
 
 extern int memhp_online_type_from_str(const char *str);
@@ -361,6 +370,7 @@ extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 		unsigned long nr_pages);
+extern bool mhp_supports_memmap_on_memory(unsigned long size);
 extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index a8cef4955907..e3c310225a60 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1011,6 +1011,20 @@ static int online_memory_block(struct memory_block *mem, void *arg)
 	return device_online(&mem->dev);
 }
 
+bool __weak arch_support_memmap_on_memory(void)
+{
+	return false;
+}
+
+bool mhp_supports_memmap_on_memory(unsigned long size)
+{
+	if (!arch_support_memmap_on_memory() ||
+	    !IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) ||
+	    size > memory_block_size_bytes())
+		return false;
+	return true;
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1046,6 +1060,16 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error;
 	new_node = ret;
 
+	/*
+	 * Return -EINVAL if caller specified MHP_MEMMAP_ON_MEMORY and we do
+	 * not support it.
+	 */
+	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
+	    !mhp_supports_memmap_on_memory(size)) {
+		ret = -EINVAL;
+		goto error;
+	}
+
 	/* call arch's memory hotadd */
 	ret = arch_add_memory(nid, start, size, &params);
 	if (ret < 0)
-- 
2.26.2


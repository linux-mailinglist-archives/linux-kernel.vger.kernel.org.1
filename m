Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A827A87E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgI1HX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:23:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24446 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726596AbgI1HX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:23:26 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601277804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dxFIAvdDhbvLlFuhNKwmYntlyEYl/Pf6inB3UZNC2qs=;
        b=VjW/4tSIktIX2WjJW9h0wdmmf1EcgEZEtf0mKhLHzvBs12eOHp2q8e/twELxL3AyqxrwbR
        2RGSMoG0RV9q/YtspBymkzZt9WkU9d7pvwjpjxM3H6UY7HCVkK1c2pJ4e3wHFwGMXlKGjb
        zwxf+z06dYWmTIAkMGU1uurjTd18Hy8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-C6zXZHgHPZ6MbmStW_7GXw-1; Mon, 28 Sep 2020 03:23:20 -0400
X-MC-Unique: C6zXZHgHPZ6MbmStW_7GXw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C90CB8030A4;
        Mon, 28 Sep 2020 07:23:18 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-128.bne.redhat.com [10.64.54.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6DC47838A;
        Mon, 28 Sep 2020 07:23:16 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v3 2/2] arm64/mm: Enable color zero pages
Date:   Mon, 28 Sep 2020 17:22:56 +1000
Message-Id: <20200928072256.13098-3-gshan@redhat.com>
In-Reply-To: <20200928072256.13098-1-gshan@redhat.com>
References: <20200928072256.13098-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables color zero pages by allocating contiguous page frames
for it. The number of pages for this is determined by L1 dCache
(or iCache) size, which is probbed from the hardware.

   * Export cache_setup_of_node() so that the cache topology could
     be parsed from device-tree.

   * Add cache_get_info() so that L1 dCache size can be retrieved.

   * Implement setup_zero_pages(), which is called after the page
     allocator begins to work, to allocate the contiguous pages
     needed by color zero page. With this, reading load on these
     zero pages can be distributed in different L1/L2/L3 dCache
     sets, to improve the overall performance. On other hand, it
     isn't going to thrash same L1/L2/L3 dCache, which is beneficial
     to overall load balance.

   * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/cache.h   |  3 ++
 arch/arm64/include/asm/pgtable.h |  9 ++++-
 arch/arm64/kernel/cacheinfo.c    | 67 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c             | 37 ++++++++++++++++++
 arch/arm64/mm/mmu.c              |  7 ----
 drivers/base/cacheinfo.c         |  3 +-
 include/linux/cacheinfo.h        |  6 +++
 7 files changed, 121 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a4d1b5f771f6..a42dbcc6b484 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -89,6 +89,9 @@ static inline int cache_line_size_of_cpu(void)
 }
 
 int cache_line_size(void);
+unsigned int cache_get_info(unsigned int level, unsigned int type,
+			    unsigned int *sets, unsigned int *ways,
+			    unsigned int *cl_size);
 
 /*
  * Read the effective value of CTR_EL0.
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 6953498f4d40..5cb5f8bb090d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -54,8 +54,13 @@ extern void __pgd_error(const char *file, int line, unsigned long val);
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
-#define ZERO_PAGE(vaddr)	phys_to_page(__pa_symbol(empty_zero_page))
+extern unsigned long empty_zero_page;
+extern unsigned long zero_page_mask;
+
+#define __HAVE_COLOR_ZERO_PAGE
+#define ZERO_PAGE(vaddr)				\
+	(virt_to_page((void *)(empty_zero_page +	\
+	(((unsigned long)(vaddr)) & zero_page_mask))))
 
 #define pte_ERROR(pte)		__pte_error(__FILE__, __LINE__, pte_val(pte))
 
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 7fa6828bb488..c13b8897323f 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -43,6 +43,73 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+unsigned int cache_get_info(unsigned int level, unsigned int type,
+			    unsigned int *sets, unsigned int *ways,
+			    unsigned int *cl_size)
+{
+	int ret, i, cpu = smp_processor_id();
+	enum cache_type t;
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo ci, *p = NULL;
+
+	/* Sanity check */
+	if (type != CACHE_TYPE_INST && type != CACHE_TYPE_DATA)
+		return 0;
+
+	/* Fetch the cache information if it has been populated */
+	if (this_cpu_ci->num_leaves) {
+		for (i = 0; i < this_cpu_ci->num_leaves; i++) {
+			p = &this_cpu_ci->info_list[i];
+			if (p->level == level &&
+			    (p->type == type || p->type == CACHE_TYPE_UNIFIED))
+				break;
+		}
+
+		ret = (i < this_cpu_ci->num_leaves) ? 0 : -ENOENT;
+		goto out;
+	}
+
+	/*
+	 * The cache information isn't populated yet, we have to
+	 * retrieve it from ACPI or device tree.
+	 */
+	t = get_cache_type(level);
+	if (t == CACHE_TYPE_NOCACHE ||
+	    (t != CACHE_TYPE_SEPARATE && t != type)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	p = &ci;
+	p->type = type;
+	p->level = level;
+	this_cpu_ci->info_list = p;
+	this_cpu_ci->num_levels = 1;
+	this_cpu_ci->num_leaves = 1;
+	if (!acpi_disabled)
+		ret = cache_setup_acpi(cpu);
+	else if (of_have_populated_dt())
+		ret = cache_setup_of_node(cpu);
+	else
+		ret = -EPERM;
+
+	memset(this_cpu_ci, 0, sizeof(*this_cpu_ci));
+
+out:
+	if (!ret) {
+		if (sets)
+			*sets = p->number_of_sets;
+		if (ways)
+			*ways = p->ways_of_associativity;
+		if (cl_size)
+			*cl_size = p->coherency_line_size;
+
+		return p->size;
+	}
+
+	return 0;
+}
+
 static int __init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves, fw_level;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 481d22c32a2e..330a9f610f28 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -18,6 +18,7 @@
 #include <linux/gfp.h>
 #include <linux/memblock.h>
 #include <linux/sort.h>
+#include <linux/cacheinfo.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
 #include <linux/dma-direct.h>
@@ -69,6 +70,11 @@ EXPORT_SYMBOL(vmemmap);
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 static phys_addr_t arm64_dma32_phys_limit __ro_after_init;
 
+unsigned long empty_zero_page;
+EXPORT_SYMBOL(empty_zero_page);
+unsigned long zero_page_mask;
+EXPORT_SYMBOL(zero_page_mask);
+
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -507,6 +513,36 @@ static void __init free_unused_memmap(void)
 }
 #endif	/* !CONFIG_SPARSEMEM_VMEMMAP */
 
+static void __init setup_zero_pages(void)
+{
+	struct page *page;
+	unsigned int size;
+	int order, i;
+
+	size = cache_get_info(1, CACHE_TYPE_DATA, NULL, NULL, NULL);
+	order = size > 0 ? get_order(PAGE_ALIGN(size)) : 0;
+	order = min(order, MAX_ORDER - 1);
+
+	do {
+		empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO,
+						   order);
+		if (empty_zero_page)
+			break;
+	} while (--order >= 0);
+
+	if (!empty_zero_page)
+		panic("%s: out of memory\n", __func__);
+
+	page = virt_to_page((void *) empty_zero_page);
+	split_page(page, order);
+	for (i = 1 << order; i > 0; i--) {
+		mark_page_reserved(page);
+		page++;
+	}
+
+	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
+}
+
 /*
  * mem_init() marks the free areas in the mem_map and tells us how much memory
  * is free.  This is done after various parts of the system have claimed their
@@ -527,6 +563,7 @@ void __init mem_init(void)
 #endif
 	/* this will put all unused low memory onto the freelists */
 	memblock_free_all();
+	setup_zero_pages();
 
 	mem_init_print_info(NULL);
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 75df62fea1b6..736939ab3b4f 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -49,13 +49,6 @@ EXPORT_SYMBOL(vabits_actual);
 u64 kimage_voffset __ro_after_init;
 EXPORT_SYMBOL(kimage_voffset);
 
-/*
- * Empty_zero_page is a special page that is used for zero-initialized data
- * and COW.
- */
-unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
-EXPORT_SYMBOL(empty_zero_page);
-
 static pte_t bm_pte[PTRS_PER_PTE] __page_aligned_bss;
 static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 8d553c92cd32..f0dc66fc24f1 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -153,7 +153,7 @@ static void cache_of_set_props(struct cacheinfo *this_leaf,
 	cache_associativity(this_leaf);
 }
 
-static int cache_setup_of_node(unsigned int cpu)
+int cache_setup_of_node(unsigned int cpu)
 {
 	struct device_node *np;
 	struct cacheinfo *this_leaf;
@@ -195,7 +195,6 @@ static int cache_setup_of_node(unsigned int cpu)
 	return 0;
 }
 #else
-static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 46b92cd61d0c..f13d625d3e76 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -100,6 +100,12 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
+#ifdef CONFIG_OF
+int cache_setup_of_node(unsigned int cpu);
+#else
+static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
+#endif
+
 #ifndef CONFIG_ACPI_PPTT
 /*
  * acpi_find_last_cache_level is only called on ACPI enabled
-- 
2.23.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FA926BA98
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 05:26:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgIPD0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 23:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23808 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgIPD01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 23:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600226785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srllIqPSxos7+/JhOMXx5raxqrASPpx1rr/sZEs+Pus=;
        b=Y8IJxTPd7PWqTeiGam0wVP9I/2OljquSZUKBjkvEIHr29piFX4i21bSWt3/1CNt7KdnyIh
        7xtyBbGF9s2XkXeIAYT+Z38q61A0bpbvgkWJ4h85RqQDcpJN+wGM8pK0GUQg/WebayFin7
        lrv7LktEG2hnJtKsIFwHoOYOByGUtrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-bwwWZ7-rM9KtOYjnGTCenw-1; Tue, 15 Sep 2020 23:26:22 -0400
X-MC-Unique: bwwWZ7-rM9KtOYjnGTCenw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8571D186841E;
        Wed, 16 Sep 2020 03:26:21 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-108.bne.redhat.com [10.64.54.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF8937BE49;
        Wed, 16 Sep 2020 03:26:19 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-kernel@vger.kernel.org, shan.gavin@gmail.com
Subject: [PATCH 2/2] arm64/mm: Enable color zero pages
Date:   Wed, 16 Sep 2020 13:25:23 +1000
Message-Id: <20200916032523.13011-3-gshan@redhat.com>
In-Reply-To: <20200916032523.13011-1-gshan@redhat.com>
References: <20200916032523.13011-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This enables color zero pages by allocating contigous page frames
for it. The number of pages for this is determined by L1 dCache
(or iCache) size, which is probbed from the hardware.

   * Add cache_total_size() to return L1 dCache (or iCache) size

   * Implement setup_zero_pages(), which is called after the page
     allocator begins to work, to allocate the contigous pages
     needed by color zero page.

   * Reworked ZERO_PAGE() and define __HAVE_COLOR_ZERO_PAGE.

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/cache.h   | 22 ++++++++++++++++++++
 arch/arm64/include/asm/pgtable.h |  9 ++++++--
 arch/arm64/kernel/cacheinfo.c    | 34 +++++++++++++++++++++++++++++++
 arch/arm64/mm/init.c             | 35 ++++++++++++++++++++++++++++++++
 arch/arm64/mm/mmu.c              |  7 -------
 5 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a4d1b5f771f6..420e9dde2c51 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -39,6 +39,27 @@
 #define CLIDR_LOC(clidr)	(((clidr) >> CLIDR_LOC_SHIFT) & 0x7)
 #define CLIDR_LOUIS(clidr)	(((clidr) >> CLIDR_LOUIS_SHIFT) & 0x7)
 
+#define CSSELR_TND_SHIFT	4
+#define CSSELR_TND_MASK		(UL(1) << CSSELR_TND_SHIFT)
+#define CSSELR_LEVEL_SHIFT	1
+#define CSSELR_LEVEL_MASK	(UL(7) << CSSELR_LEVEL_SHIFT)
+#define CSSELR_IND_SHIFT	0
+#define CSSERL_IND_MASK		(UL(1) << CSSELR_IND_SHIFT)
+
+#define CCSIDR_64_LS_SHIFT	0
+#define CCSIDR_64_LS_MASK	(UL(7) << CCSIDR_64_LS_SHIFT)
+#define CCSIDR_64_ASSOC_SHIFT	3
+#define CCSIDR_64_ASSOC_MASK	(UL(0x1FFFFF) << CCSIDR_64_ASSOC_SHIFT)
+#define CCSIDR_64_SET_SHIFT	32
+#define CCSIDR_64_SET_MASK	(UL(0xFFFFFF) << CCSIDR_64_SET_SHIFT)
+
+#define CCSIDR_32_LS_SHIFT	0
+#define CCSIDR_32_LS_MASK	(UL(7) << CCSIDR_32_LS_SHIFT)
+#define CCSIDR_32_ASSOC_SHIFT	3
+#define CCSIDR_32_ASSOC_MASK	(UL(0x3FF) << CCSIDR_32_ASSOC_SHIFT)
+#define CCSIDR_32_SET_SHIFT	13
+#define CCSIDR_32_SET_MASK	(UL(0x7FFF) << CCSIDR_32_SET_SHIFT)
+
 /*
  * Memory returned by kmalloc() may be used for DMA, so we must make
  * sure that all such allocations are cache aligned. Otherwise,
@@ -89,6 +110,7 @@ static inline int cache_line_size_of_cpu(void)
 }
 
 int cache_line_size(void);
+int cache_total_size(void);
 
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
index 7fa6828bb488..d3b9ab757014 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -43,6 +43,40 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 	this_leaf->type = type;
 }
 
+int cache_total_size(void)
+{
+	unsigned int ctype, size;
+	unsigned long val;
+	bool ccidx = false;
+
+	/* Check first level cache is supported */
+	ctype = get_cache_type(1);
+	if (ctype == CACHE_TYPE_NOCACHE)
+		return 0;
+
+	/* ARMv8.3-CCIDX is supported or not */
+	val = read_sanitised_ftr_reg(SYS_ID_MMFR4_EL1);
+	ccidx = !!(val & (UL(0xF) << ID_AA64MMFR2_CCIDX_SHIFT));
+
+	/* Retrieve the information and calculate the total size */
+	val = FIELD_PREP(CSSELR_LEVEL_MASK, 0) |
+	      FIELD_PREP(CSSERL_IND_MASK, 0);
+	write_sysreg(val, csselr_el1);
+
+	val = read_sysreg(ccsidr_el1);
+	if (ccidx) {
+		size = (1 << FIELD_GET(CCSIDR_64_LS_MASK, val)) *
+		       (FIELD_GET(CCSIDR_64_ASSOC_MASK, val) + 1) *
+		       (FIELD_GET(CCSIDR_64_SET_MASK, val) + 1);
+	} else {
+		size = (1 << FIELD_GET(CCSIDR_32_LS_MASK, val)) *
+		       (FIELD_GET(CCSIDR_32_ASSOC_MASK, val) + 1) *
+		       (FIELD_GET(CCSIDR_32_SET_MASK, val) + 1);
+	}
+
+	return size;
+}
+
 static int __init_cache_level(unsigned int cpu)
 {
 	unsigned int ctype, level, leaves, fw_level;
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 481d22c32a2e..ca6b3cddafb7 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -69,6 +69,11 @@ EXPORT_SYMBOL(vmemmap);
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
@@ -507,6 +512,35 @@ static void __init free_unused_memmap(void)
 }
 #endif	/* !CONFIG_SPARSEMEM_VMEMMAP */
 
+static void __init setup_zero_pages(void)
+{
+	struct page *page;
+	int order, size, i;
+
+	size = cache_total_size();
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
@@ -527,6 +561,7 @@ void __init mem_init(void)
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
-- 
2.23.0


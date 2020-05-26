Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3C2F1AE10E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Apr 2020 17:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgDQP0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Apr 2020 11:26:30 -0400
Received: from foss.arm.com ([217.140.110.172]:52822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728610AbgDQP0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:26:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 499FB1FB;
        Fri, 17 Apr 2020 08:26:29 -0700 (PDT)
Received: from e112269-lin.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF4C83F73D;
        Fri, 17 Apr 2020 08:26:26 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexios Zavras <alexios.zavras@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pan Zhang <zhangpan26@huawei.com>,
        Steve Capper <steve.capper@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH RESEND] arm64: Map page table of linear map readonly
Date:   Fri, 17 Apr 2020 16:26:19 +0100
Message-Id: <20200417152619.41680-1-steven.price@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's fairly rare that linear mappings need to be updated, so to improve
security we can map the leaf page table entries as read-only, this makes
it harder for an attacker to modify the permissions of the linear
mappings, while the overhead is low because the linear mappings don't
need to be changed frequently. When they do need to be updated we can
use fixmaps to create a temporary alternative mapping to do the update.

Signed-off-by: Steven Price <steven.price@arm.com>
---
Resending as I didn't receive any comments on my first posting[1].
Anyone have any views as to whether this is a good idea or not?

[1] https://lore.kernel.org/linux-arm-kernel/20200306173217.44372-1-steven.price@arm.com/

 arch/arm64/Kconfig              |  9 ++++++++
 arch/arm64/include/asm/fixmap.h | 20 ++++++++++++++++-
 arch/arm64/mm/mmu.c             | 38 +++++++++++++++++++++++++++++++--
 arch/arm64/mm/pageattr.c        | 36 ++++++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 40fb05d96c60..138d8b50d894 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1213,6 +1213,15 @@ config RODATA_FULL_DEFAULT_ENABLED
 	  This requires the linear region to be mapped down to pages,
 	  which may adversely affect performance in some cases.
 
+config LINEAR_PGTABLE_RO
+	bool "Apply r/o permissions to page tables of linear mapping"
+	help
+	  Apply read-only attributes to the page tables that make up the
+	  the linear mapping. This prevents the linear page tables from being
+	  inadvertently modified.
+
+	  This requires rodata=on (or RODATA_FULL_DEFAULT_ENABLED).
+
 config ARM64_SW_TTBR0_PAN
 	bool "Emulate Privileged Access Never using TTBR0_EL1 switching"
 	help
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index f987b8a8f325..55bf08151d73 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -67,6 +67,12 @@ enum fixed_addresses {
 	FIX_ENTRY_TRAMP_TEXT,
 #define TRAMP_VALIAS		(__fix_to_virt(FIX_ENTRY_TRAMP_TEXT))
 #endif /* CONFIG_UNMAP_KERNEL_AT_EL0 */
+
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	FIX_LINEAR_RO_BEGIN,
+	FIX_LINEAR_RO_END = FIX_LINEAR_RO_BEGIN + NR_CPUS - 1,
+#endif
+
 	__end_of_permanent_fixed_addresses,
 
 	/*
@@ -77,7 +83,15 @@ enum fixed_addresses {
 #define FIX_BTMAPS_SLOTS	7
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	/*
+	 * Share the space with the LINEAR_RO area as during early boot, the
+	 * LINEAR_RO area isn't needed
+	 */
+	FIX_BTMAP_END = FIX_LINEAR_RO_BEGIN,
+#else
 	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
+#endif
 	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
 
 	/*
@@ -89,9 +103,13 @@ enum fixed_addresses {
 	FIX_PUD,
 	FIX_PGD,
 
-	__end_of_fixed_addresses
+	___end_of_fixed_addresses
 };
 
+static const enum fixed_addresses __end_of_fixed_addresses =
+	___end_of_fixed_addresses > __end_of_permanent_fixed_addresses ?
+	___end_of_fixed_addresses : __end_of_permanent_fixed_addresses;
+
 #define FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index a374e4f51a62..4f9d14b584a5 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -21,6 +21,7 @@
 #include <linux/fs.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/pagewalk.h>
 #include <linux/vmalloc.h>
 
 #include <asm/barrier.h>
@@ -456,6 +457,34 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+static int __init mark_linear_pmd_ro(pmd_t *pmd, unsigned long addr,
+				     unsigned long next, struct mm_walk *walk)
+{
+	phys_addr_t pmd_phys = pte_offset_phys(pmd, 0);
+
+	__map_memblock(walk->mm->pgd, pmd_phys, pmd_phys + PAGE_SIZE,
+		       PAGE_KERNEL_RO, NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+
+	return 0;
+}
+
+static const struct mm_walk_ops mark_linear_pg_ro_ops __initconst = {
+	.pmd_entry = mark_linear_pmd_ro,
+};
+
+/*
+ * Remove the write permission from the leaf page tables of the linear map
+ */
+void __init mark_linear_pg_ro(void)
+{
+	down_read(&init_mm.mmap_sem);
+	walk_page_range_novma(&init_mm, PAGE_OFFSET, PAGE_END,
+			      &mark_linear_pg_ro_ops, init_mm.pgd, NULL);
+	up_read(&init_mm.mmap_sem);
+}
+#endif
+
 static void __init map_mem(pgd_t *pgdp)
 {
 	phys_addr_t kernel_start = __pa_symbol(_text);
@@ -503,7 +532,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * so we should avoid them here.
 	 */
 	__map_memblock(pgdp, kernel_start, kernel_end,
-		       PAGE_KERNEL, NO_CONT_MAPPINGS);
+		       PAGE_KERNEL, flags | NO_CONT_MAPPINGS);
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
@@ -679,6 +708,11 @@ void __init paging_init(void)
 	cpu_replace_ttbr1(lm_alias(swapper_pg_dir));
 	init_mm.pgd = swapper_pg_dir;
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	if (rodata_full)
+		mark_linear_pg_ro();
+#endif
+
 	memblock_free(__pa_symbol(init_pg_dir),
 		      __pa_symbol(init_pg_end) - __pa_symbol(init_pg_dir));
 
@@ -1187,8 +1221,8 @@ void __set_fixmap(enum fixed_addresses idx,
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
 	} else {
 		pte_clear(&init_mm, addr, ptep);
-		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
 	}
+	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
 }
 
 void *__init fixmap_remap_fdt(phys_addr_t dt_phys, int *size, pgprot_t prot)
diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 250c49008d73..52d34c06656c 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -7,6 +7,7 @@
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
+#include <linux/uaccess.h>
 
 #include <asm/pgtable.h>
 #include <asm/set_memory.h>
@@ -19,6 +20,33 @@ struct page_change_data {
 
 bool rodata_full __ro_after_init = IS_ENABLED(CONFIG_RODATA_FULL_DEFAULT_ENABLED);
 
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+static void set_linear_pte_range(pte_t *ptep, pte_t pte)
+{
+	unsigned long flags;
+	unsigned int idx;
+	unsigned long addr;
+
+	local_irq_save(flags);
+	preempt_disable();
+
+	/* During early boot we use FIX_PTE as we don't need a per-CPU slot */
+	if (system_state < SYSTEM_SCHEDULING)
+		idx = FIX_PTE;
+	else
+		idx = FIX_LINEAR_RO_BEGIN + smp_processor_id();
+
+	addr = virt_to_phys(ptep);
+	set_fixmap(idx, addr);
+	ptep = (pte_t *)(__fix_to_virt(idx) + (addr & ~PAGE_MASK));
+	set_pte(ptep, pte);
+	clear_fixmap(idx);
+
+	preempt_enable();
+	local_irq_restore(flags);
+}
+#endif
+
 static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 {
 	struct page_change_data *cdata = data;
@@ -27,7 +55,13 @@ static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
 	pte = clear_pte_bit(pte, cdata->clear_mask);
 	pte = set_pte_bit(pte, cdata->set_mask);
 
-	set_pte(ptep, pte);
+#ifdef CONFIG_LINEAR_PGTABLE_RO
+	if (addr >= PAGE_OFFSET)
+		set_linear_pte_range(ptep, pte);
+	else
+#endif
+		set_pte(ptep, pte);
+
 	return 0;
 }
 
-- 
2.20.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21601C7712
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgEFQty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:49:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53309 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730550AbgEFQsp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMx70VH0z9v4kJ;
        Wed,  6 May 2020 18:48:43 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id q2Zja-3ir84Y; Wed,  6 May 2020 18:48:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMx66m5tz9v4kH;
        Wed,  6 May 2020 18:48:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BDBC08B7C5;
        Wed,  6 May 2020 18:48:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wDxJAbuYw4Ye; Wed,  6 May 2020 18:48:44 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E9D28B777;
        Wed,  6 May 2020 18:48:44 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 3957365911; Wed,  6 May 2020 16:48:44 +0000 (UTC)
Message-Id: <e83bb51b9b7aaecb59f4c23165571d230a8587fa.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 38/45] powerpc/8xx: Add a function to early map kernel via
 huge pages
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to early map kernel memory using huge pages.

For 512k pages, just use standard page table and map in using 512k
pages.

For 8M pages, create a hugepd table and populate the two PGD
entries with it.

This function can only be used to create page tables at startup. Once
the regular SLAB allocation functions replace memblock functions,
this function cannot allocate new pages anymore. However it can still
update existing mappings with new protections.

hugepd_none() macro is moved into asm/hugetlb.h to be usable outside
of mm/hugetlbpage.c

early_pte_alloc_kernel() is made visible.

_PAGE_HUGE flag is now displayed by ptdump.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Select CONFIG_HUGETLBFS instead of CONFIG_HUGETLB_PAGE which leads to linktime failure
---
 .../include/asm/nohash/32/hugetlb-8xx.h       |  5 ++
 arch/powerpc/include/asm/pgtable.h            |  2 +
 arch/powerpc/mm/nohash/8xx.c                  | 52 +++++++++++++++++++
 arch/powerpc/mm/pgtable_32.c                  |  2 +-
 arch/powerpc/mm/ptdump/8xx.c                  |  5 ++
 arch/powerpc/platforms/Kconfig.cputype        |  1 +
 6 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
index 1c7d4693a78e..e752a5807a59 100644
--- a/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/hugetlb-8xx.h
@@ -35,6 +35,11 @@ static inline void hugepd_populate(hugepd_t *hpdp, pte_t *new, unsigned int pshi
 	*hpdp = __hugepd(__pa(new) | _PMD_USER | _PMD_PRESENT | _PMD_PAGE_8M);
 }
 
+static inline void hugepd_populate_kernel(hugepd_t *hpdp, pte_t *new, unsigned int pshift)
+{
+	*hpdp = __hugepd(__pa(new) | _PMD_PRESENT | _PMD_PAGE_8M);
+}
+
 static inline int check_and_get_huge_psize(int shift)
 {
 	return shift_to_mmu_psize(shift);
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index b1f1d5339735..961895be932a 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -107,6 +107,8 @@ unsigned long vmalloc_to_phys(void *vmalloc_addr);
 
 void pgtable_cache_add(unsigned int shift);
 
+pte_t *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va);
+
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_PPC32)
 void mark_initmem_nx(void);
 #else
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index d9f205d9a654..570ab2114a73 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -9,8 +9,10 @@
 
 #include <linux/memblock.h>
 #include <linux/mmu_context.h>
+#include <linux/hugetlb.h>
 #include <asm/fixmap.h>
 #include <asm/code-patching.h>
+#include <asm/pgalloc.h>
 
 #include <mm/mmu_decl.h>
 
@@ -54,6 +56,56 @@ unsigned long p_block_mapped(phys_addr_t pa)
 	return 0;
 }
 
+static pte_t __init *early_hugepd_alloc_kernel(hugepd_t *pmdp, unsigned long va)
+{
+	if (hpd_val(*pmdp) == 0) {
+		pte_t *ptep = memblock_alloc(sizeof(pte_basic_t), SZ_4K);
+
+		if (!ptep)
+			return NULL;
+
+		hugepd_populate_kernel((hugepd_t *)pmdp, ptep, PAGE_SHIFT_8M);
+		hugepd_populate_kernel((hugepd_t *)pmdp + 1, ptep, PAGE_SHIFT_8M);
+	}
+	return hugepte_offset(*(hugepd_t *)pmdp, va, PGDIR_SHIFT);
+}
+
+static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
+					     pgprot_t prot, int psize, bool new)
+{
+	pmd_t *pmdp = pmd_ptr_k(va);
+	pte_t *ptep;
+
+	if (WARN_ON(psize != MMU_PAGE_512K && psize != MMU_PAGE_8M))
+		return -EINVAL;
+
+	if (new) {
+		if (WARN_ON(slab_is_available()))
+			return -EINVAL;
+
+		if (psize == MMU_PAGE_512K)
+			ptep = early_pte_alloc_kernel(pmdp, va);
+		else
+			ptep = early_hugepd_alloc_kernel((hugepd_t *)pmdp, va);
+	} else {
+		if (psize == MMU_PAGE_512K)
+			ptep = pte_offset_kernel(pmdp, va);
+		else
+			ptep = hugepte_offset(*(hugepd_t *)pmdp, va, PGDIR_SHIFT);
+	}
+
+	if (WARN_ON(!ptep))
+		return -ENOMEM;
+
+	/* The PTE should never be already present */
+	if (new && WARN_ON(pte_present(*ptep) && pgprot_val(prot)))
+		return -EINVAL;
+
+	set_huge_pte_at(&init_mm, va, ptep, pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)));
+
+	return 0;
+}
+
 /*
  * MMU_init_hw does the chip-specific initialization of the MMU hardware.
  */
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index bd0cb6e3573e..05902bbff8d6 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -61,7 +61,7 @@ static void __init *early_alloc_pgtable(unsigned long size)
 	return ptr;
 }
 
-static pte_t __init *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
+pte_t __init *early_pte_alloc_kernel(pmd_t *pmdp, unsigned long va)
 {
 	if (pmd_none(*pmdp)) {
 		pte_t *ptep = early_alloc_pgtable(PTE_FRAG_SIZE);
diff --git a/arch/powerpc/mm/ptdump/8xx.c b/arch/powerpc/mm/ptdump/8xx.c
index a3169677dced..b3185b32793d 100644
--- a/arch/powerpc/mm/ptdump/8xx.c
+++ b/arch/powerpc/mm/ptdump/8xx.c
@@ -11,6 +11,11 @@
 
 static const struct flag_info flag_array[] = {
 	{
+		.mask	= _PAGE_HUGE,
+		.val	= _PAGE_HUGE,
+		.set	= "h",
+		.clear	= " ",
+	}, {
 		.mask	= _PAGE_RO | _PAGE_NA,
 		.val	= 0,
 		.set	= "rw",
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 5774a55a9c58..e3fb0ef5129f 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -56,6 +56,7 @@ config PPC_8xx
 	select PPC_HAVE_KUEP
 	select PPC_HAVE_KUAP
 	select HAVE_ARCH_VMAP_STACK
+	select HUGETLBFS
 
 config 40x
 	bool "AMCC 40x"
-- 
2.25.0


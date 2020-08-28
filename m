Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3840A255F98
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 19:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgH1RV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 13:21:27 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11687 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgH1RUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598635246; x=1630171246;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9dzVAvMQzryRH4OY4uy0c2IA1NXr4r5gdlmIqy/4veo=;
  b=rUA5MOKx5oQ5CGgJQK5+hItGeXsdypoh/JsnjsXmSFMX8JCgQKmZDHfs
   gXEDwTby1Nxtei8kftPhIXwg7TkXEOsRiS7aVVDGxSHmqVsuFJTzJfoyC
   vkHEOrV0We2vv/jRSmpEtrpBesH8CMTulVhqDZfTmMt4SBa2dfJxZbJbM
   k4CNu02Q4Tr5rY6xaN8Si6Nk+C4PsoqVesIM0AT30ytkATivVYcFvQnhL
   tOwUHMxdSWtMOkOkRD9I27bIntkY9Pc1r6yBqvFc64+SHDVHtirUx3Xw2
   U2sMJZkeVMULNBJznYL3CgwO2Xh3hopZrWTjcetV5nzawurQOOEZttAJD
   Q==;
IronPort-SDR: oVB1RnvEJohTD62mkBh4XgMRZTBfVr0U9YyD4Efsh0sHCtrxQ22OdMiMWeDzd0s2LThIDH8eAH
 zloE0g7IFaSw4e8FdtUg1y9LSCeuJU78LeeIIS7XWg8RSo3Prvt9HJcuzeQiQVeDgkehaSL9ir
 TX8KRcpOobWUAz7qf3oU2R8jkTMMOcRK3hG8AwRSBDL++a1/s19XSHAqESkiALZwd7U0vtp2ya
 84JBYOI+fFOGLVn09cQU0naOye0IyAfmNwUlPcsgea3ZQFmDp8I1mcd10PQeNRsbcAurbUjh6H
 gis=
X-IronPort-AV: E=Sophos;i="5.76,364,1592841600"; 
   d="scan'208";a="146018513"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Aug 2020 01:20:44 +0800
IronPort-SDR: 7SRYQKk9zxvE7eHLJTl7xFD+VLP0KE4VhurfnSNR5Ni0udJvFmnhNKPEvB7EeBt6h3euP/S9Yu
 WXPhNwFXOdVg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 10:08:16 -0700
IronPort-SDR: cHEGtdZXUata0e29TqwV7pKiqsGxwZ/GjjyrOJsV4uVGyhC0xccgHd+P5yS9KgF9dMW1nvOkqH
 0s8KQjCl06Cw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.59.137])
  by uls-op-cesaip01.wdc.com with ESMTP; 28 Aug 2020 10:20:43 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH v7 3/9] RISC-V: Implement late mapping page table allocation functions
Date:   Fri, 28 Aug 2020 10:20:30 -0700
Message-Id: <20200828172036.8056-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200828172036.8056-1-atish.patra@wdc.com>
References: <20200828172036.8056-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, page table setup is done during setup_va_final where fixmap can
be used to create the temporary mappings. The physical frame is allocated
from memblock_alloc_* functions. However, this won't work if page table
mapping needs to be created for a different mm context (i.e. efi mm) at
a later point of time.

Use generic kernel page allocation function & macros for any mapping
after setup_vm_final.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Acked-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/riscv/mm/init.c | 130 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 99 insertions(+), 31 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index b75ebe8e7a92..cac2c31f8beb 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -32,6 +32,17 @@ extern char _start[];
 void *dtb_early_va __initdata;
 uintptr_t dtb_early_pa __initdata;
 
+struct pt_alloc_ops {
+	pte_t *(*get_pte_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pte)(uintptr_t va);
+#ifndef __PAGETABLE_PMD_FOLDED
+	pmd_t *(*get_pmd_virt)(phys_addr_t pa);
+	phys_addr_t (*alloc_pmd)(uintptr_t va);
+#endif
+};
+
+static struct pt_alloc_ops pt_ops;
+
 static void __init zone_sizes_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
@@ -211,7 +222,6 @@ EXPORT_SYMBOL(pfn_base);
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
-static bool mmu_enabled;
 
 #define MAX_EARLY_MAPPING_SIZE	SZ_128M
 
@@ -234,27 +244,46 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 	}
 }
 
-static pte_t *__init get_pte_virt(phys_addr_t pa)
+static inline pte_t *__init get_pte_virt_early(phys_addr_t pa)
 {
-	if (mmu_enabled) {
-		clear_fixmap(FIX_PTE);
-		return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
-	} else {
-		return (pte_t *)((uintptr_t)pa);
-	}
+	return (pte_t *)((uintptr_t)pa);
 }
 
-static phys_addr_t __init alloc_pte(uintptr_t va)
+static inline pte_t *__init get_pte_virt_fixmap(phys_addr_t pa)
+{
+	clear_fixmap(FIX_PTE);
+	return (pte_t *)set_fixmap_offset(FIX_PTE, pa);
+}
+
+static inline pte_t *get_pte_virt_late(phys_addr_t pa)
+{
+	return (pte_t *) __va(pa);
+}
+
+static inline phys_addr_t __init alloc_pte_early(uintptr_t va)
 {
 	/*
 	 * We only create PMD or PGD early mappings so we
 	 * should never reach here with MMU disabled.
 	 */
-	BUG_ON(!mmu_enabled);
+	BUG();
+}
 
+static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
+{
 	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
 }
 
+static phys_addr_t alloc_pte_late(uintptr_t va)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_page(GFP_KERNEL);
+	if (!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)))
+		BUG();
+	return __pa(vaddr);
+}
+
 static void __init create_pte_mapping(pte_t *ptep,
 				      uintptr_t va, phys_addr_t pa,
 				      phys_addr_t sz, pgprot_t prot)
@@ -279,28 +308,46 @@ pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
 #endif
 pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
 
-static pmd_t *__init get_pmd_virt(phys_addr_t pa)
+static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
 {
-	if (mmu_enabled) {
-		clear_fixmap(FIX_PMD);
-		return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
-	} else {
-		return (pmd_t *)((uintptr_t)pa);
-	}
+	/* Before MMU is enabled */
+	return (pmd_t *)((uintptr_t)pa);
 }
 
-static phys_addr_t __init alloc_pmd(uintptr_t va)
+static pmd_t *__init get_pmd_virt_fixmap(phys_addr_t pa)
 {
-	uintptr_t pmd_num;
+	clear_fixmap(FIX_PMD);
+	return (pmd_t *)set_fixmap_offset(FIX_PMD, pa);
+}
+
+static pmd_t *get_pmd_virt_late(phys_addr_t pa)
+{
+	return (pmd_t *) __va(pa);
+}
 
-	if (mmu_enabled)
-		return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+static phys_addr_t __init alloc_pmd_early(uintptr_t va)
+{
+	uintptr_t pmd_num;
 
 	pmd_num = (va - PAGE_OFFSET) >> PGDIR_SHIFT;
 	BUG_ON(pmd_num >= NUM_EARLY_PMDS);
 	return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
 }
 
+static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
+{
+	return memblock_phys_alloc(PAGE_SIZE, PAGE_SIZE);
+}
+
+static phys_addr_t alloc_pmd_late(uintptr_t va)
+{
+	unsigned long vaddr;
+
+	vaddr = __get_free_page(GFP_KERNEL);
+	BUG_ON(!vaddr);
+	return __pa(vaddr);
+}
+
 static void __init create_pmd_mapping(pmd_t *pmdp,
 				      uintptr_t va, phys_addr_t pa,
 				      phys_addr_t sz, pgprot_t prot)
@@ -316,28 +363,28 @@ static void __init create_pmd_mapping(pmd_t *pmdp,
 	}
 
 	if (pmd_none(pmdp[pmd_idx])) {
-		pte_phys = alloc_pte(va);
+		pte_phys = pt_ops.alloc_pte(va);
 		pmdp[pmd_idx] = pfn_pmd(PFN_DOWN(pte_phys), PAGE_TABLE);
-		ptep = get_pte_virt(pte_phys);
+		ptep = pt_ops.get_pte_virt(pte_phys);
 		memset(ptep, 0, PAGE_SIZE);
 	} else {
 		pte_phys = PFN_PHYS(_pmd_pfn(pmdp[pmd_idx]));
-		ptep = get_pte_virt(pte_phys);
+		ptep = pt_ops.get_pte_virt(pte_phys);
 	}
 
 	create_pte_mapping(ptep, va, pa, sz, prot);
 }
 
 #define pgd_next_t		pmd_t
-#define alloc_pgd_next(__va)	alloc_pmd(__va)
-#define get_pgd_next_virt(__pa)	get_pmd_virt(__pa)
+#define alloc_pgd_next(__va)	pt_ops.alloc_pmd(__va)
+#define get_pgd_next_virt(__pa)	pt_ops.get_pmd_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pmd_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		fixmap_pmd
 #else
 #define pgd_next_t		pte_t
-#define alloc_pgd_next(__va)	alloc_pte(__va)
-#define get_pgd_next_virt(__pa)	get_pte_virt(__pa)
+#define alloc_pgd_next(__va)	pt_ops.alloc_pte(__va)
+#define get_pgd_next_virt(__pa)	pt_ops.get_pte_virt(__pa)
 #define create_pgd_next_mapping(__nextp, __va, __pa, __sz, __prot)	\
 	create_pte_mapping(__nextp, __va, __pa, __sz, __prot)
 #define fixmap_pgd_next		fixmap_pte
@@ -421,6 +468,12 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 	BUG_ON((load_pa % map_size) != 0);
 	BUG_ON(load_sz > MAX_EARLY_MAPPING_SIZE);
 
+	pt_ops.alloc_pte = alloc_pte_early;
+	pt_ops.get_pte_virt = get_pte_virt_early;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_early;
+	pt_ops.get_pmd_virt = get_pmd_virt_early;
+#endif
 	/* Setup early PGD for fixmap */
 	create_pgd_mapping(early_pg_dir, FIXADDR_START,
 			   (uintptr_t)fixmap_pgd_next, PGDIR_SIZE, PAGE_TABLE);
@@ -497,9 +550,16 @@ static void __init setup_vm_final(void)
 	phys_addr_t pa, start, end;
 	struct memblock_region *reg;
 
-	/* Set mmu_enabled flag */
-	mmu_enabled = true;
-
+	/**
+	 * MMU is enabled at this point. But page table setup is not complete yet.
+	 * fixmap page table alloc functions should be used at this point
+	 */
+	pt_ops.alloc_pte = alloc_pte_fixmap;
+	pt_ops.get_pte_virt = get_pte_virt_fixmap;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_fixmap;
+	pt_ops.get_pmd_virt = get_pmd_virt_fixmap;
+#endif
 	/* Setup swapper PGD for fixmap */
 	create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
 			   __pa_symbol(fixmap_pgd_next),
@@ -533,6 +593,14 @@ static void __init setup_vm_final(void)
 	/* Move to swapper page table */
 	csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
 	local_flush_tlb_all();
+
+	/* generic page allocation functions must be used to setup page table */
+	pt_ops.alloc_pte = alloc_pte_late;
+	pt_ops.get_pte_virt = get_pte_virt_late;
+#ifndef __PAGETABLE_PMD_FOLDED
+	pt_ops.alloc_pmd = alloc_pmd_late;
+	pt_ops.get_pmd_virt = get_pmd_virt_late;
+#endif
 }
 #else
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
-- 
2.24.0


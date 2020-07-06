Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62061215D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jul 2020 19:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729739AbgGFR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jul 2020 13:26:41 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:41516 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgGFR0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594056421; x=1625592421;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ihAfLD97lU7TjJORSki+rGBXYnAkG5Afd7XbqxsjX2E=;
  b=pvZWBdEaLS229Bo7MppuCWvCUqNHXT+JAnVrFqhqg4tgXREmASpeTeiI
   co+Vk9lPnU7fqTbVb3Pw18AfyGse+fO+AopbbJUrbiLyY4o77C/FERUlc
   +B0DI98cEJMRijxHLksIGX+l4ivCsQySDtXi671p9B182UpiKZwd9nZk6
   Pmxf7GeDI8Vi+De3ivFlWyIJbb9XHaTV75st4HYZRHa1eyuHNT0Dwz5qZ
   T2A3+/cBhJgXlMhYcjB3zATR9l6Z3FuPXrjSqKkYnZI1gdAFVdPSsJ4jI
   C91nPdQATeu6j9cQ6L60Hb8i1gWj07+Pcg0qJAoDKAolwuBfbJyNTSZVn
   g==;
IronPort-SDR: MnpOxvIt8djBtwnI/s2OmuNybH68QnlDvKHFfwXx7r2N0dzEj3Hk/F9O0a5Wga9DvC2JSEjEjr
 j9N0rpTIFnsbA9HywPS+HEffEuI6ktyNX4JG/ZkLA1WnymPz+vwHkrwvf3Q2PMnWwvAze+43uj
 6IxsCBU1XNFbrReekVhXAx2oq6BH36Nqf09mMs4UTj9buAOyQDJKxu1dnWTa9Rfj4/3q1j1kMD
 ptxDppcjKi4Ouph6j7Aq47QBPPjXr/M5aCT8ZtfwNGsgmV9qqcJAknM06LRQKmApn3U3lkQEyn
 O14=
X-IronPort-AV: E=Sophos;i="5.75,320,1589212800"; 
   d="scan'208";a="244770174"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 01:26:51 +0800
IronPort-SDR: u9KUGkv8yKnDTM+j/h9WB90/gCb+L/qe2M8v/4+c6GPx2CMtcAa1bcXGbHqZS7ukqQnA4AJSZU
 tb5LF6SZt5YODRbss7wvCEtGJez78W7DE=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 10:14:38 -0700
IronPort-SDR: 8BPyeAFugfQ7vcY4FOBjK8k4D9Wq3qcPHzxx/TXBvy4o44HkaDoMMWpj8fedogoDvDgZnn0vgI
 tJlwLUq1NXtw==
WDCIronportException: Internal
Received: from 6hj08h2.ad.shared (HELO jedi-01.hgst.com) ([10.86.57.161])
  by uls-op-cesaip01.wdc.com with ESMTP; 06 Jul 2020 10:26:29 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup.patel@wdc.com>, Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [RFC PATCH v2 02/11] RISC-V: Move DT mapping outof fixmap
Date:   Mon,  6 Jul 2020 10:26:00 -0700
Message-Id: <20200706172609.25965-3-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200706172609.25965-1-atish.patra@wdc.com>
References: <20200706172609.25965-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anup Patel <anup.patel@wdc.com>

Currently, RISC-V reserves 1MB of fixmap memory for device tree. However,
it maps only single PMD (2MB) space for fixmap which leaves only < 1MB space
left for other kernel features such as early ioremap which requires fixmap
as well. The fixmap size can be increased by another 2MB but it brings
additional complexity and changes the virtual memory layout as well.
If we require some additional feature requiring fixmap again, it has to be
moved again.

Technically, DT doesn't need a fixmap as the memory occupied by the DT is
only used during boot. Thus, init memory section can be used for the same
purpose as well. This simplifies fixmap implementation.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/include/asm/fixmap.h |  3 ---
 arch/riscv/kernel/head.S        |  1 -
 arch/riscv/kernel/head.h        |  2 --
 arch/riscv/kernel/setup.c       |  8 +++-----
 arch/riscv/mm/init.c            | 36 ++++++++++++++-------------------
 5 files changed, 18 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
index 1ff075a8dfc7..11613f38228a 100644
--- a/arch/riscv/include/asm/fixmap.h
+++ b/arch/riscv/include/asm/fixmap.h
@@ -22,9 +22,6 @@
  */
 enum fixed_addresses {
 	FIX_HOLE,
-#define FIX_FDT_SIZE	SZ_1M
-	FIX_FDT_END,
-	FIX_FDT = FIX_FDT_END + FIX_FDT_SIZE / PAGE_SIZE - 1,
 	FIX_PTE,
 	FIX_PMD,
 	FIX_TEXT_POKE1,
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 7ed1b22950fd..c5b529234ad8 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -244,7 +244,6 @@ clear_bss_done:
 #endif
 	/* Start the kernel */
 	call soc_early_init
-	call parse_dtb
 	tail start_kernel
 
 .Lsecondary_start:
diff --git a/arch/riscv/kernel/head.h b/arch/riscv/kernel/head.h
index 105fb0496b24..b48dda3d04f6 100644
--- a/arch/riscv/kernel/head.h
+++ b/arch/riscv/kernel/head.h
@@ -16,6 +16,4 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa);
 extern void *__cpu_up_stack_pointer[];
 extern void *__cpu_up_task_pointer[];
 
-void __init parse_dtb(void);
-
 #endif /* __ASM_HEAD_H */
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f04373be54a6..8519a6d29857 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -49,8 +49,9 @@ atomic_t hart_lottery __section(.sdata);
 unsigned long boot_cpu_hartid;
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
-void __init parse_dtb(void)
+static void __init parse_dtb(void)
 {
+	/* Early scan of device tree from init memory */
 	if (early_init_dt_scan(dtb_early_va))
 		return;
 
@@ -63,6 +64,7 @@ void __init parse_dtb(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	parse_dtb();
 	init_mm.start_code = (unsigned long) _stext;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
@@ -74,11 +76,7 @@ void __init setup_arch(char **cmdline_p)
 
 	setup_bootmem();
 	paging_init();
-#if IS_ENABLED(CONFIG_BUILTIN_DTB)
 	unflatten_and_copy_device_tree();
-#else
-	unflatten_device_tree();
-#endif
 	clint_init_boot_cpu();
 
 #ifdef CONFIG_SWIOTLB
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f4adb3684f3d..c18c94ab3b23 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -28,7 +28,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 EXPORT_SYMBOL(empty_zero_page);
 
 extern char _start[];
-void *dtb_early_va;
 
 static void __init zone_sizes_init(void)
 {
@@ -120,8 +119,6 @@ static void __init setup_initrd(void)
 }
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-static phys_addr_t dtb_early_pa __initdata;
-
 void __init setup_bootmem(void)
 {
 	struct memblock_region *reg;
@@ -158,13 +155,9 @@ void __init setup_bootmem(void)
 	setup_initrd();
 #endif /* CONFIG_BLK_DEV_INITRD */
 
-	/*
-	 * Avoid using early_init_fdt_reserve_self() since __pa() does
-	 * not work for DTB pointers that are fixmap addresses
-	 */
-	memblock_reserve(dtb_early_pa, fdt_totalsize(dtb_early_va));
-
+	early_init_fdt_reserve_self();
 	early_init_fdt_scan_reserved_mem();
+
 	memblock_allow_resize();
 	memblock_dump_all();
 
@@ -184,6 +177,10 @@ EXPORT_SYMBOL(va_pa_offset);
 unsigned long pfn_base;
 EXPORT_SYMBOL(pfn_base);
 
+#define DTB_EARLY_SIZE		SZ_1M
+static char early_dtb[DTB_EARLY_SIZE] __initdata;
+void *dtb_early_va __initdata = early_dtb;
+
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
@@ -375,7 +372,8 @@ static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t size)
 
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
-	uintptr_t va, end_va;
+	int dtb_size;
+	uintptr_t va, pa, end_va;
 	uintptr_t load_pa = (uintptr_t)(&_start);
 	uintptr_t load_sz = (uintptr_t)(&_end) - load_pa;
 	uintptr_t map_size = best_map_size(load_pa, MAX_EARLY_MAPPING_SIZE);
@@ -424,17 +422,11 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 				   load_pa + (va - PAGE_OFFSET),
 				   map_size, PAGE_KERNEL_EXEC);
 
-	/* Create fixed mapping for early FDT parsing */
-	end_va = __fix_to_virt(FIX_FDT) + FIX_FDT_SIZE;
-	for (va = __fix_to_virt(FIX_FDT); va < end_va; va += PAGE_SIZE)
-		create_pte_mapping(fixmap_pte, va,
-				   dtb_pa + (va - __fix_to_virt(FIX_FDT)),
-				   PAGE_SIZE, PAGE_KERNEL);
-
-	/* Save pointer to DTB for early FDT parsing */
-	dtb_early_va = (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PAGE_MASK);
-	/* Save physical address for memblock reservation */
-	dtb_early_pa = dtb_pa;
+	/* Copy FDT to init memory for early scan */
+	pa = load_pa + ((unsigned long)dtb_early_va - PAGE_OFFSET);
+	dtb_size = fdt_totalsize((void *)dtb_pa);
+	dtb_size = (dtb_size > DTB_EARLY_SIZE) ? DTB_EARLY_SIZE : dtb_size;
+	memcpy((void *)pa, (void *)dtb_pa, dtb_size);
 }
 
 static void __init setup_vm_final(void)
@@ -481,6 +473,8 @@ static void __init setup_vm_final(void)
 	local_flush_tlb_all();
 }
 #else
+void *dtb_early_va __initdata;
+
 asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 {
 #ifdef CONFIG_BUILTIN_DTB
-- 
2.24.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8EC2F5875
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbhANC3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:29:21 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11011 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbhANC3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:29:20 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DGSrm2H1NzhsJ2;
        Thu, 14 Jan 2021 10:27:36 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Thu, 14 Jan 2021 10:28:30 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2] initramfs: Provide a common initrd reserve function
Date:   Thu, 14 Jan 2021 10:33:58 +0800
Message-ID: <20210114023358.176459-1-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM and riscv have same logic to check and reserve
the memory of initrd, let's provide a common function to
reduce duplicated code.

Add __LINUX_INITRD_H define in initrd.h to prevent build error
(found by kernel test robot <lkp@intel.com>) from the multiple
inclusion of same header file multiple time.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
v2: fix build err

 arch/arm/mm/init.c     | 43 +---------------------------------
 arch/riscv/mm/init.c   | 53 +-----------------------------------------
 include/linux/initrd.h | 11 +++++++++
 init/initramfs.c       | 45 +++++++++++++++++++++++++++++++++++
 4 files changed, 58 insertions(+), 94 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 828a2561b229..a29e14cd626c 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -153,47 +153,6 @@ phys_addr_t __init arm_memblock_steal(phys_addr_t size, phys_addr_t align)
 	return phys;
 }
 
-static void __init arm_initrd_init(void)
-{
-#ifdef CONFIG_BLK_DEV_INITRD
-	phys_addr_t start;
-	unsigned long size;
-
-	initrd_start = initrd_end = 0;
-
-	if (!phys_initrd_size)
-		return;
-
-	/*
-	 * Round the memory region to page boundaries as per free_initrd_mem()
-	 * This allows us to detect whether the pages overlapping the initrd
-	 * are in use, but more importantly, reserves the entire set of pages
-	 * as we don't want these pages allocated for other purposes.
-	 */
-	start = round_down(phys_initrd_start, PAGE_SIZE);
-	size = phys_initrd_size + (phys_initrd_start - start);
-	size = round_up(size, PAGE_SIZE);
-
-	if (!memblock_is_region_memory(start, size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region - disabling initrd\n",
-		       (u64)start, size);
-		return;
-	}
-
-	if (memblock_is_region_reserved(start, size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region - disabling initrd\n",
-		       (u64)start, size);
-		return;
-	}
-
-	memblock_reserve(start, size);
-
-	/* Now convert initrd to virtual addresses */
-	initrd_start = __phys_to_virt(phys_initrd_start);
-	initrd_end = initrd_start + phys_initrd_size;
-#endif
-}
-
 #ifdef CONFIG_CPU_ICACHE_MISMATCH_WORKAROUND
 void check_cpu_icache_size(int cpuid)
 {
@@ -215,7 +174,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 	/* Register the kernel text, kernel data and initrd with memblock. */
 	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
 
-	arm_initrd_init();
+	reserve_initrd_mem();
 
 	arm_mm_memblock_reserve();
 
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index da53902ef0fc..93cba0d3f43f 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -105,55 +105,6 @@ void __init mem_init(void)
 	print_vm_layout();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void __init setup_initrd(void)
-{
-	phys_addr_t start;
-	unsigned long size;
-
-	/* Ignore the virtul address computed during device tree parsing */
-	initrd_start = initrd_end = 0;
-
-	if (!phys_initrd_size)
-		return;
-	/*
-	 * Round the memory region to page boundaries as per free_initrd_mem()
-	 * This allows us to detect whether the pages overlapping the initrd
-	 * are in use, but more importantly, reserves the entire set of pages
-	 * as we don't want these pages allocated for other purposes.
-	 */
-	start = round_down(phys_initrd_start, PAGE_SIZE);
-	size = phys_initrd_size + (phys_initrd_start - start);
-	size = round_up(size, PAGE_SIZE);
-
-	if (!memblock_is_region_memory(start, size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
-		       (u64)start, size);
-		goto disable;
-	}
-
-	if (memblock_is_region_reserved(start, size)) {
-		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
-		       (u64)start, size);
-		goto disable;
-	}
-
-	memblock_reserve(start, size);
-	/* Now convert initrd to virtual addresses */
-	initrd_start = (unsigned long)__va(phys_initrd_start);
-	initrd_end = initrd_start + phys_initrd_size;
-	initrd_below_start_ok = 1;
-
-	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		(void *)(initrd_start), size);
-	return;
-disable:
-	pr_cont(" - disabling initrd\n");
-	initrd_start = 0;
-	initrd_end = 0;
-}
-#endif /* CONFIG_BLK_DEV_INITRD */
-
 void __init setup_bootmem(void)
 {
 	phys_addr_t mem_start = 0;
@@ -198,9 +149,7 @@ void __init setup_bootmem(void)
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 	set_max_mapnr(max_low_pfn);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif /* CONFIG_BLK_DEV_INITRD */
+	reserve_initrd_mem();
 
 	/*
 	 * Avoid using early_init_fdt_reserve_self() since __pa() does
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index 8db6f8c8030b..85c15717af34 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -1,5 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#ifndef __LINUX_INITRD_H
+#define __LINUX_INITRD_H
+
 #define INITRD_MINOR 250 /* shouldn't collide with /dev/ram* too soon ... */
 
 /* starting block # of image */
@@ -15,6 +18,12 @@ extern int initrd_below_start_ok;
 extern unsigned long initrd_start, initrd_end;
 extern void free_initrd_mem(unsigned long, unsigned long);
 
+#ifdef CONFIG_BLK_DEV_INITRD
+extern void __init reserve_initrd_mem(void);
+#else
+static inline void __init reserve_initrd_mem(void) {}
+#endif
+
 extern phys_addr_t phys_initrd_start;
 extern unsigned long phys_initrd_size;
 
@@ -24,3 +33,5 @@ extern char __initramfs_start[];
 extern unsigned long __initramfs_size;
 
 void console_on_rootfs(void);
+
+#endif /* __LINUX_INITRD_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index 55b74d7e5260..f75c89e9d602 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -535,6 +535,51 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+void __init reserve_initrd_mem(void)
+{
+	phys_addr_t start;
+	unsigned long size;
+
+	/* Ignore the virtul address computed during device tree parsing */
+	initrd_start = initrd_end = 0;
+
+	if (!phys_initrd_size)
+		return;
+	/*
+	 * Round the memory region to page boundaries as per free_initrd_mem()
+	 * This allows us to detect whether the pages overlapping the initrd
+	 * are in use, but more importantly, reserves the entire set of pages
+	 * as we don't want these pages allocated for other purposes.
+	 */
+	start = round_down(phys_initrd_start, PAGE_SIZE);
+	size = phys_initrd_size + (phys_initrd_start - start);
+	size = round_up(size, PAGE_SIZE);
+
+	if (!memblock_is_region_memory(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx is not a memory region",
+		       (u64)start, size);
+		goto disable;
+	}
+
+	if (memblock_is_region_reserved(start, size)) {
+		pr_err("INITRD: 0x%08llx+0x%08lx overlaps in-use memory region\n",
+		       (u64)start, size);
+		goto disable;
+	}
+
+	memblock_reserve(start, size);
+	/* Now convert initrd to virtual addresses */
+	initrd_start = (unsigned long)__va(phys_initrd_start);
+	initrd_end = initrd_start + phys_initrd_size;
+	initrd_below_start_ok = 1;
+
+	return;
+disable:
+	pr_cont(" - disabling initrd\n");
+	initrd_start = 0;
+	initrd_end = 0;
+}
+
 void __weak __init free_initrd_mem(unsigned long start, unsigned long end)
 {
 #ifdef CONFIG_ARCH_KEEP_MEMBLOCK
-- 
2.17.1


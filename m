Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849E92F7262
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733187AbhAOFlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:41:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11018 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733144AbhAOFlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:41:32 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DH94309pJzj7Mx;
        Fri, 15 Jan 2021 13:39:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:40:43 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 4/4] riscv: Covert to reserve_initrd_mem()
Date:   Fri, 15 Jan 2021 13:46:06 +0800
Message-ID: <20210115054606.124502-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
References: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Covert to the generic reserve_initrd_mem() function.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/riscv/mm/init.c | 54 +-------------------------------------------
 1 file changed, 1 insertion(+), 53 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index bf5379135e39..1eaae54c8ea1 100644
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
@@ -186,10 +137,7 @@ void __init setup_bootmem(void)
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 	set_max_mapnr(max_low_pfn);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif /* CONFIG_BLK_DEV_INITRD */
-
+	reserve_initrd_mem();
 	/*
 	 * Avoid using early_init_fdt_reserve_self() since __pa() does
 	 * not work for DTB pointers that are fixmap addresses
-- 
2.26.2


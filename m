Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE02F7263
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 06:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733175AbhAOFlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 00:41:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11019 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733061AbhAOFlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 00:41:32 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DH9431tJJzj7ns;
        Fri, 15 Jan 2021 13:39:47 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.498.0; Fri, 15 Jan 2021 13:40:42 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        <palmerdabbelt@google.com>, Atish Patra <atish.patra@wdc.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>, <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/4] ARM: Covert to reserve_initrd_mem()
Date:   Fri, 15 Jan 2021 13:46:05 +0800
Message-ID: <20210115054606.124502-4-wangkefeng.wang@huawei.com>
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
 arch/arm/mm/init.c | 43 +------------------------------------------
 1 file changed, 1 insertion(+), 42 deletions(-)

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
 
-- 
2.26.2


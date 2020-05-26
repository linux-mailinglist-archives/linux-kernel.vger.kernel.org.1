Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF501C7725
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730778AbgEFQu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:50:56 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56659 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbgEFQsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:22 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwg1bgpz9v4kP;
        Wed,  6 May 2020 18:48:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id QntUCMKCfgIu; Wed,  6 May 2020 18:48:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwg0r5Wz9v4kF;
        Wed,  6 May 2020 18:48:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EF3288B7C5;
        Wed,  6 May 2020 18:48:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id aqzt6KIO-SF2; Wed,  6 May 2020 18:48:20 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D61C8B7C3;
        Wed,  6 May 2020 18:48:20 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 6A9A165911; Wed,  6 May 2020 16:48:20 +0000 (UTC)
Message-Id: <9dd7022f292466f02ad2003a4b9619c6a4b8922b.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 15/45] powerpc/mm: Allocate static page tables for fixmap
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate static page tables for the fixmap area. This allows
setting mappings through page tables before memblock is ready.
That's needed to use early_ioremap() early and to use standard
page mappings with fixmap.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/fixmap.h |  4 ++++
 arch/powerpc/kernel/setup_32.c    |  2 +-
 arch/powerpc/mm/pgtable_32.c      | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index 2ef155a3c821..ccbe2e83c950 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -86,6 +86,10 @@ enum fixed_addresses {
 #define __FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
 
+#define FIXMAP_ALIGNED_SIZE	(ALIGN(FIXADDR_TOP, PGDIR_SIZE) - \
+				 ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE))
+#define FIXMAP_PTE_SIZE	(FIXMAP_ALIGNED_SIZE / PGDIR_SIZE * PTE_TABLE_SIZE)
+
 #define FIXMAP_PAGE_NOCACHE PAGE_KERNEL_NCG
 #define FIXMAP_PAGE_IO	PAGE_KERNEL_NCG
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 305ca89d856f..fee167d2701f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -80,7 +80,7 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Configure static keys first, now that we're relocated. */
 	setup_feature_keys();
 
-	early_ioremap_setup();
+	early_ioremap_init();
 
 	/* Enable early debugging if any specified (see udbg.h) */
 	udbg_early_init();
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index f62de06e3d07..9934659cb871 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -29,11 +29,27 @@
 #include <asm/fixmap.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
+#include <asm/early_ioremap.h>
 
 #include <mm/mmu_decl.h>
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
+static u8 early_fixmap_pagetable[FIXMAP_PTE_SIZE] __page_aligned_data;
+
+notrace void __init early_ioremap_init(void)
+{
+	unsigned long addr = ALIGN_DOWN(FIXADDR_START, PGDIR_SIZE);
+	pte_t *ptep = (pte_t *)early_fixmap_pagetable;
+	pmd_t *pmdp = pmd_ptr_k(addr);
+
+	for (; (s32)(FIXADDR_TOP - addr) > 0;
+	     addr += PGDIR_SIZE, ptep += PTRS_PER_PTE, pmdp++)
+		pmd_populate_kernel(&init_mm, pmdp, ptep);
+
+	early_ioremap_setup();
+}
+
 static void __init *early_alloc_pgtable(unsigned long size)
 {
 	void *ptr = memblock_alloc(size, size);
-- 
2.25.0


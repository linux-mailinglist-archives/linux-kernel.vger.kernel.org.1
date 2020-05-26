Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985291D8F7B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 07:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgESFto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 01:49:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:58079 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728715AbgESFta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:49:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49R4hQ5z1nz9txm1;
        Tue, 19 May 2020 07:49:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 7ucAsrBkRbXA; Tue, 19 May 2020 07:49:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49R4hQ5Dftz9txlx;
        Tue, 19 May 2020 07:49:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BA0988B7A7;
        Tue, 19 May 2020 07:49:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id yuJcWXqz5tUh; Tue, 19 May 2020 07:49:27 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6CA098B767;
        Tue, 19 May 2020 07:49:27 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 48BB865A4A; Tue, 19 May 2020 05:49:27 +0000 (UTC)
Message-Id: <d2d60202a8821dc81cffe6ff59cc13c15b7e4bb6.1589866984.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1589866984.git.christophe.leroy@csgroup.eu>
References: <cover.1589866984.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 43/45] powerpc/8xx: Implement dedicated kasan_init_region()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 19 May 2020 05:49:27 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a kasan_init_region() dedicated to 8xx that
allocates KASAN regions using huge pages.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/kasan/8xx.c    | 74 ++++++++++++++++++++++++++++++++++
 arch/powerpc/mm/kasan/Makefile |  1 +
 2 files changed, 75 insertions(+)
 create mode 100644 arch/powerpc/mm/kasan/8xx.c

diff --git a/arch/powerpc/mm/kasan/8xx.c b/arch/powerpc/mm/kasan/8xx.c
new file mode 100644
index 000000000000..db4ef44af22f
--- /dev/null
+++ b/arch/powerpc/mm/kasan/8xx.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define DISABLE_BRANCH_PROFILING
+
+#include <linux/kasan.h>
+#include <linux/memblock.h>
+#include <linux/hugetlb.h>
+#include <asm/pgalloc.h>
+
+static int __init
+kasan_init_shadow_8M(unsigned long k_start, unsigned long k_end, void *block)
+{
+	pmd_t *pmd = pmd_ptr_k(k_start);
+	unsigned long k_cur, k_next;
+
+	for (k_cur = k_start; k_cur != k_end; k_cur = k_next, pmd += 2, block += SZ_8M) {
+		pte_basic_t *new;
+
+		k_next = pgd_addr_end(k_cur, k_end);
+		k_next = pgd_addr_end(k_next, k_end);
+		if ((void *)pmd_page_vaddr(*pmd) != kasan_early_shadow_pte)
+			continue;
+
+		new = memblock_alloc(sizeof(pte_basic_t), SZ_4K);
+		if (!new)
+			return -ENOMEM;
+
+		*new = pte_val(pte_mkhuge(pfn_pte(PHYS_PFN(__pa(block)), PAGE_KERNEL)));
+
+		hugepd_populate_kernel((hugepd_t *)pmd, (pte_t *)new, PAGE_SHIFT_8M);
+		hugepd_populate_kernel((hugepd_t *)pmd + 1, (pte_t *)new, PAGE_SHIFT_8M);
+	}
+	return 0;
+}
+
+int __init kasan_init_region(void *start, size_t size)
+{
+	unsigned long k_start = (unsigned long)kasan_mem_to_shadow(start);
+	unsigned long k_end = (unsigned long)kasan_mem_to_shadow(start + size);
+	unsigned long k_cur;
+	int ret;
+	void *block;
+
+	block = memblock_alloc(k_end - k_start, SZ_8M);
+	if (!block)
+		return -ENOMEM;
+
+	if (IS_ALIGNED(k_start, SZ_8M)) {
+		kasan_init_shadow_8M(k_start, ALIGN_DOWN(k_end, SZ_8M), block);
+		k_cur = ALIGN_DOWN(k_end, SZ_8M);
+		if (k_cur == k_end)
+			goto finish;
+	} else {
+		k_cur = k_start;
+	}
+
+	ret = kasan_init_shadow_page_tables(k_start, k_end);
+	if (ret)
+		return ret;
+
+	for (; k_cur < k_end; k_cur += PAGE_SIZE) {
+		pmd_t *pmd = pmd_ptr_k(k_cur);
+		void *va = block + k_cur - k_start;
+		pte_t pte = pfn_pte(PHYS_PFN(__pa(va)), PAGE_KERNEL);
+
+		if (k_cur < ALIGN_DOWN(k_end, SZ_512K))
+			pte = pte_mkhuge(pte);
+
+		__set_pte_at(&init_mm, k_cur, pte_offset_kernel(pmd, k_cur), pte, 0);
+	}
+finish:
+	flush_tlb_kernel_range(k_start, k_end);
+	return 0;
+}
diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index 6577897673dd..440038ea79f1 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -3,3 +3,4 @@
 KASAN_SANITIZE := n
 
 obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC_8xx)		+= 8xx.o
-- 
2.25.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78352F8BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbhAPGAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 01:00:16 -0500
Received: from exmail.andestech.com ([60.248.187.195]:38724 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbhAPGAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 01:00:14 -0500
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 10G5tmlX057678;
        Sat, 16 Jan 2021 13:55:48 +0800 (GMT-8)
        (envelope-from nylon7@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.120) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Sat, 16 Jan 2021
 13:58:44 +0800
From:   Nylon Chen <nylon7@andestech.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kasan-dev@googlegroups.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <aryabinin@virtuozzo.com>,
        <glider@google.com>, <dvyukov@google.com>, <nylon7717@gmail.com>,
        <alankao@andestech.com>, <nickhu@andestech.com>,
        "Nylon Chen" <nylon7@andestech.com>
Subject: [PATCH v2 1/1] riscv/kasan: add KASAN_VMALLOC support
Date:   Sat, 16 Jan 2021 13:58:35 +0800
Message-ID: <20210116055836.22366-2-nylon7@andestech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210116055836.22366-1-nylon7@andestech.com>
References: <20210116055836.22366-1-nylon7@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.15.120]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 10G5tmlX057678
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It references to x86/s390 architecture.

So, it doesn't map the early shadow page to cover VMALLOC space.

Prepopulate top level page table for the range that would otherwise be
empty.

lower levels are filled dynamically upon memory allocation while
booting.

Signed-off-by: Nylon Chen <nylon7@andestech.com>
Signed-off-by: Nick Hu <nickhu@andestech.com>
---
 arch/riscv/Kconfig         |  1 +
 arch/riscv/mm/kasan_init.c | 57 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 81b76d44725d..15a2c8088bbe 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -57,6 +57,7 @@ config RISCV
 	select HAVE_ARCH_JUMP_LABEL
 	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN if MMU && 64BIT
+	select HAVE_ARCH_KASAN_VMALLOC if MMU && 64BIT
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_KGDB_QXFER_PKT
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index 12ddd1f6bf70..4b9149f963d3 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -9,6 +9,19 @@
 #include <linux/pgtable.h>
 #include <asm/tlbflush.h>
 #include <asm/fixmap.h>
+#include <asm/pgalloc.h>
+
+static __init void *early_alloc(size_t size, int node)
+{
+	void *ptr = memblock_alloc_try_nid(size, size,
+		__pa(MAX_DMA_ADDRESS), MEMBLOCK_ALLOC_ACCESSIBLE, node);
+
+	if (!ptr)
+		panic("%pS: Failed to allocate %zu bytes align=%zx nid=%d from=%llx\n",
+			__func__, size, size, node, (u64)__pa(MAX_DMA_ADDRESS));
+
+	return ptr;
+}
 
 extern pgd_t early_pg_dir[PTRS_PER_PGD];
 asmlinkage void __init kasan_early_init(void)
@@ -83,6 +96,40 @@ static void __init populate(void *start, void *end)
 	memset(start, 0, end - start);
 }
 
+void __init kasan_shallow_populate(void *start, void *end)
+{
+	unsigned long vaddr = (unsigned long)start & PAGE_MASK;
+	unsigned long vend = PAGE_ALIGN((unsigned long)end);
+	unsigned long pfn;
+	int index;
+	void *p;
+	pud_t *pud_dir, *pud_k;
+	pgd_t *pgd_dir, *pgd_k;
+	p4d_t *p4d_dir, *p4d_k;
+
+	while (vaddr < vend) {
+		index = pgd_index(vaddr);
+		pfn = csr_read(CSR_SATP) & SATP_PPN;
+		pgd_dir = (pgd_t *)pfn_to_virt(pfn) + index;
+		pgd_k = init_mm.pgd + index;
+		pgd_dir = pgd_offset_k(vaddr);
+		set_pgd(pgd_dir, *pgd_k);
+
+		p4d_dir = p4d_offset(pgd_dir, vaddr);
+		p4d_k  = p4d_offset(pgd_k, vaddr);
+
+		vaddr = (vaddr + PUD_SIZE) & PUD_MASK;
+		pud_dir = pud_offset(p4d_dir, vaddr);
+		pud_k = pud_offset(p4d_k, vaddr);
+
+		if (pud_present(*pud_dir)) {
+			p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
+			pud_populate(&init_mm, pud_dir, p);
+		}
+		vaddr += PAGE_SIZE;
+	}
+}
+
 void __init kasan_init(void)
 {
 	phys_addr_t _start, _end;
@@ -90,7 +137,15 @@ void __init kasan_init(void)
 
 	kasan_populate_early_shadow((void *)KASAN_SHADOW_START,
 				    (void *)kasan_mem_to_shadow((void *)
-								VMALLOC_END));
+								VMEMMAP_END));
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		kasan_shallow_populate(
+			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
+			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
+	else
+		kasan_populate_early_shadow(
+			(void *)kasan_mem_to_shadow((void *)VMALLOC_START),
+			(void *)kasan_mem_to_shadow((void *)VMALLOC_END));
 
 	for_each_mem_range(i, &_start, &_end) {
 		void *start = (void *)_start;
-- 
2.17.1


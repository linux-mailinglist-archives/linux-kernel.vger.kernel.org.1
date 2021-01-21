Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA042FE463
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727676AbhAUHw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:52:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbhAUG6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:58:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D75DD23975;
        Thu, 21 Jan 2021 06:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212214;
        bh=oxrWdVN1jjUNfPNGVTpzLGl9h7s88l7H9ReGOAzQUS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kUNd8Qh3ffY2klERX+Q4uvPseISziF58s7BizswGoLg+eVrZTWOjQBPaaHbnr8Ba+
         gHNvONXO/2OFY2h705ImduKSwJtq5Fqw3otAqW1HX9AlMAqvLh+e7oOFXhhXaAcDAC
         Tsq7dAs1qZE4g5y+wdb/ejn6vTE0Qyjr2LGEbgP0wHxvddcZ/TGKkO1+cpl30eVDFr
         bM1lcLR3L0vmf2CWCFC8Xd/XfpUzx2SAggHTmTaT6/xuaAqTRAOKek3zJsHZgExjlb
         wIar4ZOqR3+51zndtL3WA6RB7/I7/zNNBPMBzpojc+O/c8Wm6LfcCbOOaILOGCA+fW
         Dmgo8hWyAJ+gg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 09/29] csky: Fixup PTE global for 2.5:1.5 virtual memory
Date:   Thu, 21 Jan 2021 14:53:29 +0800
Message-Id: <20210121065349.3188251-9-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Fixup commit c2d1adfa9a24 "csky: Add memory layout 2.5G(user):1.5G
(kernel)". That patch broke the global bit in PTE.

C-SKY TLB's entry contain two pages:
vpn, vpn + 1 -> ppn0, ppn1

All PPN's attributes contain global bit and final global is PPN0.G
& PPN1.G. So we must keep PPN0.G and PPN1.G same in one TLB's
entry.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/include/asm/pgtable.h | 2 +-
 arch/csky/mm/init.c             | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index 6ec97af0d1ff..2485db84dba8 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -34,7 +34,7 @@
 
 #define pmd_page(pmd)	(pfn_to_page(pmd_phys(pmd) >> PAGE_SHIFT))
 #define pte_clear(mm, addr, ptep)	set_pte((ptep), \
-	(((unsigned int) addr & PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
+	(((unsigned int) addr >= PAGE_OFFSET) ? __pte(_PAGE_GLOBAL) : __pte(0)))
 #define pte_none(pte)		(!(pte_val(pte) & ~_PAGE_GLOBAL))
 #define pte_present(pte)	(pte_val(pte) & _PAGE_PRESENT)
 #define pte_pfn(x)	((unsigned long)((x).pte_low >> PAGE_SHIFT))
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index 7742f1441a67..8170d7ce116b 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -30,9 +30,12 @@
 #include <asm/tlb.h>
 #include <asm/cacheflush.h>
 
+#define PTRS_KERN_TABLE \
+		((PTRS_PER_PGD - USER_PTRS_PER_PGD) * PTRS_PER_PTE)
+
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
 pte_t invalid_pte_table[PTRS_PER_PTE] __page_aligned_bss;
-pte_t kernel_pte_tables[(PTRS_PER_PGD - USER_PTRS_PER_PGD)*PTRS_PER_PTE] __page_aligned_bss;
+pte_t kernel_pte_tables[PTRS_KERN_TABLE] __page_aligned_bss;
 
 EXPORT_SYMBOL(invalid_pte_table);
 unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
@@ -149,6 +152,9 @@ void __init mmu_init(unsigned long min_pfn, unsigned long max_pfn)
 		swapper_pg_dir[i].pgd =
 			__pa(kernel_pte_tables + (PTRS_PER_PTE * (i - USER_PTRS_PER_PGD)));
 
+	for (i = 0; i < PTRS_KERN_TABLE; i++)
+		set_pte(&kernel_pte_tables[i], __pte(_PAGE_GLOBAL));
+
 	for (i = min_pfn; i < max_pfn; i++)
 		set_pte(&kernel_pte_tables[i - PFN_DOWN(va_pa_offset)], pfn_pte(i, PAGE_KERNEL));
 
-- 
2.17.1


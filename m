Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD62A96E9
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 14:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgKFNU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 08:20:58 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59558 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727410AbgKFNU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 08:20:58 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CSLcQ3lSGz9v15t;
        Fri,  6 Nov 2020 14:20:54 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5gvZkFtVHQcI; Fri,  6 Nov 2020 14:20:54 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CSLcQ2zYkz9v15c;
        Fri,  6 Nov 2020 14:20:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9DCD48B8BF;
        Fri,  6 Nov 2020 14:20:55 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id eTPlQqlIsTlD; Fri,  6 Nov 2020 14:20:55 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3FB808B8BD;
        Fri,  6 Nov 2020 14:20:55 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id F010F66868; Fri,  6 Nov 2020 13:20:54 +0000 (UTC)
Message-Id: <16a571bb32eb6e8cd44bda484c8d81cd8a25e6d7.1604668827.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: Refactor the floor/ceiling check in hugetlb range
 freeing functions
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  6 Nov 2020 13:20:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All hugetlb range freeing functions have a verification like the following,
which only differs by the mask used, depending on the page table level.

	start &= MASK;
	if (start < floor)
		return;
	if (ceiling) {
		ceiling &= MASK;
		if (! ceiling)
			return;
		}
	if (end - 1 > ceiling - 1)
		return;

Refactor that into a helper function which takes the mask as
an argument, returning true when [start;end[ is not fully
contained inside [floor;ceiling[

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/hugetlbpage.c | 56 ++++++++++++-----------------------
 1 file changed, 19 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 36c3800769fb..f8d8a4988e15 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -294,6 +294,21 @@ static void hugepd_free(struct mmu_gather *tlb, void *hugepte)
 static inline void hugepd_free(struct mmu_gather *tlb, void *hugepte) {}
 #endif
 
+/* Return true when the entry to be freed maps more than the area being freed */
+static bool range_is_outside_limits(unsigned long start, unsigned long end,
+				    unsigned long floor, unsigned long ceiling,
+				    unsigned long mask)
+{
+	if ((start & mask) < floor)
+		return true;
+	if (ceiling) {
+		ceiling &= mask;
+		if (!ceiling)
+			return true;
+	}
+	return end - 1 > ceiling - 1;
+}
+
 static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshift,
 			      unsigned long start, unsigned long end,
 			      unsigned long floor, unsigned long ceiling)
@@ -309,15 +324,7 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
 	if (shift > pdshift)
 		num_hugepd = 1 << (shift - pdshift);
 
-	start &= pdmask;
-	if (start < floor)
-		return;
-	if (ceiling) {
-		ceiling &= pdmask;
-		if (! ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	if (range_is_outside_limits(start, end, floor, ceiling, pdmask))
 		return;
 
 	for (i = 0; i < num_hugepd; i++, hpdp++)
@@ -334,18 +341,9 @@ static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
 				   unsigned long addr, unsigned long end,
 				   unsigned long floor, unsigned long ceiling)
 {
-	unsigned long start = addr;
 	pgtable_t token = pmd_pgtable(*pmd);
 
-	start &= PMD_MASK;
-	if (start < floor)
-		return;
-	if (ceiling) {
-		ceiling &= PMD_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	if (range_is_outside_limits(addr, end, floor, ceiling, PMD_MASK))
 		return;
 
 	pmd_clear(pmd);
@@ -395,15 +393,7 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 				  addr, next, floor, ceiling);
 	} while (addr = next, addr != end);
 
-	start &= PUD_MASK;
-	if (start < floor)
-		return;
-	if (ceiling) {
-		ceiling &= PUD_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	if (range_is_outside_limits(start, end, floor, ceiling, PUD_MASK))
 		return;
 
 	pmd = pmd_offset(pud, start);
@@ -446,15 +436,7 @@ static void hugetlb_free_pud_range(struct mmu_gather *tlb, p4d_t *p4d,
 		}
 	} while (addr = next, addr != end);
 
-	start &= PGDIR_MASK;
-	if (start < floor)
-		return;
-	if (ceiling) {
-		ceiling &= PGDIR_MASK;
-		if (!ceiling)
-			return;
-	}
-	if (end - 1 > ceiling - 1)
+	if (range_is_outside_limits(start, end, floor, ceiling, PGDIR_MASK))
 		return;
 
 	pud = pud_offset(p4d, start);
-- 
2.25.0


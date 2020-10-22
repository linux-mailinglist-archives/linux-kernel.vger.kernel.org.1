Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A4D295866
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508332AbgJVGa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:30:27 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:32167 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508262AbgJVG3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBn1z2yz9vBLM;
        Thu, 22 Oct 2020 08:29:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hnvLZHpE6EO9; Thu, 22 Oct 2020 08:29:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBn1DV2z9vBKl;
        Thu, 22 Oct 2020 08:29:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 23F3C8B805;
        Thu, 22 Oct 2020 08:29:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7mqMKWf9G1QJ; Thu, 22 Oct 2020 08:29:38 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CC22A8B769;
        Thu, 22 Oct 2020 08:29:37 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A4E8F667EF; Thu, 22 Oct 2020 06:29:37 +0000 (UTC)
Message-Id: <c7029a78e78709ad9272d7a44260e06b649169b2.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 12/20] powerpc/32s: Inline flush_tlb_range() and
 flush_tlb_kernel_range()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:37 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_tlb_range() and flush_tlb_kernel_range() are trivial calls to
flush_range().

Make flush_range() global and inline flush_tlb_range()
and flush_tlb_kernel_range().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 15 ++++++++--
 arch/powerpc/mm/book3s32/tlb.c                | 30 +++++--------------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index 542765944531..2f480d184526 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -8,9 +8,7 @@
  */
 void hash__flush_tlb_mm(struct mm_struct *mm);
 void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
-extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end);
-extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
+void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end);
 
 #ifdef CONFIG_SMP
 void _tlbie(unsigned long address);
@@ -38,6 +36,17 @@ static inline void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmad
 		_tlbie(vmaddr);
 }
 
+static inline void
+flush_tlb_range(struct vm_area_struct *vma, unsigned long start, unsigned long end)
+{
+	flush_range(vma->vm_mm, start, end);
+}
+
+static inline void flush_tlb_kernel_range(unsigned long start, unsigned long end)
+{
+	flush_range(&init_mm, start, end);
+}
+
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
 					unsigned long vmaddr)
 {
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index 65389bfe2eb8..f9b8e1ce4371 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -71,8 +71,12 @@ void tlb_flush(struct mmu_gather *tlb)
  *    -- Cort
  */
 
-static void flush_range(struct mm_struct *mm, unsigned long start,
-			unsigned long end)
+/*
+ * For each address in the range, find the pte for the address
+ * and check _PAGE_HASHPTE bit; if it is set, find and destroy
+ * the corresponding HPTE.
+ */
+void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	pmd_t *pmd;
 	unsigned long pmd_end;
@@ -105,15 +109,7 @@ static void flush_range(struct mm_struct *mm, unsigned long start,
 		++pmd;
 	}
 }
-
-/*
- * Flush kernel TLB entries in the given range
- */
-void flush_tlb_kernel_range(unsigned long start, unsigned long end)
-{
-	flush_range(&init_mm, start, end);
-}
-EXPORT_SYMBOL(flush_tlb_kernel_range);
+EXPORT_SYMBOL(flush_range);
 
 /*
  * Flush all the (user) entries for the address space described by mm.
@@ -145,18 +141,6 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr)
 }
 EXPORT_SYMBOL(hash__flush_tlb_page);
 
-/*
- * For each address in the range, find the pte for the address
- * and check _PAGE_HASHPTE bit; if it is set, find and destroy
- * the corresponding HPTE.
- */
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
-{
-	flush_range(vma->vm_mm, start, end);
-}
-EXPORT_SYMBOL(flush_tlb_range);
-
 void __init early_init_mmu(void)
 {
 }
-- 
2.25.0


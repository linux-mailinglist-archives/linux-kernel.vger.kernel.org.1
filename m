Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475CF29585D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503773AbgJVG3y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:54 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40555 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508275AbgJVG3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBr1mFrz9vCxg;
        Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id SW-tFubHQOup; Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBr10WQz9vBKl;
        Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 17EF38B806;
        Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WW8AyKCvhhi4; Thu, 22 Oct 2020 08:29:41 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D68E18B805;
        Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id BAC8F667EF; Thu, 22 Oct 2020 06:29:40 +0000 (UTC)
Message-Id: <9af895be7d4b404d40e749a2659552fd138e62c4.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 15/20] powerpc/32s: Inline flush_hash_entry()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:40 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

flush_hash_entry() is a simple function calling
flush_hash_pages() if it's a hash MMU or doing nothing otherwise.

Inline it.

And use it also in __ptep_test_and_clear_young().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 17 +++++++++++------
 arch/powerpc/include/asm/tlb.h               |  3 ---
 arch/powerpc/mm/book3s32/tlb.c               | 14 --------------
 3 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 36443cda8dcf..914c19959a84 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -238,8 +238,14 @@ extern void add_hash_page(unsigned context, unsigned long va,
 			  unsigned long pmdval);
 
 /* Flush an entry from the TLB/hash table */
-extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
-			     unsigned long address);
+static inline void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
+{
+	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
+		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
+
+		flush_hash_pages(mm->context.id, addr, ptephys, 1);
+	}
+}
 
 /*
  * PTE updates. This function is called whenever an existing
@@ -291,10 +297,9 @@ static inline int __ptep_test_and_clear_young(struct mm_struct *mm,
 {
 	unsigned long old;
 	old = pte_update(mm, addr, ptep, _PAGE_ACCESSED, 0, 0);
-	if (old & _PAGE_HASHPTE) {
-		unsigned long ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(mm->context.id, addr, ptephys, 1);
-	}
+	if (old & _PAGE_HASHPTE)
+		flush_hash_entry(mm, ptep, addr);
+
 	return (old & _PAGE_ACCESSED) != 0;
 }
 #define ptep_test_and_clear_young(__vma, __addr, __ptep) \
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index d97f061fecac..160422a439aa 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -40,9 +40,6 @@ extern void tlb_flush(struct mmu_gather *tlb);
 /* Get the generic bits... */
 #include <asm-generic/tlb.h>
 
-extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
-			     unsigned long address);
-
 static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 					  unsigned long address)
 {
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index e7865a3f0231..0d412953fe58 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -29,20 +29,6 @@
 
 #include <mm/mmu_decl.h>
 
-/*
- * Called when unmapping pages to flush entries from the TLB/hash table.
- */
-void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
-{
-	unsigned long ptephys;
-
-	if (mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
-		ptephys = __pa(ptep) & PAGE_MASK;
-		flush_hash_pages(mm->context.id, addr, ptephys, 1);
-	}
-}
-EXPORT_SYMBOL(flush_hash_entry);
-
 /*
  * TLB flushing:
  *
-- 
2.25.0


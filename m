Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7266929585B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895643AbgJVG3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30370 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508268AbgJVG3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBq1xGPz9vBLx;
        Thu, 22 Oct 2020 08:29:39 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id XXCtb1c81R8K; Thu, 22 Oct 2020 08:29:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBq1Bb4z9vBKl;
        Thu, 22 Oct 2020 08:29:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24E9F8B806;
        Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ve5BpVntV12p; Thu, 22 Oct 2020 08:29:40 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D63778B805;
        Thu, 22 Oct 2020 08:29:39 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id B20ED667EF; Thu, 22 Oct 2020 06:29:39 +0000 (UTC)
Message-Id: <ebc933d1c530a19ef3cf7983f6ae94814f6e92ac.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 14/20] powerpc/32s: Inline tlb_flush()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:39 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On book3s/32, tlb_flush() does nothing when the CPU has a hash table,
it calls _tlbia() otherwise.

Inline it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 11 +++++++++++
 arch/powerpc/mm/book3s32/tlb.c                | 15 ---------------
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index 42708c1719d6..d941c06d4f2e 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -20,6 +20,17 @@ static inline void _tlbie(unsigned long address)
 #endif
 void _tlbia(void);
 
+/*
+ * Called at the end of a mmu_gather operation to make sure the
+ * TLB flush is completely done.
+ */
+static inline void tlb_flush(struct mmu_gather *tlb)
+{
+	/* 603 needs to flush the whole TLB here since it doesn't use a hash table. */
+	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE))
+		_tlbia();
+}
+
 static inline void flush_range(struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	start &= PAGE_MASK;
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.c
index f0edbad5966c..e7865a3f0231 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -43,21 +43,6 @@ void flush_hash_entry(struct mm_struct *mm, pte_t *ptep, unsigned long addr)
 }
 EXPORT_SYMBOL(flush_hash_entry);
 
-/*
- * Called at the end of a mmu_gather operation to make sure the
- * TLB flush is completely done.
- */
-void tlb_flush(struct mmu_gather *tlb)
-{
-	if (!mmu_has_feature(MMU_FTR_HPTE_TABLE)) {
-		/*
-		 * 603 needs to flush the whole TLB here since
-		 * it doesn't use a hash table.
-		 */
-		_tlbia();
-	}
-}
-
 /*
  * TLB flushing:
  *
-- 
2.25.0


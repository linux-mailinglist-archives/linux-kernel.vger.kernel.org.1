Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF193295862
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 08:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895629AbgJVG3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 02:29:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42521 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508251AbgJVG3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 02:29:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CGyBk38CQz9vBKx;
        Thu, 22 Oct 2020 08:29:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Lly7IQ7jR6WI; Thu, 22 Oct 2020 08:29:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CGyBk2CWsz9vBKw;
        Thu, 22 Oct 2020 08:29:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B3E68B806;
        Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qhdYHAtasZ3q; Thu, 22 Oct 2020 08:29:35 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA4F28B769;
        Thu, 22 Oct 2020 08:29:34 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8F2AA667EF; Thu, 22 Oct 2020 06:29:34 +0000 (UTC)
Message-Id: <475136425541db5c7c8a0395d19d400525b251bc.1603348103.git.christophe.leroy@csgroup.eu>
In-Reply-To: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
References: <648e2448e938d52d0b5887445e018ca584edc06d.1603348103.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 09/20] powerpc/32s: Inline _tlbie() on non SMP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 22 Oct 2020 06:29:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On non SMP, _tlbie() is just a tlbie plus a sync instruction.

Make it static inline.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/32/tlbflush.h | 7 +++++++
 arch/powerpc/mm/book3s32/hash_low.S           | 7 ++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/tlbflush.h b/arch/powerpc/include/asm/book3s/32/tlbflush.h
index 3043e7af70aa..f392a619138d 100644
--- a/arch/powerpc/include/asm/book3s/32/tlbflush.h
+++ b/arch/powerpc/include/asm/book3s/32/tlbflush.h
@@ -12,7 +12,14 @@ extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			    unsigned long end);
 extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
 
+#ifdef CONFIG_SMP
 void _tlbie(unsigned long address);
+#else
+static inline void _tlbie(unsigned long address)
+{
+	asm volatile ("tlbie %0; sync" : : "r" (address) : "memory");
+}
+#endif
 void _tlbia(void);
 
 static inline void local_flush_tlb_page(struct vm_area_struct *vma,
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index b2c912e517b9..006e9a452bde 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -637,8 +637,8 @@ _ASM_NOKPROBE_SYMBOL(flush_hash_pages)
 /*
  * Flush an entry from the TLB
  */
-_GLOBAL(_tlbie)
 #ifdef CONFIG_SMP
+_GLOBAL(_tlbie)
 	lwz	r8,TASK_CPU(r2)
 	oris	r8,r8,11
 	mfmsr	r10
@@ -662,12 +662,9 @@ _GLOBAL(_tlbie)
 	stw	r0,0(r9)		/* clear mmu_hash_lock */
 	mtmsr	r10
 	isync
-#else /* CONFIG_SMP */
-	tlbie	r3
-	sync
-#endif /* CONFIG_SMP */
 	blr
 _ASM_NOKPROBE_SYMBOL(_tlbie)
+#endif /* CONFIG_SMP */
 
 /*
  * Flush the entire TLB. 603/603e only
-- 
2.25.0


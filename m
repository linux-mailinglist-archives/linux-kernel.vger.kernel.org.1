Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1BE2B4A53
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgKPQJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:09:34 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38293 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730962AbgKPQJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:09:34 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CZYtG2Bs9z9vDFh;
        Mon, 16 Nov 2020 17:09:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id yKPDwfMvW28n; Mon, 16 Nov 2020 17:09:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CZYtG0w6Qz9vDFf;
        Mon, 16 Nov 2020 17:09:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B852D8B7A5;
        Mon, 16 Nov 2020 17:09:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3MolZdsrsKwf; Mon, 16 Nov 2020 17:09:31 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5EDF28B7A3;
        Mon, 16 Nov 2020 17:09:31 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0A40766884; Mon, 16 Nov 2020 16:09:31 +0000 (UTC)
Message-Id: <8a4ffe4798e9ea32aaaccdf85e411bb1beed3500.1605542955.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/32s: Handle PROTFAULT in hash_page() also for
 CONFIG_PPC_KUAP
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 16 Nov 2020 16:09:31 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On hash 32 bits, handling minor protection faults like unsetting
dirty flag is heavy if done from the normal page_fault processing,
because it implies hash table software lookup for flushing the entry
and then a DSI is taken anyway to add the entry back.

When KUAP was implemented, as explained in commit a68c31fc01ef
("powerpc/32s: Implement Kernel Userspace Access Protection"),
protection faults has been diverted from hash_page() because
hash_page() was not able to identify a KUAP fault.

Implement KUAP verification in hash_page(), by clearing write
permission when the access is a kernel access and Ks is 1.
This works regardless of the address because kernel segments always
have Ks set to 0 while user segments have Ks set to 0 only
when kernel write to userspace is granted.

Then protection faults can be handled by hash_page() even for KUAP.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S |  8 --------
 arch/powerpc/mm/book3s32/hash_low.S  | 13 +++++++++++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index a0dda2a1f2df..a4b811044f97 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -294,11 +294,7 @@ BEGIN_MMU_FTR_SECTION
 	stw	r11, THR11(r10)
 	mfspr	r10, SPRN_DSISR
 	mfcr	r11
-#ifdef CONFIG_PPC_KUAP
-	andis.	r10, r10, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH | DSISR_PROTFAULT)@h
-#else
 	andis.	r10, r10, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH)@h
-#endif
 	mfspr	r10, SPRN_SPRG_THREAD
 	beq	hash_page_dsi
 .Lhash_page_dsi_cont:
@@ -323,11 +319,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 	EXCEPTION_PROLOG handle_dar_dsisr=1
 	get_and_save_dar_dsisr_on_stack	r4, r5, r11
 BEGIN_MMU_FTR_SECTION
-#ifdef CONFIG_PPC_KUAP
-	andis.	r0, r5, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH | DSISR_PROTFAULT)@h
-#else
 	andis.	r0, r5, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH)@h
-#endif
 	bne	handle_page_fault_tramp_2	/* if not, try to put a PTE */
 	rlwinm	r3, r5, 32 - 15, 21, 21		/* DSISR_STORE -> _PAGE_RW */
 	bl	hash_page
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index b2c912e517b9..9a56ba4f68f2 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -95,8 +95,6 @@ _GLOBAL(hash_page)
 #else
 	rlwimi	r8,r4,23,20,28		/* compute pte address */
 #endif
-	rlwinm	r0,r3,32-3,24,24	/* _PAGE_RW access -> _PAGE_DIRTY */
-	ori	r0,r0,_PAGE_ACCESSED|_PAGE_HASHPTE
 
 	/*
 	 * Update the linux PTE atomically.  We do the lwarx up-front
@@ -112,7 +110,18 @@ _GLOBAL(hash_page)
 #endif
 .Lretry:
 	lwarx	r6,0,r8			/* get linux-style pte, flag word */
+#ifdef CONFIG_PPC_KUAP
+	mfsrin	r5,r4
+	rlwinm	r0,r9,28,_PAGE_RW	/* MSR[PR] => _PAGE_RW */
+	rlwinm	r5,r5,12,_PAGE_RW	/* Ks => _PAGE_RW */
+	andc	r5,r5,r0		/* Ks & ~MSR[PR] */
+	andc	r5,r6,r5		/* Clear _PAGE_RW when Ks = 1 && MSR[PR] = 0 */
+	andc.	r5,r3,r5		/* check access & ~permission */
+#else
 	andc.	r5,r3,r6		/* check access & ~permission */
+#endif
+	rlwinm	r0,r3,32-3,24,24	/* _PAGE_RW access -> _PAGE_DIRTY */
+	ori	r0,r0,_PAGE_ACCESSED|_PAGE_HASHPTE
 #ifdef CONFIG_SMP
 	bne-	.Lhash_page_out		/* return if access not permitted */
 #else
-- 
2.25.0


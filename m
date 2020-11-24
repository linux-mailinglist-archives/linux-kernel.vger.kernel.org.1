Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28192C3172
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgKXTwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:52:03 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28242 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgKXTwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:52:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgZRL03Z3z9v0DR;
        Tue, 24 Nov 2020 20:51:58 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id H_VMhRiRcdnR; Tue, 24 Nov 2020 20:51:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgZRK5mC1z9v0DM;
        Tue, 24 Nov 2020 20:51:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BE2518B7B7;
        Tue, 24 Nov 2020 20:51:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PjDsj-tZCLnK; Tue, 24 Nov 2020 20:51:57 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7EEB58B7AF;
        Tue, 24 Nov 2020 20:51:57 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 566DA6688D; Tue, 24 Nov 2020 19:51:57 +0000 (UTC)
Message-Id: <f5bc21db7a33dab55924734e6060c2e9daed562e.1606247495.git.christophe.leroy@csgroup.eu>
In-Reply-To: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
References: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 3/3] powerpc/32s: Cleanup around PTE_FLAGS_OFFSET in
 hash_low.S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 19:51:57 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTE_FLAGS_OFFSET is defined in asm/page_32.h and used only
in hash_low.S

And PTE_FLAGS_OFFSET nullity depends on CONFIG_PTE_64BIT

Instead of tests like #if (PTE_FLAGS_OFFSET != 0), use
CONFIG_PTE_64BIT related code.

Also move the definition of PTE_FLAGS_OFFSET into hash_low.S
directly, that improves readability.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/page_32.h  |  6 ------
 arch/powerpc/mm/book3s32/hash_low.S | 23 +++++++++++++----------
 2 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index d64dfe3ac712..56f217606327 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -16,12 +16,6 @@
 #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
 #endif
 
-#ifdef CONFIG_PTE_64BIT
-#define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
-#else
-#define PTE_FLAGS_OFFSET	0
-#endif
-
 #if defined(CONFIG_PPC_256K_PAGES) || \
     (defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES))
 #define PTE_SHIFT	(PAGE_SHIFT - PTE_T_LOG2 - 2)	/* 1/4 of a page */
diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index 1366e8e4fc05..f559a931b9a8 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -26,6 +26,12 @@
 #include <asm/feature-fixups.h>
 #include <asm/code-patching-asm.h>
 
+#ifdef CONFIG_PTE_64BIT
+#define PTE_FLAGS_OFFSET	4	/* offset of PTE flags, in bytes */
+#else
+#define PTE_FLAGS_OFFSET	0
+#endif
+
 #ifdef CONFIG_SMP
 	.section .bss
 	.align	2
@@ -94,6 +100,11 @@ _GLOBAL(hash_page)
 	rlwimi	r8,r4,22,20,29		/* insert next 10 bits of address */
 #else
 	rlwimi	r8,r4,23,20,28		/* compute pte address */
+	/*
+	 * If PTE_64BIT is set, the low word is the flags word; use that
+	 * word for locking since it contains all the interesting bits.
+	 */
+	addi	r8,r8,PTE_FLAGS_OFFSET
 #endif
 
 	/*
@@ -101,13 +112,7 @@ _GLOBAL(hash_page)
 	 * because almost always, there won't be a permission violation
 	 * and there won't already be an HPTE, and thus we will have
 	 * to update the PTE to set _PAGE_HASHPTE.  -- paulus.
-	 *
-	 * If PTE_64BIT is set, the low word is the flags word; use that
-	 * word for locking since it contains all the interesting bits.
 	 */
-#if (PTE_FLAGS_OFFSET != 0)
-	addi	r8,r8,PTE_FLAGS_OFFSET
-#endif
 .Lretry:
 	lwarx	r6,0,r8			/* get linux-style pte, flag word */
 #ifdef CONFIG_PPC_KUAP
@@ -511,8 +516,9 @@ _GLOBAL(flush_hash_pages)
 	rlwimi	r5,r4,22,20,29
 #else
 	rlwimi	r5,r4,23,20,28
+	addi	r5,r5,PTE_FLAGS_OFFSET
 #endif
-1:	lwz	r0,PTE_FLAGS_OFFSET(r5)
+1:	lwz	r0,0(r5)
 	cmpwi	cr1,r6,1
 	andi.	r0,r0,_PAGE_HASHPTE
 	bne	2f
@@ -556,9 +562,6 @@ _GLOBAL(flush_hash_pages)
 	 * already clear, we're done (for this pte).  If not,
 	 * clear it (atomically) and proceed.  -- paulus.
 	 */
-#if (PTE_FLAGS_OFFSET != 0)
-	addi	r5,r5,PTE_FLAGS_OFFSET
-#endif
 33:	lwarx	r8,0,r5			/* fetch the pte flags word */
 	andi.	r0,r8,_PAGE_HASHPTE
 	beq	8f			/* done if HASHPTE is already clear */
-- 
2.25.0


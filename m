Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72A342918A2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbgJRRZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:25:29 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:36642 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgJRRZZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:25:25 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CDmxB401vz9vCyc;
        Sun, 18 Oct 2020 19:25:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id GN-qKgBtLpLm; Sun, 18 Oct 2020 19:25:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CDmxB36Cvz9ty3L;
        Sun, 18 Oct 2020 19:25:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 494D18B778;
        Sun, 18 Oct 2020 19:25:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id EpJiRDk3HG-l; Sun, 18 Oct 2020 19:25:22 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 034438B75E;
        Sun, 18 Oct 2020 19:25:22 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1A34466488; Sun, 18 Oct 2020 17:25:18 +0000 (UTC)
Message-Id: <c3e64da3d5d068c69a201e03bbae7da055761e5b.1603041883.git.christophe.leroy@csgroup.eu>
In-Reply-To: <822833ce3dc10634339818f7d1ab616edf63b0c6.1603041883.git.christophe.leroy@csgroup.eu>
References: <822833ce3dc10634339818f7d1ab616edf63b0c6.1603041883.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/2] powerpc/44x: Don't support 47x code and non 47x code
 at the same time
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 18 Oct 2020 17:25:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

440/460 variants and 470 variants are not compatible, no
need to make code supporting both and using MMU features.

Just use CONFIG_PPC_47x to decide what to build.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Move outside #ifdef CONFIG_PPC_47x a label "1:" used by 44x
---
 arch/powerpc/kernel/entry_32.S   | 11 +++--------
 arch/powerpc/mm/nohash/tlb_low.S | 29 +++++++----------------------
 2 files changed, 10 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 8cdc8bcde703..a425360deabb 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -439,15 +439,13 @@ syscall_exit_cont:
 	andis.	r10,r0,DBCR0_IDM@h
 	bnel-	load_dbcr0
 #endif
-#ifdef CONFIG_44x
-BEGIN_MMU_FTR_SECTION
+#ifdef CONFIG_PPC_47x
 	lis	r4,icache_44x_need_flush@ha
 	lwz	r5,icache_44x_need_flush@l(r4)
 	cmplwi	cr0,r5,0
 	bne-	2f
+#endif /* CONFIG_PPC_47x */
 1:
-END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_47x)
-#endif /* CONFIG_44x */
 BEGIN_FTR_SECTION
 	lwarx	r7,0,r1
 END_FTR_SECTION_IFSET(CPU_FTR_NEED_PAIRED_STWCX)
@@ -948,10 +946,7 @@ restore_kuap:
 
 	/* interrupts are hard-disabled at this point */
 restore:
-#ifdef CONFIG_44x
-BEGIN_MMU_FTR_SECTION
-	b	1f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
+#if defined(CONFIG_44x) && !defined(CONFIG_PPC_47x)
 	lis	r4,icache_44x_need_flush@ha
 	lwz	r5,icache_44x_need_flush@l(r4)
 	cmplwi	cr0,r5,0
diff --git a/arch/powerpc/mm/nohash/tlb_low.S b/arch/powerpc/mm/nohash/tlb_low.S
index eaeee402f96e..68797e072f55 100644
--- a/arch/powerpc/mm/nohash/tlb_low.S
+++ b/arch/powerpc/mm/nohash/tlb_low.S
@@ -92,36 +92,25 @@ _GLOBAL(__tlbil_va)
 	tlbsx.	r6,0,r3
 	bne	10f
 	sync
-BEGIN_MMU_FTR_SECTION
-	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
+#ifndef CONFIG_PPC_47x
 	/* On 440 There are only 64 TLB entries, so r3 < 64, which means bit
 	 * 22, is clear.  Since 22 is the V bit in the TLB_PAGEID, loading this
 	 * value will invalidate the TLB entry.
 	 */
 	tlbwe	r6,r6,PPC44x_TLB_PAGEID
-	isync
-10:	wrtee	r10
-	blr
-2:
-#ifdef CONFIG_PPC_47x
+#else
 	oris	r7,r6,0x8000	/* specify way explicitly */
 	clrrwi	r4,r3,12	/* get an EPN for the hashing with V = 0 */
 	ori	r4,r4,PPC47x_TLBE_SIZE
 	tlbwe   r4,r7,0		/* write it */
+#endif /* !CONFIG_PPC_47x */
 	isync
-	wrtee	r10
+10:	wrtee	r10
 	blr
-#else /* CONFIG_PPC_47x */
-1:	trap
-	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;
-#endif /* !CONFIG_PPC_47x */
 
 _GLOBAL(_tlbil_all)
 _GLOBAL(_tlbil_pid)
-BEGIN_MMU_FTR_SECTION
-	b	2f
-END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
+#ifndef CONFIG_PPC_47x
 	li	r3,0
 	sync
 
@@ -136,8 +125,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 
 	isync
 	blr
-2:
-#ifdef CONFIG_PPC_47x
+#else
 	/* 476 variant. There's not simple way to do this, hopefully we'll
 	 * try to limit the amount of such full invalidates
 	 */
@@ -179,11 +167,8 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_47x)
 	b	1b		/* Then loop */
 1:	isync			/* Sync shadows */
 	wrtee	r11
-#else /* CONFIG_PPC_47x */
-1:	trap
-	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0;
-#endif /* !CONFIG_PPC_47x */
 	blr
+#endif /* !CONFIG_PPC_47x */
 
 #ifdef CONFIG_PPC_47x
 
-- 
2.25.0


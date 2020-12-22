Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C96C92E0AA0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgLVN3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:29:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:10682 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgLVN3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:29:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D0cbr5hxYz9v1w6;
        Tue, 22 Dec 2020 14:28:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id UOAY9j8SVciD; Tue, 22 Dec 2020 14:28:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D0cbr4nBTz9v1w3;
        Tue, 22 Dec 2020 14:28:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 07B798B81B;
        Tue, 22 Dec 2020 14:28:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cwtUx0ecZJsd; Tue, 22 Dec 2020 14:28:25 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B71268B812;
        Tue, 22 Dec 2020 14:28:25 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 970E566969; Tue, 22 Dec 2020 13:28:25 +0000 (UTC)
Message-Id: <b28673e492bf7de73db8eb7aab8baa934b75bfdd.1608641533.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1608641532.git.christophe.leroy@csgroup.eu>
References: <cover.1608641532.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 03/15] powerpc/32s: Only build hash code when
 CONFIG_PPC_BOOK3S_604 is selected
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Dec 2020 13:28:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is now possible to only build book3s/32 kernel for
CPUs without hash table.

Opt out hash related code when CONFIG_PPC_BOOK3S_604 is not selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Rebased
---
 arch/powerpc/kernel/head_book3s_32.S | 12 ++++++++++++
 arch/powerpc/mm/book3s32/Makefile    |  4 +++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index fbc48a500846..f6355fcca86a 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -293,6 +293,7 @@ MachineCheck:
 	DO_KVM  0x300
 DataAccess:
 #ifdef CONFIG_VMAP_STACK
+#ifdef CONFIG_PPC_BOOK3S_604
 BEGIN_MMU_FTR_SECTION
 	mtspr	SPRN_SPRG_SCRATCH2,r10
 	mfspr	r10, SPRN_SPRG_THREAD
@@ -309,12 +310,14 @@ BEGIN_MMU_FTR_SECTION
 MMU_FTR_SECTION_ELSE
 	b	1f
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
 1:	EXCEPTION_PROLOG_0 handle_dar_dsisr=1
 	EXCEPTION_PROLOG_1
 	b	handle_page_fault_tramp_1
 #else	/* CONFIG_VMAP_STACK */
 	EXCEPTION_PROLOG handle_dar_dsisr=1
 	get_and_save_dar_dsisr_on_stack	r4, r5, r11
+#ifdef CONFIG_PPC_BOOK3S_604
 BEGIN_MMU_FTR_SECTION
 	andis.	r0, r5, (DSISR_BAD_FAULT_32S | DSISR_DABRMATCH)@h
 	bne	handle_page_fault_tramp_2	/* if not, try to put a PTE */
@@ -322,8 +325,11 @@ BEGIN_MMU_FTR_SECTION
 	bl	hash_page
 	b	handle_page_fault_tramp_1
 MMU_FTR_SECTION_ELSE
+#endif
 	b	handle_page_fault_tramp_2
+#ifdef CONFIG_PPC_BOOK3S_604
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
 #endif	/* CONFIG_VMAP_STACK */
 
 /* Instruction access exception. */
@@ -339,12 +345,14 @@ InstructionAccess:
 	mfspr	r11, SPRN_SRR1		/* check whether user or kernel */
 	stw	r11, SRR1(r10)
 	mfcr	r10
+#ifdef CONFIG_PPC_BOOK3S_604
 BEGIN_MMU_FTR_SECTION
 	andis.	r11, r11, SRR1_ISI_NOPT@h	/* no pte found? */
 	bne	hash_page_isi
 .Lhash_page_isi_cont:
 	mfspr	r11, SPRN_SRR1		/* check whether user or kernel */
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
 	andi.	r11, r11, MSR_PR
 
 	EXCEPTION_PROLOG_1
@@ -355,9 +363,11 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
 	beq	1f			/* if so, try to put a PTE */
 	li	r3,0			/* into the hash table */
 	mr	r4,r12			/* SRR0 is fault address */
+#ifdef CONFIG_PPC_BOOK3S_604
 BEGIN_MMU_FTR_SECTION
 	bl	hash_page
 END_MMU_FTR_SECTION_IFSET(MMU_FTR_HPTE_TABLE)
+#endif
 #endif	/* CONFIG_VMAP_STACK */
 1:	mr	r4,r12
 	andis.	r5,r9,DSISR_SRR1_MATCH_32S@h /* Filter relevant SRR1 bits */
@@ -690,6 +700,7 @@ handle_page_fault_tramp_2:
 	EXC_XFER_LITE(0x300, handle_page_fault)
 
 #ifdef CONFIG_VMAP_STACK
+#ifdef CONFIG_PPC_BOOK3S_604
 .macro save_regs_thread		thread
 	stw	r0, THR0(\thread)
 	stw	r3, THR3(\thread)
@@ -761,6 +772,7 @@ fast_hash_page_return:
 	mfspr	r11, SPRN_SPRG_SCRATCH1
 	mfspr	r10, SPRN_SPRG_SCRATCH0
 	rfi
+#endif /* CONFIG_PPC_BOOK3S_604 */
 
 stack_overflow:
 	vmap_stack_overflow_exception
diff --git a/arch/powerpc/mm/book3s32/Makefile b/arch/powerpc/mm/book3s32/Makefile
index 3f972db17761..446d9de88ce4 100644
--- a/arch/powerpc/mm/book3s32/Makefile
+++ b/arch/powerpc/mm/book3s32/Makefile
@@ -6,4 +6,6 @@ ifdef CONFIG_KASAN
 CFLAGS_mmu.o  		+= -DDISABLE_BRANCH_PROFILING
 endif
 
-obj-y += mmu.o hash_low.o mmu_context.o tlb.o nohash_low.o
+obj-y += mmu.o mmu_context.o
+obj-$(CONFIG_PPC_BOOK3S_603) += nohash_low.o
+obj-$(CONFIG_PPC_BOOK3S_604) += hash_low.o tlb.o
-- 
2.25.0


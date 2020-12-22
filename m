Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E6E2E0AA7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 14:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgLVNaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 08:30:08 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:4422 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727335AbgLVNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 08:30:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D0cc33qvfz9v15f;
        Tue, 22 Dec 2020 14:28:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id h7MDa2IEVZS2; Tue, 22 Dec 2020 14:28:35 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D0cc32szTz9v15c;
        Tue, 22 Dec 2020 14:28:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9574B8B812;
        Tue, 22 Dec 2020 14:28:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9MuO-i_JlkLZ; Tue, 22 Dec 2020 14:28:36 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 18ECA8B81B;
        Tue, 22 Dec 2020 14:28:36 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id E307066969; Tue, 22 Dec 2020 13:28:35 +0000 (UTC)
Message-Id: <d3067e4f2acbc6a1b74daa9b2604cd072ac4cd0f.1608641533.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1608641532.git.christophe.leroy@csgroup.eu>
References: <cover.1608641532.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 13/15] powerpc/32: Enable instruction translation at the
 same time as data translation
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 22 Dec 2020 13:28:35 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8xx, kernel text is pinned.
On book3s/32, kernel text is mapped by BATs.

Enable instruction translation at the same time as data translation, it
makes things simpler.

In syscall handler, MSR_RI can also be set at the same time because
srr0/srr1 are already saved and r1 is set properly.

Also update comment in power_save_ppc32_restore().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S     | 15 ++++++++-----
 arch/powerpc/kernel/head_6xx_8xx.h | 35 +++++++++++++++---------------
 arch/powerpc/kernel/idle_6xx.S     |  4 +---
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 9ef75efaff47..2c38106c2c93 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -213,12 +213,8 @@ transfer_to_handler_cont:
 3:
 	mflr	r9
 	tovirt_novmstack r2, r2 	/* set r2 to current */
-	tovirt_vmstack r9, r9
 	lwz	r11,0(r9)		/* virtual address of handler */
 	lwz	r9,4(r9)		/* where to go when done */
-#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
-	mtspr	SPRN_NRI, r0
-#endif
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
 	 * When tracing IRQ state (lockdep) we enable the MMU before we call
@@ -235,6 +231,11 @@ transfer_to_handler_cont:
 
 	/* MSR isn't changing, just transition directly */
 #endif
+#ifdef CONFIG_HAVE_ARCH_VMAP_STACK
+	mtctr	r11
+	mtlr	r9
+	bctr				/* jump to handler */
+#else
 	mtspr	SPRN_SRR0,r11
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
@@ -242,6 +243,7 @@ transfer_to_handler_cont:
 #ifdef CONFIG_40x
 	b .	/* Prevent prefetch past rfi */
 #endif
+#endif
 
 #if defined (CONFIG_PPC_BOOK3S_32) || defined(CONFIG_E500)
 4:	rlwinm	r12,r12,0,~_TLF_NAPPING
@@ -261,7 +263,9 @@ _ASM_NOKPROBE_SYMBOL(transfer_to_handler)
 _ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-1:	/* MSR is changing, re-enable MMU so we can notify lockdep. We need to
+1:
+#ifndef CONFIG_HAVE_ARCH_VMAP_STACK
+	/* MSR is changing, re-enable MMU so we can notify lockdep. We need to
 	 * keep interrupts disabled at this point otherwise we might risk
 	 * taking an interrupt before we tell lockdep they are enabled.
 	 */
@@ -276,6 +280,7 @@ _ASM_NOKPROBE_SYMBOL(transfer_to_handler_cont)
 #endif
 
 reenable_mmu:
+#endif
 	/*
 	 * We save a bunch of GPRs,
 	 * r3 can be different from GPR3(r1) at this point, r9 and r11
diff --git a/arch/powerpc/kernel/head_6xx_8xx.h b/arch/powerpc/kernel/head_6xx_8xx.h
index 11b608b6f4b7..bedbf37c2a0c 100644
--- a/arch/powerpc/kernel/head_6xx_8xx.h
+++ b/arch/powerpc/kernel/head_6xx_8xx.h
@@ -49,10 +49,14 @@
 .endm
 
 .macro EXCEPTION_PROLOG_2 handle_dar_dsisr=0
-	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
-	mtmsr	r11
-	isync
+	li	r11, MSR_KERNEL & ~MSR_RI /* re-enable MMU */
+	mtspr	SPRN_SRR1, r11
+	lis	r11, 1f@h
+	ori	r11, r11, 1f@l
+	mtspr	SPRN_SRR0, r11
 	mfspr	r11, SPRN_SPRG_SCRATCH2
+	rfi
+1:
 	stw	r11,GPR1(r1)
 	stw	r11,0(r1)
 	mr	r11, r1
@@ -75,7 +79,7 @@
 	.endif
 	lwz	r9, SRR1(r12)
 	lwz	r12, SRR0(r12)
-	li	r10, MSR_KERNEL & ~MSR_IR /* can take exceptions */
+	li	r10, MSR_KERNEL		/* can take exceptions */
 	mtmsr	r10			/* (except for mach check in rtas) */
 	stw	r0,GPR0(r11)
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
@@ -95,9 +99,13 @@
 	lwz	r1,TASK_STACK-THREAD(r12)
 	beq-	99f
 	addi	r1, r1, THREAD_SIZE - INT_FRAME_SIZE
-	li	r10, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
-	mtmsr	r10
-	isync
+	li	r10, MSR_KERNEL		/* can take exceptions */
+	mtspr	SPRN_SRR1, r10
+	lis	r10, 1f@h
+	ori	r10, r10, 1f@l
+	mtspr	SPRN_SRR0, r10
+	rfi
+1:
 	tovirt(r12, r12)
 	stw	r11,GPR1(r1)
 	stw	r11,0(r1)
@@ -108,8 +116,6 @@
 	mfcr	r10
 	rlwinm	r10,r10,0,4,2	/* Clear SO bit in CR */
 	stw	r10,_CCR(r1)		/* save registers */
-	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL & ~MSR_IR) /* can take exceptions */
-	mtmsr	r10			/* (except for mach check in rtas) */
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
 	stw	r2,GPR2(r1)
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l
@@ -126,8 +132,6 @@
 	ACCOUNT_CPU_USER_ENTRY(r2, r11, r12)
 
 3:
-	lis	r11, transfer_to_syscall@h
-	ori	r11, r11, transfer_to_syscall@l
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
 	 * If MSR is changing we need to keep interrupts disabled at this point
@@ -139,12 +143,8 @@
 #else
 	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL | MSR_EE)
 #endif
-#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
-	mtspr	SPRN_NRI, r0
-#endif
-	mtspr	SPRN_SRR1,r10
-	mtspr	SPRN_SRR0,r11
-	rfi				/* jump to handler, enable MMU */
+	mtmsr	r10
+	b	transfer_to_syscall		/* jump to handler */
 99:	b	ret_from_kernel_syscall
 .endm
 
@@ -197,7 +197,6 @@
 #define EXC_XFER_TEMPLATE(hdlr, trap, tfer, ret)		\
 	li	r10,trap;					\
 	stw	r10,_TRAP(r11);					\
-	LOAD_REG_IMMEDIATE(r10, MSR_KERNEL);			\
 	bl	tfer;						\
 	.long	hdlr;						\
 	.long	ret
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index c15f91e00d36..153366e178c4 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -145,9 +145,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 
 /*
  * Return from NAP/DOZE mode, restore some CPU specific registers,
- * we are called with DR/IR still off and r2 containing physical
- * address of current.  R11 points to the exception frame (physical
- * address).  We have to preserve r10.
+ * R11 points to the exception frame. We have to preserve r10.
  */
 _GLOBAL(power_save_ppc32_restore)
 	lwz	r9,_LINK(r11)		/* interrupted in ppc6xx_idle: */
-- 
2.25.0


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472AC3036D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389209AbhAZGuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:50:06 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:28636 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729807AbhAYOvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:51:12 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmN0VQ7z9v0H3;
        Mon, 25 Jan 2021 15:48:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id hy79YT4UEz6t; Mon, 25 Jan 2021 15:48:19 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmM6BnJz9v0Gh;
        Mon, 25 Jan 2021 15:48:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 634BA8B79E;
        Mon, 25 Jan 2021 15:48:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id XU2mawkGT9Wt; Mon, 25 Jan 2021 15:48:25 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 451948B79B;
        Mon, 25 Jan 2021 15:48:25 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 3439466AD8; Mon, 25 Jan 2021 14:48:25 +0000 (UTC)
Message-Id: <83673797466c59fbbfe85dbd85436af6afc5eb63.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 12/23] powerpc/syscall: Make syscall.c buildable on PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:25 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ifdef out specific PPC64 stuff to allow building
syscall.c on PPC32.

Modify Makefile to always build syscall.o

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/Makefile  | 4 ++--
 arch/powerpc/kernel/syscall.c | 9 +++++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1cbc51fc82fd..23c127db0d0c 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -46,10 +46,10 @@ obj-y				:= cputable.o syscalls.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
 				   of_platform.o prom_parse.o firmware.o \
-				   hw_breakpoint_constraints.o
+				   hw_breakpoint_constraints.o syscall.o
 obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o \
-				   paca.o nvram_64.o note.o syscall.o
+				   paca.o nvram_64.o note.o
 obj-$(CONFIG_COMPAT)		+= sys_ppc32.o signal_32.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index b627a6384029..bf9bf4b5bc41 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -39,7 +39,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
-	BUG_ON(regs->softe != IRQS_ENABLED);
+	BUG_ON(arch_irq_disabled_regs(regs));
 
 #ifdef CONFIG_PPC_PKEY
 	if (mmu_has_feature(MMU_FTR_PKEY)) {
@@ -77,7 +77,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	 * frame, or if the unwinder was taught the first stack frame always
 	 * returns to user with IRQS_ENABLED, this store could be avoided!
 	 */
-	regs->softe = IRQS_ENABLED;
+	irq_soft_mask_regs_set_state(regs, IRQS_ENABLED);
 
 	local_irq_enable();
 
@@ -147,6 +147,7 @@ static notrace inline bool prep_irq_for_enabled_exit(bool clear_ri)
 		__hard_EE_RI_disable();
 	else
 		__hard_irq_disable();
+#ifdef CONFIG_PPC64
 	if (unlikely(lazy_irq_pending_nocheck())) {
 		/* Took an interrupt, may have more exit work to do. */
 		if (clear_ri)
@@ -158,7 +159,7 @@ static notrace inline bool prep_irq_for_enabled_exit(bool clear_ri)
 	}
 	local_paca->irq_happened = 0;
 	irq_soft_mask_set(IRQS_ENABLED);
-
+#endif
 	return true;
 }
 
@@ -281,7 +282,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	return ret;
 }
 
-#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
+#ifdef CONFIG_PPC_BOOK3S_64 /* BOOK3E not yet using this */
 notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long msr)
 {
 #ifdef CONFIG_PPC_BOOK3E
-- 
2.25.0


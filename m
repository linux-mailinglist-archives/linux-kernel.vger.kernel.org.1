Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6449B19FCEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgDFSRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 14:17:13 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:2147 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727125AbgDFSQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:47 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzJY70q5z9v01L;
        Mon,  6 Apr 2020 20:16:45 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=qSNKqBDi; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wgh4TypN8Led; Mon,  6 Apr 2020 20:16:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzJY5rVWz9v016;
        Mon,  6 Apr 2020 20:16:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197005; bh=AJ+tv3kuOpeLkdCTFp4bjAsOe2+DSaoetbR6kIu0H5E=;
        h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
        b=qSNKqBDiTNZlxeAlbUeWfiUTdTnBeiHDGU1q7Ayx+yK1j1SyR2lR/HEX+toDW5X8p
         +FkwUmqJdHTkcjsnn7Z++cunPfZiDgjetcp3BMEoUbmXpe+BJvh8tk+uhMpnU1mWbX
         Q8/zGIRr9ZadH78KTP9fxLhV7sqepwNeyRvNJTnQ=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BC9508B784;
        Mon,  6 Apr 2020 20:16:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8bpWA5C7YzDS; Mon,  6 Apr 2020 20:16:45 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7F3DB8B775;
        Mon,  6 Apr 2020 20:16:45 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 56522656E9; Mon,  6 Apr 2020 18:16:45 +0000 (UTC)
Message-Id: <e30f5786ab17a5c1c2798abb33f43b27c49b3b35.1586196948.git.christophe.leroy@c-s.fr>
In-Reply-To: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
References: <5aeaa33383e833f6eca30893fbd188b88e019eaa.1586196948.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v3 09/15] powerpc/syscall: Make syscall_64.c buildable on
 PPC32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon,  6 Apr 2020 18:16:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ifdef out specific PPC64 stuff to allow building
syscall_64.c on PPC32.

Modify Makefile to always build syscall.o

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/Makefile  | 5 ++---
 arch/powerpc/kernel/syscall.c | 9 +++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 8cc3c831dccd..e4be425b7718 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -45,11 +45,10 @@ obj-y				:= cputable.o syscalls.o \
 				   signal.o sysfs.o cacheinfo.o time.o \
 				   prom.o traps.o setup-common.o \
 				   udbg.o misc.o io.o misc_$(BITS).o \
-				   of_platform.o prom_parse.o
+				   of_platform.o prom_parse.o syscall.o
 obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o signal_64.o \
-				   paca.o nvram_64.o firmware.o note.o \
-				   syscall.o
+				   paca.o nvram_64.o firmware.o note.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
index 4c46f3aefaf8..98c98ce12f7d 100644
--- a/arch/powerpc/kernel/syscall.c
+++ b/arch/powerpc/kernel/syscall.c
@@ -34,7 +34,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 		BUG_ON(!(regs->msr & MSR_RI));
 	BUG_ON(!(regs->msr & MSR_PR));
 	BUG_ON(!FULL_REGS(regs));
-	BUG_ON(regs->softe != IRQS_ENABLED);
+	BUG_ON(IS_ENABLED(CONFIG_PPC64) && get_softe(regs) != IRQS_ENABLED);
 
 	account_cpu_user_entry();
 
@@ -56,7 +56,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 	 * frame, or if the unwinder was taught the first stack frame always
 	 * returns to user with IRQS_ENABLED, this store could be avoided!
 	 */
-	regs->softe = IRQS_ENABLED;
+	set_softe(regs, IRQS_ENABLED);
 
 	local_irq_enable();
 
@@ -114,6 +114,7 @@ static notrace inline bool prep_irq_for_enabled_exit(void)
 
 	/* This pattern matches prep_irq_for_idle */
 	__hard_EE_RI_disable();
+#ifdef CONFIG_PPC64
 	if (unlikely(lazy_irq_pending())) {
 		/* Took an interrupt, may have more exit work to do. */
 		__hard_RI_enable();
@@ -124,7 +125,7 @@ static notrace inline bool prep_irq_for_enabled_exit(void)
 	}
 	local_paca->irq_happened = 0;
 	irq_soft_mask_set(IRQS_ENABLED);
-
+#endif
 	return true;
 }
 
@@ -227,7 +228,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 	return ret;
 }
 
-#ifdef CONFIG_PPC_BOOK3S /* BOOK3E not yet using this */
+#ifdef CONFIG_PPC_BOOK3S_64 /* BOOK3E not yet using this */
 notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned long msr)
 {
 #ifdef CONFIG_PPC_BOOK3E
-- 
2.25.0


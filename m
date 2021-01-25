Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371AA30269E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbhAYOxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:53:01 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13046 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbhAYOup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:50:45 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmD6kwDz9v0Gt;
        Mon, 25 Jan 2021 15:48:12 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id BIT-ayrxheUd; Mon, 25 Jan 2021 15:48:12 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmD5tfnz9v0Gh;
        Mon, 25 Jan 2021 15:48:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EF3D8B79E;
        Mon, 25 Jan 2021 15:48:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZzVE4RS9--hq; Mon, 25 Jan 2021 15:48:18 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FFC98B79B;
        Mon, 25 Jan 2021 15:48:18 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 0566766AD8; Mon, 25 Jan 2021 14:48:17 +0000 (UTC)
Message-Id: <0f0efde4b821684f848a644c9b8eb3cf39852382.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 05/23] powerpc/64s: Make kuap_check_amr() and
 kuap_get_and_check_amr() generic
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation of porting powerpc32 to C syscall entry/exit,
rename kuap_check_amr() and kuap_get_and_check_amr() as kuap_check()
and kuap_get_and_check(), and move in the generic asm/kup.h the stub
for when CONFIG_PPC_KUAP is not selected.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/kup.h | 24 ++----------------------
 arch/powerpc/include/asm/kup.h           |  9 ++++++++-
 arch/powerpc/kernel/syscall_64.c         | 12 ++++++------
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index f50f72e535aa..1507681ad4ef 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -281,7 +281,7 @@ static inline void kuap_kernel_restore(struct pt_regs *regs,
 	 */
 }
 
-static inline unsigned long kuap_get_and_check_amr(void)
+static inline unsigned long kuap_get_and_check(void)
 {
 	if (mmu_has_feature(MMU_FTR_BOOK3S_KUAP)) {
 		unsigned long amr = mfspr(SPRN_AMR);
@@ -292,27 +292,7 @@ static inline unsigned long kuap_get_and_check_amr(void)
 	return 0;
 }
 
-#else /* CONFIG_PPC_PKEY */
-
-static inline void kuap_user_restore(struct pt_regs *regs)
-{
-}
-
-static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr)
-{
-}
-
-static inline unsigned long kuap_get_and_check_amr(void)
-{
-	return 0;
-}
-
-#endif /* CONFIG_PPC_PKEY */
-
-
-#ifdef CONFIG_PPC_KUAP
-
-static inline void kuap_check_amr(void)
+static inline void kuap_check(void)
 {
 	if (IS_ENABLED(CONFIG_PPC_KUAP_DEBUG) && mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		WARN_ON_ONCE(mfspr(SPRN_AMR) != AMR_KUAP_BLOCKED);
diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index bf221a2a523e..6ef9f9cfbed0 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -66,7 +66,14 @@ bad_kuap_fault(struct pt_regs *regs, unsigned long address, bool is_write)
 	return false;
 }
 
-static inline void kuap_check_amr(void) { }
+static inline void kuap_check(void) { }
+static inline void kuap_user_restore(struct pt_regs *regs) { }
+static inline void kuap_kernel_restore(struct pt_regs *regs, unsigned long amr) { }
+
+static inline unsigned long kuap_get_and_check(void)
+{
+	return 0;
+}
 
 /*
  * book3s/64/kup-radix.h defines these functions for the !KUAP case to flush
diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall_64.c
index 32f72965da26..b627a6384029 100644
--- a/arch/powerpc/kernel/syscall_64.c
+++ b/arch/powerpc/kernel/syscall_64.c
@@ -65,7 +65,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 			isync();
 	} else
 #endif
-		kuap_check_amr();
+		kuap_check();
 
 	account_cpu_user_entry();
 
@@ -181,7 +181,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
 
 	CT_WARN_ON(ct_state() == CONTEXT_USER);
 
-	kuap_check_amr();
+	kuap_check();
 
 	regs->result = r3;
 
@@ -303,7 +303,7 @@ notrace unsigned long interrupt_exit_user_prepare(struct pt_regs *regs, unsigned
 	 * We don't need to restore AMR on the way back to userspace for KUAP.
 	 * AMR can only have been unlocked if we interrupted the kernel.
 	 */
-	kuap_check_amr();
+	kuap_check();
 
 	local_irq_save(flags);
 
@@ -381,7 +381,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	unsigned long *ti_flagsp = &current_thread_info()->flags;
 	unsigned long flags;
 	unsigned long ret = 0;
-	unsigned long amr;
+	unsigned long kuap;
 
 	if (IS_ENABLED(CONFIG_PPC_BOOK3S) && unlikely(!(regs->msr & MSR_RI)))
 		unrecoverable_exception(regs);
@@ -394,7 +394,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	if (TRAP(regs) != 0x700)
 		CT_WARN_ON(ct_state() == CONTEXT_USER);
 
-	amr = kuap_get_and_check_amr();
+	kuap = kuap_get_and_check();
 
 	if (unlikely(*ti_flagsp & _TIF_EMULATE_STACK_STORE)) {
 		clear_bits(_TIF_EMULATE_STACK_STORE, ti_flagsp);
@@ -446,7 +446,7 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs, unsign
 	 * which would cause Read-After-Write stalls. Hence, we take the AMR
 	 * value from the check above.
 	 */
-	kuap_kernel_restore(regs, amr);
+	kuap_kernel_restore(regs, kuap);
 
 	return ret;
 }
-- 
2.25.0


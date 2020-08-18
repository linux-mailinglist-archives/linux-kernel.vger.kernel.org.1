Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46F6D248CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728770AbgHRRUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:20:51 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:12860 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgHRRTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhX1f0Rz9vCxq;
        Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Via-cmWfXFM3; Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhX0vktz9vCxg;
        Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 04CC78B7EE;
        Tue, 18 Aug 2020 19:19:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Qxy1JUxrmRRV; Tue, 18 Aug 2020 19:19:25 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B79008B7D7;
        Tue, 18 Aug 2020 19:19:25 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 977C565CF4; Tue, 18 Aug 2020 17:19:25 +0000 (UTC)
Message-Id: <dbce67900bf566bcf40179467bf1eb500814c405.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 13/25] powerpc/signal32: Move handle_signal32() close to
 handle_rt_signal32()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:25 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those two functions are similar and serving the same purpose.
To ease refactorisation, move them close to each other.

This is pure move, no code change, no cosmetic. Yes, checkpatch is
not happy, most will clear later.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal_32.c | 170 ++++++++++++++++----------------
 1 file changed, 85 insertions(+), 85 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 44a46911ff98..2cc686b9f566 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -836,6 +836,91 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	return 1;
 }
 
+/*
+ * OK, we're invoking a handler
+ */
+int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
+		struct task_struct *tsk)
+{
+	struct sigcontext __user *sc;
+	struct sigframe __user *frame;
+	struct mcontext __user *tm_mctx = NULL;
+	unsigned long newsp = 0;
+	int sigret;
+	unsigned long tramp;
+	struct pt_regs *regs = tsk->thread.regs;
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	/* Save the thread's msr before get_tm_stackpointer() changes it */
+	unsigned long msr = regs->msr;
+#endif
+
+	/* Set up Signal Frame */
+	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
+	if (!access_ok(frame, sizeof(*frame)))
+		goto badframe;
+	sc = (struct sigcontext __user *) &frame->sctx;
+
+#if _NSIG != 64
+#error "Please adjust handle_signal()"
+#endif
+	if (__put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler)
+	    || __put_user(oldset->sig[0], &sc->oldmask)
+#ifdef CONFIG_PPC64
+	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
+#else
+	    || __put_user(oldset->sig[1], &sc->_unused[3])
+#endif
+	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
+	    || __put_user(ksig->sig, &sc->signal))
+		goto badframe;
+
+	if (vdso32_sigtramp && tsk->mm->context.vdso_base) {
+		sigret = 0;
+		tramp = tsk->mm->context.vdso_base + vdso32_sigtramp;
+	} else {
+		sigret = __NR_sigreturn;
+		tramp = (unsigned long) frame->mctx.tramp;
+	}
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	tm_mctx = &frame->mctx_transact;
+	if (MSR_TM_ACTIVE(msr)) {
+		if (save_tm_user_regs(regs, &frame->mctx, &frame->mctx_transact,
+				      sigret, msr))
+			goto badframe;
+	}
+	else
+#endif
+	{
+		if (save_user_regs(regs, &frame->mctx, tm_mctx, sigret, 1))
+			goto badframe;
+	}
+
+	regs->link = tramp;
+
+#ifdef CONFIG_PPC_FPU_REGS
+	tsk->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
+#endif
+
+	/* create a stack frame for the caller of the handler */
+	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
+	if (put_user(regs->gpr[1], (u32 __user *)newsp))
+		goto badframe;
+
+	regs->gpr[1] = newsp;
+	regs->gpr[3] = ksig->sig;
+	regs->gpr[4] = (unsigned long) sc;
+	regs->nip = (unsigned long) (unsigned long)ksig->ka.sa.sa_handler;
+	/* enter the signal handler in big-endian mode */
+	regs->msr &= ~MSR_LE;
+	return 0;
+
+badframe:
+	signal_fault(tsk, regs, "handle_signal32", frame);
+
+	return 1;
+}
+
 static int do_setcontext(struct ucontext __user *ucp, struct pt_regs *regs, int sig)
 {
 	sigset_t set;
@@ -1188,91 +1273,6 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
 }
 #endif
 
-/*
- * OK, we're invoking a handler
- */
-int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
-		struct task_struct *tsk)
-{
-	struct sigcontext __user *sc;
-	struct sigframe __user *frame;
-	struct mcontext __user *tm_mctx = NULL;
-	unsigned long newsp = 0;
-	int sigret;
-	unsigned long tramp;
-	struct pt_regs *regs = tsk->thread.regs;
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	/* Save the thread's msr before get_tm_stackpointer() changes it */
-	unsigned long msr = regs->msr;
-#endif
-
-	/* Set up Signal Frame */
-	frame = get_sigframe(ksig, tsk, sizeof(*frame), 1);
-	if (!access_ok(frame, sizeof(*frame)))
-		goto badframe;
-	sc = (struct sigcontext __user *) &frame->sctx;
-
-#if _NSIG != 64
-#error "Please adjust handle_signal()"
-#endif
-	if (__put_user(to_user_ptr(ksig->ka.sa.sa_handler), &sc->handler)
-	    || __put_user(oldset->sig[0], &sc->oldmask)
-#ifdef CONFIG_PPC64
-	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
-#else
-	    || __put_user(oldset->sig[1], &sc->_unused[3])
-#endif
-	    || __put_user(to_user_ptr(&frame->mctx), &sc->regs)
-	    || __put_user(ksig->sig, &sc->signal))
-		goto badframe;
-
-	if (vdso32_sigtramp && tsk->mm->context.vdso_base) {
-		sigret = 0;
-		tramp = tsk->mm->context.vdso_base + vdso32_sigtramp;
-	} else {
-		sigret = __NR_sigreturn;
-		tramp = (unsigned long) frame->mctx.tramp;
-	}
-
-#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-	tm_mctx = &frame->mctx_transact;
-	if (MSR_TM_ACTIVE(msr)) {
-		if (save_tm_user_regs(regs, &frame->mctx, &frame->mctx_transact,
-				      sigret, msr))
-			goto badframe;
-	}
-	else
-#endif
-	{
-		if (save_user_regs(regs, &frame->mctx, tm_mctx, sigret, 1))
-			goto badframe;
-	}
-
-	regs->link = tramp;
-
-#ifdef CONFIG_PPC_FPU_REGS
-	tsk->thread.fp_state.fpscr = 0;	/* turn off all fp exceptions */
-#endif
-
-	/* create a stack frame for the caller of the handler */
-	newsp = ((unsigned long)frame) - __SIGNAL_FRAMESIZE;
-	if (put_user(regs->gpr[1], (u32 __user *)newsp))
-		goto badframe;
-
-	regs->gpr[1] = newsp;
-	regs->gpr[3] = ksig->sig;
-	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) (unsigned long)ksig->ka.sa.sa_handler;
-	/* enter the signal handler in big-endian mode */
-	regs->msr &= ~MSR_LE;
-	return 0;
-
-badframe:
-	signal_fault(tsk, regs, "handle_signal32", frame);
-
-	return 1;
-}
-
 /*
  * Do a signal return; undo the signal stack.
  */
-- 
2.25.0


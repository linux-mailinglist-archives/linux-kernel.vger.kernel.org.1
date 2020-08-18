Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6BA248CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 19:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgHRRVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 13:21:08 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11306 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgHRRT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:19:27 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BWHhV2Vpmz9vCxn;
        Tue, 18 Aug 2020 19:19:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1IGrc54H-KzX; Tue, 18 Aug 2020 19:19:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BWHhV1VQmz9vCxg;
        Tue, 18 Aug 2020 19:19:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 104D98B7EC;
        Tue, 18 Aug 2020 19:19:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Z-B9wfb6vi-X; Tue, 18 Aug 2020 19:19:23 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AA4F38B7D7;
        Tue, 18 Aug 2020 19:19:23 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 8AD1E65CF4; Tue, 18 Aug 2020 17:19:23 +0000 (UTC)
Message-Id: <fa094445c119fc00315e1c13783b493346306c6a.1597770847.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597770847.git.christophe.leroy@csgroup.eu>
References: <cover.1597770847.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 11/25] powerpc/signal: Refactor bad frame logging
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 18 Aug 2020 17:19:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The logging of bad frame appears half a dozen of times
and is pretty similar.

Create signal_fault() fonction to perform that logging.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/signal.c    | 11 +++++++++++
 arch/powerpc/kernel/signal.h    |  3 +++
 arch/powerpc/kernel/signal_32.c | 35 +++++----------------------------
 arch/powerpc/kernel/signal_64.c | 15 ++------------
 4 files changed, 21 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index 5edded5c5d20..a1d31d26dbd6 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -355,3 +355,14 @@ static unsigned long get_tm_stackpointer(struct task_struct *tsk)
 #endif
 	return ret;
 }
+
+static const char fm32[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %08lx lr %08lx\n";
+static const char fm64[] = KERN_INFO "%s[%d]: bad frame in %s: %p nip %016lx lr %016lx\n";
+
+void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
+		  const char *where, void __user *ptr)
+{
+	if (show_unhandled_signals)
+		printk_ratelimited(regs->msr & MSR_64BIT ? fm64 : fm32, tsk->comm,
+				   task_pid_nr(tsk), where, ptr, regs->nip, regs->link);
+}
diff --git a/arch/powerpc/kernel/signal.h b/arch/powerpc/kernel/signal.h
index fb98731348c3..f610cfafa478 100644
--- a/arch/powerpc/kernel/signal.h
+++ b/arch/powerpc/kernel/signal.h
@@ -93,4 +93,7 @@ static inline int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 
 #endif /* !defined(CONFIG_PPC64) */
 
+void signal_fault(struct task_struct *tsk, struct pt_regs *regs,
+		  const char *where, void __user *ptr);
+
 #endif  /* _POWERPC_ARCH_SIGNAL_H */
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index e5b2801a94ac..deb729c8b79d 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -835,12 +835,7 @@ int handle_rt_signal32(struct ksignal *ksig, sigset_t *oldset,
 	return 0;
 
 badframe:
-	if (show_unhandled_signals)
-		printk_ratelimited(KERN_INFO
-				   "%s[%d]: bad frame in handle_rt_signal32: "
-				   "%p nip %08lx lr %08lx\n",
-				   tsk->comm, tsk->pid,
-				   addr, regs->nip, regs->link);
+	signal_fault(tsk, regs, "handle_rt_signal32", addr);
 
 	return 1;
 }
@@ -1092,12 +1087,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 
  bad:
-	if (show_unhandled_signals)
-		printk_ratelimited(KERN_INFO
-				   "%s[%d]: bad frame in sys_rt_sigreturn: "
-				   "%p nip %08lx lr %08lx\n",
-				   current->comm, current->pid,
-				   rt_sf, regs->nip, regs->link);
+	signal_fault(current, regs, "sys_rt_sigreturn", rt_sf);
 
 	force_sig(SIGSEGV);
 	return 0;
@@ -1181,12 +1171,7 @@ SYSCALL_DEFINE3(debug_setcontext, struct ucontext __user *, ctx,
 	 * We kill the task with a SIGSEGV in this situation.
 	 */
 	if (do_setcontext(ctx, regs, 1)) {
-		if (show_unhandled_signals)
-			printk_ratelimited(KERN_INFO "%s[%d]: bad frame in "
-					   "sys_debug_setcontext: %p nip %08lx "
-					   "lr %08lx\n",
-					   current->comm, current->pid,
-					   ctx, regs->nip, regs->link);
+		signal_fault(current, regs, "sys_debug_setcontext", ctx);
 
 		force_sig(SIGSEGV);
 		goto out;
@@ -1287,12 +1272,7 @@ int handle_signal32(struct ksignal *ksig, sigset_t *oldset,
 	return 0;
 
 badframe:
-	if (show_unhandled_signals)
-		printk_ratelimited(KERN_INFO
-				   "%s[%d]: bad frame in handle_signal32: "
-				   "%p nip %08lx lr %08lx\n",
-				   tsk->comm, tsk->pid,
-				   frame, regs->nip, regs->link);
+	signal_fault(tsk, regs, "handle_signal32", frame);
 
 	return 1;
 }
@@ -1363,12 +1343,7 @@ SYSCALL_DEFINE0(sigreturn)
 	return 0;
 
 badframe:
-	if (show_unhandled_signals)
-		printk_ratelimited(KERN_INFO
-				   "%s[%d]: bad frame in sys_sigreturn: "
-				   "%p nip %08lx lr %08lx\n",
-				   current->comm, current->pid,
-				   addr, regs->nip, regs->link);
+	signal_fault(current, regs, "sys_sigreturn", addr);
 
 	force_sig(SIGSEGV);
 	return 0;
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index fec27d599e87..7df088b9ad0f 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -66,11 +66,6 @@ struct rt_sigframe {
 	char abigap[USER_REDZONE_SIZE];
 } __attribute__ ((aligned (16)));
 
-static const char fmt32[] = KERN_INFO \
-	"%s[%d]: bad frame in %s: %08lx nip %08lx lr %08lx\n";
-static const char fmt64[] = KERN_INFO \
-	"%s[%d]: bad frame in %s: %016lx nip %016lx lr %016lx\n";
-
 /*
  * This computes a quad word aligned pointer inside the vmx_reserve array
  * element. For historical reasons sigcontext might not be quad word aligned,
@@ -801,10 +796,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 
 badframe:
-	if (show_unhandled_signals)
-		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-				   current->comm, current->pid, "rt_sigreturn",
-				   (long)uc, regs->nip, regs->link);
+	signal_fault(current, regs, "rt_sigreturn", uc);
 
 	force_sig(SIGSEGV);
 	return 0;
@@ -911,10 +903,7 @@ int handle_rt_signal64(struct ksignal *ksig, sigset_t *set,
 	return 0;
 
 badframe:
-	if (show_unhandled_signals)
-		printk_ratelimited(regs->msr & MSR_64BIT ? fmt64 : fmt32,
-				   tsk->comm, tsk->pid, "setup_rt_frame",
-				   (long)frame, regs->nip, regs->link);
+	signal_fault(current, regs, "handle_rt_signal64", frame);
 
 	return 1;
 }
-- 
2.25.0


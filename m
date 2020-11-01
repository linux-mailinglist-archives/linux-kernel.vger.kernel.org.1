Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29D7C2A1E64
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgKAN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:56:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgKAN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:56:34 -0500
Date:   Sun, 01 Nov 2020 13:56:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604238992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2XkGWPiTVIeCLbPRYInaBgYUKzYnDirIWbvnQ0nNLfk=;
        b=jtLqX4g9xBuKEioO54DEBFWAgeTgpuyM9P57Crn94WJSZKMaTSXget7UdCFx86rV1kyICQ
        SYNlp2257tk60b4BtkP3o3j0wxeEeOfulRfsrIw+JLoenvYPB16m9BLDsQVQHEtVrqz7jE
        SAnbApGAdWpSO5nZjvMh2DM+HB6oT8sgxMwt3PXkmRfH1WCnKz4JQV01W9QEv79/Mxpljt
        gm7ooTr2lDBi2N7f2I7naH4vTvAIIeP+bPIsXveeJiuq0sQUKhwN1VbBkEKSST99NJ4JIS
        JXoSuhvwVfUCS30EZUzlz89G9WSEXNLMn8e4g0lLLx6RaLZfkofG4LT5q8Iy0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604238992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=2XkGWPiTVIeCLbPRYInaBgYUKzYnDirIWbvnQ0nNLfk=;
        b=bT+Hv0LB5f/B1QX1SBs5q2qxhhzs8IqrK89V0vd2uHBy/WrqkjyGFglM+9Rh5l4nWnGrUD
        hZogmVKFGYXjwGAQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.10-rc2
References: <160423896136.5667.9743580255833470691.tglx@nanos>
Message-ID: <160423896498.5667.10759421124605297683.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-11-01

up to:  cb05143bdf42: x86/debug: Fix DR_STEP vs ptrace_get_debugreg(6)


Three fixes all related to #DB:

 - Handle the BTF bit correctly so it doesn't get lost due to a kernel #DB

 - Only clear and set the virtual DR6 value used by ptrace on user space
   triggered #DB. A kernel #DB must leave it alone to ensure data
   consistency for ptrace.

 - Make the bitmasking of the virtual DR6 storage correct so it does not
   lose DR_STEP.


Thanks,

	tglx

------------------>
Peter Zijlstra (3):
      x86/debug: Fix BTF handling
      x86/debug: Only clear/set ->virtual_dr6 for userspace #DB
      x86/debug: Fix DR_STEP vs ptrace_get_debugreg(6)


 arch/x86/kernel/traps.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb34028b..e19df6cde35d 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -793,19 +793,6 @@ static __always_inline unsigned long debug_read_clear_dr6(void)
 	set_debugreg(DR6_RESERVED, 6);
 	dr6 ^= DR6_RESERVED; /* Flip to positive polarity */
 
-	/*
-	 * Clear the virtual DR6 value, ptrace routines will set bits here for
-	 * things we want signals for.
-	 */
-	current->thread.virtual_dr6 = 0;
-
-	/*
-	 * The SDM says "The processor clears the BTF flag when it
-	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
-	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
-	 */
-	clear_thread_flag(TIF_BLOCKSTEP);
-
 	return dr6;
 }
 
@@ -873,6 +860,20 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 */
 	WARN_ON_ONCE(user_mode(regs));
 
+	if (test_thread_flag(TIF_BLOCKSTEP)) {
+		/*
+		 * The SDM says "The processor clears the BTF flag when it
+		 * generates a debug exception." but PTRACE_BLOCKSTEP requested
+		 * it for userspace, but we just took a kernel #DB, so re-set
+		 * BTF.
+		 */
+		unsigned long debugctl;
+
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+		debugctl |= DEBUGCTLMSR_BTF;
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, debugctl);
+	}
+
 	/*
 	 * Catch SYSENTER with TF set and clear DR_STEP. If this hit a
 	 * watchpoint at the same time then that will still be handled.
@@ -935,6 +936,22 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 	irqentry_enter_from_user_mode(regs);
 	instrumentation_begin();
 
+	/*
+	 * Start the virtual/ptrace DR6 value with just the DR_STEP mask
+	 * of the real DR6. ptrace_triggered() will set the DR_TRAPn bits.
+	 *
+	 * Userspace expects DR_STEP to be visible in ptrace_get_debugreg(6)
+	 * even if it is not the result of PTRACE_SINGLESTEP.
+	 */
+	current->thread.virtual_dr6 = (dr6 & DR_STEP);
+
+	/*
+	 * The SDM says "The processor clears the BTF flag when it
+	 * generates a debug exception."  Clear TIF_BLOCKSTEP to keep
+	 * TIF_BLOCKSTEP in sync with the hardware BTF flag.
+	 */
+	clear_thread_flag(TIF_BLOCKSTEP);
+
 	/*
 	 * If dr6 has no reason to give us about the origin of this trap,
 	 * then it's very likely the result of an icebp/int01 trap.


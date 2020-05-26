Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF771D5D08
	for <lists+linux-kernel@lfdr.de>; Sat, 16 May 2020 02:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgEPALr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 20:11:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728135AbgEPALM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 20:11:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B636C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 17:11:12 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jZkPl-0002gZ-Ae; Sat, 16 May 2020 02:10:53 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id C3595FF834;
        Sat, 16 May 2020 02:10:52 +0200 (CEST)
Message-Id: <20200515235128.106581861@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 May 2020 01:46:24 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch V6 37/37] x86/entry: Remove the TRACE_IRQS cruft
References: <20200515234547.710474468@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index dce3ede7207e..fcdb41ac5c2e 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -53,19 +53,6 @@ SYM_CODE_START(native_usergs_sysret64)
 SYM_CODE_END(native_usergs_sysret64)
 #endif /* CONFIG_PARAVIRT */
 
-.macro TRACE_IRQS_FLAGS flags:req
-#ifdef CONFIG_TRACE_IRQFLAGS
-	btl	$9, \flags		/* interrupts off? */
-	jnc	1f
-	TRACE_IRQS_ON
-1:
-#endif
-.endm
-
-.macro TRACE_IRQS_IRETQ
-	TRACE_IRQS_FLAGS EFLAGS(%rsp)
-.endm
-
 /*
  * 64-bit SYSCALL instruction entry. Up to 6 arguments in registers.
  *
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 34f980c9b766..ccd32877a3c4 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -3,7 +3,6 @@
  * Save registers before calling assembly functions. This avoids
  * disturbance of register allocation in some inline assembly constructs.
  * Copyright 2001,2002 by Andi Kleen, SuSE Labs.
- * Added trace_hardirqs callers - Copyright 2007 Steven Rostedt, Red Hat, Inc.
  */
 #include <linux/linkage.h>
 #include "calling.h"
@@ -37,11 +36,6 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller,1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller,1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
@@ -49,8 +43,7 @@ SYM_FUNC_END(\name)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) \
- || defined(CONFIG_PREEMPTION)
+#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
 	popq %r10
diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index e00f064b009e..8ddff8dbaed5 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -172,14 +172,4 @@ static inline int arch_irqs_disabled(void)
 }
 #endif /* !__ASSEMBLY__ */
 
-#ifdef __ASSEMBLY__
-#ifdef CONFIG_TRACE_IRQFLAGS
-#  define TRACE_IRQS_ON		call trace_hardirqs_on_thunk;
-#  define TRACE_IRQS_OFF	call trace_hardirqs_off_thunk;
-#else
-#  define TRACE_IRQS_ON
-#  define TRACE_IRQS_OFF
-#endif
-#endif /* __ASSEMBLY__ */
-
 #endif


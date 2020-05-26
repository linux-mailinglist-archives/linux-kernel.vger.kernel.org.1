Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1939D1C58BC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgEEORs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730286AbgEEORQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:16 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81EC061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:17:16 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyNX-0002gB-DZ; Tue, 05 May 2020 16:16:59 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id E92111001F5;
        Tue,  5 May 2020 16:16:58 +0200 (CEST)
Message-Id: <20200505135831.175237951@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:54:12 +0200
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
        Will Deacon <will@kernel.org>
Subject: [patch V4 part 5 31/31] x86/entry: Remove the TRACE_IRQS cruft
References: <20200505135341.730586321@linutronix.de>
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
---
 arch/x86/entry/entry_64.S       |   13 -------------
 arch/x86/entry/thunk_64.S       |    9 +--------
 arch/x86/include/asm/irqflags.h |   10 ----------
 3 files changed, 1 insertion(+), 31 deletions(-)

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
@@ -70,11 +69,6 @@ SYM_FUNC_START_NOALIGN(\name)
 SYM_FUNC_END(\name)
 	.endm
 
-#ifdef CONFIG_TRACE_IRQFLAGS
-	THUNK trace_hardirqs_on_thunk,trace_hardirqs_on_caller, put_ret_addr_in_rdi=1
-	THUNK trace_hardirqs_off_thunk,trace_hardirqs_off_caller, put_ret_addr_in_rdi=1
-#endif
-
 #ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	EXPORT_SYMBOL(preempt_schedule_thunk)
@@ -83,8 +77,7 @@ SYM_FUNC_END(\name)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
 #endif
 
-#if defined(CONFIG_TRACE_IRQFLAGS) \
- || defined(CONFIG_PREEMPTION)
+#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(.L_restore)
 	popq %r11
 	popq %r10
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -171,14 +171,4 @@ static inline int arch_irqs_disabled(voi
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


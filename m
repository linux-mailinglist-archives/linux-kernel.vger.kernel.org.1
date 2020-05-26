Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0791C58C7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730224AbgEEOSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730205AbgEEOQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:16:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A2BC0610D5
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:16:57 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jVyN6-0002MN-SW; Tue, 05 May 2020 16:16:33 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id AD7A11001F5;
        Tue,  5 May 2020 16:16:31 +0200 (CEST)
Message-Id: <20200505135829.018447955@linutronix.de>
User-Agent: quilt/0.65
Date:   Tue, 05 May 2020 15:53:50 +0200
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
Subject: [patch V4 part 5 09/31] x86/entry: Remove the transition leftovers
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

Now that all exceptions are converted over the sane flag is not longer
needed. Also the vector argument of idtentry_body on 64 bit is pointless
now.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_32.S       |    3 +--
 arch/x86/entry/entry_64.S       |   26 ++++----------------------
 arch/x86/include/asm/idtentry.h |    6 +++---
 3 files changed, 8 insertions(+), 27 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -734,9 +734,8 @@
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Compatibility flag with 64bit
  */
-.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+.macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	ASM_CLAC
 	cld
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -497,27 +497,14 @@ SYM_CODE_END(spurious_entries_start)
 
 /**
  * idtentry_body - Macro to emit code calling the C function
- * @vector:		Vector number
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Sane variant which handles irq tracing, context tracking in C
  */
-.macro idtentry_body vector cfunc has_error_code:req sane=0
+.macro idtentry_body cfunc has_error_code:req
 
 	call	error_entry
 	UNWIND_HINT_REGS
 
-	.if \sane == 0
-	TRACE_IRQS_OFF
-
-#ifdef CONFIG_CONTEXT_TRACKING
-	testb	$3, CS(%rsp)
-	jz	.Lfrom_kernel_no_ctxt_tracking_\@
-	CALL_enter_from_user_mode
-.Lfrom_kernel_no_ctxt_tracking_\@:
-#endif
-	.endif
-
 	movq	%rsp, %rdi			/* pt_regs pointer into 1st argument*/
 
 	.if \has_error_code == 1
@@ -527,11 +514,7 @@ SYM_CODE_END(spurious_entries_start)
 
 	call	\cfunc
 
-	.if \sane == 0
-	jmp	error_exit
-	.else
 	jmp	error_return
-	.endif
 .endm
 
 /**
@@ -540,12 +523,11 @@ SYM_CODE_END(spurious_entries_start)
  * @asmsym:		ASM symbol for the entry point
  * @cfunc:		C function to be called
  * @has_error_code:	Hardware pushed error code on stack
- * @sane:		Sane variant which handles irq tracing, context tracking in C
  *
  * The macro emits code to set up the kernel context for straight forward
  * and simple IDT entries. No IST stack, no paranoid entry checks.
  */
-.macro idtentry vector asmsym cfunc has_error_code:req sane=0
+.macro idtentry vector asmsym cfunc has_error_code:req
 SYM_CODE_START(\asmsym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 	ASM_CLAC
@@ -568,7 +550,7 @@ SYM_CODE_START(\asmsym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	idtentry_body \vector \cfunc \has_error_code \sane
+	idtentry_body \cfunc \has_error_code
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
@@ -643,7 +625,7 @@ SYM_CODE_START(\asmsym)
 
 	/* Switch to the regular task stack and use the noist entry point */
 .Lfrom_usermode_switch_stack_\@:
-	idtentry_body vector noist_\cfunc, has_error_code=0 sane=1
+	idtentry_body noist_\cfunc, has_error_code=0
 
 _ASM_NOKPROBE(\asmsym)
 SYM_CODE_END(\asmsym)
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -293,10 +293,10 @@ static __always_inline void __##func(str
  * The ASM variants for DECLARE_IDTENTRY*() which emit the ASM entry stubs.
  */
 #define DECLARE_IDTENTRY(vector, func)					\
-	idtentry vector asm_##func func has_error_code=0 sane=1
+	idtentry vector asm_##func func has_error_code=0
 
 #define DECLARE_IDTENTRY_ERRORCODE(vector, func)			\
-	idtentry vector asm_##func func has_error_code=1 sane=1
+	idtentry vector asm_##func func has_error_code=1
 
 /* Special case for 32bit IRET 'trap'. Do not emit ASM code */
 #define DECLARE_IDTENTRY_SW(vector, func)
@@ -334,7 +334,7 @@ static __always_inline void __##func(str
 
 /* XEN NMI and DB wrapper */
 #define DECLARE_IDTENTRY_XEN(vector, func)				\
-	idtentry vector asm_exc_xen##func exc_##func has_error_code=0 sane=1
+	idtentry vector asm_exc_xen##func exc_##func has_error_code=0
 
 #endif /* __ASSEMBLY__ */
 


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3941F29DED0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgJ2A4u convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 28 Oct 2020 20:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731631AbgJ1WRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:36 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1A8824770;
        Wed, 28 Oct 2020 14:25:03 +0000 (UTC)
Date:   Wed, 28 Oct 2020 10:25:02 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 1/2 v2] ftrace/x86: Allow for arguments to be passed in
 to REGS by default
Message-ID: <20201028102502.28095c95@oasis.local.home>
In-Reply-To: <20201028131909.738751907@goodmis.org>
References: <20201028131542.963014814@goodmis.org>
        <20201028131909.738751907@goodmis.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From b5f5cfc63f38415b4ca7eb4cfb8c78113bfa17e0 Mon Sep 17 00:00:00 2001
From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Date: Tue, 27 Oct 2020 10:55:55 -0400
Subject: [PATCH] ftrace/x86: Allow for arguments to be passed in to REGS by
 default

Currently, the only way to get access to the registers of a function via a
ftrace callback is to set the "FL_SAVE_REGS" bit in the ftrace_ops. But as this
saves all regs as if a breakpoint were to trigger (for use with kprobes), it
is expensive.

The regs are already saved on the stack for the default ftrace callbacks, as
that is required otherwise a function being traced will get the wrong
arguments and possibly crash. And on x86, the argumentes are already stored
where they would be on a pt_regs structure to use that code for both the
regs version of a callback, it makes sense to pass that information always
to all functions.

If an architecture does this (as x86 now does), it is to set
HAVE_DYNAMIC_FTRACE_WITH_ARGS, and this will let the generic code that it
could use the regs without having to set the flags if it wants to access the
arguments from the regs pointer.

The stack pointer is also saved in the regs, and this could be useful for
having the function graph tracer not require its own trampoline!

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
Changes since v1:

 - Fixed change log from "FL_FLAGS" to "FL_SAVE_REGS"
 - Add ftrace_valid_regs() macro to test if regs are safe to use
   for full regs operations.


 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/ftrace.h |  4 ++++
 arch/x86/kernel/ftrace_64.S   | 15 ++++++++++-----
 include/linux/ftrace.h        |  4 ++++
 kernel/trace/Kconfig          |  9 +++++++++
 kernel/trace/ftrace.c         |  2 +-
 6 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7101ac64bb20..b4d2b1fcfd09 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -167,6 +167,7 @@ config X86
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select HAVE_DYNAMIC_FTRACE_WITH_ARGS	if X86_64
 	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 84b9449be080..d3b26d61a1f6 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -49,6 +49,10 @@ struct dyn_arch_ftrace {
 
 #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+#define ftrace_valid_regs(regs) (((struct pt_regs *)(regs))->ip != 0)
+#endif
+
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index ac3d5f22fe64..f769881b1cdf 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -86,6 +86,11 @@
 	movq %r8, R8(%rsp)
 	movq %r9, R9(%rsp)
 	movq $0, ORIG_RAX(%rsp)
+
+	/* Stack - skipping return address and flags */
+	leaq MCOUNT_REG_SIZE+\added+8(%rsp), %rcx
+	movq %rcx, RSP(%rsp)
+
 	/*
 	 * Save the original RBP. Even though the mcount ABI does not
 	 * require this, it helps out callers.
@@ -144,8 +149,11 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
-	/* regs go into 4th parameter (but make it NULL) */
-	movq $0, %rcx
+	/* regs go into 4th parameter */
+	leaq (%rsp), %rcx
+
+	/* Only ops with REGS flag set should have RIP set */
+	movq $0, RIP(%rcx)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
@@ -204,9 +212,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	movq %rcx, SS(%rsp)
 	movq $__KERNEL_CS, %rcx
 	movq %rcx, CS(%rsp)
-	/* Stack - skipping return address and flags */
-	leaq MCOUNT_REG_SIZE+8*2(%rsp), %rcx
-	movq %rcx, RSP(%rsp)
 
 	ENCODE_FRAME_POINTER
 
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8dde9c17aaa5..fbc095393f9b 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -90,6 +90,10 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 struct ftrace_ops;
 
+#ifndef ftrace_valid_regs
+#define ftrace_valid_regs(regs) ((regs) != NULL)
+#endif
+
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
 			      struct ftrace_ops *op, struct pt_regs *regs);
 
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a4020c0b4508..6a5b7a818d7d 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -31,6 +31,15 @@ config HAVE_DYNAMIC_FTRACE_WITH_REGS
 config HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	bool
 
+config HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	bool
+	help
+	 If this is set, then arguments and stack can be found from
+	 the pt_regs passed into the function callback regs parameter
+	 by default, even without setting the REGS flag in the ftrace_ops.
+	 This allows for use of regs_get_kernel_argument() and
+	 kernel_stack_pointer().
+
 config HAVE_FTRACE_MCOUNT_RECORD
 	bool
 	help
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2dcae8251104..6b7e097a8c5e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1484,7 +1484,7 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 	 * that wants regs, may be called without them. We can not
 	 * allow that handler to be called if regs is NULL.
 	 */
-	if (regs == NULL && (ops->flags & FTRACE_OPS_FL_SAVE_REGS))
+	if (!ftrace_valid_regs(regs) && (ops->flags & FTRACE_OPS_FL_SAVE_REGS))
 		return 0;
 #endif
 
-- 
2.25.4


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAE529DC3E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbgJ2AW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388711AbgJ2AWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:22:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96ABB207E8;
        Thu, 29 Oct 2020 00:22:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXviP-005fhT-5Q; Wed, 28 Oct 2020 20:22:53 -0400
Message-ID: <20201029002253.033736318@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 20:08:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: [RFC][PATCH 2/3 v3] ftrace/x86: Allow for arguments to be passed in to ftrace_regs by
 default
References: <20201029000816.272878754@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, the only way to get access to the registers of a function via a
ftrace callback is to set the "FL_SAVE_REGS" bit in the ftrace_ops. But as this
saves all regs as if a breakpoint were to trigger (for use with kprobes), it
is expensive.

The regs are already saved on the stack for the default ftrace callbacks, as
that is required otherwise a function being traced will get the wrong
arguments and possibly crash. And on x86, the arguments are already stored
where they would be on a pt_regs structure to use that code for both the
regs version of a callback, it makes sense to pass that information always
to all functions.

If an architecture does this (as x86_64 now does), it is to set
HAVE_DYNAMIC_FTRACE_WITH_ARGS, and this will let the generic code that it
could have access to arguments without having to set the flags.

This also includes having the stack pointer being saved, which could be used
for accessing arguments on the stack, as well as having the function graph
tracer not require its own trampoline!

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/Kconfig              |  1 +
 arch/x86/include/asm/ftrace.h | 15 +++++++++++++++
 arch/x86/kernel/ftrace_64.S   | 11 +++++++++--
 include/linux/ftrace.h        |  7 ++++++-
 kernel/trace/Kconfig          |  9 +++++++++
 5 files changed, 40 insertions(+), 3 deletions(-)

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
index 84b9449be080..6b175c2468e6 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -49,6 +49,21 @@ struct dyn_arch_ftrace {
 
 #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+struct ftrace_regs {
+	struct pt_regs		regs;
+};
+
+static __always_inline struct pt_regs *
+arch_ftrace_get_regs(struct ftrace_regs *fregs)
+{
+	/* Only when FL_SAVE_REGS is set, cs will be non zero */
+	if (!fregs->regs.cs)
+		return NULL;
+	return &fregs->regs;
+}
+#endif
+
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index ac3d5f22fe64..c4177bd00cd2 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -140,12 +140,19 @@ SYM_FUNC_START(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
 	save_mcount_regs
 
+	/* Stack - skipping return address and flags */
+	leaq MCOUNT_REG_SIZE+8(%rsp), %rcx
+	movq %rcx, RSP(%rsp)
+
 SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
-	/* regs go into 4th parameter (but make it NULL) */
-	movq $0, %rcx
+	/* regs go into 4th parameter */
+	leaq (%rsp), %rcx
+
+	/* Only ops with REGS flag set should have RIP set */
+	movq $0, CS(%rsp)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 24e1fa52337d..588ea7023a7a 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -90,16 +90,21 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 struct ftrace_ops;
 
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+
 struct ftrace_regs {
 	struct pt_regs		regs;
 };
+#define arch_ftrace_get_regs(fregs) (&(fregs)->regs)
+
+#endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
 {
 	if (!fregs)
 		return NULL;
 
-	return &fregs->regs;
+	return arch_ftrace_get_regs(fregs);
 }
 
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
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
-- 
2.28.0



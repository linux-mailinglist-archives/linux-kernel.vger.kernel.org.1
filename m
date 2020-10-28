Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDF29DF1F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403894AbgJ2A7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:59:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731563AbgJ1WRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60220246DD;
        Wed, 28 Oct 2020 13:19:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXlM5-005a6y-T5; Wed, 28 Oct 2020 09:19:09 -0400
Message-ID: <20201028131909.738751907@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 09:15:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 1/2] ftrace/x86: Allow for arguments to be passed in to REGS by default
References: <20201028131542.963014814@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, the only way to get access to the registers of a function via a
ftrace callback is to set the "FL_FLAGS" bit in the ftrace_ops. But as this
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
 arch/x86/Kconfig            |  1 +
 arch/x86/kernel/ftrace_64.S | 12 +++++++-----
 kernel/trace/Kconfig        |  9 +++++++++
 3 files changed, 17 insertions(+), 5 deletions(-)

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
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index ac3d5f22fe64..77c512334b4c 100644
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
@@ -144,8 +149,8 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
-	/* regs go into 4th parameter (but make it NULL) */
-	movq $0, %rcx
+	/* regs go into 4th parameter */
+	leaq (%rsp), %rcx
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
@@ -204,9 +209,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	movq %rcx, SS(%rsp)
 	movq $__KERNEL_CS, %rcx
 	movq %rcx, CS(%rsp)
-	/* Stack - skipping return address and flags */
-	leaq MCOUNT_REG_SIZE+8*2(%rsp), %rcx
-	movq %rcx, RSP(%rsp)
 
 	ENCODE_FRAME_POINTER
 
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



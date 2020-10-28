Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE94029D4DC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgJ1VzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:55:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728282AbgJ1VwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A2A24801;
        Wed, 28 Oct 2020 20:36:28 +0000 (UTC)
Date:   Wed, 28 Oct 2020 16:36:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC][PATCH 1/2 v2] ftrace/x86: Allow for arguments to be
 passed in to REGS by default
Message-ID: <20201028163626.20e651b1@oasis.local.home>
In-Reply-To: <20201028112916.50bcbc69@oasis.local.home>
References: <20201028131542.963014814@goodmis.org>
        <20201028131909.738751907@goodmis.org>
        <20201028102502.28095c95@oasis.local.home>
        <20201028112916.50bcbc69@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 11:29:16 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Then kprobes could just create its own pt_regs, fill in all the data
> from ftrace_regs and then fill the rest with zeros or possibly whatever
> the values currently are (does it really matter what those registers
> are?), including flags.

Here's a proof of concept patch. It passes all the kprobe self tests in
the ftracetest suite. This is just a proof of concept, and I already
know of a couple of subtle bugs that are easy to fix. But this shows
the general idea.

(this is based on my ftrace/core branch)

-- Steve

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
index 84b9449be080..0b751f94c7ec 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -49,6 +49,10 @@ struct dyn_arch_ftrace {
 
 #define FTRACE_GRAPH_TRAMP_ADDR FTRACE_GRAPH_ADDR
 
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+#define ftrace_valid_regs(regs) (((struct pt_regs *)(regs))->cs != 0)
+#endif
+
 #endif /*  CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index ac3d5f22fe64..f8833fe0ff44 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -140,16 +140,27 @@ SYM_FUNC_START(ftrace_caller)
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
+	/* Only ops with REGS flag set should have CS set */
+	movq $0, CS(%rsp)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
+	/* Handlers can change the RIP */
+	movq RIP(%rsp), %rax
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+
 	restore_mcount_regs
 
 	/*
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index a40a6cdfcca3..c3a5b2675397 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -12,18 +12,42 @@
 
 #include "common.h"
 
+/*
+ * Note, this is just a proof of concept, ftrace_regs will
+ * be of its own type (struct ftrace_regs) and this function
+ * will be architecture dependent, to fill pt_regs from
+ * the ftrace_regs structure. But for now, we simply just copy it.
+ */
+static void arch_ftrace_fill_regs(struct pt_regs *regs,
+				  struct pt_regs *ftrace_regs)
+{
+	*regs = *ftrace_regs;
+	local_save_flags(regs->flags);
+	regs->cs = __KERNEL_CS;
+}
+
+static void arch_regs_fill_ftrace(struct pt_regs *ftrace_regs,
+				  struct pt_regs *regs)
+{
+	*ftrace_regs = *regs;
+}
+
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct pt_regs *regs)
+			   struct ftrace_ops *ops,
+			   struct pt_regs *ftrace_regs)
 {
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
+	struct pt_regs regs;
 	int bit;
 
 	bit = ftrace_test_recursion_trylock();
 	if (bit < 0)
 		return;
 
+	arch_ftrace_fill_regs(&regs, ftrace_regs);
+
 	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
@@ -33,23 +57,23 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
 	} else {
-		unsigned long orig_ip = regs->ip;
-		/* Kprobe handler expects regs->ip = ip + 1 as breakpoint hit */
-		regs->ip = ip + sizeof(kprobe_opcode_t);
+		unsigned long orig_ip = regs.ip;
+		/* Kprobe handler expects regs.ip = ip + 1 as breakpoint hit */
+		regs.ip = ip + sizeof(kprobe_opcode_t);
 
 		__this_cpu_write(current_kprobe, p);
 		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
-		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+		if (!p->pre_handler || !p->pre_handler(p, &regs)) {
 			/*
-			 * Emulate singlestep (and also recover regs->ip)
+			 * Emulate singlestep (and also recover regs.ip)
 			 * as if there is a 5byte nop
 			 */
-			regs->ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
+			regs.ip = (unsigned long)p->addr + MCOUNT_INSN_SIZE;
 			if (unlikely(p->post_handler)) {
 				kcb->kprobe_status = KPROBE_HIT_SSDONE;
-				p->post_handler(p, regs, 0);
+				p->post_handler(p, &regs, 0);
 			}
-			regs->ip = orig_ip;
+			regs.ip = orig_ip;
 		}
 		/*
 		 * If pre_handler returns !0, it changes regs->ip. We have to
@@ -57,6 +81,7 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		 */
 		__this_cpu_write(current_kprobe, NULL);
 	}
+	arch_regs_fill_ftrace(ftrace_regs, &regs);
 out:
 	preempt_enable_notrace();
 	ftrace_test_recursion_unlock(bit);
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
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 9303881aac84..9b552529c6a0 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1020,12 +1020,18 @@ static struct kprobe *alloc_aggr_kprobe(struct kprobe *p)
 #ifdef CONFIG_KPROBES_ON_FTRACE
 static struct ftrace_ops kprobe_ftrace_ops __read_mostly = {
 	.func = kprobe_ftrace_handler,
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
 	.flags = FTRACE_OPS_FL_SAVE_REGS,
+#endif
 };
 
 static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 	.func = kprobe_ftrace_handler,
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+	.flags = FTRACE_OPS_FL_IPMODIFY,
+#else
 	.flags = FTRACE_OPS_FL_SAVE_REGS | FTRACE_OPS_FL_IPMODIFY,
+#endif
 };
 
 static int kprobe_ipmodify_enabled;
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
index 2dcae8251104..d7875cbc17cd 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1484,7 +1484,8 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
 	 * that wants regs, may be called without them. We can not
 	 * allow that handler to be called if regs is NULL.
 	 */
-	if (regs == NULL && (ops->flags & FTRACE_OPS_FL_SAVE_REGS))
+	if ((ops->flags & FTRACE_OPS_FL_SAVE_REGS) &&
+	    (!regs || !ftrace_valid_regs(regs)))
 		return 0;
 #endif
 

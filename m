Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1076229D4E3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgJ1VzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgJ1VwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:52:25 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 454E624834;
        Wed, 28 Oct 2020 21:14:46 +0000 (UTC)
Date:   Wed, 28 Oct 2020 17:14:44 -0400
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
Message-ID: <20201028171444.7c74c9d0@oasis.local.home>
In-Reply-To: <20201028163626.20e651b1@oasis.local.home>
References: <20201028131542.963014814@goodmis.org>
        <20201028131909.738751907@goodmis.org>
        <20201028102502.28095c95@oasis.local.home>
        <20201028112916.50bcbc69@oasis.local.home>
        <20201028163626.20e651b1@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:36:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Here's a proof of concept patch. It passes all the kprobe self tests in
> the ftracetest suite. This is just a proof of concept, and I already
> know of a couple of subtle bugs that are easy to fix. But this shows
> the general idea.

And this works for live patching as well (the below patch passed the
live patching test).

To make sure this really worked, I made the regular trampoline put RIP
into the R15 location, and live patching used that.

I'm going to start working on getting rid of FL_SAVE_REGS, by first
changing the regs parameter to struct ftrace_regs * type, and having
all regs users use ftrace_regs_get_regs(), that will return NULL if
it's not full regs (at least for x86), this way we can keep the current
regs (if kprobes *really* needs it). But then having other accesses for
this. And this way, live patching will no longer need a full regs to
work.

Then by default we can have all callbacks have access to the stack and
arguments!

-- Steve

diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
index 1fde1ab6559e..de3bf7ce1c5d 100644
--- a/arch/x86/include/asm/livepatch.h
+++ b/arch/x86/include/asm/livepatch.h
@@ -14,7 +14,7 @@
 
 static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 {
-	regs->ip = ip;
+	regs->r15 = ip;
 }
 
 #endif /* _ASM_X86_LIVEPATCH_H */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index f8833fe0ff44..aad647500818 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -148,6 +148,11 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 	/* Load the ftrace_ops into the 3rd parameter */
 	movq function_trace_op(%rip), %rdx
 
+	/* put RIP into R15 to test this */
+	movq RIP(%rsp), %rcx
+	movq %rcx, R15(%rsp)
+	movq $0, RIP(%rsp)
+
 	/* regs go into 4th parameter */
 	leaq (%rsp), %rcx
 
@@ -158,7 +163,7 @@ SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
 	/* Handlers can change the RIP */
-	movq RIP(%rsp), %rax
+	movq R15(%rsp), %rax
 	movq %rax, MCOUNT_REG_SIZE(%rsp)
 
 	restore_mcount_regs
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index c3a5b2675397..3374d53a747a 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -22,6 +22,7 @@ static void arch_ftrace_fill_regs(struct pt_regs *regs,
 				  struct pt_regs *ftrace_regs)
 {
 	*regs = *ftrace_regs;
+	regs->ip = regs->r15;
 	local_save_flags(regs->flags);
 	regs->cs = __KERNEL_CS;
 }
@@ -30,6 +31,7 @@ static void arch_regs_fill_ftrace(struct pt_regs *ftrace_regs,
 				  struct pt_regs *regs)
 {
 	*ftrace_regs = *regs;
+	ftrace_regs->r15 = regs->ip;
 }
 
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 6c0164d24bbd..87ecdf486ca3 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -199,8 +199,10 @@ static int klp_patch_func(struct klp_func *func)
 			return -ENOMEM;
 
 		ops->fops.func = klp_ftrace_handler;
-		ops->fops.flags = FTRACE_OPS_FL_SAVE_REGS |
-				  FTRACE_OPS_FL_DYNAMIC |
+		ops->fops.flags = FTRACE_OPS_FL_DYNAMIC |
+#ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+				  FTRACE_OPS_FL_SAVE_REGS |
+#endif
 				  FTRACE_OPS_FL_IPMODIFY |
 				  FTRACE_OPS_FL_PERMANENT;
 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDBE529DC3F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388718AbgJ2AW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:22:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:48376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388717AbgJ2AWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:22:55 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5E7020809;
        Thu, 29 Oct 2020 00:22:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXviP-005fhx-AB; Wed, 28 Oct 2020 20:22:53 -0400
Message-ID: <20201029002253.192388563@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 20:08:19 -0400
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
Subject: [RFC][PATCH 3/3 v3] livepatching: Use the default ftrace_ops instead of REGS when ARGS is
 available
References: <20201029000816.272878754@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

When CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS is available, the ftrace call
will be able to set the ip of the calling function. This will improve the
performance of live kernel patching where it does not need all the regs to
be stored just to change the instruction pointer.

If all archs that support live kernel patching also support
HAVE_DYNAMIC_FTRACE_WITH_ARGS, then the architecture specific function
klp_arch_set_pc() could be made generic.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/powerpc/include/asm/livepatch.h | 4 +++-
 arch/s390/include/asm/livepatch.h    | 5 ++++-
 arch/x86/include/asm/ftrace.h        | 3 +++
 arch/x86/include/asm/livepatch.h     | 4 ++--
 arch/x86/kernel/ftrace_64.S          | 4 ++++
 include/linux/ftrace.h               | 7 +++++++
 kernel/livepatch/patch.c             | 9 +++++----
 7 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 4a3d5d25fed5..ae25e6e72997 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -12,8 +12,10 @@
 #include <linux/sched/task_stack.h>
 
 #ifdef CONFIG_LIVEPATCH
-static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
 	regs->nip = ip;
 }
 
diff --git a/arch/s390/include/asm/livepatch.h b/arch/s390/include/asm/livepatch.h
index 818612b784cd..d578a8c76676 100644
--- a/arch/s390/include/asm/livepatch.h
+++ b/arch/s390/include/asm/livepatch.h
@@ -11,10 +11,13 @@
 #ifndef ASM_LIVEPATCH_H
 #define ASM_LIVEPATCH_H
 
+#include <linux/ftrace.h>
 #include <asm/ptrace.h>
 
-static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
 	regs->psw.addr = ip;
 }
 
diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
index 6b175c2468e6..7042e80941e5 100644
--- a/arch/x86/include/asm/ftrace.h
+++ b/arch/x86/include/asm/ftrace.h
@@ -62,6 +62,9 @@ arch_ftrace_get_regs(struct ftrace_regs *fregs)
 		return NULL;
 	return &fregs->regs;
 }
+
+#define ftrace_regs_set_ip(fregs, _ip)		\
+	do { (fregs)->regs.ip = (_ip); } while (0)
 #endif
 
 #endif /*  CONFIG_DYNAMIC_FTRACE */
diff --git a/arch/x86/include/asm/livepatch.h b/arch/x86/include/asm/livepatch.h
index 1fde1ab6559e..59a08d5c6f1d 100644
--- a/arch/x86/include/asm/livepatch.h
+++ b/arch/x86/include/asm/livepatch.h
@@ -12,9 +12,9 @@
 #include <asm/setup.h>
 #include <linux/ftrace.h>
 
-static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
+static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
 {
-	regs->ip = ip;
+	ftrace_regs_set_ip(fregs, ip);
 }
 
 #endif /* _ASM_X86_LIVEPATCH_H */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index c4177bd00cd2..d00806dd8eed 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -157,6 +157,10 @@ SYM_INNER_LABEL(ftrace_caller_op_ptr, SYM_L_GLOBAL)
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	call ftrace_stub
 
+	/* Handlers can change the RIP */
+	movq RIP(%rsp), %rax
+	movq %rax, MCOUNT_REG_SIZE(%rsp)
+
 	restore_mcount_regs
 
 	/*
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 588ea7023a7a..b4eb962e2be9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -97,6 +97,13 @@ struct ftrace_regs {
 };
 #define arch_ftrace_get_regs(fregs) (&(fregs)->regs)
 
+/*
+ * ftrace_regs_set_ip() is to be defined by the architecture if
+ * to allow setting of the instruction pointer from the ftrace_regs
+ * when HAVE_DYNAMIC_FTRACE_WITH_ARGS is set and it supports
+ * live kernel patching.
+ */
+#define ftrace_regs_set_ip(fregs, ip) do { } while (0)
 #endif /* CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS */
 
 static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 9af0a7c8a255..722266472903 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -42,7 +42,6 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 				       struct ftrace_ops *fops,
 				       struct ftrace_regs *fregs)
 {
-	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct klp_ops *ops;
 	struct klp_func *func;
 	int patch_state;
@@ -118,7 +117,7 @@ static void notrace klp_ftrace_handler(unsigned long ip,
 	if (func->nop)
 		goto unlock;
 
-	klp_arch_set_pc(regs, (unsigned long)func->new_func);
+	klp_arch_set_pc(fregs, (unsigned long)func->new_func);
 
 unlock:
 	preempt_enable_notrace();
@@ -200,8 +199,10 @@ static int klp_patch_func(struct klp_func *func)
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
 
-- 
2.28.0



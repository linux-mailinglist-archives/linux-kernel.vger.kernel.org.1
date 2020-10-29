Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8344A29DC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388732AbgJ2AW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:22:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:48356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388031AbgJ2AW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 20:22:56 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 755AA206BE;
        Thu, 29 Oct 2020 00:22:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXviP-005fgy-03; Wed, 28 Oct 2020 20:22:53 -0400
Message-ID: <20201029002252.818328302@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 20:08:17 -0400
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
Subject: [RFC][PATCH 1/3 v3] ftrace: Have the callbacks receive a struct ftrace_regs instead of
 pt_regs
References: <20201029000816.272878754@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

In preparation to have arguments of a function passed to callbacks attached
to functions as default, change the default callback prototype to receive a
struct ftrace_regs as the forth parameter instead of a pt_regs.

For callbacks that set the FL_SAVE_REGS flag in their ftrace_ops flags, they
will now need to get the pt_regs via a ftrace_get_regs() helper call. If
this is called by a callback that their ftrace_ops did not have a
FL_SAVE_REGS flag set, it that helper function will return NULL.

This will allow the ftrace_regs to hold enough just to get the parameters
and stack pointer, but without the worry that callbacks may have a pt_regs
that is not completely filled.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/kprobes/ftrace.c  |  3 ++-
 include/linux/ftrace.h            | 16 ++++++++++++++--
 include/linux/kprobes.h           |  2 +-
 kernel/livepatch/patch.c          |  3 ++-
 kernel/trace/ftrace.c             | 27 +++++++++++++++------------
 kernel/trace/trace_event_perf.c   |  2 +-
 kernel/trace/trace_functions.c    |  9 ++++-----
 kernel/trace/trace_irqsoff.c      |  2 +-
 kernel/trace/trace_sched_wakeup.c |  2 +-
 kernel/trace/trace_selftest.c     | 20 +++++++++++---------
 kernel/trace/trace_stack.c        |  2 +-
 11 files changed, 53 insertions(+), 35 deletions(-)

diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index a40a6cdfcca3..a01849ffe013 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -14,8 +14,9 @@
 
 /* Ftrace callback handler for kprobes -- called under preepmt disabed */
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct pt_regs *regs)
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
 	int bit;
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 8dde9c17aaa5..24e1fa52337d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -90,8 +90,20 @@ ftrace_enable_sysctl(struct ctl_table *table, int write,
 
 struct ftrace_ops;
 
+struct ftrace_regs {
+	struct pt_regs		regs;
+};
+
+static __always_inline struct pt_regs *ftrace_get_regs(struct ftrace_regs *fregs)
+{
+	if (!fregs)
+		return NULL;
+
+	return &fregs->regs;
+}
+
 typedef void (*ftrace_func_t)(unsigned long ip, unsigned long parent_ip,
-			      struct ftrace_ops *op, struct pt_regs *regs);
+			      struct ftrace_ops *op, struct ftrace_regs *fregs);
 
 ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
 
@@ -259,7 +271,7 @@ int register_ftrace_function(struct ftrace_ops *ops);
 int unregister_ftrace_function(struct ftrace_ops *ops);
 
 extern void ftrace_stub(unsigned long a0, unsigned long a1,
-			struct ftrace_ops *op, struct pt_regs *regs);
+			struct ftrace_ops *op, struct ftrace_regs *fregs);
 
 #else /* !CONFIG_FUNCTION_TRACER */
 /*
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8aab327b5539..5ac1d9b1d58c 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -325,7 +325,7 @@ static inline void wait_for_kprobe_optimizer(void) { }
 #endif /* CONFIG_OPTPROBES */
 #ifdef CONFIG_KPROBES_ON_FTRACE
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
-				  struct ftrace_ops *ops, struct pt_regs *regs);
+				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
 #endif
 
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index 6c0164d24bbd..9af0a7c8a255 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -40,8 +40,9 @@ struct klp_ops *klp_find_ops(void *old_func)
 static void notrace klp_ftrace_handler(unsigned long ip,
 				       unsigned long parent_ip,
 				       struct ftrace_ops *fops,
-				       struct pt_regs *regs)
+				       struct ftrace_regs *fregs)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct klp_ops *ops;
 	struct klp_func *func;
 	int patch_state;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 2dcae8251104..7ef9048b3d1e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -121,7 +121,7 @@ struct ftrace_ops global_ops;
 
 #if ARCH_SUPPORTS_FTRACE_OPS
 static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-				 struct ftrace_ops *op, struct pt_regs *regs);
+				 struct ftrace_ops *op, struct ftrace_regs *fregs);
 #else
 /* See comment below, where ftrace_ops_list_func is defined */
 static void ftrace_ops_no_ops(unsigned long ip, unsigned long parent_ip);
@@ -140,7 +140,7 @@ static inline void ftrace_ops_init(struct ftrace_ops *ops)
 }
 
 static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
-			    struct ftrace_ops *op, struct pt_regs *regs)
+			    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = op->private;
 	int pid;
@@ -154,7 +154,7 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 			return;
 	}
 
-	op->saved_func(ip, parent_ip, op, regs);
+	op->saved_func(ip, parent_ip, op, fregs);
 }
 
 static void ftrace_sync_ipi(void *data)
@@ -754,7 +754,7 @@ ftrace_profile_alloc(struct ftrace_profile_stat *stat, unsigned long ip)
 
 static void
 function_profile_call(unsigned long ip, unsigned long parent_ip,
-		      struct ftrace_ops *ops, struct pt_regs *regs)
+		      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct ftrace_profile_stat *stat;
 	struct ftrace_profile *rec;
@@ -2143,6 +2143,7 @@ static int ftrace_check_record(struct dyn_ftrace *rec, bool enable, bool update)
 				else
 					rec->flags &= ~FTRACE_FL_TRAMP_EN;
 			}
+
 			if (flag & FTRACE_FL_DIRECT) {
 				/*
 				 * If there's only one user (direct_ops helper)
@@ -2368,8 +2369,9 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 }
 
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
-			      struct ftrace_ops *ops, struct pt_regs *regs)
+			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	unsigned long addr;
 
 	addr = ftrace_find_rec_direct(ip);
@@ -4293,7 +4295,7 @@ static int __init ftrace_mod_cmd_init(void)
 core_initcall(ftrace_mod_cmd_init);
 
 static void function_trace_probe_call(unsigned long ip, unsigned long parent_ip,
-				      struct ftrace_ops *op, struct pt_regs *pt_regs)
+				      struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct ftrace_probe_ops *probe_ops;
 	struct ftrace_func_probe *probe;
@@ -6913,8 +6915,9 @@ void ftrace_reset_array_ops(struct trace_array *tr)
 
 static nokprobe_inline void
 __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-		       struct ftrace_ops *ignored, struct pt_regs *regs)
+		       struct ftrace_ops *ignored, struct ftrace_regs *fregs)
 {
+	struct pt_regs *regs = ftrace_get_regs(fregs);
 	struct ftrace_ops *op;
 	int bit;
 
@@ -6947,7 +6950,7 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
 				pr_warn("op=%p %pS\n", op, op);
 				goto out;
 			}
-			op->func(ip, parent_ip, op, regs);
+			op->func(ip, parent_ip, op, fregs);
 		}
 	} while_for_each_ftrace_op(op);
 out:
@@ -6970,9 +6973,9 @@ __ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
  */
 #if ARCH_SUPPORTS_FTRACE_OPS
 static void ftrace_ops_list_func(unsigned long ip, unsigned long parent_ip,
-				 struct ftrace_ops *op, struct pt_regs *regs)
+				 struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	__ftrace_ops_list_func(ip, parent_ip, NULL, regs);
+	__ftrace_ops_list_func(ip, parent_ip, NULL, fregs);
 }
 NOKPROBE_SYMBOL(ftrace_ops_list_func);
 #else
@@ -6989,7 +6992,7 @@ NOKPROBE_SYMBOL(ftrace_ops_no_ops);
  * this function will be called by the mcount trampoline.
  */
 static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
-				   struct ftrace_ops *op, struct pt_regs *regs)
+				   struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	int bit;
 
@@ -7002,7 +7005,7 @@ static void ftrace_ops_assist_func(unsigned long ip, unsigned long parent_ip,
 
 	preempt_disable_notrace();
 
-	op->func(ip, parent_ip, op, regs);
+	op->func(ip, parent_ip, op, fregs);
 
 	preempt_enable_notrace();
 	trace_clear_recursion(bit);
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index a2b9fddb8148..86b7cdff1403 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -432,7 +432,7 @@ NOKPROBE_SYMBOL(perf_trace_buf_update);
 #ifdef CONFIG_FUNCTION_TRACER
 static void
 perf_ftrace_function_call(unsigned long ip, unsigned long parent_ip,
-			  struct ftrace_ops *ops, struct pt_regs *pt_regs)
+			  struct ftrace_ops *ops,  struct ftrace_regs *fregs)
 {
 	struct ftrace_entry *entry;
 	struct perf_event *event;
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 89c414ce1388..9f88de3f1d47 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -23,10 +23,10 @@ static void tracing_start_function_trace(struct trace_array *tr);
 static void tracing_stop_function_trace(struct trace_array *tr);
 static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
-		    struct ftrace_ops *op, struct pt_regs *pt_regs);
+		    struct ftrace_ops *op, struct ftrace_regs *fregs);
 static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
-			  struct ftrace_ops *op, struct pt_regs *pt_regs);
+			  struct ftrace_ops *op, struct ftrace_regs *fregs);
 static struct tracer_flags func_flags;
 
 /* Our option */
@@ -89,7 +89,6 @@ void ftrace_destroy_function_files(struct trace_array *tr)
 static int function_trace_init(struct trace_array *tr)
 {
 	ftrace_func_t func;
-
 	/*
 	 * Instance trace_arrays get their ops allocated
 	 * at instance creation. Unless it failed
@@ -129,7 +128,7 @@ static void function_trace_start(struct trace_array *tr)
 
 static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
-		    struct ftrace_ops *op, struct pt_regs *pt_regs)
+		    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
@@ -178,7 +177,7 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 
 static void
 function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
-			  struct ftrace_ops *op, struct pt_regs *pt_regs)
+			  struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_irqsoff.c b/kernel/trace/trace_irqsoff.c
index 10bbb0f381d5..d06aab4dcbb8 100644
--- a/kernel/trace/trace_irqsoff.c
+++ b/kernel/trace/trace_irqsoff.c
@@ -138,7 +138,7 @@ static int func_prolog_dec(struct trace_array *tr,
  */
 static void
 irqsoff_tracer_call(unsigned long ip, unsigned long parent_ip,
-		    struct ftrace_ops *op, struct pt_regs *pt_regs)
+		    struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = irqsoff_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
index 97b10bb31a1f..c0181066dbe9 100644
--- a/kernel/trace/trace_sched_wakeup.c
+++ b/kernel/trace/trace_sched_wakeup.c
@@ -212,7 +212,7 @@ static void wakeup_print_header(struct seq_file *s)
  */
 static void
 wakeup_tracer_call(unsigned long ip, unsigned long parent_ip,
-		   struct ftrace_ops *op, struct pt_regs *pt_regs)
+		   struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct trace_array *tr = wakeup_trace;
 	struct trace_array_cpu *data;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 50dd913d23e7..23f07370f40e 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -107,7 +107,7 @@ static int trace_selftest_test_probe1_cnt;
 static void trace_selftest_test_probe1_func(unsigned long ip,
 					    unsigned long pip,
 					    struct ftrace_ops *op,
-					    struct pt_regs *pt_regs)
+					    struct ftrace_regs *fregs)
 {
 	trace_selftest_test_probe1_cnt++;
 }
@@ -116,7 +116,7 @@ static int trace_selftest_test_probe2_cnt;
 static void trace_selftest_test_probe2_func(unsigned long ip,
 					    unsigned long pip,
 					    struct ftrace_ops *op,
-					    struct pt_regs *pt_regs)
+					    struct ftrace_regs *fregs)
 {
 	trace_selftest_test_probe2_cnt++;
 }
@@ -125,7 +125,7 @@ static int trace_selftest_test_probe3_cnt;
 static void trace_selftest_test_probe3_func(unsigned long ip,
 					    unsigned long pip,
 					    struct ftrace_ops *op,
-					    struct pt_regs *pt_regs)
+					    struct ftrace_regs *fregs)
 {
 	trace_selftest_test_probe3_cnt++;
 }
@@ -134,7 +134,7 @@ static int trace_selftest_test_global_cnt;
 static void trace_selftest_test_global_func(unsigned long ip,
 					    unsigned long pip,
 					    struct ftrace_ops *op,
-					    struct pt_regs *pt_regs)
+					    struct ftrace_regs *fregs)
 {
 	trace_selftest_test_global_cnt++;
 }
@@ -143,7 +143,7 @@ static int trace_selftest_test_dyn_cnt;
 static void trace_selftest_test_dyn_func(unsigned long ip,
 					 unsigned long pip,
 					 struct ftrace_ops *op,
-					 struct pt_regs *pt_regs)
+					 struct ftrace_regs *fregs)
 {
 	trace_selftest_test_dyn_cnt++;
 }
@@ -414,7 +414,7 @@ static int trace_selftest_recursion_cnt;
 static void trace_selftest_test_recursion_func(unsigned long ip,
 					       unsigned long pip,
 					       struct ftrace_ops *op,
-					       struct pt_regs *pt_regs)
+					       struct ftrace_regs *fregs)
 {
 	/*
 	 * This function is registered without the recursion safe flag.
@@ -429,7 +429,7 @@ static void trace_selftest_test_recursion_func(unsigned long ip,
 static void trace_selftest_test_recursion_safe_func(unsigned long ip,
 						    unsigned long pip,
 						    struct ftrace_ops *op,
-						    struct pt_regs *pt_regs)
+						    struct ftrace_regs *fregs)
 {
 	/*
 	 * We said we would provide our own recursion. By calling
@@ -543,9 +543,11 @@ static enum {
 static void trace_selftest_test_regs_func(unsigned long ip,
 					  unsigned long pip,
 					  struct ftrace_ops *op,
-					  struct pt_regs *pt_regs)
+					  struct ftrace_regs *fregs)
 {
-	if (pt_regs)
+	struct pt_regs *regs = ftrace_get_regs(fregs);
+
+	if (regs)
 		trace_selftest_regs_stat = TRACE_SELFTEST_REGS_FOUND;
 	else
 		trace_selftest_regs_stat = TRACE_SELFTEST_REGS_NOT_FOUND;
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 969db526a563..63c285042051 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -290,7 +290,7 @@ static void check_stack(unsigned long ip, unsigned long *stack)
 
 static void
 stack_trace_call(unsigned long ip, unsigned long parent_ip,
-		 struct ftrace_ops *op, struct pt_regs *pt_regs)
+		 struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	unsigned long stack;
 
-- 
2.28.0



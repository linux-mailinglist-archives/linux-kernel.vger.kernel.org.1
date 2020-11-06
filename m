Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77E82A8CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgKFCf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:35:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgKFCfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:35:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7307822280;
        Fri,  6 Nov 2020 02:35:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1karbQ-007WNj-25; Thu, 05 Nov 2020 21:35:48 -0500
Message-ID: <20201106023547.904270143@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 21:32:45 -0500
From:   Steven Rostedt (VMware) <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 10/11 v3] ftrace: Reverse what the RECURSION flag means in the ftrace_ops
References: <20201106023235.367190737@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Now that all callbacks are recursion safe, reverse the meaning of the
RECURSION flag and rename it from RECURSION_SAFE to simply RECURSION.
Now only callbacks that request to have recursion protecting it will
have the added trampoline to do so.

Also remove the outdated comment about "PER_CPU" when determining to
use the ftrace_ops_assist_func.

Link: https://lkml.kernel.org/r/20201028115613.742454631@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: linux-doc@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace-uses.rst | 82 +++++++++++++++++++++--------
 include/linux/ftrace.h              | 12 ++---
 kernel/trace/fgraph.c               |  3 +-
 kernel/trace/ftrace.c               | 20 ++++---
 kernel/trace/trace_events.c         |  1 -
 kernel/trace/trace_functions.c      |  2 +-
 kernel/trace/trace_selftest.c       |  7 +--
 kernel/trace/trace_stack.c          |  1 -
 8 files changed, 79 insertions(+), 49 deletions(-)

diff --git a/Documentation/trace/ftrace-uses.rst b/Documentation/trace/ftrace-uses.rst
index a4955f7e3d19..86cd14b8e126 100644
--- a/Documentation/trace/ftrace-uses.rst
+++ b/Documentation/trace/ftrace-uses.rst
@@ -30,8 +30,8 @@ The ftrace context
   This requires extra care to what can be done inside a callback. A callback
   can be called outside the protective scope of RCU.
 
-The ftrace infrastructure has some protections against recursions and RCU
-but one must still be very careful how they use the callbacks.
+There are helper functions to help against recursion, and making sure
+RCU is watching. These are explained below.
 
 
 The ftrace_ops structure
@@ -108,6 +108,50 @@ The prototype of the callback function is as follows (as of v4.14):
 	at the start of the function where ftrace was tracing. Otherwise it
 	either contains garbage, or NULL.
 
+Protect your callback
+=====================
+
+As functions can be called from anywhere, and it is possible that a function
+called by a callback may also be traced, and call that same callback,
+recursion protection must be used. There are two helper functions that
+can help in this regard. If you start your code with:
+
+	int bit;
+
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
+and end it with:
+
+	ftrace_test_recursion_unlock(bit);
+
+The code in between will be safe to use, even if it ends up calling a
+function that the callback is tracing. Note, on success,
+ftrace_test_recursion_trylock() will disable preemption, and the
+ftrace_test_recursion_unlock() will enable it again (if it was previously
+enabled).
+
+Alternatively, if the FTRACE_OPS_FL_RECURSION flag is set on the ftrace_ops
+(as explained below), then a helper trampoline will be used to test
+for recursion for the callback and no recursion test needs to be done.
+But this is at the expense of a slightly more overhead from an extra
+function call.
+
+If your callback accesses any data or critical section that requires RCU
+protection, it is best to make sure that RCU is "watching", otherwise
+that data or critical section will not be protected as expected. In this
+case add:
+
+	if (!rcu_is_watching())
+		return;
+
+Alternatively, if the FTRACE_OPS_FL_RCU flag is set on the ftrace_ops
+(as explained below), then a helper trampoline will be used to test
+for rcu_is_watching for the callback and no other test needs to be done.
+But this is at the expense of a slightly more overhead from an extra
+function call.
+
 
 The ftrace FLAGS
 ================
@@ -128,26 +172,20 @@ FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED
 	will not fail with this flag set. But the callback must check if
 	regs is NULL or not to determine if the architecture supports it.
 
-FTRACE_OPS_FL_RECURSION_SAFE
-	By default, a wrapper is added around the callback to
-	make sure that recursion of the function does not occur. That is,
-	if a function that is called as a result of the callback's execution
-	is also traced, ftrace will prevent the callback from being called
-	again. But this wrapper adds some overhead, and if the callback is
-	safe from recursion, it can set this flag to disable the ftrace
-	protection.
-
-	Note, if this flag is set, and recursion does occur, it could cause
-	the system to crash, and possibly reboot via a triple fault.
-
-	It is OK if another callback traces a function that is called by a
-	callback that is marked recursion safe. Recursion safe callbacks
-	must never trace any function that are called by the callback
-	itself or any nested functions that those functions call.
-
-	If this flag is set, it is possible that the callback will also
-	be called with preemption enabled (when CONFIG_PREEMPTION is set),
-	but this is not guaranteed.
+FTRACE_OPS_FL_RECURSION
+	By default, it is expected that the callback can handle recursion.
+	But if the callback is not that worried about overehead, then
+	setting this bit will add the recursion protection around the
+	callback by calling a helper function that will do the recursion
+	protection and only call the callback if it did not recurse.
+
+	Note, if this flag is not set, and recursion does occur, it could
+	cause the system to crash, and possibly reboot via a triple fault.
+
+	Not, if this flag is set, then the callback will always be called
+	with preemption disabled. If it is not set, then it is possible
+	(but not guaranteed) that the callback will be called in
+	preemptable context.
 
 FTRACE_OPS_FL_IPMODIFY
 	Requires FTRACE_OPS_FL_SAVE_REGS set. If the callback is to "hijack"
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 0e4164a7f56d..806196345c3f 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -98,7 +98,7 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
 /*
  * FTRACE_OPS_FL_* bits denote the state of ftrace_ops struct and are
  * set in the flags member.
- * CONTROL, SAVE_REGS, SAVE_REGS_IF_SUPPORTED, RECURSION_SAFE, STUB and
+ * CONTROL, SAVE_REGS, SAVE_REGS_IF_SUPPORTED, RECURSION, STUB and
  * IPMODIFY are a kind of attribute flags which can be set only before
  * registering the ftrace_ops, and can not be modified while registered.
  * Changing those attribute flags after registering ftrace_ops will
@@ -121,10 +121,10 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops);
  *            passing regs to the handler.
  *            Note, if this flag is set, the SAVE_REGS flag will automatically
  *            get set upon registering the ftrace_ops, if the arch supports it.
- * RECURSION_SAFE - The ftrace_ops can set this to tell the ftrace infrastructure
- *            that the call back has its own recursion protection. If it does
- *            not set this, then the ftrace infrastructure will add recursion
- *            protection for the caller.
+ * RECURSION - The ftrace_ops can set this to tell the ftrace infrastructure
+ *            that the call back needs recursion protection. If it does
+ *            not set this, then the ftrace infrastructure will assume
+ *            that the callback can handle recursion on its own.
  * STUB   - The ftrace_ops is just a place holder.
  * INITIALIZED - The ftrace_ops has already been initialized (first use time
  *            register_ftrace_function() is called, it will initialized the ops)
@@ -156,7 +156,7 @@ enum {
 	FTRACE_OPS_FL_DYNAMIC			= BIT(1),
 	FTRACE_OPS_FL_SAVE_REGS			= BIT(2),
 	FTRACE_OPS_FL_SAVE_REGS_IF_SUPPORTED	= BIT(3),
-	FTRACE_OPS_FL_RECURSION_SAFE		= BIT(4),
+	FTRACE_OPS_FL_RECURSION			= BIT(4),
 	FTRACE_OPS_FL_STUB			= BIT(5),
 	FTRACE_OPS_FL_INITIALIZED		= BIT(6),
 	FTRACE_OPS_FL_DELETED			= BIT(7),
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 5658f13037b3..73edb9e4f354 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -334,8 +334,7 @@ unsigned long ftrace_graph_ret_addr(struct task_struct *task, int *idx,
 
 static struct ftrace_ops graph_ops = {
 	.func			= ftrace_stub,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
-				   FTRACE_OPS_FL_INITIALIZED |
+	.flags			= FTRACE_OPS_FL_INITIALIZED |
 				   FTRACE_OPS_FL_PID |
 				   FTRACE_OPS_FL_STUB,
 #ifdef FTRACE_GRAPH_TRAMP_ADDR
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 8185f7240095..39f2bba89b76 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -80,7 +80,7 @@ enum {
 
 struct ftrace_ops ftrace_list_end __read_mostly = {
 	.func		= ftrace_stub,
-	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_STUB,
+	.flags		= FTRACE_OPS_FL_STUB,
 	INIT_OPS_HASH(ftrace_list_end)
 };
 
@@ -866,7 +866,7 @@ static void unregister_ftrace_profiler(void)
 #else
 static struct ftrace_ops ftrace_profile_ops __read_mostly = {
 	.func		= function_profile_call,
-	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_INITIALIZED,
+	.flags		= FTRACE_OPS_FL_INITIALIZED,
 	INIT_OPS_HASH(ftrace_profile_ops)
 };
 
@@ -1040,8 +1040,7 @@ struct ftrace_ops global_ops = {
 	.local_hash.notrace_hash	= EMPTY_HASH,
 	.local_hash.filter_hash		= EMPTY_HASH,
 	INIT_OPS_HASH(global_ops)
-	.flags				= FTRACE_OPS_FL_RECURSION_SAFE |
-					  FTRACE_OPS_FL_INITIALIZED |
+	.flags				= FTRACE_OPS_FL_INITIALIZED |
 					  FTRACE_OPS_FL_PID,
 };
 
@@ -2382,7 +2381,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 
 struct ftrace_ops direct_ops = {
 	.func		= call_direct_funcs,
-	.flags		= FTRACE_OPS_FL_IPMODIFY | FTRACE_OPS_FL_RECURSION_SAFE
+	.flags		= FTRACE_OPS_FL_IPMODIFY
 			  | FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
 	/*
@@ -6864,8 +6863,7 @@ void ftrace_init_trace_array(struct trace_array *tr)
 
 struct ftrace_ops global_ops = {
 	.func			= ftrace_stub,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE |
-				  FTRACE_OPS_FL_INITIALIZED |
+	.flags			= FTRACE_OPS_FL_INITIALIZED |
 				  FTRACE_OPS_FL_PID,
 };
 
@@ -7023,11 +7021,11 @@ NOKPROBE_SYMBOL(ftrace_ops_assist_func);
 ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
 {
 	/*
-	 * If the function does not handle recursion, needs to be RCU safe,
-	 * or does per cpu logic, then we need to call the assist handler.
+	 * If the function does not handle recursion or needs to be RCU safe,
+	 * then we need to call the assist handler.
 	 */
-	if (!(ops->flags & FTRACE_OPS_FL_RECURSION_SAFE) ||
-	    ops->flags & FTRACE_OPS_FL_RCU)
+	if (ops->flags & (FTRACE_OPS_FL_RECURSION |
+			  FTRACE_OPS_FL_RCU))
 		return ftrace_ops_assist_func;
 
 	return ops->func;
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 47a71f96e5bc..244abbcd1db5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3712,7 +3712,6 @@ function_test_events_call(unsigned long ip, unsigned long parent_ip,
 static struct ftrace_ops trace_ops __initdata  =
 {
 	.func = function_test_events_call,
-	.flags = FTRACE_OPS_FL_RECURSION_SAFE,
 };
 
 static __init void event_trace_self_test_with_function(void)
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 943756c01190..89c414ce1388 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -48,7 +48,7 @@ int ftrace_allocate_ftrace_ops(struct trace_array *tr)
 
 	/* Currently only the non stack version is supported */
 	ops->func = function_trace_call;
-	ops->flags = FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_PID;
+	ops->flags = FTRACE_OPS_FL_PID;
 
 	tr->ops = ops;
 	ops->private = tr;
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 4738ad48a667..8ee3c0bb5d8a 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -150,17 +150,14 @@ static void trace_selftest_test_dyn_func(unsigned long ip,
 
 static struct ftrace_ops test_probe1 = {
 	.func			= trace_selftest_test_probe1_func,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE,
 };
 
 static struct ftrace_ops test_probe2 = {
 	.func			= trace_selftest_test_probe2_func,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE,
 };
 
 static struct ftrace_ops test_probe3 = {
 	.func			= trace_selftest_test_probe3_func,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE,
 };
 
 static void print_counts(void)
@@ -448,11 +445,11 @@ static void trace_selftest_test_recursion_safe_func(unsigned long ip,
 
 static struct ftrace_ops test_rec_probe = {
 	.func			= trace_selftest_test_recursion_func,
+	.flags			= FTRACE_OPS_FL_RECURSION,
 };
 
 static struct ftrace_ops test_recsafe_probe = {
 	.func			= trace_selftest_test_recursion_safe_func,
-	.flags			= FTRACE_OPS_FL_RECURSION_SAFE,
 };
 
 static int
@@ -561,7 +558,7 @@ static void trace_selftest_test_regs_func(unsigned long ip,
 
 static struct ftrace_ops test_regs_probe = {
 	.func		= trace_selftest_test_regs_func,
-	.flags		= FTRACE_OPS_FL_RECURSION_SAFE | FTRACE_OPS_FL_SAVE_REGS,
+	.flags		= FTRACE_OPS_FL_SAVE_REGS,
 };
 
 static int
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index c408423e5d65..969db526a563 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -318,7 +318,6 @@ stack_trace_call(unsigned long ip, unsigned long parent_ip,
 static struct ftrace_ops trace_ops __read_mostly =
 {
 	.func = stack_trace_call,
-	.flags = FTRACE_OPS_FL_RECURSION_SAFE,
 };
 
 static ssize_t
-- 
2.28.0



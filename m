Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640422A8CFE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgKFCfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:35:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFCfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:35:48 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA0872078E;
        Fri,  6 Nov 2020 02:35:47 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1karbO-007WJo-H7; Thu, 05 Nov 2020 21:35:46 -0500
Message-ID: <20201106023546.378584067@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 21:32:37 -0500
From:   Steven Rostedt (VMware) <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 02/11 v3] ftrace: Add ftrace_test_recursion_trylock() helper function
References: <20201106023235.367190737@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

To make it easier for ftrace callbacks to have recursion protection, provide
a ftrace_test_recursion_trylock() and ftrace_test_recursion_unlock() helper
that tests for recursion.

Link: https://lkml.kernel.org/r/20201028115612.634927593@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 25 +++++++++++++++++++++++++
 kernel/trace/trace_functions.c  | 12 +++++-------
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index dbb7b6d4c94c..f2a949dbfec7 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -183,5 +183,30 @@ static __always_inline void trace_clear_recursion(int bit)
 	current->trace_recursion = val;
 }
 
+/**
+ * ftrace_test_recursion_trylock - tests for recursion in same context
+ *
+ * Use this for ftrace callbacks. This will detect if the function
+ * tracing recursed in the same context (normal vs interrupt),
+ *
+ * Returns: -1 if a recursion happened.
+ *           >= 0 if no recursion
+ */
+static __always_inline int ftrace_test_recursion_trylock(void)
+{
+	return trace_test_and_set_recursion(TRACE_FTRACE_START, TRACE_FTRACE_MAX);
+}
+
+/**
+ * ftrace_test_recursion_unlock - called when function callback is complete
+ * @bit: The return of a successful ftrace_test_recursion_trylock()
+ *
+ * This is used at the end of a ftrace callback.
+ */
+static __always_inline void ftrace_test_recursion_unlock(int bit)
+{
+	trace_clear_recursion(bit);
+}
+
 #endif /* CONFIG_TRACING */
 #endif /* _LINUX_TRACE_RECURSION_H */
diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 2c2126e1871d..943756c01190 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -141,22 +141,20 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (unlikely(!tr->function_enabled))
 		return;
 
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
 	pc = preempt_count();
 	preempt_disable_notrace();
 
-	bit = trace_test_and_set_recursion(TRACE_FTRACE_START, TRACE_FTRACE_MAX);
-	if (bit < 0)
-		goto out;
-
 	cpu = smp_processor_id();
 	data = per_cpu_ptr(tr->array_buffer.data, cpu);
 	if (!atomic_read(&data->disabled)) {
 		local_save_flags(flags);
 		trace_function(tr, ip, parent_ip, flags, pc);
 	}
-	trace_clear_recursion(bit);
-
- out:
+	ftrace_test_recursion_unlock(bit);
 	preempt_enable_notrace();
 }
 
-- 
2.28.0



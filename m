Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B42B529DE54
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731877AbgJ1WTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:19:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731762AbgJ1WRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 438B8246CF;
        Wed, 28 Oct 2020 11:56:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXk3o-005ZGa-JT; Wed, 28 Oct 2020 07:56:12 -0400
Message-ID: <20201028115612.460535535@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 07:52:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/9] ftrace: Move the recursion testing into global headers
References: <20201028115244.995788961@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Currently, if a callback is registered to a ftrace function and its
ftrace_ops does not have the RECURSION flag set, it is encapsulated in a
helper function that does the recursion for it.

Really, all the callbacks should have their own recursion protection for
performance reasons. But they should not all implement their own. Move the
recursion helpers to global headers, so that all callbacks can use them.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h          |   1 +
 include/linux/trace_recursion.h | 167 ++++++++++++++++++++++++++++++++
 kernel/trace/trace.h            | 156 -----------------------------
 3 files changed, 168 insertions(+), 156 deletions(-)
 create mode 100644 include/linux/trace_recursion.h

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1bd3a0356ae4..0e4164a7f56d 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -7,6 +7,7 @@
 #ifndef _LINUX_FTRACE_H
 #define _LINUX_FTRACE_H
 
+#include <linux/trace_recursion.h>
 #include <linux/trace_clock.h>
 #include <linux/kallsyms.h>
 #include <linux/linkage.h>
diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
new file mode 100644
index 000000000000..6c94c2ece9f0
--- /dev/null
+++ b/include/linux/trace_recursion.h
@@ -0,0 +1,167 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_TRACE_RECURSION_H
+#define _LINUX_TRACE_RECURSION_H
+
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+
+#ifdef CONFIG_TRACING
+
+/* Only current can touch trace_recursion */
+
+/*
+ * For function tracing recursion:
+ *  The order of these bits are important.
+ *
+ *  When function tracing occurs, the following steps are made:
+ *   If arch does not support a ftrace feature:
+ *    call internal function (uses INTERNAL bits) which calls...
+ *   If callback is registered to the "global" list, the list
+ *    function is called and recursion checks the GLOBAL bits.
+ *    then this function calls...
+ *   The function callback, which can use the FTRACE bits to
+ *    check for recursion.
+ *
+ * Now if the arch does not support a feature, and it calls
+ * the global list function which calls the ftrace callback
+ * all three of these steps will do a recursion protection.
+ * There's no reason to do one if the previous caller already
+ * did. The recursion that we are protecting against will
+ * go through the same steps again.
+ *
+ * To prevent the multiple recursion checks, if a recursion
+ * bit is set that is higher than the MAX bit of the current
+ * check, then we know that the check was made by the previous
+ * caller, and we can skip the current check.
+ */
+enum {
+	/* Function recursion bits */
+	TRACE_FTRACE_BIT,
+	TRACE_FTRACE_NMI_BIT,
+	TRACE_FTRACE_IRQ_BIT,
+	TRACE_FTRACE_SIRQ_BIT,
+
+	/* INTERNAL_BITs must be greater than FTRACE_BITs */
+	TRACE_INTERNAL_BIT,
+	TRACE_INTERNAL_NMI_BIT,
+	TRACE_INTERNAL_IRQ_BIT,
+	TRACE_INTERNAL_SIRQ_BIT,
+
+	TRACE_BRANCH_BIT,
+/*
+ * Abuse of the trace_recursion.
+ * As we need a way to maintain state if we are tracing the function
+ * graph in irq because we want to trace a particular function that
+ * was called in irq context but we have irq tracing off. Since this
+ * can only be modified by current, we can reuse trace_recursion.
+ */
+	TRACE_IRQ_BIT,
+
+	/* Set if the function is in the set_graph_function file */
+	TRACE_GRAPH_BIT,
+
+	/*
+	 * In the very unlikely case that an interrupt came in
+	 * at a start of graph tracing, and we want to trace
+	 * the function in that interrupt, the depth can be greater
+	 * than zero, because of the preempted start of a previous
+	 * trace. In an even more unlikely case, depth could be 2
+	 * if a softirq interrupted the start of graph tracing,
+	 * followed by an interrupt preempting a start of graph
+	 * tracing in the softirq, and depth can even be 3
+	 * if an NMI came in at the start of an interrupt function
+	 * that preempted a softirq start of a function that
+	 * preempted normal context!!!! Luckily, it can't be
+	 * greater than 3, so the next two bits are a mask
+	 * of what the depth is when we set TRACE_GRAPH_BIT
+	 */
+
+	TRACE_GRAPH_DEPTH_START_BIT,
+	TRACE_GRAPH_DEPTH_END_BIT,
+
+	/*
+	 * To implement set_graph_notrace, if this bit is set, we ignore
+	 * function graph tracing of called functions, until the return
+	 * function is called to clear it.
+	 */
+	TRACE_GRAPH_NOTRACE_BIT,
+};
+
+#define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
+#define trace_recursion_clear(bit)	do { (current)->trace_recursion &= ~(1<<(bit)); } while (0)
+#define trace_recursion_test(bit)	((current)->trace_recursion & (1<<(bit)))
+
+#define trace_recursion_depth() \
+	(((current)->trace_recursion >> TRACE_GRAPH_DEPTH_START_BIT) & 3)
+#define trace_recursion_set_depth(depth) \
+	do {								\
+		current->trace_recursion &=				\
+			~(3 << TRACE_GRAPH_DEPTH_START_BIT);		\
+		current->trace_recursion |=				\
+			((depth) & 3) << TRACE_GRAPH_DEPTH_START_BIT;	\
+	} while (0)
+
+#define TRACE_CONTEXT_BITS	4
+
+#define TRACE_FTRACE_START	TRACE_FTRACE_BIT
+#define TRACE_FTRACE_MAX	((1 << (TRACE_FTRACE_START + TRACE_CONTEXT_BITS)) - 1)
+
+#define TRACE_LIST_START	TRACE_INTERNAL_BIT
+#define TRACE_LIST_MAX		((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
+
+#define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
+
+static __always_inline int trace_get_context_bit(void)
+{
+	int bit;
+
+	if (in_interrupt()) {
+		if (in_nmi())
+			bit = 0;
+
+		else if (in_irq())
+			bit = 1;
+		else
+			bit = 2;
+	} else
+		bit = 3;
+
+	return bit;
+}
+
+static __always_inline int trace_test_and_set_recursion(int start, int max)
+{
+	unsigned int val = current->trace_recursion;
+	int bit;
+
+	/* A previous recursion check was made */
+	if ((val & TRACE_CONTEXT_MASK) > max)
+		return 0;
+
+	bit = trace_get_context_bit() + start;
+	if (unlikely(val & (1 << bit)))
+		return -1;
+
+	val |= 1 << bit;
+	current->trace_recursion = val;
+	barrier();
+
+	return bit;
+}
+
+static __always_inline void trace_clear_recursion(int bit)
+{
+	unsigned int val = current->trace_recursion;
+
+	if (!bit)
+		return;
+
+	bit = 1 << bit;
+	val &= ~bit;
+
+	barrier();
+	current->trace_recursion = val;
+}
+
+#endif /* CONFIG_TRACING */
+#endif /* _LINUX_TRACE_RECURSION_H */
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 34e0c4d5a6e7..2bb30ee4c3c6 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -559,162 +559,6 @@ struct tracer {
 };
 
 
-/* Only current can touch trace_recursion */
-
-/*
- * For function tracing recursion:
- *  The order of these bits are important.
- *
- *  When function tracing occurs, the following steps are made:
- *   If arch does not support a ftrace feature:
- *    call internal function (uses INTERNAL bits) which calls...
- *   If callback is registered to the "global" list, the list
- *    function is called and recursion checks the GLOBAL bits.
- *    then this function calls...
- *   The function callback, which can use the FTRACE bits to
- *    check for recursion.
- *
- * Now if the arch does not support a feature, and it calls
- * the global list function which calls the ftrace callback
- * all three of these steps will do a recursion protection.
- * There's no reason to do one if the previous caller already
- * did. The recursion that we are protecting against will
- * go through the same steps again.
- *
- * To prevent the multiple recursion checks, if a recursion
- * bit is set that is higher than the MAX bit of the current
- * check, then we know that the check was made by the previous
- * caller, and we can skip the current check.
- */
-enum {
-	/* Function recursion bits */
-	TRACE_FTRACE_BIT,
-	TRACE_FTRACE_NMI_BIT,
-	TRACE_FTRACE_IRQ_BIT,
-	TRACE_FTRACE_SIRQ_BIT,
-
-	/* INTERNAL_BITs must be greater than FTRACE_BITs */
-	TRACE_INTERNAL_BIT,
-	TRACE_INTERNAL_NMI_BIT,
-	TRACE_INTERNAL_IRQ_BIT,
-	TRACE_INTERNAL_SIRQ_BIT,
-
-	TRACE_BRANCH_BIT,
-/*
- * Abuse of the trace_recursion.
- * As we need a way to maintain state if we are tracing the function
- * graph in irq because we want to trace a particular function that
- * was called in irq context but we have irq tracing off. Since this
- * can only be modified by current, we can reuse trace_recursion.
- */
-	TRACE_IRQ_BIT,
-
-	/* Set if the function is in the set_graph_function file */
-	TRACE_GRAPH_BIT,
-
-	/*
-	 * In the very unlikely case that an interrupt came in
-	 * at a start of graph tracing, and we want to trace
-	 * the function in that interrupt, the depth can be greater
-	 * than zero, because of the preempted start of a previous
-	 * trace. In an even more unlikely case, depth could be 2
-	 * if a softirq interrupted the start of graph tracing,
-	 * followed by an interrupt preempting a start of graph
-	 * tracing in the softirq, and depth can even be 3
-	 * if an NMI came in at the start of an interrupt function
-	 * that preempted a softirq start of a function that
-	 * preempted normal context!!!! Luckily, it can't be
-	 * greater than 3, so the next two bits are a mask
-	 * of what the depth is when we set TRACE_GRAPH_BIT
-	 */
-
-	TRACE_GRAPH_DEPTH_START_BIT,
-	TRACE_GRAPH_DEPTH_END_BIT,
-
-	/*
-	 * To implement set_graph_notrace, if this bit is set, we ignore
-	 * function graph tracing of called functions, until the return
-	 * function is called to clear it.
-	 */
-	TRACE_GRAPH_NOTRACE_BIT,
-};
-
-#define trace_recursion_set(bit)	do { (current)->trace_recursion |= (1<<(bit)); } while (0)
-#define trace_recursion_clear(bit)	do { (current)->trace_recursion &= ~(1<<(bit)); } while (0)
-#define trace_recursion_test(bit)	((current)->trace_recursion & (1<<(bit)))
-
-#define trace_recursion_depth() \
-	(((current)->trace_recursion >> TRACE_GRAPH_DEPTH_START_BIT) & 3)
-#define trace_recursion_set_depth(depth) \
-	do {								\
-		current->trace_recursion &=				\
-			~(3 << TRACE_GRAPH_DEPTH_START_BIT);		\
-		current->trace_recursion |=				\
-			((depth) & 3) << TRACE_GRAPH_DEPTH_START_BIT;	\
-	} while (0)
-
-#define TRACE_CONTEXT_BITS	4
-
-#define TRACE_FTRACE_START	TRACE_FTRACE_BIT
-#define TRACE_FTRACE_MAX	((1 << (TRACE_FTRACE_START + TRACE_CONTEXT_BITS)) - 1)
-
-#define TRACE_LIST_START	TRACE_INTERNAL_BIT
-#define TRACE_LIST_MAX		((1 << (TRACE_LIST_START + TRACE_CONTEXT_BITS)) - 1)
-
-#define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
-
-static __always_inline int trace_get_context_bit(void)
-{
-	int bit;
-
-	if (in_interrupt()) {
-		if (in_nmi())
-			bit = 0;
-
-		else if (in_irq())
-			bit = 1;
-		else
-			bit = 2;
-	} else
-		bit = 3;
-
-	return bit;
-}
-
-static __always_inline int trace_test_and_set_recursion(int start, int max)
-{
-	unsigned int val = current->trace_recursion;
-	int bit;
-
-	/* A previous recursion check was made */
-	if ((val & TRACE_CONTEXT_MASK) > max)
-		return 0;
-
-	bit = trace_get_context_bit() + start;
-	if (unlikely(val & (1 << bit)))
-		return -1;
-
-	val |= 1 << bit;
-	current->trace_recursion = val;
-	barrier();
-
-	return bit;
-}
-
-static __always_inline void trace_clear_recursion(int bit)
-{
-	unsigned int val = current->trace_recursion;
-
-	if (!bit)
-		return;
-
-	bit = 1 << bit;
-	val &= ~bit;
-
-	barrier();
-	current->trace_recursion = val;
-}
-
 static inline struct ring_buffer_iter *
 trace_buffer_iter(struct trace_iterator *iter, int cpu)
 {
-- 
2.28.0



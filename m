Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500972A1059
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 22:41:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgJ3VkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 17:40:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:46806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgJ3VkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 17:40:15 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E702224E;
        Fri, 30 Oct 2020 21:40:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kYc85-00647X-KK; Fri, 30 Oct 2020 17:40:13 -0400
Message-ID: <20201030214013.510163165@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 17:31:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH 03/11 v2] ftrace: Optimize testing what context current is in
References: <20201030213142.096102821@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

The preempt_count() is not a simple location in memory, it could be part of
per_cpu code or more. Each access to preempt_count(), or one of its accessor
functions (like in_interrupt()) takes several cycles. By reading
preempt_count() once, and then doing tests to find the context against the
value return is slightly faster than using in_nmi() and in_interrupt().

Link: https://lkml.kernel.org/r/20201028115612.780796355@goodmis.org

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index f2a949dbfec7..ac3d73484cb2 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -117,22 +117,29 @@ enum {
 
 #define TRACE_CONTEXT_MASK	TRACE_LIST_MAX
 
+/*
+ * Used for setting context
+ *  NMI     = 0
+ *  IRQ     = 1
+ *  SOFTIRQ = 2
+ *  NORMAL  = 3
+ */
+enum {
+	TRACE_CTX_NMI,
+	TRACE_CTX_IRQ,
+	TRACE_CTX_SOFTIRQ,
+	TRACE_CTX_NORMAL,
+};
+
 static __always_inline int trace_get_context_bit(void)
 {
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
+	unsigned long pc = preempt_count();
 
-	return bit;
+	if (!(pc & (NMI_MASK | HARDIRQ_MASK | SOFTIRQ_OFFSET)))
+		return TRACE_CTX_NORMAL;
+	else
+		return pc & NMI_MASK ? TRACE_CTX_NMI :
+			pc & HARDIRQ_MASK ? TRACE_CTX_IRQ : TRACE_CTX_SOFTIRQ;
 }
 
 static __always_inline int trace_test_and_set_recursion(int start, int max)
-- 
2.28.0



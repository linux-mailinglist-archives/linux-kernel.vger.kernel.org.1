Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B9C29DEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgJ2Azz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731669AbgJ1WRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:40 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54268246D1;
        Wed, 28 Oct 2020 11:56:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXk3o-005ZHZ-V5; Wed, 28 Oct 2020 07:56:12 -0400
Message-ID: <20201028115612.780796355@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 07:52:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 3/9] ftrace: Optimize testing what context current is in
References: <20201028115244.995788961@goodmis.org>
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

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_recursion.h | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index da17a1144bf4..04d21e9ec48b 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -111,22 +111,29 @@ enum {
 
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
+	unsigned long pc = preempt_count();
 
-		else if (in_irq())
-			bit = 1;
-		else
-			bit = 2;
-	} else
-		bit = 3;
-
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



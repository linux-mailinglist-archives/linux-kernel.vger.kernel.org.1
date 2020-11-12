Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB7D32AFC83
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 02:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgKLBiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 20:38:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgKLAfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 19:35:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0ED0722240;
        Thu, 12 Nov 2020 00:33:36 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kd0YR-0002CG-0Y; Wed, 11 Nov 2020 19:33:35 -0500
Message-ID: <20201112003334.906341178@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 11 Nov 2020 19:32:56 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 12/17] fgraph: Make overruns 4 bytes in graph stack structure
References: <20201112003244.764326960@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Inspecting the data structures of the function graph tracer, I found that
the overrun value is unsigned long, which is 8 bytes on a 64 bit machine,
and not only that, the depth is an int (4 bytes). The overrun can be simply
an unsigned int (4 bytes) and pack the ftrace_graph_ret structure better.

The depth is moved up next to the func, as it is used more often with func,
and improves cache locality.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/ftrace.h               | 4 ++--
 kernel/trace/trace_entries.h         | 4 ++--
 kernel/trace/trace_functions_graph.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 806196345c3f..8dde9c17aaa5 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -864,11 +864,11 @@ struct ftrace_graph_ent {
  */
 struct ftrace_graph_ret {
 	unsigned long func; /* Current function */
+	int depth;
 	/* Number of functions that overran the depth limit for current task */
-	unsigned long overrun;
+	unsigned int overrun;
 	unsigned long long calltime;
 	unsigned long long rettime;
-	int depth;
 } __packed;
 
 /* Type of the callback handlers for tracing function graph*/
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index 18c4a58aff79..ceafe2dc97e1 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -93,10 +93,10 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
 	F_STRUCT(
 		__field_struct(	struct ftrace_graph_ret,	ret	)
 		__field_packed(	unsigned long,	ret,		func	)
-		__field_packed(	unsigned long,	ret,		overrun	)
+		__field_packed(	int,		ret,		depth	)
+		__field_packed(	unsigned int,	ret,		overrun	)
 		__field_packed(	unsigned long long, ret,	calltime)
 		__field_packed(	unsigned long long, ret,	rettime	)
-		__field_packed(	int,		ret,		depth	)
 	),
 
 	F_printk("<-- %ps (%d) (start: %llx  end: %llx) over: %d",
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 60d66278aa0d..d874dec87131 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -957,7 +957,7 @@ print_graph_return(struct ftrace_graph_ret *trace, struct trace_seq *s,
 
 	/* Overrun */
 	if (flags & TRACE_GRAPH_PRINT_OVERRUN)
-		trace_seq_printf(s, " (Overruns: %lu)\n",
+		trace_seq_printf(s, " (Overruns: %u)\n",
 				 trace->overrun);
 
 	print_graph_irq(iter, trace->func, TRACE_GRAPH_RET,
-- 
2.28.0



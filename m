Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 127FF29DF20
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729376AbgJ2A70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 20:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731564AbgJ1WRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C80124741;
        Wed, 28 Oct 2020 13:19:11 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXlM6-005a7S-1m; Wed, 28 Oct 2020 09:19:10 -0400
Message-ID: <20201028131909.923504298@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 09:15:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RFC][PATCH 2/2] ftrace: Test arguments by adding trace_printk in function tracer
References: <20201028131542.963014814@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index 89c414ce1388..4bd3194540f1 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -129,7 +129,7 @@ static void function_trace_start(struct trace_array *tr)
 
 static void
 function_trace_call(unsigned long ip, unsigned long parent_ip,
-		    struct ftrace_ops *op, struct pt_regs *pt_regs)
+		    struct ftrace_ops *op, struct pt_regs *regs)
 {
 	struct trace_array *tr = op->private;
 	struct trace_array_cpu *data;
@@ -153,6 +153,17 @@ function_trace_call(unsigned long ip, unsigned long parent_ip,
 	if (!atomic_read(&data->disabled)) {
 		local_save_flags(flags);
 		trace_function(tr, ip, parent_ip, flags, pc);
+#ifdef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
+		trace_printk("%pS %lx %lx %lx %lx %lx %lx %lx\n",
+			     (void *)ip,
+			     kernel_stack_pointer(regs),
+			     regs_get_kernel_argument(regs, 0),
+			     regs_get_kernel_argument(regs, 1),
+			     regs_get_kernel_argument(regs, 2),
+			     regs_get_kernel_argument(regs, 3),
+			     regs_get_kernel_argument(regs, 4),
+			     regs_get_kernel_argument(regs, 5));
+#endif
 	}
 	ftrace_test_recursion_unlock(bit);
 	preempt_enable_notrace();
-- 
2.28.0



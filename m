Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8D8273758
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 02:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgIVA1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 20:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:55444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbgIVA1C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 20:27:02 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28BEF23A9D;
        Tue, 22 Sep 2020 00:27:01 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKW96-001rah-5E; Mon, 21 Sep 2020 20:27:00 -0400
Message-ID: <20200922002700.031403462@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 20:26:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [for-linus][PATCH 4/8] tracing: Make the space reserved for the pid wider
References: <20200922002620.231334654@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

For 64bit CONFIG_BASE_SMALL=0 systems PID_MAX_LIMIT is set by default to
4194304. During boot the kernel sets a new value based on number of CPUs
but no lower than 32768. It is 1024 per CPU so with 128 CPUs the default
becomes 131072 which needs six digits.
This value can be increased during run time but must not exceed the
initial upper limit.

Systemd sometime after v241 sets it to the upper limit during boot. The
result is that when the pid exceeds five digits, the trace output is a
little hard to read because it is no longer properly padded (same like
on big iron with 98+ CPUs).

Increase the pid padding to seven digits.

Link: https://lkml.kernel.org/r/20200904082331.dcdkrr3bkn3e4qlg@linutronix.de

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.c        | 38 ++++++++++++++++++-------------------
 kernel/trace/trace_output.c | 12 ++++++------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f40d850ebabc..2a7c26345e83 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3782,14 +3782,14 @@ unsigned long trace_total_entries(struct trace_array *tr)
 
 static void print_lat_help_header(struct seq_file *m)
 {
-	seq_puts(m, "#                  _------=> CPU#            \n"
-		    "#                 / _-----=> irqs-off        \n"
-		    "#                | / _----=> need-resched    \n"
-		    "#                || / _---=> hardirq/softirq \n"
-		    "#                ||| / _--=> preempt-depth   \n"
-		    "#                |||| /     delay            \n"
-		    "#  cmd     pid   ||||| time  |   caller      \n"
-		    "#     \\   /      |||||  \\    |   /         \n");
+	seq_puts(m, "#                    _------=> CPU#            \n"
+		    "#                   / _-----=> irqs-off        \n"
+		    "#                  | / _----=> need-resched    \n"
+		    "#                  || / _---=> hardirq/softirq \n"
+		    "#                  ||| / _--=> preempt-depth   \n"
+		    "#                  |||| /     delay            \n"
+		    "#  cmd     pid     ||||| time  |   caller      \n"
+		    "#     \\   /        |||||  \\    |   /         \n");
 }
 
 static void print_event_info(struct array_buffer *buf, struct seq_file *m)
@@ -3810,26 +3810,26 @@ static void print_func_help_header(struct array_buffer *buf, struct seq_file *m,
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#           TASK-PID   %s  CPU#   TIMESTAMP  FUNCTION\n", tgid ? "TGID     " : "");
-	seq_printf(m, "#              | |     %s    |       |         |\n",	 tgid ? "  |      " : "");
+	seq_printf(m, "#           TASK-PID    %s CPU#     TIMESTAMP  FUNCTION\n", tgid ? "   TGID   " : "");
+	seq_printf(m, "#              | |      %s   |         |         |\n",      tgid ? "     |    " : "");
 }
 
 static void print_func_help_header_irq(struct array_buffer *buf, struct seq_file *m,
 				       unsigned int flags)
 {
 	bool tgid = flags & TRACE_ITER_RECORD_TGID;
-	const char *space = "          ";
-	int prec = tgid ? 10 : 2;
+	const char *space = "            ";
+	int prec = tgid ? 12 : 2;
 
 	print_event_info(buf, m);
 
-	seq_printf(m, "#                          %.*s  _-----=> irqs-off\n", prec, space);
-	seq_printf(m, "#                          %.*s / _----=> need-resched\n", prec, space);
-	seq_printf(m, "#                          %.*s| / _---=> hardirq/softirq\n", prec, space);
-	seq_printf(m, "#                          %.*s|| / _--=> preempt-depth\n", prec, space);
-	seq_printf(m, "#                          %.*s||| /     delay\n", prec, space);
-	seq_printf(m, "#           TASK-PID %.*sCPU#  ||||    TIMESTAMP  FUNCTION\n", prec, "   TGID   ");
-	seq_printf(m, "#              | |   %.*s  |   ||||       |         |\n", prec, "     |    ");
+	seq_printf(m, "#                            %.*s  _-----=> irqs-off\n", prec, space);
+	seq_printf(m, "#                            %.*s / _----=> need-resched\n", prec, space);
+	seq_printf(m, "#                            %.*s| / _---=> hardirq/softirq\n", prec, space);
+	seq_printf(m, "#                            %.*s|| / _--=> preempt-depth\n", prec, space);
+	seq_printf(m, "#                            %.*s||| /     delay\n", prec, space);
+	seq_printf(m, "#           TASK-PID  %.*s CPU#  ||||   TIMESTAMP  FUNCTION\n", prec, "     TGID   ");
+	seq_printf(m, "#              | |    %.*s   |   ||||      |         |\n", prec, "       |    ");
 }
 
 void
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 4d1893564912..000e9dc224c6 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -497,7 +497,7 @@ lat_print_generic(struct trace_seq *s, struct trace_entry *entry, int cpu)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%8.8s-%-5d %3d",
+	trace_seq_printf(s, "%8.8s-%-7d %3d",
 			 comm, entry->pid, cpu);
 
 	return trace_print_lat_fmt(s, entry);
@@ -588,15 +588,15 @@ int trace_print_context(struct trace_iterator *iter)
 
 	trace_find_cmdline(entry->pid, comm);
 
-	trace_seq_printf(s, "%16s-%-5d ", comm, entry->pid);
+	trace_seq_printf(s, "%16s-%-7d ", comm, entry->pid);
 
 	if (tr->trace_flags & TRACE_ITER_RECORD_TGID) {
 		unsigned int tgid = trace_find_tgid(entry->pid);
 
 		if (!tgid)
-			trace_seq_printf(s, "(-----) ");
+			trace_seq_printf(s, "(-------) ");
 		else
-			trace_seq_printf(s, "(%5d) ", tgid);
+			trace_seq_printf(s, "(%7d) ", tgid);
 	}
 
 	trace_seq_printf(s, "[%03d] ", iter->cpu);
@@ -636,7 +636,7 @@ int trace_print_lat_context(struct trace_iterator *iter)
 		trace_find_cmdline(entry->pid, comm);
 
 		trace_seq_printf(
-			s, "%16s %5d %3d %d %08x %08lx ",
+			s, "%16s %7d %3d %d %08x %08lx ",
 			comm, entry->pid, iter->cpu, entry->flags,
 			entry->preempt_count, iter->idx);
 	} else {
@@ -917,7 +917,7 @@ static enum print_line_t trace_ctxwake_print(struct trace_iterator *iter,
 	S = task_index_to_char(field->prev_state);
 	trace_find_cmdline(field->next_pid, comm);
 	trace_seq_printf(&iter->seq,
-			 " %5d:%3d:%c %s [%03d] %5d:%3d:%c %s\n",
+			 " %7d:%3d:%c %s [%03d] %7d:%3d:%c %s\n",
 			 field->prev_pid,
 			 field->prev_prio,
 			 S, delim,
-- 
2.28.0



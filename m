Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1920528E583
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 19:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbgJNRhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 13:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:57684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389427AbgJNRha (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 13:37:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4806F221EB;
        Wed, 14 Oct 2020 17:37:30 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kSkiP-002yHf-2w; Wed, 14 Oct 2020 13:37:29 -0400
Message-ID: <20201014173728.961779933@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 14 Oct 2020 13:36:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 06/12] tracing: Move is_good_name() from trace_probe.h to trace.h
References: <20201014173647.955053902@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <zanussi@kernel.org>

is_good_name() is useful for other trace infrastructure, such as
synthetic events, so make it available via trace.h.

Link: https://lkml.kernel.org/r/cc6d6a2d7da6957fcbe1e2922e76d18d2bb459b4.1602598160.git.zanussi@kernel.org

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace.h       | 13 +++++++++++++
 kernel/trace/trace_probe.h | 13 -------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index f777bb68e660..34e0c4d5a6e7 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -19,6 +19,7 @@
 #include <linux/glob.h>
 #include <linux/irq_work.h>
 #include <linux/workqueue.h>
+#include <linux/ctype.h>
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #include <asm/unistd.h>		/* For NR_SYSCALLS	     */
@@ -2090,4 +2091,16 @@ static __always_inline void trace_iterator_reset(struct trace_iterator *iter)
 	iter->pos = -1;
 }
 
+/* Check the name is good for event/group/fields */
+static inline bool is_good_name(const char *name)
+{
+	if (!isalpha(*name) && *name != '_')
+		return false;
+	while (*++name != '\0') {
+		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
+			return false;
+	}
+	return true;
+}
+
 #endif /* _LINUX_KERNEL_TRACE_H */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 04d00987da69..2f703a20c724 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -16,7 +16,6 @@
 #include <linux/tracefs.h>
 #include <linux/types.h>
 #include <linux/string.h>
-#include <linux/ctype.h>
 #include <linux/ptrace.h>
 #include <linux/perf_event.h>
 #include <linux/kprobes.h>
@@ -348,18 +347,6 @@ bool trace_probe_match_command_args(struct trace_probe *tp,
 #define trace_probe_for_each_link_rcu(pos, tp)	\
 	list_for_each_entry_rcu(pos, &(tp)->event->files, list)
 
-/* Check the name is good for event/group/fields */
-static inline bool is_good_name(const char *name)
-{
-	if (!isalpha(*name) && *name != '_')
-		return false;
-	while (*++name != '\0') {
-		if (!isalpha(*name) && !isdigit(*name) && *name != '_')
-			return false;
-	}
-	return true;
-}
-
 #define TPARG_FL_RETURN BIT(0)
 #define TPARG_FL_KERNEL BIT(1)
 #define TPARG_FL_FENTRY BIT(2)
-- 
2.28.0



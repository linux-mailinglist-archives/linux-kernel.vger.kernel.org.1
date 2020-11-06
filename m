Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C44E2A8D08
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 03:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgKFCgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 21:36:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgKFCfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 21:35:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4538F20888;
        Fri,  6 Nov 2020 02:35:49 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1karbP-007WMk-Lu; Thu, 05 Nov 2020 21:35:47 -0500
Message-ID: <20201106023547.466892083@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 05 Nov 2020 21:32:43 -0500
From:   Steven Rostedt (VMware) <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 08/11 v3] perf/ftrace: Add recursion protection to the ftrace callback
References: <20201106023235.367190737@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a ftrace callback does not supply its own recursion protection and
does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
make a helper trampoline to do so before calling the callback instead of
just calling the callback directly.

The default for ftrace_ops is going to change. It will expect that handlers
provide their own recursion protection, unless its ftrace_ops states
otherwise.

Link: https://lkml.kernel.org/r/20201028115613.444477858@goodmis.org

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_perf.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 643e0b19920d..fd58d83861d8 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -439,10 +439,15 @@ perf_ftrace_function_call(unsigned long ip, unsigned long parent_ip,
 	struct hlist_head head;
 	struct pt_regs regs;
 	int rctx;
+	int bit;
 
 	if ((unsigned long)ops->private != smp_processor_id())
 		return;
 
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
 	event = container_of(ops, struct perf_event, ftrace_ops);
 
 	/*
@@ -463,13 +468,15 @@ perf_ftrace_function_call(unsigned long ip, unsigned long parent_ip,
 
 	entry = perf_trace_buf_alloc(ENTRY_SIZE, NULL, &rctx);
 	if (!entry)
-		return;
+		goto out;
 
 	entry->ip = ip;
 	entry->parent_ip = parent_ip;
 	perf_trace_buf_submit(entry, ENTRY_SIZE, rctx, TRACE_FN,
 			      1, &regs, &head, NULL);
 
+out:
+	ftrace_test_recursion_unlock(bit);
 #undef ENTRY_SIZE
 }
 
-- 
2.28.0



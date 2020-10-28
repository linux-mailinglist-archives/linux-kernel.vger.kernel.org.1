Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7672129DF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 01:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731566AbgJ1WRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731499AbgJ1WR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:26 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19C18246F1;
        Wed, 28 Oct 2020 11:56:15 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kXk3p-005ZJz-N4; Wed, 28 Oct 2020 07:56:13 -0400
Message-ID: <20201028115613.591878956@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 28 Oct 2020 07:52:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 8/9] perf/ftrace: Check for rcu_is_watching() in callback function
References: <20201028115244.995788961@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a ftrace callback requires "rcu_is_watching", then it adds the
FTRACE_OPS_FL_RCU flag and it will not be called if RCU is not "watching".
But this means that it will use a trampoline when called, and this slows
down the function tracing a tad. By checking rcu_is_watching() from within
the callback, it no longer needs the RCU flag set in the ftrace_ops and it
can be safely called directly.

Cc: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_event_perf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index fd58d83861d8..a2b9fddb8148 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -441,6 +441,9 @@ perf_ftrace_function_call(unsigned long ip, unsigned long parent_ip,
 	int rctx;
 	int bit;
 
+	if (!rcu_is_watching())
+		return;
+
 	if ((unsigned long)ops->private != smp_processor_id())
 		return;
 
@@ -484,7 +487,6 @@ static int perf_ftrace_function_register(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
 
-	ops->flags   = FTRACE_OPS_FL_RCU;
 	ops->func    = perf_ftrace_function_call;
 	ops->private = (void *)(unsigned long)nr_cpu_ids;
 
-- 
2.28.0



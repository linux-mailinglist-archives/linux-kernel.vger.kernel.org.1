Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129732737E9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 03:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgIVBY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 21:24:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729547AbgIVBYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 21:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 685C023A9B;
        Tue, 22 Sep 2020 01:24:54 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kKX37-001sRW-Fb; Mon, 21 Sep 2020 21:24:53 -0400
Message-ID: <20200922012453.360307617@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 21 Sep 2020 21:24:37 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH 23/26] tracing: Enable adding dynamic events early stage
References: <20200922012414.115238201@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu <mhiramat@kernel.org>

Split the event fields initialization from creating new event directory.
This allows the boot-time tracing to define dynamic events before
initializing events directory on tracefs.

Link: https://lkml.kernel.org/r/159974153790.478751.3475515065034825374.stgit@devnote2

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 8e87fbab6930..42c0e7df6e70 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -38,6 +38,7 @@ DEFINE_MUTEX(event_mutex);
 LIST_HEAD(ftrace_events);
 static LIST_HEAD(ftrace_generic_fields);
 static LIST_HEAD(ftrace_common_fields);
+static bool eventdir_initialized;
 
 #define GFP_TRACE (GFP_KERNEL | __GFP_ZERO)
 
@@ -2486,7 +2487,10 @@ __trace_add_new_event(struct trace_event_call *call, struct trace_array *tr)
 	if (!file)
 		return -ENOMEM;
 
-	return event_create_dir(tr->event_dir, file);
+	if (eventdir_initialized)
+		return event_create_dir(tr->event_dir, file);
+	else
+		return event_define_fields(call);
 }
 
 /*
@@ -3478,6 +3482,9 @@ __init int event_trace_init(void)
 	if (ret)
 		pr_warn("Failed to register trace events module notifier\n");
 #endif
+
+	eventdir_initialized = true;
+
 	return 0;
 }
 
-- 
2.28.0


